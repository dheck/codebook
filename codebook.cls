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
\usetikzlibrary{calc}

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
  itemsep=3pt,
  parsep=0pt,
  labelsep=6pt,
  font=\bfseries,
  left=0pt .. 20pt,
  labelwidth=!,
}

\setlist[itemize,1]{label={\small\textbullet}}
\setlist[itemize,2]{label=\textendash}

\newlist{tasks}{enumerate}{1}
\setlist[tasks]{
  label=\alph*),
  font=\mdseries
  }

%---------------------------------------
% #fonts
%---------------------------------------

\RequirePackage[final,letterspace=80]{microtype}
\RequirePackage[T1]{fontenc}

\RequirePackage{type1cm}
\RequirePackage[largesc]{newpxtext}
\RequirePackage[scale=0.88,semicondensed]{noto-mono}
\RequirePackage[scaled=1.02,proportional,semibold]{sourcesanspro}
\RequirePackage[]{newpxmath}

% \RequirePackage{setspace}
% \setstretch{1.083}
\linespread{1.1}

\renewcommand\tiny{\@setfontsize\tiny{6}{7}}
\renewcommand\large{\@setfontsize\large{11.5}{14}}
\renewcommand\Large{\@setfontsize\Large{13}{17}}
\renewcommand\LARGE{\@setfontsize\LARGE{15}{20}}
\renewcommand\huge{\@setfontsize\huge{20}{24}}
\renewcommand\Huge{\@setfontsize\Huge{24}{29}}
\newcommand\HUGE{\@setfontsize\HUGE{30}{36}}


%---------------------------------------
% #colors
%---------------------------------------

\definecolor{cbLightBlue}{HTML}{729fcf}
\definecolor{cbBlue}{HTML}{3465a4}
\definecolor{cbDarkBlue}{HTML}{204a87}
\definecolor{cbLightGreen}{HTML}{8ae234}
\definecolor{cbGreen}{HTML}{73d216}
\definecolor{cbDarkGreen}{HTML}{4e9a06}
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
  textwidth=4.65in,
  textheight=7.5in,
  marginparsep=0.15in,
  marginparwidth=1in,
  headheight=12pt,
  headsep=24pt,
  footskip=24pt,
  papersize={7in,9.25in},
  twoside,
  includemp,    % respect margin when placing text block on paper
  outer=0.56in,
  % bindingoffset=0.156in,
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
  {\sffamily\fontseries{sb}\HUGE}
\newcommand{\cb@subtitlefont}
  {\sffamily\itshape\LARGE}
\newcommand{\cb@authorfont}
  {\sffamily\huge}

