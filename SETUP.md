# AI Setup Prompt

Copy the prompt below into an AI coding agent that has terminal and file access. The agent may guide the user through installation or perform it when the environment allows.

Repository: https://github.com/jinggqu/PolyU-Thesis-LaTeX

```text
Set up the PolyU Thesis LaTeX project from https://github.com/jinggqu/PolyU-Thesis-LaTeX for me from start to finish. Work on macOS, Windows, or Linux as appropriate, explain only decisions that require my input, and continue until the generated thesis PDF has been opened successfully.

Follow this workflow:

1. Inspect the environment before changing anything. Detect the operating system and CPU architecture, and check for Git, pdflatex, latexmk, biber, tlmgr, Visual Studio Code, and the LaTeX Workshop extension. Report what is already available. Never remove or replace an existing TeX distribution without my explicit approval.

2. If a suitable TeX Live installation is missing, ask whether I want step-by-step guidance or want you to install it. Before downloading software, using administrator privileges, or changing the system PATH, explain the exact action and obtain confirmation. Use the current stable TeX Live release from the official TeX Users Group sources:
   - Installer documentation: https://tug.org/texlive/doc/install-tl.html
   - Network installer: https://tug.org/texlive/acquire-netinstall.html
   - macOS BasicTeX: https://tug.org/mactex/

3. Keep the TeX Live installation compact. On macOS, prefer the current BasicTeX package. On Windows, use the official install-tl-windows installer. On Linux, prefer the official install-tl network installer unless I explicitly request the operating system package manager. Use A4 paper and install only the English language collection. Do not install other language collections. For a custom installation, include `collection-basic`, `collection-latex`, `collection-latexrecommended`, `collection-latexextra`, `collection-mathscience`, `collection-fontsrecommended`, `collection-bibtexextra`, `collection-binextra`, and `collection-langenglish`; then add the `newtx` and `inconsolata` packages if they are not already present. Ensure that pdflatex, latexmk, biber, biblatex, and pdfcrop are available. Refresh the shell PATH and verify each required command after installation. If compilation later reports a missing LaTeX package, identify and install only the corresponding TeX Live package, then retry.

4. Obtain the project. First check whether the current directory already contains main.tex, metadata.tex, polyu-thesis.cls, and .latexmkrc. If it does, use this working copy and do not clone another one. Otherwise, ask me for the destination directory, install Git only with my approval if it is missing, run `git clone --depth 1 https://github.com/jinggqu/PolyU-Thesis-LaTeX.git`, and enter the cloned project. Do not overwrite an existing directory or discard local changes.

5. Collect the metadata in one concise questionnaire before editing metadata.tex. Ask for the thesis title, student name, degree name, degree abbreviation, department, initial-submission month, initial-submission year, award year, chief supervisor, and whether this is an initial examination copy or a final corrected copy. Also ask whether the thesis is a dual degree, whether the student transferred in, and which optional components should be enabled: dedication, publications, List of Figures, List of Tables, List of Algorithms, List of Listings, and abbreviations. Request partner-university or transfer-attribution details only when applicable. Ask whether to leave a handwritten-signature space or use an electronic-signature image; do not copy a signature or other sensitive file without explicit permission.

6. Show me a short summary of the proposed metadata values and switches, ask me to confirm them, and then edit metadata.tex. Preserve its comments and command structure. Do not put package configuration in metadata.tex and do not replace thesis chapter content unless I ask.

7. If Visual Studio Code is installed, offer to open the project and ensure that the LaTeX Workshop extension is available. The included workspace settings are authoritative. VS Code builds should use the bundled latexmk recipe and produce thesis.pdf in the project root. Visual Studio Code is convenient but must not be required for the command-line build.

8. Compile from the project root with `latexmk main.tex`. Continue through the required pdflatex and biber passes, diagnose missing dependencies, and retry until compilation succeeds. Confirm that thesis.pdf exists, references are resolved, and the final log contains no LaTeX errors, undefined references, or overfull boxes. Do not treat normal first-pass rerun messages as final failures.

9. Open thesis.pdf with the operating system's default PDF handler: use `open thesis.pdf` on macOS, `Start-Process thesis.pdf` in PowerShell on Windows, or `xdg-open thesis.pdf` on Linux. If the environment is remote or headless, state that the file could not be opened graphically and give its absolute path instead.

10. Finish with a concise summary containing the TeX Live version, project path, metadata fields or optional choices still awaiting user content, compilation result, and absolute path to thesis.pdf. Do not claim success until the PDF exists and either opens successfully or a headless-environment limitation has been clearly reported.
```
