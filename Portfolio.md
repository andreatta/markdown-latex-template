<!--
Template to create a good looking pdf document from markdown with the help of a little Latex.
A lot of inspiration is taken from https://github.com/chiakaivalya/thesis-markdown-pandoc. Thank you.

This markdown file can be converted directly from vim:

Convert to pdf
	:!pandoc % -o %:r.pdf
Convert to tex (for further adjustments or to include it in another markdown file)
	:!pandoc % -o %:r.tex
Convert using the make file
	:!make
-->

---
# Latex settings

title: Document Title
subtitle: Maybe a subtitle
author: You know who you are
date: the date

lang: de-CH

# table of content
toc: yes
toc-title: Inhaltverzeichnis
toc-depth: 2
numbersections: yes

# general layout options
papersize: a4
fontsize: 11pt
margin-top: 3cm
margin-bottom: 3cm
documentclass: book
classoption: openright

# colors
links-as-notes: yes
linkcolor: green
citecolor: red
urlcolor: blue
toccolor: black

# add some Latex styling rules and packages not mentioned in the Latex template
header-includes:
	# draw some electronics schematics or other sketches
	- \usepackage{tikz}
	- \usepackage[european]{circuitikz}

	# special symbols box, checkmarks etc
	- \usepackage{wasysym}

	# style header and footer
	- \usepackage{fancyhdr}
	- \pagestyle{plain}

# include title page as Latex file to have more styling options
include-before:
	- \input{templates/title.tex}
---

\clearpage
<!-- Use roman site numbers for first preface ant toc -->
\pagenumbering{Roman}

\chapter*{Preface}

Just a lil' *something* to get you **started** ^[This is a note].  
This chapter is not part of the table of content.

-----
Maybe a thoughtful quote?
-----

\hfill -- cee

<!-- start with page number 1 -->
\mainmatter

# Chapter 1
Some Text and a [Link](#Appendix) to another Chapter.

# Chapter 2

## A list

- item 1
	+ subitem 1
	+ ~~subitem 2~~
- item 2
- item 3

### Or an ordered list

#. Number One
#. Number Two
#. Number Three

## Some \LaTeX math formulas

$$
_{m,n} = 
 \begin{pmatrix}
  a_{1,1} & a_{1,2} & \cdots & a_{1,n} \\
  a_{2,1} & a_{2,2} & \cdots & a_{2,n} \\
  \vdots  & \vdots  & \ddots & \vdots  \\
  a_{m,1} & a_{m,2} & \cdots & a_{m,n} 
 \end{pmatrix}
$$

Or some inline math.

$\pi = {C \over d} = 3.1415$

## Subscript and superscript

H~2~O or 2^8^

## Some fancy symbols

\XBox\				Xbox  
\CheckedBox\ 	CheckedBox  

## Or a blockquote

> blockquote  
> to tell you something

## Code block with syntax highlighting

~~~~~~~{.C .numberLines startFrom="13"}
if (a > 3) {
  moveShip(5 * gravity, DOWN);
}
~~~~~~~

## You can even draw schematics with tikz

Simple example taken from  
<http://www.texample.net/tikz/examples/circuitikz/>

\begin{circuitikz} \draw
	(0,0) to[C] (0,2) -- (0,3.5)
  to[R] (4,3.5) -- (4,2)
  to[L] (4,0) -- (0,0)
  (4,2) to[D*, *-*]
	(2,0) to [D*, -*]
	(0,2) to[R]
	(2,2) to[cV, v=0.3] (4,2)
  (2,0) to[I, -*] (2,2);
\end{circuitikz}

More elaborate example taken from  
<http://www.texample.net/tikz/examples/power-electronics-converter-inverter/>

\begin{center}
\begin{circuitikz}
	\draw
  (0,0)
	to[V, l=$V_s$] ++(0,2.5)
	to[short] ++(1,0) coordinate (A)
	to[short] ++(0.5,0)
	to[L, l=$L_1$, v=$v_{L_1}$] ++(1.5,0)
	to[short] ++(1,0) coordinate (B)
	to[short] ++(1,0) node[above] (C) {1}
	to[open, o-o] ++(0.65,0) coordinate (D)
	to[short] ++(0.5,0)
	to[L, l=$L_2$, v=$v_{L_2}$] ++(1.5,0)
	to[short] ++(0.5,0) coordinate (E)
	to[short] ++(2.5,0)
	to[generic, v=$~~V_o$] ++(0,-2.5)
	--(0,0)
	(A)                                         % Left of L1, top of switch A
	to[short] ++(0,-1.5) node[left] {2}
	to[open, o-o] ++(0,-0.5) node[left] {1}
	|- (0,0)
	(B)                                         % C1 connection starting from top
	to[C, l=$C_1$] ++(0,-1.75) coordinate (Aaux)
	-- ($(A |- Aaux) + (0.5,0)$)
	to[short, o-] ++(-0.5,-0.15)
	($(C)!0.5!(D)$)                             % Switch B low connector
	++(0,-0.5) node[left] {2}
	to[short, o-] ++(0,-0.1)
	|- (0,0)
	(D)                                         % Switch B blade
	to[short] ++(-0.65, -0.1)
	(E)                                         % C2 connection
	to[C, l=$C_2$] ++(0,-2.5)
	(B)                                         % Vc1
	to[open, v=$V_{C_1}~~$] (Aaux)
	;
\end{circuitikz}
\end{center}

---------------

Begin next chapter on a new page.

\clearpage

# Chapter 4 with picture

![Good Code: <https://xkcd.com/844/>](img/good_code.png){height=11cm}

\clearpage

## And a table

These tables are directly taken from [the official Pandoc User's Guide](http://pandoc.org/README.html#tables).

-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.

### And another table without headers

----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
----------- ------- --------------- -------------------------

: Here's a multiline table without headers.

\appendix

# Appendix {#Appendix}

## Include other Latex files

Latex files can be included with 

	\include

or

	\input

\clearpage
\input{templates/kirchhoff.tex}
