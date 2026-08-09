%% PolyU Thesis LaTeX class
%% Based on the PolyU Research Postgraduate thesis format regulations for 2025/26.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{polyu-thesis}[2026/08/10 v2.2 PolyU Thesis LaTeX class]

\newif\ifpolyu@double
\newif\ifpolyu@redaccent
\polyu@doublefalse
\polyu@redaccenttrue
\DeclareOption{double}{\polyu@doubletrue}
\DeclareOption{onehalf}{\polyu@doublefalse}
\DeclareOption{blackaccent}{\polyu@redaccentfalse}
\DeclareOption{redaccent}{\polyu@redaccenttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[12pt,a4paper,oneside,openany]{report}

% PolyU requires A4 but does not specify margins; use 25 mm on all sides.
\RequirePackage[a4paper,margin=25mm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
% Load theorem support before newtxmath so both agree on the proof-end symbol.
\RequirePackage{amsthm}
\RequirePackage{xpatch}
\RequirePackage{newtxtext,newtxmath}
% Use a Times-compatible serif family for text and headings.
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage[table,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{booktabs,longtable,tabularx,array,multirow}
\RequirePackage{xltabular}
\RequirePackage{makecell}
\RequirePackage{adjustbox}
\RequirePackage{threeparttable}
% Load rotating before tablefootnote so rotation is detected.
\RequirePackage{rotating}
\RequirePackage{tablefootnote}
\RequirePackage{siunitx}
% Do not load amssymb: newtxmath already defines \Bbbk.
\RequirePackage{mathtools,bm}
\RequirePackage{caption,subcaption,float}
\RequirePackage{placeins}
\RequirePackage{pdflscape}
\RequirePackage{wrapfig}
\RequirePackage{changepage}
\RequirePackage{enumitem}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\counterwithin{algorithm}{chapter}
\RequirePackage{listings}
\RequirePackage{upquote}
% Use Inconsolata for source code.
\RequirePackage[scaled=0.95]{inconsolata}
\RequirePackage{csquotes}
\RequirePackage{url}
\RequirePackage{xspace}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\RequirePackage[nameinlink,noabbrev]{cleveref}

% Generate searchable PDF 1.7; PolyU requires PDF 1.4 or later.
\ifdefined\pdfminorversion
  \pdfminorversion=7
\fi

% Use PolyU red for links. The `blackaccent` option makes links black.
\definecolor{PolyURed}{HTML}{A02337}
\definecolor{PolyUGrey}{HTML}{58595B}
\definecolor{ThesisInk}{HTML}{202124}
\definecolor{ThesisPanel}{HTML}{F3F4F6}
\definecolor{ThesisRule}{HTML}{C9CDD3}

\ifpolyu@redaccent
  \colorlet{ThesisLink}{PolyURed}
\else
  \colorlet{ThesisLink}{black}
\fi

\hypersetup{
  colorlinks=true,
  linkcolor=ThesisLink,
  citecolor=ThesisLink,
  urlcolor=ThesisLink,
  filecolor=ThesisLink,
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=2,
  pdfpagelayout=OneColumn,
  pdfdisplaydoctitle=true
}

% Keep list titles black and clickable; colour only page numbers. Hyperref has
% three title-link branches, so patch all three.
\xpatchcmd{\contentsline}
  {\Hy@toclinkstart{#2}\Hy@toclinkend}
  {\Hy@toclinkstart{\normalcolor #2}\Hy@toclinkend}
  {}
  {\ClassWarning{polyu-thesis}{Unable to neutralise a contents title link}}
\xpatchcmd{\contentsline}
  {\Hy@toclinkstart{#2}\Hy@toclinkend}
  {\Hy@toclinkstart{\normalcolor #2}\Hy@toclinkend}
  {}
  {\ClassWarning{polyu-thesis}{Unable to neutralise a contents title link}}
\xpatchcmd{\contentsline}
  {\Hy@toclinkstart{#2}\Hy@toclinkend}
  {\Hy@toclinkstart{\normalcolor #2}\Hy@toclinkend}
  {}
  {\ClassWarning{polyu-thesis}{Unable to neutralise a contents title link}}

% Use the font's centred dot instead of a baseline period in list leaders.
\xpatchcmd{\@dottedtocline}
  {\hbox{.}}
  {\hbox{\textperiodcentered}}
  {}
  {\ClassWarning{polyu-thesis}{Unable to align contents dot leaders}}

% Apply the class line-spacing option throughout the thesis.
\newcommand{\polyu@applylinespacing}{%
  \ifpolyu@double\doublespacing\else\onehalfspacing\fi
}
\AtBeginDocument{\polyu@applylinespacing}

\setlength{\parindent}{1.5em}
\setlength{\parskip}{0pt}
\setlist{nosep}
\setcounter{secnumdepth}{3}
% Show chapters, sections, and subsections in the contents.
\setcounter{tocdepth}{2}
% Allow two-line running heads.
\setlength{\headheight}{27pt}

% Set captions in the body font and size.
\captionsetup{font={normalsize,rm},labelfont={bf,rm},labelsep=period}
\captionsetup[algorithm]{font={normalsize,rm},labelfont={bf,rm},labelsep=period}
\captionsetup[lstlisting]{
  font={normalsize,rm},
  labelfont={bf,rm},
  labelsep=period,
  justification=raggedright,
  singlelinecheck=false
}
\sisetup{detect-all}
\graphicspath{{figures/}}
\renewcommand{\arraystretch}{1.12}

% Serif heading hierarchy.
\titleformat{\chapter}[display]
  {\normalfont\rmfamily\bfseries\color{ThesisInk}\raggedright}
  {\fontsize{12}{14}\selectfont\color{ThesisInk}\MakeUppercase{\chaptertitlename}\ \thechapter}
  {7pt}
  {\fontsize{26}{31}\selectfont}
  [\vspace{8pt}\color{ThesisRule}\titlerule]
\titleformat{name=\chapter,numberless}[display]
  {\normalfont\rmfamily\bfseries\color{ThesisInk}\raggedright}
  {}
  {0pt}
  {\fontsize{26}{31}\selectfont}
  [\vspace{8pt}\color{ThesisRule}\titlerule]
\titlespacing*{\chapter}{0pt}{-8pt}{30pt}
\titleformat{\section}
  {\normalfont\Large\rmfamily\bfseries\color{ThesisInk}}
  {\thesection}{0.7em}{}
\titleformat{\subsection}
  {\normalfont\large\rmfamily\bfseries\color{ThesisInk}}
  {\thesubsection}{0.7em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\rmfamily\bfseries\color{ThesisInk}}
  {\thesubsubsection}{0.7em}{}

% Running heads; chapter-opening pages show only the page number.
\renewcommand{\chaptermark}[1]{\markboth{\thechapter\quad #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
\fancyhf{}
\fancyhead[L]{\small\rmfamily\nouppercase{\leftmark}}
\fancyhead[R]{\small\rmfamily\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\small\rmfamily\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}
\pagestyle{fancy}

\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

\newcommand{\eg}{\textit{e.g.}\xspace}
\newcommand{\ie}{\textit{i.e.}\xspace}
\newcommand{\etc}{\textit{etc.}\xspace}
\newcommand{\etal}{\textit{et~al.}\xspace}

% Mark best results in bold and runner-up results with an underline.
\newcommand{\best}[1]{\textbf{#1}}
\newcommand{\runnerup}[1]{{\rmfamily\mdseries\underline{#1}}}

\newtheoremstyle{thesisplain}
  {\topsep}{\topsep}{\itshape}{}% body spacing and font
  {\rmfamily\bfseries}{.}{0.5em}{}% head font and punctuation
\newtheoremstyle{thesisdefinition}
  {\topsep}{\topsep}{\normalfont}{}% body spacing and font
  {\rmfamily\bfseries}{.}{0.5em}{}% head font and punctuation
\newtheoremstyle{thesisremark}
  {\topsep}{\topsep}{\normalfont}{}% body spacing and font
  {\rmfamily\bfseries}{.}{0.5em}{}% head font and punctuation
\theoremstyle{thesisplain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\theoremstyle{thesisdefinition}
\newtheorem{definition}[theorem]{Definition}
\theoremstyle{thesisremark}
\newtheorem{remark}[theorem]{Remark}

\lstdefinestyle{thesis}{
  basicstyle=\small\ttfamily,
  keywordstyle=\bfseries\color{ThesisInk},
  commentstyle=\itshape\color{PolyUGrey},
  stringstyle=\color{ThesisInk},
  numbers=left,
  numberstyle=\scriptsize\ttfamily\color{PolyUGrey},
  frame=single,
  rulecolor=\color{ThesisRule},
  backgroundcolor=\color{white},
  breaklines=true,
  showstringspaces=false,
  columns=fullflexible,
  captionpos=t,
  floatplacement=htbp,
  upquote=true
}
\lstset{style=thesis}
\renewcommand{\lstlistingname}{Listing}
\renewcommand{\lstlistlistingname}{List of Listings}

% Use the thesis spacing and chapter gaps in every float list.
\pretocmd{\@chapter}{%
  \addtocontents{loa}{\protect\addvspace{10\p@}}%
  \addtocontents{lol}{\protect\addvspace{10\p@}}%
}{}{}
\newcommand{\polyu@uniformlist}[2]{%
  \begingroup
    \polyu@applylinespacing
    \chapter*{#1}%
    \@mkboth{\MakeUppercase{#1}}{\MakeUppercase{#1}}%
    \@starttoc{#2}%
  \endgroup
}
\renewcommand{\listoffigures}{\polyu@uniformlist{\listfigurename}{lof}}
\renewcommand{\listoftables}{\polyu@uniformlist{\listtablename}{lot}}
\newcommand{\l@algorithm}{\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand{\listofalgorithms}{\polyu@uniformlist{\listalgorithmname}{loa}}
\renewcommand{\lstlistoflistings}{\polyu@uniformlist{\lstlistlistingname}{lol}}

\newcommand{\thesisfrontchapter}[1]{%
  \clearpage
  \chapter*{#1}%
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
}

\newcommand{\thesisfrontmatter}{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{1}%
}

\newcommand{\thesismainmatter}{%
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

\newcommand{\makecoverpage}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{center}
    \vspace*{18mm}
    {\Large\rmfamily\bfseries\MakeUppercase{\thesistitle}\par}
    \vfill
    {\large\rmfamily\bfseries\MakeUppercase{\studentname}\par}
    \vspace{18mm}
    {\large\degreeabbr\par}
    \vspace{18mm}
    {\large The Hong Kong Polytechnic University\par}
    \ifdualdegree
      \vspace{10mm}
      {\large This programme is jointly offered by The Hong Kong Polytechnic University and \partneruniversity\par}
    \fi
    \vfill
    {\large\awardyear\par}
    \ifinitialsubmission
      \vspace{18mm}
      {\large Initial Submission for Examination Purpose\par}
    \fi
    \vspace*{12mm}
  \end{center}
  \clearpage
}

\newcommand{\makethesistitlepage}{%
  \thispagestyle{empty}%
  \begin{center}
    \vspace*{10mm}
    {\Large\rmfamily\bfseries The Hong Kong Polytechnic University\par}
    \vspace{12mm}
    {\large\department\par}
    \ifdualdegree
      \vspace{6mm}
      {\large\partneruniversity\par}
      \vspace{3mm}
      {\large\partnerdepartment\par}
    \fi
    \vfill
    {\Large\rmfamily\bfseries\thesistitle\par}
    \vfill
    {\large\studentname\par}
    \vfill
    {\large A thesis submitted in partial fulfilment of the requirements for the degree of \degree\par}
    \vfill
    {\large\initialsubmissionmonth\ \initialsubmissionyear\par}
    \vspace*{12mm}
  \end{center}
  \clearpage
}

\crefname{chapter}{Chapter}{Chapters}
\crefname{section}{Section}{Sections}
\crefname{figure}{Figure}{Figures}
\crefname{table}{Table}{Tables}
\crefname{equation}{Equation}{Equations}
\crefname{algorithm}{Algorithm}{Algorithms}
\crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}

\endinput
