#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
figure_dir="$project_dir/figures"

if ! command -v pdfcrop >/dev/null 2>&1; then
  echo "ERROR: required tool is unavailable: pdfcrop" >&2
  exit 1
fi

requested_count="${1:-1}"
if [[ ! "$requested_count" =~ ^[1-9][0-9]*$ ]]; then
  echo "WARN: '$requested_count' is not a positive integer; cropping the newest PDF only." >&2
  requested_count=1
fi

pdf_files=()
while IFS= read -r -d '' pdf_file; do
  pdf_files+=("$pdf_file")
done < <(find "$figure_dir" -type f -name '*.pdf' -print0)
if (( ${#pdf_files[@]} == 0 )); then
  echo "ERROR: no PDF files found under $figure_dir" >&2
  exit 1
fi

if (( requested_count > ${#pdf_files[@]} )); then
  requested_count=${#pdf_files[@]}
fi

remaining_files=("${pdf_files[@]}")
for ((processed_count = 0; processed_count < requested_count; processed_count++)); do
  newest_index=0
  for ((file_index = 1; file_index < ${#remaining_files[@]}; file_index++)); do
    if [[ "${remaining_files[$file_index]}" -nt "${remaining_files[$newest_index]}" ]]; then
      newest_index=$file_index
    fi
  done

  source_pdf="${remaining_files[$newest_index]}"
  source_name="$(basename "$source_pdf")"
  source_dir="$(dirname "$source_pdf")"
  temporary_pdf="$source_dir/.${source_name%.pdf}.pdfcrop.pdf"

  rm -f -- "$temporary_pdf"
  if ! pdfcrop "$source_pdf" "$temporary_pdf"; then
    rm -f -- "$temporary_pdf"
    exit 1
  fi
  mv -f -- "$temporary_pdf" "$source_pdf"
  echo "Cropped: $source_pdf"

  unset "remaining_files[$newest_index]"
  if (( processed_count + 1 < requested_count )); then
    remaining_files=("${remaining_files[@]}")
  fi
done
