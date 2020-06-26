% Adapted from https://tex.stackexchange.com/questions/8827/preparing-cheat-sheets
% and https://github.com/ACHinrichs/LaTeX-templates/blob/master/cheatsheet/cheatsheet.cls%

% Package options:
%  columns=<n>
%
% Document template:
% \documentclass{mycheatsheet}
% 
% \begin{document}
%   \title{<title>}
%   \subject{<subject>}
%   \author{<author>}
%   \date{<date>}
%   \maketitle
%   ...
% \end{document}
% 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycheatsheet}[2019/08/08 Cheatsheet class]
\RequirePackage{kvoptions}

\SetupKeyvalOptions{ family=mcs, prefix=mcs@ }
\DeclareStringOption[3]{columns}
\DeclareStringOption[8pt]{fontsize}
\DeclareVoidOption{twocolumn}{\ClassError{mycheatsheet}{`twocolumn' is not supported,
  use `columns=2' instead}{}}
\DeclareBoolOption[true]{coloredheadings}
\DeclareBoolOption[true]{numberedtheorems}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOptionKey}{mynotes}}
\ProcessKeyvalOptions*

\LoadClass[portuguese-br,
           landscape,
           fontsize=\mcs@fontsize,
           margin=1cm,
           loadmath,
           loadtheorems=false]{mynotes}

\RequirePackage{luatex85}
\RequirePackage{etoolbox}
\RequirePackage{xparse}

\RequirePackage[allowlitunits, inter-unit-product=\ensuremath{\cdot}]{siunitx}

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{xifthen}

\RequirePackage{tikz}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.16}

% Turn off header and footer
\pagestyle{empty}

\definecolor{headings}{RGB}{20,80,130}

\ifmcs@coloredheadings
  \def\mcs@headingcolor{headings}
\else
  \def\mcs@headingcolor{black}
\fi

% Redefine section commands to use less space
\setcounter{secnumdepth}{1}
\renewcommand{\section}{\@startsection{section}{1}{0mm}%
                                {-1ex plus -.5ex minus -.2ex}%
                                {0.5ex plus .2ex}%x
                                {\normalfont\Large\bfseries\color{\mcs@headingcolor}}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{0mm}%
                                {-1ex plus -.5ex minus -.2ex}%
                                {0.5ex plus .2ex}%
                                {\normalfont\large\bfseries\color{\mcs@headingcolor}}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0mm}%
                                {-1ex plus -.5ex minus -.2ex}%
                                {0.5ex plus .2ex}%
                                {\normalfont\normalsize\bfseries\color{\mcs@headingcolor}}}

\renewcommand{\maketitle}{%
  {\centering%
    \ifdefempty{\@subject}{}{\normalfont\normalcolor\large\bfseries\@subject\\[.5ex]}%
    \ifdefempty{\@title}{}{\normalfont\normalcolor\LARGE\bfseries\@title\\[.5ex]}%
    \ifdefempty{\@author}{}{\normalfont\normalcolor\large\@author\\[.5ex]}%
    \ifdefempty{\@date}{}{\normalfont\normalcolor\large\@date\\[.5ex]}%
  }%
}

\setlength{\parskip}{0pt plus 0.5ex}
\setlength{\tabcolsep}{3pt}

\newcommand{\zerodisplayskips}{%
  \setlength{\abovedisplayskip}{1pt plus 1pt}%
  \setlength{\belowdisplayskip}{1pt plus 1pt}%
  \setlength{\abovedisplayshortskip}{1pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{1pt plus 1pt}}
\appto{\normalsize}{\zerodisplayskips}
\appto{\small}{\zerodisplayskips}
\appto{\footnotesize}{\zerodisplayskips}


% Theorems

% TODO: put this on notes and start using the loadtheorems flag
\RequirePackage[tikz]{mdframed}

\newtheorem{mcs@thmcounter}{}[section]

\ifmcs@numberedtheorems
  \newcommand\mcs@newtheorem@inner[2]{\newtheorem{#1}[mcs@thmcounter]{#2}}
\else
  \newcommand\mcs@newtheorem@inner[2]{\newtheorem*{#1}{#2}}
\fi

\mdfsetup{
  innertopmargin=-3pt,
  innerleftmargin=3pt,
  innerrightmargin=3pt,
  innerbottommargin=3pt,
}

\NewDocumentCommand\mcs@newtheorem{m m o}{
  \mcs@newtheorem@inner{#1}{#2}
  \mcs@newtheorem@inner{framed#1}{#2}
  \surroundwithmdframed{framed#1}
  
  \IfValueT{#3}{
    \AtBeginEnvironment{#1}{#3}
    \AtBeginEnvironment{framed#1}{#3}
  }
}

\theoremstyle{definition}
\mcs@newtheorem{definition}{Def}[\renewcommand{\emph}[1]{\textit{\textbf{#1}}}]
\mcs@newtheorem{theorem}{T}
\mcs@newtheorem{corollary}{Cor}
\mcs@newtheorem{notation}{Not}
\mcs@newtheorem{remark}{Obs}
\mcs@newtheorem{example}{Ex}
\mcs@newtheorem{interpretation}{Int}

\newtheoremstyle{named}{}{}{}{}{\bfseries}{.}{.5em}{\thmnote{#3}}
\theoremstyle{named}
\mcs@newtheorem{namedtheorem}{}


\mdfdefinestyle{mcs@framed}{
  nobreak,
  innertopmargin=.7\baselineskip,
  singleextra={
    \node[xshift=10pt,fill=white,anchor=west,inner xsep=2pt,inner ysep=0pt] at (P-|O) %
    {\strut\textbf{\mcs@frametitle}};
  },
}

\newenvironment{framed}[1]{%
  \def\mcs@frametitle{#1}%
  \begin{mdframed}[style=mcs@framed]%
}{%
  \end{mdframed}%
}


\newcommand{\units}[1]{\ensuremath{\left[\si{#1}\right]}}
\newcommand{\qunits}[1]{\ensuremath{\quad\units{#1}}}


% Lists
\setlist{noitemsep, nolistsep}
\setlist[1]{itemsep=.1ex plus 2ex, leftmargin=2em}
\setlist[2]{itemsep=.1ex plus 1ex, leftmargin=1em}
\setlist[description]{%
  font={\normalfont\bfseries}
}
\setlist[enumerate, 1]{%
  label=(\alph*)
}
\setlist[enumerate, 2]{%
  label=(\roman*)
}

% Setup columns
\AtBeginDocument{
  \raggedright
  \begin{multicols*}{\mcs@columns}
      % multicol parameters
      % These lengths are set only within the two main columns
      %\setlength{\columnseprule}{0.25pt}
      \setlength{\premulticols}{1pt}
      \setlength{\postmulticols}{1pt}
      \setlength{\multicolsep}{1pt}
      \setlength{\columnsep}{2pt}
}

\AtEndDocument{
  \end{multicols*}
}
