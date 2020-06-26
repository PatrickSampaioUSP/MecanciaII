% Adapted from https://github.com/latextemplates/LNCS

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mynotes}

% Support for key-value options
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=mynotes,
  prefix=mynotes@
}

\DeclareBoolOption[true]{loadmath}
\DeclareBoolOption[false]{loadtheorems}

\DeclareBoolOption[false]{titlepage}
\DeclareStringOption[10pt]{fontsize}
\DeclareStringOption[2cm]{margin}

\DeclareBoolOption[false]{landscape}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOptionKey}{mynotes}}

% Execute options
\ProcessKeyvalOptions*

\PassOptionsToClass{fontsize=\mynotes@fontsize}{scrartcl}
\PassOptionsToPackage{margin=\mynotes@margin}{geometry}

\ifmynotes@landscape
  \PassOptionsToPackage{landscape}{geometry}
  \PassOptionsToClass{scrartcl}{geometry}
\fi

\ifmynotes@titlepage
  \PassOptionsToClass{titlepage=true}{scrartcl}
\else
  \PassOptionsToClass{titlepage=false}{scrartcl}
\fi

% TODO: default heading
\PassOptionsToClass{a4paper, version=last, headings=standardclasses, parskip=half}{scrartcl}
\LoadClass{scrartcl}

\RequirePackage{babel}

\RequirePackage{fontspec}
\RequirePackage[english]{selnolig}

\setmainfont{Tex Gyre Pagella}

% Math packages
\ifmynotes@loadmath
  \RequirePackage{mathtools}
  \RequirePackage{amssymb}
  \RequirePackage{amsthm}
  \RequirePackage[math-style=ISO]{unicode-math}

  \RequirePackage{physics}

  \newcommand{\E}[1][]{\ensuremath{\mathbb{E}_{#1}\qty}}
  \renewcommand{\P}{\ensuremath{\mathbb{P}\qty}}

  \setmathfont{TeX Gyre Pagella Math}
\fi

\ifmynotes@loadtheorems
  \ClassWarning{mynotes}{loadtheorems not implemented}
  % TODO: implement this
\fi

\renewcommand*{\fps@figure}{btp}
\appto{\@floatboxreset}{\centering}

\RequirePackage[a4paper]{geometry}
\RequirePackage[babel, final]{microtype}

\RequirePackage[usenames, dvipsnames, table]{xcolor}
\RequirePackage{graphicx}

\RequirePackage{enumitem}

% Better tables
\RequirePackage{array}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{booktabs}

% Implements subfigures
\RequirePackage{subcaption}

% Backticks (`) are rendered as such in verbatim environment.
% See https://tex.stackexchange.com/a/341057/9075 for details.
\RequirePackage{upquote}

% Nicer tables
\RequirePackage{booktabs}

% For easy quotations: \enquote{text}
% This package is very smart when nesting is applied
\RequirePackage{csquotes}

\RequirePackage{url}
%improve wrapping of URLs - hint by http://tex.stackexchange.com/a/10419/9075
\g@addto@macro{\UrlBreaks}{\UrlOrds}

% Put footnotes below floats
% Source: https://tex.stackexchange.com/a/32993/9075
\RequirePackage{stfloats}
\fnbelowfloat

\RequirePackage[bookmarks,
            hidelinks,
            breaklinks,
            pdfusetitle,
            pdfencoding=unicode]{hyperref}

% Enable correct jumping to figures when referencing
\RequirePackage[all]{hypcap}

% Enable \cref{...} and \Cref{...} instead of \ref
\RequirePackage[capitalise,nameinlink]{cleveref}

% Enable use of \thanks in \author without hyperref warning
\let\mynotes@thanks\thanks
\renewcommand{\thanks}[1]{\texorpdfstring{\mynotes@thanks{#1}}{}}
