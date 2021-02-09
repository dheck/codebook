\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{codebook}
\RequirePackage{etoolbox}

\newtoggle{cb@minted}
\DeclareOption{minted}{\toggletrue{cb@minted}}
\newtoggle{cb@drafting}
\DeclareOption{drafting}{\toggletrue{cb@drafting}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,twoside]{book}

\RequirePackage{xifthen, newfloat, xpatch}

% Use option 'gray' to produce B/W version of document.
\RequirePackage[dvipsnames,table]{xcolor}

% For the adjustwidth environment
\RequirePackage[strict]{changepage}

% Layout-related packages
\RequirePackage{titletoc}
\RequirePackage[pagestyles,outermarks,newparttoc,clearempty,explicit]{titlesec}

\RequirePackage{tikz}
\usetikzlibrary{calc,backgrounds}

% Must be loaded after xcolor
\RequirePackage[framemethod=tikz]{mdframed}
% Fix a bug in older versions of mdframed that
% prevents the 'skipbelow' option from working.
\xpatchcmd{\endmdframed}
  {\aftergroup\endmdf@trivlist\color@endgroup}
  {\endmdf@trivlist\color@endgroup\@doendpe}
  {}{}


%---------------------------------------
% #settings
%---------------------------------------

\newlength{\cb@parindent}
\setlength{\cb@parindent}{15pt}
\setlength{\parindent}{\cb@parindent}

\raggedbottom
\frenchspacing  % no additional space after punctuation

% Space between adjacent floats
\setlength{\floatsep}{18pt plus 4pt minus 3pt}
\setlength{\@fpsep}{18pt plus 1fil minus 4pt}

% % Space between top/bottom float and text
\setlength{\textfloatsep}{24pt plus 6pt minus 4pt}

% % % Space before/after 'here' floats.
\setlength{\intextsep}{12pt plus 4pt minus 3pt}

\def\textfraction{.25}
% % Floats that occupy this percentage of a page
% % qualify for being placed on a page of their own.
\def\floatpagefraction{.66}
\def\topfraction{.75}
% \def\bottomfraction{.7}

\setcounter{secnumdepth}{2}

% The vertical spacing between adjacent rules, for example \hline\hline
% or \toprule\toprule.
\setlength{\doublerulesep}{1.5pt}

% \setcounter{topnumber}{2}
% \setcounter{bottomnumber}{1}

%---------------------------------------
% #enumerate, #itemize, #lists
%---------------------------------------
\RequirePackage{enumitem}

\setlist{
  topsep=6pt,
  itemsep=2pt,
  parsep=0pt,
  leftmargin=\parindent,
  align=left,
  labelwidth=\parindent,
  labelsep=0pt
}

\setlist[itemize,1]{label={\raisebox{1pt}{\footnotesize\textbullet}}}
\setlist[itemize,2]{label=\textendash,topsep=2pt}

\setlist[description]{
  labelsep=6pt
}

\newlist{tasks}{enumerate}{1}
\setlist[tasks]{
  label=\alph*),
  font=\mdseries
  }

%---------------------------------------
% #fonts
%---------------------------------------

\RequirePackage[final,letterspace=60,tracking=true]{microtype}
% \SetTracking{ encoding = *, size = small- }{ 1220 }


\RequirePackage[T1]{fontenc}

\RequirePackage{type1cm}
\RequirePackage[largesc]{newpxtext}
\RequirePackage[scale=0.87,semicondensed]{noto-mono}
\RequirePackage[scaled=1.0,proportional]{sourcesanspro}
% \RequirePackage[sf,sflining,scaled=0.92]{merriweather}
\RequirePackage[]{newpxmath}

% \RequirePackage{setspace}
% \setstretch{1.083}
\linespread{1.083}   % leading 13pt
% \linespread{1.125}  % leading 13.5pt

