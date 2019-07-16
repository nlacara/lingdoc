%% lingdoc.sty
%% (c) 2017--2019 Nicholas LaCara
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% This is a testing version from May 2019. There are bugs.
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Welcome to lingdoc.cls!
%%
%% This is a special class file by Nicholas LaCara, 
%% used to provide special formatting options for 
%% linguistics papers, handouts, &c.
%% 
%% This class takes article.cls as its base
%% and provides several modifications via packages
%% Nick regularly calls. 
%%
%%
%% Important Package Options:
%% 
%% article - for papers and articles
%% handout - portait handout with marginnotes
%% landout - landscape, two-column handout
%%
%% PSTricksOff   - turns off pstricks (faster; good for drafts)
%%
%% times   - turns on Times font in plain LaTeX
%% cmodern - disables special fonts in plain LaTeX (uses computer modern)
%%
%% pdflatex - Disables pst-jtree and pst-node (just in case)
%% expex    - Load expex instead of gb4e-compatibility
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% TO DO:
%%
%% Footnotes per column in landout? May not be possible with
%% multicol, so this might require some serious reworking.
%% 
%% Fix spacing issues with fullwidth environment. (Sort of fixed?)
%% 
%% Make fullwidth do something in landout. Again, seems difficult to
%% implement with multicols.
%% 
%% More sans font options in (PDF)LaTeX mode. 
%% 
%% Implement XeLaTeX support again.
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[2014/01/01]
\ProvidesClass{lingdoc}

%%%% Initial Code %%%%

%% We'll use if-then-else statements 
%% to enact package options

\RequirePackage{ifthen}

%% Layouts
  \newboolean{article}
  \setboolean{article}{false}
  \newboolean{handout}
  \setboolean{handout}{false}
  \newboolean{landout}
  \setboolean{landout}{false}
  
%% Fonts 
  \newboolean{minion}
  \setboolean{minion}{true}
  \newboolean{times}
  \setboolean{times}{false}
%   \newboolean{fontspec}
%   \setboolean{fontspec}{false}
  
  \newboolean{alegreya}
  \setboolean{alegreya}{true}
  \newboolean{montserrat}
  \setboolean{montserrat}{false}
  
%% Font sizes
  \newboolean{10pt}
  \setboolean{10pt}{false}
  \newboolean{11pt}
  \setboolean{11pt}{false}
  \newboolean{12pt}
  \setboolean{12pt}{false}

%% Example packages
  \newboolean{expex}
  \setboolean{expex}{false}
  \newboolean{linguex}
  \setboolean{linguex}{false}
  \newboolean{gb4e}
  \setboolean{gb4e}{false}
  \newboolean{gb4emu}
  \setboolean{gb4emu}{true}

%% Other ling packages
  \newboolean{jtree}
  \setboolean{jtree}{true}

  \newboolean{ottab}
  \setboolean{ottab}{false} 

  \newboolean{tipa}
  \setboolean{tipa}{false}
 
%% Other useful things
  \newboolean{pstricksoff}
  \setboolean{pstricksoff}{false}
  \newboolean{draftfoot}
  \setboolean{draftfoot}{false}
  
  \newboolean{hyperref}
  \setboolean{hyperref}{true}
  
  \newboolean{title}
  \setboolean{title}{true}
  
  \newboolean{noindent}
  \setboolean{noindent}{false}
  
  \newboolean{color}
  \setboolean{color}{false}
  
  \newboolean{nocolor}
  \setboolean{nocolor}{false}
  
  \newboolean{hang}
  \setboolean{hang}{true}

  \newboolean{center}
  \setboolean{center}{false}
  
  \newboolean{natbib}
  \setboolean{natbib}{true}
  
%% Class options %%
  
%%% Layouts %%%
  \DeclareOption{article}{\setboolean{article}{true}\ExecuteOptions{12pt}} %% For papers and articles  
  \DeclareOption{handout}{\setboolean{handout}{true}\ExecuteOptions{11pt}} %% Portrait handout
  \DeclareOption{landout}{\setboolean{landout}{true}\ExecuteOptions{10pt}} %% Landscape handout

%%% Font options %%%
  \DeclareOption{times}{\setboolean{times}{true}\setboolean{minion}{false}}
  \DeclareOption{montserrat}{\setboolean{montserrat}{true}\setboolean{alegreya}{false}}

  \DeclareOption{nofonts}{\setboolean{minion}{false}\setboolean{alegreya}{false}} %% Uses computer modern in plain LaTeX

  \DeclareOption{tipa}{\setboolean{tipa}{true}}

