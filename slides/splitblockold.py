#!/usr/bin/env python3

"""
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
splitblockold.py (Release 1.0.0)
================-------------------------------------------------------------------
(C) in 2016 by Norman Markgraf (nmarkgraf (at) hotmail (dot) com

Pandoc moreblocks filter
Reimplemented all in phyton under panflute.
Older releases (<1.9) are written in Haskel
but only worked with pandoc before 1.17.0.3!


History (Pyhton3 and panflute):
-------------------------------
Release 1.0.0 nm (08.12.2016) New code! Now Pyhton3 and panflute as grid.


Please try PEP8 ! ;-)

> pep8 --show-source --first splitblockold.py

Problems?
    - maybe you should use "#!/usr/bin/env python" as first line? ;-)pandoc
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""
from panflute import (Header, Plain, RawInline, RawBlock,
                      toJSONFilter, debug, Block, MetaInlines)


def prepare(doc):
    debug('Starting "splitblockold.py" ...')


def doColumnsBegin(size):
    ret = ('\\vspace*{-1em}'
           '\\begin{columns}[T]\n'
           '\t\\begin{column}[t]{'+size+'\\textwidth}')
    return RawBlock(ret, format='latex')


def doColumnsSeperator(size):
    ret = ('\t\\end{column}\n'
           '\t\\begin{column}[t]{'+size+'\\textwidth}')
    return RawBlock(ret, format='latex')


def doColumnsEnd():
    return RawBlock('\t\\end{column}\n\\end{columns}\n', format='latex')


def finalize(doc):
    debug('Ending "splitblockold.py" ...')


def splitblockold(e, doc):
    # print(doc.format)
    if doc.format == "latex" or doc.format == "beamer":

        if isinstance(e, Header):
            # debug(e)
            if e.level == 3 or e.level == 5:
                if "twocolumnsbegin" in e.classes:
                    return doColumnsBegin('0.485')
                elif "twocolumnsep" in e.classes:
                    return doColumnsSeperator('0.485')
                elif "twocolumnsend" in e.classes:
                    return doColumnsEnd()
                elif "threecolumnsbegin" in e.classes:
                    return doColumnsBegin('0.33')
                elif "threecolumnsep" in e.classes:
                    return doColumnsSeperator('0.33')
                elif "threecolumnsend" in e.classes:
                    return doColumnsEnd()
                elif "twocolumnsbigleftbegin" in e.classes:
                    return doColumnsBegin('0.66')
                elif "twocolumnsbigleftsep" in e.classes:
                    return doColumnsSeperator('0.33')
                elif "twocolumnsbigleftend" in e.classes:
                    return doColumnsEnd()
                elif "fourquadone" in e.classes:
                    return RawBlock("\\FourQuad{%\n", format="latex")
                elif "fourquadtwo" in e.classes:
                    return RawBlock("\n}{%\n", format="latex")
                elif "fourquadthree" in e.classes:
                    return RawBlock("\n}{%\n", format="latex")
                elif "fourquadfour" in e.classes:
                    return RawBlock("\n}{%\n", format="latex")
                elif "fourquadend" in e.classes:
                    return RawBlock("\n}% END QuadFour\n", format="latex")
            else:
                return
        else:
            return
    else:
        return


if __name__ == "__main__":
    toJSONFilter(splitblockold, prepare=prepare, finalize=finalize)