\renewcommand\tiny{\@setfontsize\tiny{6}{7}}
\renewcommand\large{\@setfontsize\large{11.5}{14}}
\renewcommand\Large{\@setfontsize\Large{13}{16}}
\renewcommand\LARGE{\@setfontsize\LARGE{15}{20}}
\renewcommand\huge{\@setfontsize\huge{18}{22}}
\renewcommand\Huge{\@setfontsize\Huge{24}{26}}
\newcommand\HUGE{\@setfontsize\HUGE{28}{32}}


%---------------------------------------
% #colors
%---------------------------------------

\definecolor{cbLightBlue}{HTML}{729fcf}
\definecolor{cbBlue}{HTML}{3465a4}
\definecolor{cbDarkBlue}{HTML}{204a87}
\definecolor{cbLightGreen}{HTML}{73d216}
\definecolor{cbGreen}{HTML}{4e9a06}
\definecolor{cbDarkGreen}{HTML}{336204}
\definecolor{cbLightRed}{HTML}{ef2929}
\definecolor{cbRed}{HTML}{cc0000}
\definecolor{cbDarkRed}{HTML}{a40000}
\definecolor{cbLightOrange}{HTML}{fcaf3e}
\definecolor{cbOrange}{HTML}{f57900}
\definecolor{cbDarkOrange}{HTML}{ce5c00}
\definecolor{cbLightYellow}{HTML}{fce94f}
\definecolor{cbYellow}{HTML}{edd400}
\definecolor{cbDarkYellow}{HTML}{c4a000}
\definecolor{cbLightPurple}{HTML}{ad7fa8}
\definecolor{cbPurple}{HTML}{75507b}
\definecolor{cbDarkPurple}{HTML}{5c3566}
\definecolor{cbLightBrown}{HTML}{e9b96e}
\definecolor{cbBrown}{HTML}{c17d11}
\definecolor{cbDarkBrown}{HTML}{8f5902}
\colorlet{cbLightGray}{black!7}


%---------------------------------------
% #geometry
%---------------------------------------

\RequirePackage{geometry}
\geometry{
  textwidth=4.5in,
  textheight=7.5in,
  marginparsep=0.2in,
  marginparwidth=1.1in,
  headheight=12pt,
  headsep=28pt,
  footskip=24pt,
  papersize={7in,9.25in},
  twoside,
  asymmetric,
  reversemarginpar,
  includemp,    % respect margin when placing text block on paper
  outer=0.54in,
  % bindingoffset=0.156in,
  % showframe,
  top=0.9in,
}

\newlength{\cb@overhang}
\newlength{\fulltextwidth}

\newcommand{\cb@updategeom}{%
  \setlength{\cb@overhang}{\marginparwidth}
  \addtolength{\cb@overhang}{\marginparsep}

  \setlength{\fulltextwidth}{\textwidth}
  \addtolength{\fulltextwidth}{\marginparwidth}
  \addtolength{\fulltextwidth}{\marginparsep}
}

\AtBeginDocument{\cb@updategeom}


%---------------------------------------
% Footnotes and margin notes
%---------------------------------------

% \RequirePackage[hang]{footmisc}
\setlength{\skip\footins}{16pt}
% \renewcommand{\footnoterule}{%
%   \kern -3pt
%   \hrule width \textwidth height 0.3pt
%   \kern 2.6pt
% }
% \renewcommand{\footnotemargin}{1pc}