%%% Font sizes %%%  
  \DeclareOption{10pt}{\def\aku@ptsize{0}\setboolean{10pt}{true}}
  \DeclareOption{11pt}{\def\aku@ptsize{1}\setboolean{11pt}{true}}
  \DeclareOption{12pt}{\def\aku@ptsize{2}\setboolean{12pt}{true}}
  
    %% The code above is weird because of the way article.cls handles font sizes.
    %% If \ExecuteOptions{12pt} is called below, it will ignore manually called
    %% 11pt and 12pt options. This gets around this problem.
    %% 
    %% See: https://tex.stackexchange.com/questions/123604/option-seemingly-ignored

%%% Linguistic examples %%%
  \DeclareOption{expex}{\setboolean{expex}{true}\setboolean{gb4emu}{false}} %% Use expex
  \DeclareOption{linguex}{\setboolean{linguex}{true}\setboolean{gb4emu}{false}} %% Use linguex
  \DeclareOption{gb4e}{\setboolean{gb4e}{true}\setboolean{gb4emu}{false}} %% Use linguex instead of GB4e
  \DeclareOption{noex}{\setboolean{gb4emu}{false}} %% Disables all example environments.

%%% Linguistics packages %%%
  \DeclareOption{nojtree}{\setboolean{jtree}{false}} %% Disables pst-jtree/pst-node (jic).
  \DeclareOption{ottab}{\setboolean{tipa}{true}\setboolean{ottab}{true}} %% For ottablx

%%% Other options %%%
  \DeclareOption{draftfoot}{\setboolean{draftfoot}{true}} %% Includes draft notice in footer.
  \DeclareOption{nohyperref}{\setboolean{hyperref}{false}} %% disables hyperref
  \DeclareOption{notitle}{\setboolean{title}{false}} %% Disables automatic \maketitle
  \DeclareOption{PSTricksOff}{\setboolean{pstricksoff}{true}} %% Turn pstricks off
  \DeclareOption{noindent}{\setboolean{noindent}{true}} %% Turns off indentation for the articlelayout.
  \DeclareOption{color}{\setboolean{color}{true}} %% Turns on color headings, sections, and title.
  \DeclareOption{nocolor}{\setboolean{nocolor}{true}\setboolean{color}{false}} %% 
  \DeclareOption{nohang}{\setboolean{hang}{false}} %% Turns off hanging material in the left margin.
  \DeclareOption{center}{\setboolean{center}{true}} %% For centering the textblock in article layout.
  \DeclareOption{nonatbib}{\setboolean{natbib}{false}} %% Disable natbib (if you want to use, e.g., biber)
  
\ExecuteOptions{article}
  
\ProcessOptions \relax
\PassOptionsToClass{1\aku@ptsize pt}{article} %% See the comments in the %%% Font Sizes %%% section above.

%%%% The beginning! %%%%
%% For colors
  \RequirePackage[dvipsnames]{xcolor}


\ifthenelse{\boolean{landout}}%
  {\LoadClass[twoside]{article}}% 10pt for landout
  {\ifthenelse{\boolean{handout}}%
    {\LoadClass[]{article}}% 11pt for handout
    {\LoadClass[twoside]{article}}}% 12 pt for papers
%%%% Author, title, etc... %%%%

% In case notitle is used, but no author/title are defined. 
  \ifthenelse{\boolean{title}}{}{\gdef\@headertitle{\relax}\gdef\@headerauthor{\relax}}
  \ifthenelse{\boolean{title}}{}{\gdef\@shorttitle{}\gdef\@shortauthor{}}

