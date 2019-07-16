# lingdoc

Lingdoc is a LaTeX class geared primarily at typesetting papers and handouts for linguistics, although it can be used for documents from other fields as well. 

Lingdoc supports three page layouts:

1. A traditional layout for multi-paragraph documents (the default).
2. A handout layout with marginal notes for talks and presentations.
3. A two-column, landscape layout for handouts common in linguistics.

A key feature of Lingdoc is the ability to switch between three layouts with minimal effort, which facilitates converting a handout to a typical document (which was part of my original motivation for creating the class).

The class assumes you have a number of packages installed. See the documentations (lingdoc.pdf) for more details.

### Installation

I assume if you are downloading this from GitHub you know what you are doing.

1. Put it wherever you put latex classes and style files on your system (this might vary; I keep mine in ~/texmf/tex/latex/lingdoc/lingdoc.cls). 
2. Make sure to run $texhash on the appropriate directory (in my case: $ texhash ~/texmf).

### To Do

* Footnotes per column in landout? May not be possible with multicol, so this might require some serious reworking.
* Fix spacing issues with fullwidth environment. (Sort of fixed?)
* Make fullwidth do something in landout. Again, seems difficult to implement with multicols.
* More sans font options in (PDF)LaTeX mode. 
* Implement official XeLaTeX support again. Previous, non-public versions had this. It *will* work with XeLaTeX, but your mileage may vary.


### OSS

This class is open source software, coded using open source software (GNU/Linux (Ubuntu/Fedora), KDE, Kile, and TexLive).