\renewcommand{\maketitle}{%
  \hypersetup{pdfauthor=\@author, pdftitle=\@title}%
  \thispagestyle{empty}%
  {%
  \setlength\parindent{0mm}%
  \raggedright\par
  \par\vspace*{6pc}%
  \parbox{\linewidth}{\raggedright\cb@titlefont
    \@title}%
  \par\vspace*{18pt}%
  \parbox{\linewidth}{\raggedright\cb@subtitlefont
    \@subtitle}%
  \par\vspace*{24pc}%
  \parbox{\linewidth}{\raggedright\cb@authorfont
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
    {\@chapapp\ \thechapter.\enspace{\chaptertitle}}
    {}}
\newcommand{\cb@oddhead}{%
  \ifthesection
    {\thesection.\enspace}
    {}%
  \textit{\sectiontitle}}
\newcommand{\cb@page}
  {{\bfseries\thepage}}


% Headers and footers extend into the margin
\widenhead*{0cm}{\cb@overhang}%

% Plain pages are empty except for a page number
% in the bottom-right corner.
\renewpagestyle{plain}{%
  \sethead{}{}{}
  \setfoot
    {\iftoggle{cb@drafting}{\sffamily\small\today}{}}
    {}{\cb@page}}


% Regular pages
\renewpagestyle{headings}[]{%
  % [even pages][][]{odd pages}{}{}
  \setfoot
    [][][\iftoggle{cb@drafting}{\sffamily\small\today}{}]
    {\iftoggle{cb@drafting}{\sffamily\small\today}{}}{}{}
  \sethead
    [\cb@page\hspace{6mm}\cb@evenhead][][]
    {}{}{\cb@oddhead\hspace*{6mm}\cb@page}
  }
\pagestyle{headings}

%-------------------
% Table of Contents [#toc]
%-------------------
\setcounter{tocdepth}{2}
\contentsmargin{8mm}

% \newcommand{\cb@tocrule}{{\normalfont\normalsize\titlerule*[0.5pc]{.}}}
% \newcommand{\cb@tocrule}{\hspace{2ex}}
\newcommand{\cb@tocrule}{\hfill}
\titlecontents{part}[0mm]
  {\vspace{30pt}\Large\sffamily}
  {{\thecontentslabel}\hspace{1.5ex}\fontseries{sb}\selectfont}
  {}
  {\hfill\contentspage}
  [\vspace*{-8pt}\rule{\linewidth}{0.4pt}\vspace*{6pt}]

\titlecontents{chapter}[0mm]
  {\addvspace{6pt}\sffamily\bfseries}
  {\large\rule{0pt}{16pt}\makebox[20pt][r]{\mdseries\thecontentslabel\hspace{1.5ex}}}
  {\hspace*{20pt}\rule{0pt}{10pt}}
  {\cb@tocrule\contentspage}
  []

\titlecontents{section}[20pt]
  {\addvspace{2pt}\sffamily}
  {\makebox[20pt][r]{\color{black}\thecontentslabel\hspace{1.5ex}}\bfseries}
  {\makebox[20pt][l]{}\bfseries}
  {\cb@tocrule\contentspage}

\titlecontents{subsection}[40pt]
  {\sffamily}
  {\makebox[26pt][l]{\fontseries{l}\selectfont\thecontentslabel}}
  {\makebox[26pt][l]{}}
  {\cb@tocrule\contentspage}


%---------------------
% [#part]
%---------------------

% Part pages are empty but can contain additional text.
\assignpagestyle{\part}{empty}
\titleclass{\part}{top}

\titleformat{\part}[display]
  {\centering\sffamily%\titlerule[0.4pt]
  }
  {\huge\fontseries{l}\selectfont\textcolor{cbBlue}{\partname\ \thepart}%
  % \titlerule
  }
  {12pt}
  {%
  % \vspace*{12pt}%
  \Huge\fontseries{sb}\selectfont{#1}}

\titlespacing*{\part}
  {0pt}{6\baselineskip}{6\baselineskip}


%---------------------
% [#chapter]
%---------------------
\assignpagestyle{\chapter}{plain}

\titleformat{\chapter}[display]
  {\raggedright\sffamily}
  {\huge\fontseries{l}\selectfont\textcolor{cbBlue}{{\@chapapp}~\thechapter}}
  {1pc}
  {\huge\bfseries{#1}}

\titleformat{name=\chapter,numberless}[display]
  {\raggedright\sffamily}
  {}
  {1pc}
  {\huge\fontseries{sb}\selectfont{#1}}

\titlespacing*{\chapter}
  {0pt}{1.5pc}{5pc}

%---------------------
% [#section]
%---------------------
\titleformat{\section}
  {\sffamily\bfseries\Large\raggedright}
  {\mdseries\thesection}
  {1.5ex}
  {#1}

\titlespacing*{\section}
  {0pt}{24pt}{9pt}

%---------------------
% [#subsection]
%---------------------
\titleformat{\subsection}
  {\sffamily\large}
  {\fontseries{l}\selectfont\thesubsection}
  {1.5ex}
  {#1}

\titlespacing*{\subsection}
  {0pt}{16pt}{8pt}


\titleformat{\subsubsection}
  {\sffamily\itshape}
  {\thesubsection}
  {1.5ex}
  {#1}


%---------------------
% [#paragraph]
%---------------------

\titleformat{\paragraph} %[runin]
  {\bfseries}
  {\theparagraph}
  {1pc}
  {#1}

\titlespacing*{\paragraph}
  {0pt}{15pt}{3pt}


%---------------------------------------
% #captions
%---------------------------------------
\RequirePackage{caption, subcaption}

\captionsetup{
  font={small},
  labelfont={bf},
  skip=10pt,
  labelsep=period,
  singlelinecheck=true}

\captionsetup[sub]{
  font={small},
  labelfont={}}

\captionsetup[table]{
  position=above,
  labelsep=newline,
  justification=Centering,
  singlelinecheck=false,
  labelfont={normalsize,bf,sc},
  skip=2pt,
}


% Side captions
\RequirePackage[centerbody,rightcaption]{sidecap}

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
  {\begin{adjustwidth*}{0cm}{-\cb@overhang}%
    \begin{minipage}{\fulltextwidth}}
  {\end{minipage}\end{adjustwidth*}}

\newenvironment{sidefigure}[1][tbp]
  {\begin{SCfigure}[1][#1]}
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

\newenvironment{widetable}[1][tbp]
  {\begin{table}\begin{cb@wide}}
  {\end{cb@wide}\end{table}}

%---------------------------------------
% Epigraphs
%---------------------------------------

\newlength{\epigraphwidth}
\setlength{\epigraphwidth}{3in}
\newlength{\beforeepigraphskip}
\setlength{\beforeepigraphskip}{0mm}
\newlength{\afterepigraphskip}
\setlength{\afterepigraphskip}{2\baselineskip}

\newenvironment{epigraphs}[1][\epigraphwidth]
  {\vspace*{\beforeepigraphskip}%
    \begin{adjustwidth}{\dimexpr\linewidth-#1\relax}
        {0mm}
    \setlength{\parskip}{0pt}%
    \small
    \par
  }
  {\end{adjustwidth}
  \vspace*{\afterepigraphskip}}

\newcommand\epigraph[2][]
  {\RaggedRight\noindent#2\\[2pt]
  \noindent\kern1sp---\,{#1}\par\bigskip}


%---------------------------------------
% Exercises [#exercise]
%---------------------------------------

\RequirePackage{answers}
\let\openbox\relax

\Newassociation{answer}{cb@solution}{ans}

\newcommand{\cb@exerciseprefix}{}
\newcounter{exercise}[chapter]
\renewcommand{\theexercise}{\thechapter.\arabic{exercise}}
\newenvironment{exercise}[1][]
  {\refstepcounter{exercise}%
    \paragraph{\makebox[0mm][r]{\mdseries}Exercise\ \theexercise%
      \ifblank{#1}{}{\hspace{1.2ex}\mdseries\rmfamily\itshape#1}%
      {\hspace{1.5ex}\cb@exerciseprefix}}}
  {}

\renewenvironment{cb@solution}[1]
  {\paragraph{Exercise #1}}
  {}

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
\setlength{\fancyvrbtopsep}{\baselineskip}


% Modify Verbatim environment to use the updated font size.
% (\fvset{fontsize=} would also change the size of
% inline verbatim material.)
\RequirePackage{relsize}
\renewcommand\RSpercentTolerance{0}
\RecustomVerbatimEnvironment{Verbatim}{Verbatim}
  {fontsize=\relscale{0.96}, baselinestretch=1.08} %\fontsize{9}{11}}

% \FV@AddToHook\FV@ListParameterHook{\vspace{-6pt}}

\DefineVerbatimEnvironment{FVerbatim}{Verbatim}{
  xleftmargin=0pt
}

% Default settings for verbatim environments that occur
% as part of the text.
\fvset{
    baselinestretch=1,
    % xleftmargin=\cb@parindent
  }

% Settings for verbatim environments inside lst environments
\newcommand{\cb@setuplisting}{}%

% Font used for Verbatim blocks and long code listings.
\renewcommand{\cb@setuplisting}{%
  \fvset{
    % xleftmargin=0pt,
    rulecolor=black,
    }%
  % \setlength{\fancyvrbtopsep}{2pt}%
}

% Define listing environment, unless one already exists
\ifcsmacro{listing}{}{
  \DeclareFloatingEnvironment[
    fileext=lst,
    placement=tbp,
    name=Listing]{listing}
}


\let\cb@origlisting=\listing
\renewcommand{\listing}[1][tbp]
  {\cb@origlisting\cb@setuplisting\fvset{xleftmargin=0pt,frame=lines,framesep=6pt}}

\captionsetup[listing]{
  singlelinecheck=false,
  justification=RaggedRight,
  skip=-6pt
}
\RequirePackage{marginnote}
\renewcommand*{\marginfont}{\footnotesize\itshape\color{cbBlue}}
\renewcommand*{\raggedleftmarginnote}{\RaggedRight}
\renewcommand*{\raggedrightmarginnote}{\RaggedLeft}

\RequirePackage{needspace}

\newsavebox{\lstcaption}
\newcommand\emitlabel{}
\newenvironment{lst}[2][]{%
  \goodbreak
  \cb@setuplisting
  \refstepcounter{listing}%
  \ifblank{#1}{}{\label{#1}}%
  \captionlistentry*[listing]{#2}%
  \renewcommand{\emitlabel}{}%
  \fvset{formatcom=\marginnote{\rmfamily\scriptsize\fbox{\thelisting}\\[2pt]#2}}%
  \ignorespaces
}{%
  \nobreak
}

\newenvironment{lst*}[1]{%
  \goodbreak
  \cb@setuplisting
  \refstepcounter{listing}%
  \renewcommand{\emitlabel}{}%
  \fvset{formatcom=\marginnote{\rmfamily\scriptsize#1}}%
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
    urlcolor=cbBlue,
    citecolor=cbBlue,
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
    linewidth=0.8pt,
    innertopmargin=28pt, innerbottommargin=12pt,
    innerleftmargin=14.2pt, innerrightmargin=14.2pt,
    skipabove=0pt, skipbelow=0pt,
    frametitlefont=\sffamily\fontseries{b}\selectfont\color{black},
    frametitlealignment=\raggedright,
    frametitlerule=false,
    frametitlerulewidth=0.25pt,
    frametitleaboveskip=12pt,
    frametitlebelowskip=0pt,
    frametitlebackgroundcolor=white,
    linecolor=cbDarkBrown,
  }

\newenvironment{aside}[1]
  {\begin{asidebox}
  \captionlistentry[asidebox]{#1}%
    \begin{mdframed}[style=asideframe,
      skipabove=\bigskipamount,
      skipbelow=\bigskipamount,
    singleextra={\node at ([xshift=0pt] O |- P) [fill=none, inner sep=2pt,
        font=\sffamily\fontseries{b}\selectfont, fill=cbDarkBrown, text=white, anchor=north west]
        {\hspace*{1.3ex}\strut Box \theasidebox.\hspace{1.5ex}#1\hspace*{1.3ex}};},
      ]%
    \setlength{\parindent}{\cb@parindent}%
  }%
  {%
  \end{mdframed}
  \end{asidebox}
  }

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