%------------
% Title page [#titlepage]
%------------
\def\@subtitle{}
\newcommand\subtitle[1]{\gdef\@subtitle{#1}}

\newcommand{\cb@titlefont}
  {\sffamily\bfseries\HUGE}
\newcommand{\cb@subtitlefont}
  {\sffamily\LARGE}
\newcommand{\cb@authorfont}
  {\sffamily\bfseries\LARGE}

\renewcommand{\maketitle}{%
  \hypersetup{pdfauthor=\@author, pdftitle=\@title}%
  \thispagestyle{empty}%
  {%
  \setlength\parindent{0mm}%
  \centering\par
  \par\vspace*{6pc}%
  \parbox{\linewidth}{\centering\cb@titlefont
    \@title}%
  \par\vspace*{3pc}%
  \parbox{\linewidth}{\centering\cb@subtitlefont
    \@subtitle}%
  \par\vfill
  \parbox{\linewidth}{\centering\cb@authorfont
    {{\@author}}}%
  }%
  \newpage
  }

\newenvironment{copyrightpage}
  {%
    \newpage
    \thispagestyle{empty}
    \null
    \vfill\footnotesize
    \setlength{\parindent}{0mm}%
    \setlength{\parskip}{\medskipamount}%
    }
  {}
\newenvironment{dedicationpage}
  {\cleardoublepage
    \null\vspace{5cm}
    \noindent\centering}
  {\vfill}


%---------------------
% Headers and Footers [#head]
%---------------------

\newcommand{\cb@evenhead}{%
  \ifthechapter
    {\@chapapp\ \thechapter.\enspace\textit{\chaptertitle}}
    {}}
\newcommand{\cb@oddhead}{%
  \ifthesection
    {\thesection.\enspace}
    {}%
  {\sectiontitle}}
\newcommand{\cb@page}
  {\textbf{\thepage}}


% Headers and footers extend into the margin
% \widenhead{\cb@overhang}{0cm}%

\newcommand{\cb@draftingnote}
  {\iftoggle{cb@drafting}{\textcolor{gray}{\small\@title---DRAFT---\today}}{}}

% Plain pages are empty except for a page number
% in the bottom-right corner.
\renewpagestyle{plain}{%
  \sethead{}{}{}%
  \setfoot{}{\cb@draftingnote}{\cb@page}%
  }


% Regular pages
\renewpagestyle{headings}[]{%
  \sethead{\cb@draftingnote}{}{}
  % [even pages][][]{odd pages}{}{}
  \setfoot
    [\sffamily\llap{\cb@page\hspace{12mm}}\small\cb@evenhead][][]
    {}{}{\sffamily{\small\cb@oddhead}\hspace*{12mm}\cb@page}
  }
\pagestyle{headings}

%-------------------
% Table of Contents [#toc]
%-------------------
\setcounter{tocdepth}{2}
\contentsmargin{14mm}

% \newcommand{\cb@tocrule}{{\normalfont\normalsize\titlerule*[0.4pc]{.}}}
% \newcommand{\cb@tocrule}{\hspace{2ex}}
\newcommand{\cb@tocrule}{\hfill}
\titlecontents{part}[20pt]
  {\addvspace{30pt}\large\bfseries\scshape}
  {\contentslabel{20pt}}
  {}
  {\hfill\rmfamily\normalsize\contentspage}
  [\vspace{8pt}]

\titlecontents{chapter}[0pt]
  {\addvspace{8pt}\bfseries}
  {\chaptertitlename\ \thecontentslabel.\hspace{1.6ex}}
  {}
  {\cb@tocrule\rmfamily\normalsize\contentspage}
  [\addvspace{4pt}]

\titlecontents{section}[25pt]
  {}
  {\contentslabel{25pt}}
  {}
  {\cb@tocrule\contentspage}

\titlecontents{subsection}[60pt]
  {}
  {\contentslabel{35pt}}
  {\hspace*{-35pt}}
  {\cb@tocrule\contentspage}


%---------------------
% [#part]
%---------------------

\assignpagestyle{\part}{empty}

% Part pages are empty but can contain additional text.
\titleclass{\part}{top}

\titleformat{\part}
  {\raggedright\rmfamily\itshape\bfseries}
  {\makebox[0pt][r]{\raisebox{-9.5pt}[0pt][0pt]{\fontsize{140}{30}\selectfont
      \color{cbLightBlue!50}%
      \thepart}}}
  {0pt}
  {\Huge\fontseries{b}\selectfont{#1}}
  % [{\titlerule[1.2pt]}]

\titlespacing*{\part}
  {0pt}{8pc}{4pc}


%---------------------
% [#chapter]
%---------------------
\assignpagestyle{\chapter}{plain}

\titleformat{\chapter}
  {\raggedright\rmfamily\itshape\Huge\bfseries}
  {\makebox[\textwidth][r]
    {\raisebox{-20pt}[0pt][0pt]{\fontsize{132}{30}\selectfont
      \color{cbLightBlue!50}%
      \thechapter}}%
    \hspace*{-\textwidth}
  }
  {0pt}
  {\strut#1}
  % [{\titlerule[1pt]}]

\titlespacing*{\chapter}
  {0pt}{2pc}{8pc}

%---------------------
% [#section]
%---------------------
\titleformat{\section}
  {\rmfamily\itshape\bfseries\Large\raggedright}
  {%\thesection
    \makebox[0pt][r]{\color{cbDarkBlue}\thesection\hspace*{10pt}}%
  }
  {0pt}
  {#1}

\titlespacing*{\section}
  {0pt}{22pt}{8pt}

%---------------------
% [#subsection]
%---------------------
\titleformat{\subsection}
  {\large\rmfamily\itshape\bfseries}
  {\makebox[0pt][r]{\color{cbDarkBlue}\thesubsection\hspace*{10pt}}}
  {0pt}
  {#1}

\titlespacing*{\subsection}
  {0pt}{18pt}{6pt}

%---------------------
% [#subsubsection]
%---------------------

\titleformat{\subsubsection}
  {\rmfamily\bfseries}
  {\textcolor{cbDarkBlue}{\thesubsubsection}}
  {1.5ex}
  {#1}

\titlespacing*{\subsubsection}
  {0pt}{12pt}{5pt}

%---------------------
% [#paragraph]
%---------------------

\titleformat{\paragraph}
  {\bfseries}
  {\theparagraph}
  {1pc}
  {#1}

\titlespacing*{\paragraph}
  {0pt}{14pt}{2pt}


%---------------------------------------
% #captions
%---------------------------------------
\RequirePackage{caption, subcaption}

\captionsetup{
  font={small},
  labelfont={bf},
  skip=10pt,
  labelsep=quad,
  singlelinecheck=false}

\captionsetup[sub]{
  font={small},
  labelfont={}}

\captionsetup[table]{
  % position=above,
  % labelsep=newline,
  % justification=Centering,
  singlelinecheck=false,
  skip=6pt,
}


% Side captions
\RequirePackage[rightcaption,raggedright, rightbody,]{sidecap}

\def\sidecaptionrelwidth{20}
\sidecaptionvpos{figure}{b}
\def\sidecaptionsep{\marginparsep}

\captionsetup[SCfigure]{
  singlelinecheck=false,
  justification=RaggedRight}

\captionsetup[SCtable]{
  singlelinecheck=false,
  justification=RaggedRight}


%---------------------------------------
% #figure
%---------------------------------------

% Creates a minipage that extends into the margin.
\newenvironment{cb@wide}
  {\begin{adjustwidth}{-\cb@overhang}{0cm}%
    \begin{minipage}{\fulltextwidth}}
  {\end{minipage}\end{adjustwidth}}

\newenvironment{sidefigure}[1][tbp]
  {\begin{SCfigure}[20][#1]}
  {\end{SCfigure}}

\newenvironment{widefigure}[1][tbp]
  {\begin{figure}[#1]\begin{cb@wide}}
  {\end{cb@wide}\end{figure}}


%---------------------------------------
% Tables [#table]
%---------------------------------------

\RequirePackage{array, booktabs}

\heavyrulewidth=0.8pt
\lightrulewidth=0.4pt
\cmidrulewidth=0.4pt
\arrayrulewidth=0.4pt
\belowrulesep=.7ex
\aboverulesep=.45ex

\newenvironment{widetable}[1][tbp]
  {\begin{table}\begin{cb@wide}}
  {\end{cb@wide}\end{table}}

%---------------------------------------
% Epigraphs
%---------------------------------------

\newlength{\epigraphwidth}
\setlength{\epigraphwidth}{3.2in}
\newlength{\epigraphindent}
\setlength{\epigraphindent}{-0.5\dimexpr\marginparwidth+\marginparsep\relax}
\newlength{\beforeepigraphskip}
\setlength{\beforeepigraphskip}{-5pc}
\newlength{\afterepigraphskip}
\setlength{\afterepigraphskip}{2.5pc}

\newenvironment{epigraphs}[1][\epigraphwidth]
  {\vspace*{\beforeepigraphskip}%
    \begin{adjustwidth}{\epigraphindent}{0pt}
    \begin{minipage}{\epigraphwidth}
    \setlength{\parskip}{0pt}%
    \small\raggedright
    \par
  }
  {%
  \end{minipage}
  \end{adjustwidth}
  \vspace*{\afterepigraphskip}}

\newcommand\epigraph[2][]
  {#2
  \ifblank{#1}{}{%
    \begin{itemize}[left=4pt..12pt,rightmargin=4em]
    \item[\mdseries---] {#1}
    \end{itemize}
  }
  % \par\begin{adjustwidth}{0mm}{0mm}\raggedright
  % \mdseries---\,{#1}
  % \end{adjustwidth}
  \par\bigskip}

\newcommand{\chapterindent}{\noindent}


%---------------------------------------
% Exercises [#exercise]
%---------------------------------------

\RequirePackage{answers}
\RequirePackage{ntheorem}

% Define new theorem style for formatting exercises.
\newcommand{\cbexercisesymbol}{$\triangleright$}
\newtheoremstyle{exercise}%
  {\item[\llap{\cbexercisesymbol}\hskip\labelsep\theorem@headerfont ##1 ##2\theorem@separator\hspace{\labelsep}]}%
  {\item[\rlap{\vbox{\hbox{\llap{\cbexercisesymbol}\hskip\labelsep\theorem@headerfont ##1\ ##2\ (##3)\theorem@separator}\hbox{\strut}}}]}

\theoremstyle{exercise}
\theoremheaderfont{\bfseries}
\theorembodyfont{\upshape}
\theoremindent0pt
\theorempreskip{\bigskipamount}
\theorempostskip{\bigskipamount}
\theoremseparator{} 
\newtheorem{exercise}{Exercise}[chapter]

\Newassociation{answer}{cbsolution}{ans}
\renewenvironment{cbsolution}[1]
  {\trivlist\item[]\textbf{#1.}\hspace{\labelsep}}
  {\endtrivlist}

\renewcommand{\solutionextension}{solution}
\Opensolutionfile{ans}[\jobname]

\newcommand{\inputanswers}{%
  \Closesolutionfile{ans}
  \input{\jobname.solution}}


%---------------------------------------
% Listings [#listings]
%---------------------------------------
\RequirePackage{fancyvrb}
\RequirePackage{newfloat}
\iftoggle{cb@minted}
  {\RequirePackage[newfloat]{minted}}
  {}

% Adjust spacing above verbatim environment.
\newlength{\fancyvrbtopsep}
\FV@AddToHook{\FV@ListParameterHook}
  {\topsep=\fancyvrbtopsep}
\setlength{\fancyvrbtopsep}{\abovedisplayskip}
% \setlength{\fancyvrbtopsep}{\baselineskip}


% Modify Verbatim environment to use a smaller font size.
% (We cannot use \fvset{fontsize=} here because this would
% also change the font size of inline \verb|| material.
\RequirePackage{relsize}
\renewcommand\RSpercentTolerance{0}
\RecustomVerbatimEnvironment{Verbatim}{Verbatim}
  {fontsize=\small}%, baselinestretch=1.06}

% Define listing environment, unless one already exists
\ifcsmacro{listing}{}{
  \DeclareFloatingEnvironment[
    fileext=lst,
    placement=tbp,
    name=Listing]{listing}
}
\AtBeginEnvironment{listing}{\fvset{frame=lines,framesep=6pt,framerule=0.4pt}}

\captionsetup[listing]{
  singlelinecheck=false,
  justification=RaggedRight,
  skip=-6pt
}
\RequirePackage{marginnote}
\renewcommand*{\marginfont}{\rmfamily\footnotesize\itshape\color{black}}
\renewcommand*{\raggedleftmarginnote}{\RaggedRight}
\renewcommand*{\raggedrightmarginnote}{\RaggedLeft}

% marginnote doesn't understand asymmetric two-page layouts, so we
% patch its internal test so that it always moves margin notes
% to the left.
\g@addto@macro{\@mn@margintest}{\@tempswatrue}

\newsavebox{\lstcaption}
\newenvironment{lst}[2][]{%
  \goodbreak
  \refstepcounter{listing}%
  \renewcommand{\caption}[1]{%
    \captionlistentry*[listing]{##1}%
    \def\cb@lstcaption{##1}}
  \caption{#2\ifblank{#1}{}{\label{#1}}}%
  \fvset{formatcom=\marginnote{\upshape{\sffamily\bfseries\thelisting}\hspace{1.5ex}\cb@lstcaption}}%
  \ignorespaces
}{%
  \nobreak
}

\newenvironment{lst*}[1]{%
  \goodbreak
  \refstepcounter{listing}%
  \fvset{formatcom=\marginnote{\upshape#1}}%
  \ignorespaces
}{%
  \nobreak
}


%---------------------------------------
% [#hyper]
% Load hyperref after all packages have been set up
%---------------------------------------
\RequirePackage{imakeidx}
\RequirePackage[
    final,
    colorlinks=true,
    linkcolor=.,
    urlcolor=black,
    citecolor=black,
    breaklinks,
    baseurl={http://}
  ]{hyperref}
% \urlstyle{em}
\renewcommand\UrlFont{\itshape}


%---------------------------------------
% Frames and boxes
%---------------------------------------

\DeclareFloatingEnvironment[
  placement=tbp,
  listname={List of Boxes},
  name=Box,
  within=none,
  chapterlistsgaps=off]
  {asidebox}

\mdfdefinestyle{asideframe}{
    linewidth=1pt,
    innertopmargin=12pt, innerbottommargin=14pt,
    innerleftmargin=10pt, innerrightmargin=10pt,
    skipabove=0pt, skipbelow=0pt,
    frametitlefont=\large\rmfamily\itshape\bfseries\color{black},
    frametitlealignment=\raggedright,
    frametitlerule=false,
    % frametitlerulewidth=0.25pt,
    frametitleaboveskip=12pt,
    frametitlebelowskip=0pt,
    frametitlebackgroundcolor=white,
    linecolor=black,
  }

\newenvironment{aside}[1]
  {\begin{asidebox}
    \captionlistentry[asidebox]{#1}%
    \begin{mdframed}[style=asideframe,
      skipabove=\bigskipamount,
      skipbelow=\bigskipamount,
      frametitle={Box \theasidebox.\enspace#1},
    % singleextra={\node[overlay] at ([xshift=-\marginparsep] O |- P) [fill=none, inner sep=2pt,
    %     font=\sffamily\bfseries, text=cbDarkBrown, %draw=cbDarkBrown, fill=cbDarkBrown, text=white, 
    %     inner sep=0pt,
    %     anchor=north east]
    %     {\strut Box \theasidebox};},
      ]%
    \setlength{\parindent}{\cb@parindent}%
  }%
  {%
  \end{mdframed}
  \end{asidebox}
  }

% Customize the quote environment.
\renewenvironment{quote}
  {\list{}{\leftmargin=20pt
    \rightmargin=20pt
    \parsep=0pt
    \listparindent=\cb@parindent}%
    \item\relax}
  {\endlist}

\newenvironment{note}
  {\begin{quote}\small}
  {\end{quote}}

\endinput