% Renewed and expanded \title command.
\renewcommand{\title}[2][]{%
  \ifstrempty{#1}%
% \@shortitle will be for pdf metadata.
% \@headertitle puts title material in the running headers
% since \@title doesn't behave right there.
    {\gdef\@shorttitle{#2}\gdef\@headertitle{#2}\gdef\@title{#2}}%
% If the optional argument is given, use that in pdf metadata.
% Useful in case the full title contains LaTeX code.
    {\gdef\@shorttitle{#1}\gdef\@headertitle{#2}\gdef\@title{#2}}}
    
% Renewed and expanded \author command.
% Works like \title.
\renewcommand{\author}[2][]{%
  \ifstrempty{#1}%
    {\gdef\@shortauthor{#2}\gdef\@headerauthor{#2}\gdef\@author{#2}}%
    {\gdef\@shortauthor{#1}\gdef\@headerauthor{#2}\gdef\@author{#2}}}
    
% This is a command for affiliation. Typesets after name in the title.
\newcommand*{\affiliation}[1]{\gdef\@affiliation{#1}\gdef\@affiltitle{~\textperiodcentered~#1}}
  \newcommand*{\@affiltitle}{\@latex@warning@no@line{No \noexpand\affiliation given}}

% This is a command for events, classes, talks etc.
% Typesets before date in the title.
\newcommand*{\event}[1]{\gdef\@event{#1}\gdef\@eventtitle{#1~\textperiodcentered~}}
  \newcommand*{\@eventtitle}{\@latex@warning@no@line{No \noexpand\event given}}

% This is used to draw boxed material, 
% including the Abstract environment. 
% \RequirePackage[framemethod=TikZ]{mdframed} 	%% mdframed does weird stuff in floats.
\RequirePackage[most]{tcolorbox} 			%% tcolorbox does too, but it's easier to fix.
  \tcbuselibrary{breakable}				%% Make boxes break over pages.
  
  
% This is a box for the abstract and keywords.
% Still a little buggy, since section headings
% have a bunch of space above them.

\newtcolorbox{AbstractBox}[1][]{%
  sharp corners,
  enhanced,
  colback=absbg,
  colframe=absbar,
  boxrule=0pt,
  leftrule=0.75em,
  colupper=figfg
}

\newenvironment{Abstract}{\begin{fullwidth}\begin{AbstractBox}}{\end{AbstractBox}\end{fullwidth}}

% This provides an abstract section.
\newboolean{abstract}
\setboolean{abstract}{false}
\renewcommand{\abstract}[1]{\setboolean{abstract}{true}\gdef\@abstract{#1}}

% And this provides a command for entering keywords.
% Keywords are set in the keywords section and
% included in the pdf metadata.
\newboolean{keywords}
\setboolean{keywords}{false}
\gdef\@keywords{}
\newcommand{\keywords}[1]{\setboolean{keywords}{true}\gdef\@keywords{#1}}
 


%%%% Page layouts %%%%

% The geometry package is used to set up margins for each layout.
\RequirePackage{geometry}

% These are the options for an academic paper. 
% The margins scaled based on font size.
  \ifthenelse{\boolean{article}\AND\boolean{12pt}}
    {\geometry{letterpaper, width=6in,height=9in}}{}
    
  \ifthenelse{\boolean{article}\AND\boolean{11pt}}
    {\geometry{letterpaper, width=5.5in,height=8.25in}}{}

  \ifthenelse{\boolean{article}\AND\boolean{10pt}}
    {\geometry{letterpaper, width=5in,height=7.5in}}{}
    
  \ifthenelse{\boolean{article}\AND\boolean{center}}{\geometry{centering}}{}
    
% These are the options for a portrait handout.
  \ifthenelse{\boolean{handout}}%
    {\geometry{letterpaper, centering, left=1in, top=1in, height=9in, textwidth=4.75in, marginparsep=0.25in, marginparwidth=1.5in}}{}
    
% These are the options for a landscape handout.
  \ifthenelse{\boolean{landout}}%
    {\geometry{letterpaper, landscape, centering, margin=1in}}{}
    
% Set up headers, page numbers using fancyhdr
  \RequirePackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhead{}
    \fancyfoot{}
  
% This sets a universal length for page and section numbers
% so they begin a consistent lenghth from following/preceding
% material.
  \newlength{\marginno}
  \setlength{\marginno}{2.125em}
  
% This determines whether page/section numbers hang
% in the left margin or not.
  \newlength{\negmarginno}
  \newlength{\pageno}
    \ifthenelse{\boolean{hang}}%
      {\setlength{\negmarginno}{-\marginno}\setlength{\pageno}{\marginno}}%
      {\setlength{\negmarginno}{0em}\setlength{\pageno}{0em}}%

% The handout layout has a different header than paper and landout.
    \ifthenelse{\boolean{handout}}%
      {\fancyhead[L]{\sf\textcolor{head}{\@headerauthor~\textperiodcentered~\@headertitle}}%
	\fancyhead[R]{\sf\textcolor{page}{\thepage}}}%
      {\fancyhead[EL]{\sf\makebox[\marginno][l]{\textbf{\textcolor{page}{\thepage}}}\textcolor{head}{\@headertitle}}%
	\fancyhead[OR]{\sf\textcolor{head}{\@headerauthor}\makebox[\marginno][r]{\textbf{\textcolor{page}{\thepage}}}}}%
	
% The handout layout does not have different even--odd pages.
    \ifthenelse{\boolean{handout}}%
      {\fancyheadoffset[R]{1.75in}%
	\fancyfootoffset[R]{1.75in}}%
      {\fancyheadoffset[EL]{\pageno}%
	\fancyheadoffset[OR]{\pageno}}
	
% This sets a note in the lower right corner that the document is a draft.
    \ifthenelse{\boolean{draftfoot}}{\fancyfoot[R]{\small\sf [Draft -- \today]}}{}

% This format section headings  
\RequirePackage{titlesec}

% Landout does not set section numbers in the left margin, and it
% compensates with different font sizes and weights.
  \ifthenelse{\boolean{landout}}%
   {\titleformat*{\section}{\large\sffamily\bfseries}%
    \titleformat*{\subsection}{\sffamily\bfseries}%
    \titleformat*{\subsubsection}{\sffamily\itshape}%
    \titlelabel{\makebox[\marginno][l]{\thetitle}}}%
% % The other layouts share the same section formatting.
   {\titleformat*{\section}{\color{section}\sffamily\bfseries}%
    \titleformat*{\subsection}{\color{subsection}\sffamily}%
    \titleformat*{\subsubsection}{\color{subsection}\sffamily\itshape}%
    \titlelabel{\hspace*{\negmarginno}\makebox[\marginno][l]{\thetitle}}}


%%%% Some other packages %%%%


%% These are colors used throughout the layouts.
%% They are derived from the ones on my website.
    \definecolor{nblue}{HTML}{092942} 
    \definecolor{nblue2}{HTML}{214E70}
    \definecolor{nblue3}{HTML}{EFF3F6}
    \definecolor{nbrown}{HTML}{663E08}
    
   
%% This sets various aliases for color mode.
  \ifthenelse{\boolean{color}}{%
    \colorlet{section}{nblue2}%
    \colorlet{subsection}{nblue2}
    \colorlet{footnote}{nblue2}
    \colorlet{page}{nblue2}
    \colorlet{head}{nblue}
    \colorlet{margin}{nblue2}
    \colorlet{title}{nblue2}
    \colorlet{titlerule}{nblue}
    \colorlet{date}{nbrown}
    \colorlet{event}{nbrown}
    \colorlet{author}{nbrown}
    \colorlet{affiliation}{nbrown}}{%
%% This sets the default values to black.
    \colorlet{section}{black}%
    \colorlet{subsection}{black}
    \colorlet{footnote}{black}
    \colorlet{page}{black}
    \colorlet{head}{black}
    \colorlet{margin}{black}
    \colorlet{titlerule}{black}
    \colorlet{title}{black}
    \colorlet{date}{black}
    \colorlet{event}{black}
    \colorlet{author}{black}
    \colorlet{affiliation}{black}}
    
%% A few colors are used for citations and links
%% even when the color option isn't used.
%% If the nocolor option is used, these get set
%% to black.
  \ifthenelse{\boolean{nocolor}}{%
    \colorlet{absbar}{black}%
    \colorlet{absbg}{black!05}%
    \colorlet{shadebar}{black}%
    \colorlet{shadebg}{black!10}%
    \colorlet{figfg}{black}%
    \colorlet{link}{black}%
    \colorlet{cite}{black}
    \colorlet{url}{black}}{%
%% This sets the default values to something more colorful.
    \colorlet{absbar}{nblue2}%
    \colorlet{absbg}{nblue3}%
    \colorlet{shadebar}{nblue2}%
    \colorlet{shadebg}{nblue3}%
    \colorlet{figfg}{nblue}%
    \colorlet{link}{nblue2}%
    \colorlet{cite}{nblue}
    \colorlet{url}{nblue2}}%
    
  
% Hyperref includes bookmarks for sections, pdf metadata,
% and internal and external hyperlinks.
\ifthenelse{\boolean{hyperref}}%
  {\RequirePackage{hyperref}%
  \ifxetex \else\RequirePackage{breakurl}\fi%
% This sets up hyperref.
    \hypersetup{colorlinks,
                pdfauthor={\@pdfauthor},
                pdftitle={\@pdftitle},  
                pdfkeywords={\@pdfkeywords},
                linkcolor=link, 
                citecolor=cite, 
                urlcolor=url, 
                breaklinks}}{}   
                
%%%% Typeface setup %%%%

% utf8 document encoding for diacritics, etc...
    \RequirePackage[utf8]{inputenc}
    
% For fancier fonts, we need this.
    \RequirePackage[T1]{fontenc}
    
% This loads microtype if it is installed
% and gives a warning if it is not.
    \IfFileExists{microtype.sty}{\RequirePackage{microtype}}{\ClassWarningNoLine{lacara}{Warning: Microtype not found.}}% %% Makes things look better

% This loads inconsolata as the typewriter font if it is installed.
    \IfFileExists{inconsolata.sty}{\RequirePackage{inconsolata}}{\ClassWarningNoLine{lacara}{Warning: inconsolata.sty not found.}}
    
% This loads Alegreya Sans as the sans font, if it is installed. 
      \ifthenelse{\boolean{alegreya}}% 
        {\IfFileExists{AlegreyaSans.sty}
          {\RequirePackage[osf]{AlegreyaSans}}%
% If Alegreya Sans is not installed, fall back
%to Montserrat, and issue a warning.
          {\@latex@warning@no@line{AlegreySans.sty not found. Falling back to Montserrat!}%
            \setboolean{alegreya}{false}\setboolean{montserrat}{true}}}{}%  Try montserrat.
  
% This loads Montserrat as the sans font, if it is installed. 
      \ifthenelse{\boolean{montserrat}}% 
        {\IfFileExists{montserrat.sty}
          {\RequirePackage[scale=0.82, regular, oldstyle]{montserrat}}%
% If Montserrat is not installed, then
% no special sans font is loaded.
          {\@latex@warning@no@line{montserrat.sty not found.}}}{}

% % This loads Lato as the sans font, if it is installed. 
%     \IfFileExists{lato.sty}{\RequirePackage{lato}}{\ClassWarningNoLine{lacara}{Warning: lato.sty not found.}}

% This loads Quattrocento as the sans font, if they are installed. 
%     \IfFileExists{quattrocento.sty}{\RequirePackage{quattrocento}}{\ClassWarningNoLine{lacara}{Warning: quattrocento.sty not found.}}

 
% This loads the Minion Pro font if it is installed.
      \ifthenelse{\boolean{minion}}% 
        {\IfFileExists{MinionPro.sty}
          {\RequirePackage{MinionPro}}%
% If Minion is not installed, fall back
%to Times, and issue a warning.
          {\@latex@warning@no@line{MinionPro.sty not found. Falling back to Times!}%
            \setboolean{minion}{false}\setboolean{times}{true}}}{}%  Fallback to Times

% Load the Times font for math.
      \ifthenelse{\boolean{times}}% %% Use times if option is called
          {\RequirePackage{mathptmx}}{}%

% tipa handles IPA fonts in LaTeX.
% Turn on with package option ‘tipa’
      \ifthenelse{\boolean{tipa}}
        {\RequirePackage{tipa}% Loads tipa
% Load times fonts for tipa if Minion is being used.
% Otherwise, we would get 
	  \ifthenelse{\boolean{minion}}{\DeclareFontSubstitution{T3}{ptm}{m}{n}}{}}{}
%       \newcommand{\IPAfont}[1]{\ClassWarningNoLine{lacara}{\noexpand\IPAfont defined for XeLaTeX only! Ignoring command.}}

% If OT tableaux are to be typeset, loads OTtablx.
\ifthenelse{\boolean{ottab}}% Use OTtablx
{\ifxetex%
    \RequirePackage[square, open, medium, noipa]{OTtablx}%
  \else %
    \RequirePackage[square, open, medium]{OTtablx}}{}%  

%%%% Other packages %%%%
  
% NatBib is for author--date citations with BibTeX.
\ifthenelse{\boolean{natbib}}{\RequirePackage[sort]{natbib}}{}

% I use the linquiry2 bibstyle, since I am a syntactician.
  \ifthenelse{\boolean{natbib}}{\bibliographystyle{linquiry2}}{}

% A fairly common format for in-line citations.
  \ifthenelse{\boolean{natbib}}{\bibpunct[: ]{(}{)}{,}{a}{}{,}}{}
  
% Gets rid of space between entries in the bibliography.
  \ifthenelse{\boolean{natbib}}{\setlength{\bibsep}{0.0pt}}{}
  
% I use this for macros, but it is not required for use in
% this package. Therefore, it only loads if installed.  
\IfFileExists{xspace.sty}{\RequirePackage{xspace}}%
  {\ClassWarningNoLine{lacara}{Warning: xspace.sty not found}}

% I use this for strikethrough in documents and macros.
% It is not used by this package.
% Option ‘normalem’ keeps ulem from redefining \emph.
\IfFileExists{ulem.sty}{\RequirePackage[normalem]{ulem}}
  {\ClassWarningNoLine{lacara}{Warning: ulem.sty not found}}

% This provides options for typesetting good-looking tables.
% It is not necessary for this package,
% so it only loads if installed.
\IfFileExists{booktabs.sty}{\RequirePackage{booktabs}}%
  {\ClassWarningNoLine{lacara}{Warning: booktabs.sty not found}}

%% For drawing trees
\ifthenelse{\boolean{jtree}}%
  {\RequirePackage{pstricks}%
  \RequirePackage{pst-jtree}%
  \RequirePackage{pst-node}}{}

% Turns off pstricks drawing entirely.
  \ifthenelse{\boolean{pstricksoff}}{\PSTricksOff}{} 

% The first version of this class used the framed package
% to draw boxes. The following are defined for backwards
% compatibility, but they may not work all the time.

% The first is just for regular boxes.
% This is for backward compatibilty with files that
% assumed the framed package was being used.
\newenvironment{framed}{\begin{tcolorbox}[sharp corners, colback=white]}{\end{tcolorbox}}
%
% The framed package also included a shaded box 
% environment. This makes those too, but
% there is more control over what happens.
\newenvironment{shaded}{\begin{tcolorbox}[sharp corners, leftrule=0.75em, rightrule=0em, toprule=0em, bottomrule=0em, colback=shadebg, colframe=shadebar]}{\end{tcolorbox}}
%
% This reimplementation is better since mdframed
% will break boxes over pages.


% % This package is used to boxed material (good in handouts).
% % It is not critical to the package, so only loads if installed.
% \IfFileExists{framed.sty}{\RequirePackage{framed}%
%   \ifthenelse{\boolean{color}}%
%     {\definecolor{shadecolor}{HTML}{EFF3F6}}%
%       {\definecolor{shadecolor}{gray}{0.85}}}%
%   {\ClassWarningNoLine{lacara}{Warning: framed.sty not found}}
  

% Nice multicolumn environments, used by the landout layout.
\RequirePackage{multicol}

% OK, things get weird here.
% To make sure that \multicols gets called after \maketitle
% I decided to make it so they are both called by \begin{document}
% and then \maketitle first. This means that \maketitle
% does not have to be called after the \begin{document} declaration
% The package option ‘notitle’ disables this behavior.
  \ifthenelse{\boolean{landout}}%
    {\setlength\columnsep{2em}%
     \AtBeginDocument%
	{\ifthenelse{\boolean{title}}{\maketitle}{}%
	\frenchspacing%
	\begin{multicols}{2}}%
% End the \multicols environment at the end of the document.
      \AtEndDocument%
	{\end{multicols}}}%
% To facilitate compiling the same document in different layouts,
% the \maketitle behavior described above occurs in the other layouts.
    {\AtBeginDocument%
	{\ifthenelse{\boolean{title}}{\maketitle}{}%
	\frenchspacing}}
  
% This facilitates formatting of list environments.
% It is required by the built-in example environment.
\RequirePackage[inline]{enumitem}

% List bullets/numbers in the margin in handout mode.
  \ifthenelse{\boolean{handout}}{\setlist[1]{leftmargin=0ex}}{}
  
% Marginnotes for handout option  
\ifthenelse{\boolean{handout}}{\RequirePackage{marginnote}}{} 


%%%% Example environments %%%%

% For various reasons, rather than relying on a package for
% linguistic examples, I've imported code from Alan  Munn's
% gb4e-emulate.sty, which duplicates the behavior of gb4e.
% This allows us to disable automath (^ and _ % outside of
% math mode) without any conflicts. It is also more flexible
% than gb4e and typesets material in a way more consistent
% with other example packages.
% However, gb4e-emulate is not widely distributed, so it
% seems better to include it here. 

\ifthenelse{\boolean{gb4emu}}{%
% The following is from gb4e-emulate.sty --
% emulation of gb4e using enumitem for increased flexibility of formatting
% Copyright 2010 by Alan Munn <amunn@msu.edu>
  \RequirePackage{cgloss4e}%
% Set up lists equivalent to those in gb4e
% First the base list (exe)
  \newlist{exe}{enumerate}{1}%
    \setlist[exe]{label={(\arabic*)},widest=88,align=left,topsep= 7\p@ plus2\p@ minus3\p@,itemsep=3\p@ plus2\p@,ref=\arabic*,leftmargin=*,%
      before=\setcounter{exei}{\value{EXE}}, % Added by NL to make counter resume from last no.
      after=\setcounter{EXE}{\value{exei}}}  % even when embedded in other environments.
	\newcounter{EXE}
% Lists for subexamples.
  \newlist{xlist}{enumerate}{3}%
    \setlist[xlist,1]{topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,labelsep=*,parsep=\p@ plus.5\p@ minus.5\p@,label={\alph*.},ref={\arabic{exei}\alph*}, widest=a.,align=left,itemindent=0em,leftmargin=*}%
    \setlist[xlist,2]{topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,labelsep=*,parsep=\p@ plus.5\p@ minus.5\p@,label={\roman*.},ref={\thexlisti.\roman*}, widest=iv.,align=left,itemindent=0em,leftmargin=*}%
    \setlist[xlist,3]{topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,labelsep=*,parsep=\p@ plus.5\p@ minus.5\p@,label={\arabic*.},ref={\thexlistii.\arabic*}, widest=9.,align=left,itemindent=0em,leftmargin=*}%
% Emulate specific lists. Sets up the specific list environments.
  \newenvironment{xlisti}{\begin{xlist}[topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,parsep=\p@ plus.5\p@ minus.5\p@,labelsep=*,label={\roman*.},ref={\arabic{exei}\roman*},widest=iv.,labelsep=*,align=left,itemindent=0em,leftmargin=*]}{\end{xlist}}%
  \newenvironment{xlista}{\begin{xlist}[topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,parsep=\p@ plus.5\p@ minus.5\p@,labelsep=*,label={\alph*.},ref={\arabic{exei}\alph*},widest=a.,labelsep=*,align=left,itemindent=0em,leftmargin=*]}{\end{xlist}}%
  \newenvironment{xlistn}{\begin{xlist}[topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,parsep=\p@ plus.5\p@ minus.5\p@,labelsep=*,label={\arabic*.},ref={\arabic{exei}\arabic*},widest=9.,labelsep=*,align=left,itemindent=0em,leftmargin=*]}{\end{xlist}}%
  \newenvironment{xlistI}{\begin{xlist}[topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,parsep=\p@ plus.5\p@ minus.5\p@,labelsep=*,label={\Roman*.},ref={\arabic{exei}\Roman*},widest=IV.,labelsep=*,align=left,itemindent=0em,leftmargin=*]}{\end{xlist}}%
  \newenvironment{xlistA}{\begin{xlist}[topsep=1.5\p@ plus\p@,itemsep=1.5\p@ plus\p@,parsep=\p@ plus.5\p@ minus.5\p@,labelsep=*,label={\Alph*.},ref={\arabic{exei}\Alph*},widest=M.,labelsep=*,align=left,itemindent=0em,leftmargin=*]}{\end{xlist}}%
% Subexample macro without vertical spacing code from gb4e
  \def\@subex#1#2{\settowidth{\labelwidth}{#1}\itemindent\z@\labelsep#2%
           \parsep\p@ plus.5\p@ minus.5\p@%
           \leftmargin\labelwidth\advance\leftmargin#2\relax}%
% These are the example-items from gb4e.
  \def\ex{\@ifnextchar [{\@ex}{\item}}%
  \def\@ex[#1]#2{\item\@exj[#1]{#2}}%
  \def\@exj[#1]#2{\@exjbg{#1} #2 \end{list}}%
  \def\exi#1{\item[#1]\@ifnextchar [{\@exj}{}}%
  \def\judgewidth#1{\def\@jwidth{#1}}%
  \judgewidth{??}%
  \def\@exjbg#1{\begin{list}{#1}{\@subex{\@jwidth}{0ex}}\item}%
  \def\exr#1{\exi{{(\ref{#1})}}}%
  \def\exp#1{\exi{{(\ref{#1}$'$)}}}%
  \def\sn{\exi{}}}%
% This is the end of gb4e-emulate.sty code.
% This is the else part of the \ifthenelse command above,
% allowing other example packages to be called.
% 
% First, there's linguex:
    {\ifthenelse{\boolean{linguex}}%
    {\RequirePackage{linguex}}%
% Then expex:
    {\ifthenelse{\boolean{expex}}%
      {\RequirePackage{expex}}%
% Finally, for (real) gb4e, automath must disabled since it conflicts
      {\RequirePackage{gb4e}\noautomath% 
% Turn gb4e's automath back on (since people probably expect this).
        \AtBeginDocument{\automath}}}}% 

% Custom formatting stuff


% Set default indent to 1.5em in paper mode unless noindent option is given.
  
  \ifthenelse{\boolean{noindent}}{\setlength{\parindent}{0em}}{%
    \ifthenelse{\boolean{article}}{\setlength{\parindent}{1.5em}}{}}
  
% Set indent to 0em in handout modes. 
  \ifthenelse{\boolean{landout}}{\setlength{\parindent}{0em}}{}
  \ifthenelse{\boolean{handout}}{\setlength{\parindent}{0em}}{}
  
% Shuts up fancyhdr
  \setlength{\headheight}{14.5pt}
  
% In handout mode, it's sometimes nice to have the body extend into
% the right margin, and this environment does that. However, this
% is set up so that it is defined in all layouts.

  \ifthenelse{\boolean{handout}}%
    {\newenvironment{fullwidth}{\vskip\baselineskip\begin{minipage}{6.5in}}{\end{minipage}\vskip\baselineskip}}%
    {\ifthenelse{\boolean{landout}}%
      {\newenvironment{fullwidth}{}{}}%
      {\newenvironment{fullwidth}{}{}}}
      


% This provides a full-width references section for 
% the handout mode.

\newcommand{\References}[1]{%
  \begin{fullwidth}%
    \section*{References}%
      \begin{footnotesize}%
	\begin{multicols}{2}  \renewcommand{\bibsection}{} %
	  \bibliography{#1}%
	\end{multicols}%
      \end{footnotesize}%
  \end{fullwidth}}

% This is all stuff for setting pdf metadata.
% Modified from Semantics & Pragmatics class, first we define commands
% for setting this information
\def\@pdfauthor{\relax}
  \newcommand{\pdfauthor}[1]{\def\@pdfauthor{#1}}
\def\@pdftitle{\relax}
  \newcommand{\pdftitle}[1]{\def\@pdftitle{#1}}
\def\@pdfkeywords{\relax}
  \newcommand{\pdfkeywords}[1]{\def\@pdfkeywords{#1}}
  
% Then, when the \begin{document} is called, this metadata
% is set. This, apparently, cannot be done in the preamble
% or directly in hypersetup. But it works here.
\AtBeginDocument{\pdftitle{\@shorttitle}%
		  \pdfauthor{\@shortauthor}%
		  \pdfkeywords{\@keywords}}


% This sets the date format to DD MMMM YYYY.
\renewcommand{\today}{\number\day\space\ifcase\month\or
   January\or February\or March\or April\or May\or June\or
   July\or August\or September\or October\or November\or December\fi
   \space\number\year}

% Here we redefine \maketitle.
% First, a general format for material under the main title.
  \def\@Title{\noindent{\sf{\scshape\textcolor{author}{\@author}}\textcolor{affiliation}{\@affiltitle} \hfill \textcolor{event}{\@eventtitle}\textcolor{date}{\@date} \par}}

% The way the title is set varies across layouts.
% The handout layout has a wide right margin, but we
% want the title to extend across the whole page.
% Therefore,
\ifthenelse{\boolean{handout}}%
% Handout mode creates the title in a parbox
% that fills the width of the page, going in to
% the left margin. This is probably not the
% right way to do this, but it works.
  {\def\@maketitle{%
  %   \newpage
    \null
      \parbox{6.5in}{%
    \noindent\textcolor{titlerule}{\rule{\linewidth}{0.625ex}}\\%\vskip2pt
    \@Title\vskip0.5ex%
    \noindent{\sf\textbf{\Large \textcolor{title}{\@title}}\par}
    \ifthenelse{\boolean{abstract}}{\sf\vskip0.75ex\noindent{\small\@abstract}\par}{}
    \ifthenelse{\boolean{keywords}}{\sf\vskip0.5ex\noindent\textsc{Keywords:}\ \@keywords}{}
    \vskip-1.5ex\noindent\textcolor{titlerule}{\rule{\linewidth}{0.125ex}}}}\thispagestyle{empty}}
% The other layouts just redefine how the thing looks.
{\def\@maketitle{%
  \newpage
  \null
  \let \footnote \thanks
    \noindent\textcolor{titlerule}{\rule{\linewidth}{0.625ex}}\\%\vskip2pt
    \@Title\vskip0.5ex%
    \noindent{\sf\textbf{\LARGE \textcolor{title}{\@title}}\par}
    \ifthenelse{\boolean{abstract}}{\sf\vskip0.75ex\noindent{\small\@abstract}\par}{}
    \ifthenelse{\boolean{keywords}}{\sf\vskip0.5ex\noindent\textsc{Keywords:}\ \@keywords}{}
    \vskip-1.5ex\noindent\textcolor{titlerule}{\rule{\textwidth}{0.125ex}}}}
  
  
% Here we change how footnotes behave.
% In article and landout layouts, footnote numbers hang
% in the left margin. This value sets how far they hang.
  \newlength{\fnhang} % Dstance of left edge of the footnote number from the beginning of the footnote text.
  \newlength{\negfnhang} % Distance of number hanging into the left margin.
    
% When hanging is called, we want this value to be 0.
  \ifthenelse{\boolean{hang}}{\setlength{\fnhang}{1.5em}\setlength{\negfnhang}{-\fnhang}}{\setlength{\fnhang}{1.5em}\setlength{\negfnhang}{0em}}
% In handout mode, we want sans serif margin notes:
  \ifthenelse{\boolean{handout}}%
    {\renewcommand*{\marginfont}{\color{margin}\sffamily\footnotesize}%
      \let\footnote\marginnote}%
% In other layouts, the footnote number 
% should extend into the left margin. To ease changing between
% handout and other layouts, redefine marginnote as footnote
    {\renewcommand\@makefntext[1]{%
      \noindent\hskip\negfnhang\makebox[\fnhang][l]{\textcolor{footnote}{\@thefnmark}}#1}%
      \let\marginnote\footnote}
      
% Below reformats the table and figure environments.

% Create a new caption style.
\RequirePackage[format=hang, labelfont={bf,sf}, textfont={sf}, labelsep=quad, justification=justified, singlelinecheck=false]{caption}

% First, define a tcolorbox style for the floats.
\newtcolorbox{FloatBox}[1][]{%
  sharp corners,
  enhanced,
  colback=absbg,
  colframe=absbar,
  boxrule=0pt,
  leftrule=0.75em,
  colupper=figfg
}

% Now we redefine the figure environment in order
% to incorporate a box environment.
\let\oldfigure\figure
\let\endoldfigure\endfigure
\renewenvironment{figure}{\begin{oldfigure}\begin{FloatBox}}{\end{FloatBox}\end{oldfigure}}

% And we do the same for the table environment.
\let\oldtable\table
\let\endoldtable\endtable
\renewenvironment{table}{\begin{oldtable}\begin{FloatBox}}{\end{FloatBox}\end{oldtable}}
