#import "@preview/simple-plot:0.3.0": plot
#import "@preview/cetz:0.3.4": canvas, draw

#import "@preview/theorion:0.6.0": *
//#import cosmos.simple: *
#import cosmos.fancy: *
//#import cosmos.rainbow: *
//#import cosmos.clouds: *
#show: show-theorion
#set-inherited-levels(3)

#let (exercise-counter, exercise-box, exercise, show-exercise) = make-frame(
  "exercise",
  "Exercise",
  counter: lemma-counter,
  //inherited-from: heading,
  render: lemma-box.with(),  // reuse definition's render/style
)

#import "@preview/lovelace:0.3.1": *

#set heading(numbering: "1.1.1.1.1")
//#set math.equation(numbering: none)
#set math.equation(numbering: "(1)")
#set page(numbering: "1", number-align: center, margin: 1.5in)
#set par(justify: true)
#set text(
  size: 11pt
)

#set list(indent: 1em)
#set enum(indent: 1em)
#show heading: set block(below: 1.5em, above: 1.5em)
#show math.equation: set text(size: 0.9em)
#show figure.caption: set align(center)
#show ref: set text(fill:blue)
#show link: it => text(fill:blue, underline(it))
#show figure.caption: set text(size: 0.9em)
#show figure.where(kind: table): set figure.caption(position: top)

// Inline code
#show raw.where(block: false): it => box(fill: rgb("#f0f0f0"), inset: (x: 2pt), radius: 2pt, it)

// Code blocks

#show raw.where(block: true): it => block(
  fill: gray.lighten(80%),
  inset: 10pt,
  radius: 5pt,
  width: 100%,
  text(size: 0.85em, it)
)

#let code(body) = raw(body, lang: none)
#let sat = smallcaps[sat]
#let unsat = smallcaps[unsat]
#let relu = math.op("relu")


//#set par(first-line-indent: (amount: 1.5em, all: false))

#let mytitle = "Neural Network Verification"
#let mysubtitle = "A Guide for Researchers and Practitioners"
#let me = "ThanhVu (Vu) Nguyen"
#let institute = "George Mason University"
#let mybookgithub = "https://code.roars.dev/phd-cs-us"


#let alert(txt) = {highlight(fill:red.lighten(30%))[#txt]}
#let paragraph(title, body) = {
  v(0.5em)
  text(weight: "bold", style: "italic")[#highlight(fill:gray.lighten(70%))[#title] ]
  body
}


#let simpsons(s) = quote(
    attribution: [#text(size:0.85em)[*The Simpsons* 😱]],
    block:true
  )[
      #text(style:"italic", size:0.85em)[#s]
  ]

  
#let cb(who: none, fill:gray, icon, msg) = block(
  width: 100%,
  fill: fill,
  radius: (right: 5pt),
  stroke: (left: 3pt + fill.darken(10%)),
  inset: (left: 10pt, right: 10pt, y: 10pt),
)[
    #icon 
  #if who != none [
    #text(weight: "bold", size: 0.9em)[#who] \
  ]
  #text(size: 0.85em)[#msg]
]


#let comment(who, color, msg) = [
  #text(fill: color)[*#who*: #msg]
]

#let tvn(msg) = comment("TVN", red, msg)
#let hd(msg) = comment("HD", blue, msg)

#let bab = [#smallcaps[BaB]]
#let tool = [#smallcaps[NeuralSAT]]

#show figure.where(kind: image): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure(supplement: [Tab.])
#show math.equation: set math.equation(supplement: [Eq.])
#show heading: set heading(supplement: [Sec.])





// Title Page
#align(center)[
  #box(
    stroke: (x: 3pt + olive, y: 3pt + olive),
    inset: 1in
  )[
    #v(0.5fr)
    #text(size: 22pt, weight: "bold")[#mytitle]
    #v(1em)
    #text(size: 16pt, weight: "bold")[#mysubtitle]
    #v(1fr)
    //#image("files/usamap.png", width: 100%)
    #v(1fr)
    #text(size: 18pt)[*#me* and *Hai Duong*]
    #v(0.2fr)
    #text(size: 14pt)[#institute]
  ]
]

#pagebreak()


#v(1fr)
#emph-block[
    This #link(mybookgithub)[work] © #datetime.today().year() by #me and Hai Duong is licensed under CC BY-NC-ND 4.0. To view a copy of this license, visit #link("https://creativecommons.org/licenses/by-nc-nd/4.0/")[creativecommons.org].
]


#pagebreak()
#outline(title: "Contents and Summary")
#pagebreak()


#heading(numbering: none)[Preface]



#pagebreak()



// \documentclass[oneside,11pt,dvipsnames]{book}
// \setcounter{secnumdepth}{3}

// \usepackage{xcolor}
// \definecolor{myred}{RGB}{255,100,100}
// \definecolor{yellowfill}{RGB}{255,245,200}
// \definecolor{codegreen}{rgb}{0,0.6,0}
// \definecolor{codegray}{rgb}{0.5,0.5,0.5}
// \definecolor{codepurple}{rgb}{0.58,0,0.82}
// \definecolor{backcolour}{rgb}{0.97,0.97,0.97}
// \usepackage[utf8]{inputenc}
// \usepackage[T1]{fontenc}
// \usepackage[margin=1.5in]{geometry}
// \usepackage{amsmath,amssymb,amsthm}
// \usepackage{complexity}
// \usepackage{etoolbox}
// \usepackage{hyperref}
// \hypersetup{
//   colorlinks,
//   citecolor=black,
//   filecolor=black,
//   linkcolor=blue,
//   urlcolor=blue,
// }

// \usepackage{soul}
// \usepackage[most]{tcolorbox}

// \numberwithin{equation}{section}
// \newtheorem{theorem}{Theorem}[section]
// \newtheorem{lemma}{Lemma}[section]
// \newtheorem{corollary}{Corollary}[section]

// % Definitions and remarks usually use a different style:
// \theoremstyle{definition}
// \newtheorem{definition}{Definition}[section]
// \newtheorem{example}{Example}[section]
// \newtheorem{problem}{Problem}[section]
// %\newtheorem{solutione}{Solution}[section]
// \theoremstyle{remark}
// \newtheorem{remark}{Remark}


// \newbool{showsol}
// \setbool{showsol}{false} % set to false to hide solutions

// \newenvironment{solution}{%
//   \ifbool{showsol}{%
//     \begin{mysolbox}%
//         {\small \textbf{Solution}: }
//   }{%
//     \comment % start ignoring
//   }%
// }{%
//   \ifbool{showsol}{%
//     \end{mysolbox}%
//   }{%
//     \endcomment % stop ignoring
//   }%
// }

// % \setsecnumdepth{subsection}
// % \setcounter{tocdepth}{3}
// \usepackage{multirow,multicol}
// \usepackage{enumitem}
// \usepackage{epigraph}
// \usepackage{cite}
// \usepackage{caption}
// \usepackage{adjustbox}
// \usepackage{makecell}
// \usepackage{longtable}
// \captionsetup{font=small}
// \usepackage{graphicx}
// \usepackage{pdfpages}
// \usepackage{wrapfig}
// \usepackage{subcaption}
// \setlength in textsep{0pt} % remove extra space above and below in-line float
// %\usepackage{cleveref}
// \usepackage{booktabs}
// \usepackage{tikz}
// \usetikzlibrary{calc,positioning,intersections}
// \tikzstyle{input}=[circle,draw=green,fill=green!20,thick]
// \tikzstyle{hidden}=[circle,draw=yellow,fill=yellowfill,thick]
// \tikzstyle{output}=[circle,draw=red,fill=red!20,thick]

// \usepackage{pgfplots}
// \pgfplotsset{compat=1.18}

// \usepackage{anyfontsize}
// \usepackage{sectsty}

// \usepackage[makeroom]{cancel}

// \usepackage{listings}
// \lstset{basicstyle=\ttfamily\scriptsize,
//   language=Python,
//   morekeywords={assert},
//   keywordstyle=\color{blue},
//   commentstyle=\color{magenta},
//   numbers=none,
//   mathescape,
//   stepnumber=1,
//   numbersep=8pt,
//   tabsize=4,
//   showspaces=false,
//   showstringspaces=false,
//   emph={},
//   emphstyle=\color{red}\bfseries
// }
// \definecolor{keywords}{RGB}{0,35,197}
// \definecolor{comments}{RGB}{19,121,0}
// \definecolor{highlight}{RGB}{255,255,102}


// \usepackage[linesnumbered,ruled,vlined]{algorithm2e}
// \SetKwFor{Parfor}{parfor}{do}{endparfor}

// \SetKwInOut{Input}{input}
// \SetKwInOut{Output}{output}

// \SetKw{Break}{break}
// \SetKw{Continue}{continue}
// \SetKw{In}{in}
// \SetKwData{certified}{certified}
// \SetKwData{prooftree}{proof}
// \SetKwData{uncertified}{uncertified}
// \SetKwData{model}{model}
// \SetKwData{leaf}{node}
// \SetKwData{mynull}{null}
// \SetKwData{layer}{layer}
// \SetKwData{layer}{layer}
// \SetKwData{layerbounds}{layer\_bounds}
// \DontPrintSemicolon

// \SetAlgoCaptionSeparator{.}
// \SetAlCapFnt{\footnotesize\rm}
// \SetAlCapNameFnt{\footnotesize\rm}

// \newcommand{\mycode}[1]{\textrm{\texttt{#1}}}



// \newtoggle{usecomment}
// \settoggle{usecomment}{false}

// \newcommand{\tcomment}[1]{\iftoggle{usecomment}{#1}{}}
// \newcommand{\tvn}[1]{\iftoggle{usecomment}{{\color{red}{[TVN]: #1}}}{}}

// \newcommand{\mbd}[1]{\iftoggle{usecomment}{{\color{magenta}{[MBD]: #1}}}{}}
// \newcommand{\hd}[1]{\iftoggle{usecomment}{{\color{blue}{[HD]: #1}}}{}}
// \newcommand{\hai}[1]{\iftoggle{usecomment}{{\color{blue}{[HD]: #1}}}{}}

// \newcommand{\mynew}[1]{\iftoggle{usecomment}{{\color{red}{[NEW]: #1}}}{}}
// \newcommand{\alert}[1]{{\color{red}{#1}}}
// %\newcommand{\ignore}[1]{}

// \newcommand{\blue}[1]{\textcolor{blue}{#1}}
// \newcommand{\red}[1]{\textcolor{red}{#1}}

// \newcommand{\mytitle}{Introduction to Deep Neural Network Verification}
// %\newcommand{\mysubtitle}{A Handbook for Navigating CS PhD Admissions in the U.S.}
// \newcommand{\mybookaddress}{\href{https://roars.dev/book_nnv/book.pdf}{https://roars.dev/book_nnv/book.pdf}}
// \newcommand{\mybookgithub}{https://code.roars.dev/book_nnv}
// \newcommand{\me}{}
// \newcommand{ in stitute}{George Mason University}

// \newtcolorbox{mybox}{
//   enhanced,
//   boxrule=0pt,frame hidden,
//   borderline west={2pt}{0pt}{green!75!black},
//   colback=green!10!white,
//   sharp corners
// }

// \newenvironment{commentbox}[1][]{
//   \small
//   \begin{mybox}
//     {\small \textbf{#1}}
//   }{
//   \end{mybox}
// }

// \newtcolorbox{mysolbox}{
//   enhanced,
//     breakable,
//   boxrule=0pt,frame hidden,
//   borderline west={2pt}{0pt}{red!75!black},
//   colback=blue!10!white,
//   sharp corners
// }

// \newcommand{\ignore}[1]{}


// \makeatletter
// % for cross references
// % \renewcommand{\algorithmcflinename}{L.}and use it in
// \renewcommand{\algorithmautorefname}{Alg.}
// \renewcommand{\figureautorefname}{Fig.}
// \renewcommand{\tableautorefname}{Tab.}
// \renewcommand{\equationautorefname}{Eq.}
// \providecommand{\definitionautorefname}{Def.}
// \renewcommand{\chapterautorefname}{\textsection\@gobble}
// \renewcommand{\sectionautorefname}{\textsection\@gobble}
// \renewcommand{\subsectionautorefname}{\textsection\@gobble}
// \renewcommand{\subsubsectionautorefname}{\textsection\@gobble}
// \renewcommand{\appendixautorefname}{\textsection\@gobble}

// \newcommand{\exampleautorefname}{Ex.}
// \newcommand{$"ActPatterns"$autorefname}{Prob.}

// \makeatother
// \newcommand{\proofgen}{\texttt{BaB$_{\text{ProofGen}}$}}
// \newcommand{\prooflang}{\texttt{BaB$_{\text{ProofLang}}$}}
// \newcommand{\proofcheck}{\texttt{BaB$_{\text{ProofCheck}}$}}
// \newcommand{\veristable}{\texttt{VeriStable}}
// \newcommand{\crown}{\texttt{$alpha\beta$-CROWN}}
// \newcommand{\nnenum}{\texttt{nnenum}}
// \newcommand{\sobolbox}{\texttt{SobolBox}}
// \newcommand{\marabou}{\texttt{Marabou}}
// \newcommand{\eran}{\texttt{ERAN}}
// \newcommand{\reluplex}{\texttt{Reluplex}}
// \newcommand{\reluval}{\texttt{Reluval}}
// \newcommand{\neurify}{\texttt{Neurify}}
// \newcommand{\nnv}{\texttt{NNV}}
// \newcommand{\ovalnnv}{\texttt{OVAL}}
// \newcommand{\dnnv}{\texttt{DNNV}}
// \newcommand{\verinet}{\texttt{VeriNet}}
// \newcommand{\mnbab}{\texttt{MN-BaB}}
// % \newcommand{\vnncomp}{VNN-COMP'23}
// \newcommand{\planet}{\texttt{Planet}}
// \newcommand{\bab}{\texttt{BaB$_{\text{NNV}}$}}
// \newcommand{\neuralsat}{\texttt{NeuralSAT}}
// \newcommand{\tool}{\texttt{NeuralSAT}}
// \newcommand{\pyrat}{\texttt{PyRAT}}
// \newcommand{\cora}{\texttt{CORA}}
// \newcommand{\mipverify}{\texttt{MIPVerify}}
// \newcommand{\crowndefault}{\texttt{$alpha\beta$-CROWN} (default)}

// \newcommand{\myrelu}{\mathrm{ReLU}}
// \newcommand{\relu}[1]{\mathrm{ReLU}<=ft(#1\right)}
// \newcommand{\sigmoid}[1]{\mathrm{sigmoid}<=ft(#1\right)}
// \newcommand{\mytanh}[1]{\mathrm{tanh}<=ft(#1\right)}
// \newcommand{\softmax}[1]{\mathrm{softmax}<=ft(#1\right)}

// \newcommand{\sat}{\texttt{sat}}
// \newcommand{\unsat}{\texttt{unsat}}

// \newcommand{\code}[1]{\texttt{#1}}

// \lstdefinelanguage{SMTLIB}{
//     morekeywords={assert, declare-const, declare-pwl, or, and, },
//     alsoletter={-},
//     morecomment=[l];,
//     morestring=[b]",
//     morekeywords=[2]{Real, Int, ReLU},
//     keywordstyle=[2]\color{codepurple},
// }

// \lstdefinestyle{SMTLIB-style}{
//     backgroundcolor=\color{backcolour},
//     commentstyle=\color{codegreen},
//     keywordstyle=\color{blue},
//     numberstyle=\tiny\color{black},
//     stringstyle=\color{codepurple},
//     basicstyle=\ttfamily\footnotesize,
//     breakatwhitespace=false,
//     breaklines=true,
//     captionpos=b,
//     keepspaces=true,
//     numbers=left,
//     numbersep=5pt,
//     showspaces=false,
//     showstringspaces=false,
//     showtabs=false,
//     tabsize=2,
// }

// % \lstset{
// %     language=SMTLIB,
// %     style=SMTLIB-style
// % }


// \begin{document}

// \pagestyle{empty}


// \begin{tikzpicture}[overlay,remember picture]

//     % Background color
//     \fill[
//     black!2]
//     (current page.south west) rectangle (current page.north east);

//     % Rectangles
//     \shade[
//     left color=Dandelion,
//     right color=Dandelion!40,
//     transform canvas ={rotate around ={45:($(current page.north west)+(0,-6)$)}}]
//     ($(current page.north west)+(0,-6)$) rectangle ++(9,1.5);

//     \shade[
//     left color=lightgray,
//     right color=lightgray!50,
//     rounded corners=0.75cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(.5,-10)$)}}]
//     ($(current page.north west)+(0.5,-10)$) rectangle ++(15,1.5);

//     \shade[
//     left color=lightgray,
//     rounded corners=0.3cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(.5,-10)$)}}] ($(current page.north west)+(1.5,-9.55)$) rectangle ++(7,.6);

//     \shade[
//     left color=orange!80,
//     right color=orange!60,
//     rounded corners=0.4cm,
//     transform canvas ={rotate around ={45:($(current page.north)+(-1.5,-3)$)}}]
//     ($(current page.north)+(-1.5,-3)$) rectangle ++(9,0.8);

//     \shade[
//     left color=red!80,
//     right color=red!80,
//     rounded corners=0.9cm,
//     transform canvas ={rotate around ={45:($(current page.north)+(-3,-8)$)}}] ($(current page.north)+(-3,-8)$) rectangle ++(15,1.8);

//     \shade[
//     left color=orange,
//     right color=Dandelion,
//     rounded corners=0.9cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(4,-15.5)$)}}]
//     ($(current page.north west)+(4,-15.5)$) rectangle ++(30,1.8);

//     \shade[
//     left color=RoyalBlue,
//     right color=Emerald,
//     rounded corners=0.75cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(13,-10)$)}}]
//     ($(current page.north west)+(13,-10)$) rectangle ++(15,1.5);

//     \shade[
//     left color=ForestGreen,
//     rounded corners=0.3cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(18,-8)$)}}]
//     ($(current page.north west)+(18,-8)$) rectangle ++(15,0.6);

//     \shade[
//     left color=ForestGreen,
//     rounded corner

//     transform canvas ={rotate around ={45:($(current page.north west)+(19,-5.65)$)}}]
//     ($(current page.north west)+(19,-5.65)$) rectangle ++(15,0.8);

//     \shade[
//     left color=OrangeRed,
//     right color=red!80,
//     rounded corners=0.6cm,
//     transform canvas ={rotate around ={45:($(current page.north west)+(20,-9)$)}}]
//     ($(current page.north west)+(20,-9)$) rectangle ++(14,1.2);



//     % Title
//     \node[align=center] at ($(current page.center)+(0,-5)$)
//     {
//         {\fontsize{24}{24} \selectfont {{Introduction to}}} \\[0.15in]
//         {\fontsize{24}{24} \selectfont {{Deep Neural Network Verification}}} \\[1in]
//         %{\fontsize{18}{18} \selectfont {{A Handbook for International Students}}} \\[1.in]

//         {\fontsize{14}{19.2} \selectfont \textcolor{ForestGreen}{ \bf \me{}}}\\[0.1in]

//     \today{} (latest version available on \href{\mybookgithub}{Github})
//     };
//     \end{tikzpicture}


// \newpage
// \pagestyle{empty}


// % \begin{figure}[h]
// %     \centering
// %      in cludegraphics[scale=0.1]{files/IMG_0785.jpeg}
// %     \caption{Two of my angels. They are breeding and laying eggs. <fig:angelfish}
// %   \end{figure}




// \vspace*{\stretch{1}}

// \begin{tcolorbox}[enhanced]
//     \small
//     This \href{\mybookgithub}{work} © 2025 by \me{} is licensed under CC BY-NC-ND 4.0. To view a copy of this license, visit \url{https://creativecommons.org/licenses/by-nc-nd/4.0/}
// \end{tcolorbox}





// %\chapter*{Preface}



// \newpage
// \tableofcontents




// \newcommand{\proofnet}[1]{
// \begin{tikzpicture}[scale=#1,every node/.style={scale=#1},->,semithick]
//   % Styles


//   % Nodes
//   \node[input]  (x1) at (0,1) {$x_1$};
//   \node[input]  (x2) at (0,-1) {$x_2$};

//   \node[hidden] (v1) at (2.5,1) {$v_1$};
//   \node[hidden] (v2) at (2.5,-1)   {$v_2$};
//   \node[hidden] (v3) at (5,1) {$v_3$};
//   \node[hidden] (v4) at (5,-1) {$v_4$};

//   \node[output] (y1) at (7.5,1) {$y_1$};
//   \node[output] (y2) at (7.5,-1) {$y_2$};

//   % Edges with weights
//   % x1 to hidden
//   \draw (x1) -- (v1) node[midway,above] {$-0.5$};


//   \draw (x1) -- (v2) node[near end,below] {$0.3$};

//   % x2 to hidden
//   \draw (x2) -- (v2) node[midway,below] {$0.2$};
//   \draw (x2) -- (v1) node[near end,above] {$0.2$};


//   % hidden layer connections
//   \draw (v1) -- (v3) node[midway,above] {$-0.9$};

//   \draw (v1) -- (v4) node[near end,below] {$0.6$};


//   \draw (v2) -- (v4) node[midway,below] {$0.9$};
//   \draw (v2) -- (v3) node[near end,above] {$0.6$};

//   % hidden to outputs
//   \draw (v3) -- (y1) node[midway,above] {$-0.1$};
//   \draw (v3) -- (y2) node[near end,below] {$-0.3$};
//   \draw (v4) -- (y1) node[near end,above] {$0.2$};
//   \draw (v4) -- (y2) node[midway,below] {$0.5$};

//   % biases
//   \node[above] at (v1.north) {$-0.5$};
//   \node[above] at (v3.north) {$0.2$};
//   \node[above] at (y1.north) {$-0.4$};

//   \node[below] at (v2.south) {$0.3$};
//   \node[below] at (v4.south) {$-0.1$};
//   \node[below] at (y2.south) {$-0.5$};

// \end{tikzpicture}
// }


//Basics of Neural Networks and Verification
= Neural Networks <chap:nn-basics>

== Basics of Neural Networks
A _neural network_ (*NN*) @Goodfellow-et-al-2016 consists of an input layer, multiple hidden layers, and an output layer. Each layer has a number of neurons, each connected to neurons in the next layer through a predefined set of weights (computed during training). 
A _Deep Neural Network_ (*DNN*) is an NN with _two_ or more hidden layers.


The output of an NN is obtained by iteratively computing  the  values  of  neurons  in  each  layer.
The value of a neuron in the input layer is the input data.
The value of a neuron in the hidden layers is computed by applying an _affine transformation_ (@sec:affine) to values of neurons in the previous layers, then followed by an _activation function_ (@sec:activation) such as ReLU and Sigmoid.
The value of a neuron in the output layer is computed similarly but may skip the activation function.

== NN as a Function
We can view an NN as a function that maps input vectors to output vectors:

$ f: RR^n -> RR^m $

where $n$ is the number of input neurons and $m$ is the number of output neurons. The neurons in the input layer are the inputs to the function, and the neurons in the output layer are the outputs of the function. The neurons in the hidden layers are also functions that transform the inputs from the previous layer to produce outputs for the next layer.



#let mydnn(sc: 100%) = figure(
  scale(sc)[
    #canvas({
      import draw: *
      let r = 0.42
      let x1 = (0, 2)
      let x2 = (0, 0)
      let x3 = (3, 2)
      let x4 = (3, 0)
      let x5 = (5, 1)

      let edges = (
        (x1, x3, "-0.5", "above"),
        (x1, x4,  "0.5", "below"),
        (x2, x3,  "0.5", "above"),
        (x2, x4, "-0.5", "below"),
        (x3, x5, "-1.0", "above"),
        (x4, x5,  "1.0", "below"),
      )

      // pass 1: lines only
      for (a, b, label, side) in edges {
        let dx = b.at(0) - a.at(0)
        let dy = b.at(1) - a.at(1)
        let len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / len
        let uy = dy / len
        let start = (a.at(0) + r * ux, a.at(1) + r * uy)
        let end   = (b.at(0) - r * ux, b.at(1) - r * uy)
        line(start, end, stroke: 1pt, mark: (end: ">"))
      }

      // pass 2: labels on top of lines
      for (a, b, label, side) in edges {
        let dx = b.at(0) - a.at(0)
        let dy = b.at(1) - a.at(1)
        let len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / len
        let uy = dy / len
        let sign = if side == "above" { 1 } else { -1 }
        let mx = (a.at(0) + b.at(0)) / 2 + (-uy * 0.25 * sign)
        let my = (a.at(1) + b.at(1)) / 2 + ( ux * 0.25 * sign)
        content((mx, my), box(fill: gray.lighten(70%), inset: 1pt, text(size: 9pt)[#label]))
      }

      // pass 3: nodes on top of everything
      for (pos, label, fill-color, value) in (
        (x1, $x_1$, green.lighten(50%),  ""),
        (x2, $x_2$, green.lighten(50%),  ""),
        (x3, $x_3$, yellow.lighten(50%), "1.0"),
        (x4, $x_4$, yellow.lighten(50%), "-1.0"),
        (x5, $x_5$, red.lighten(50%),    "-1.0"),
      ) {
        circle(pos, radius: r, stroke: 1pt, fill: fill-color)
        content(pos, label)
        content((pos.at(0), pos.at(1) - 0.65), text(size: 9pt)[#value])
      }
    })
  ]
)


#figure(
mydnn(sc: 100%),
  caption: [A simple network with two inputs $x_1,x_2$, two hidden neurons $x_3,x_4$, and one output neuron $x_5$.],
) <fig:dnn>

#example[
@fig:dnn shows an NN with two inputs $x_1, x_2 in RR$, two hidden neurons $x_3, x_4$ in one hidden layer, and one output neuron $x_5$. The connections between the neurons are weighted edges, and the biases are shown below each neuron.



- The hidden neurons compute:
  $ x_3 =  relu(-0.5 x_1 + 0.5 x_2 + 1.0), x_4 =  relu(0.5 x_1 - 0.5 x_2 - 1.0), $
  where $ relu(x) = "max"(x, 0)$ is the ReLU activation function.
- The output neuron computes:
  $ x_5 = -1.0 dot x_3 + 1.0 dot x_4 - 1.0. $

Thus, this NN computes a function $f: RR^2 -> RR$ where:
$ f(x_1, x_2) = - relu(-0.5 x_1 + 0.5 x_2 + 1.0) +  relu(0.5 x_1 - 0.5 x_2 - 1.0) - 1.0. $
] <ex:dnn>

== Affine Transformation <sec:affine>

The affine transformation (AF) of a neuron consists of a _linear combination_---a weighted sum $sum$---of its inputs, followed by the addition of a bias term. More specifically, for a neuron with weights $w_1, dots, w_n$, bias $b$, and inputs $v_1, dots, v_n$ from the previous layer, the AF computes:

$ f(v_1, v_2, dots, v_n) = sum_(i=1)^(n) w_i v_i + b. $ <eq:affine>

#example[
In @fig:dnn, neuron $x_3$ receives inputs $x_1$ and $x_2$ with weights $-0.5$, $0.5$, and bias $1.0$, so its AF is $x_3 = -0.5 x_1 + 0.5 x_2 + 1.0$.
]


// % \paragraph{Matrix Form} AF can also be represented in matrix form.
// % \begin{equation}
// % f(v_1, v_2, \dots,v_n) = \begin{pmatrix}
// % w_1 & w_2 & dots & w_n
// % \end{pmatrix}
// % \begin{pmatrix}
// % v_1 \\
// % v_2 \\
// % \vdots \\
// % v_n
// % \end{pmatrix}
// % +
// % b,
// % \end{equation}


// % or equivalently,
// % \begin{equation}
// % f(\vec{v}) = W \vec{v} + b,
// % \end{equation}
// % where $W$ is the weight matrix, $\vec{x}$ is the input vector, and $b$ is the bias vector.


// % The affine transformation can be expressed in matrix form as follows:

// % \[
// % \begin{pmatrix}
// % x_3 \\
// % x_4
// % \end{pmatrix}
// % =
// % \begin{pmatrix}
// % -0.5 & 0.5 \\
// % 1.0 & 1.0
// % \end{pmatrix}
// % \begin{pmatrix}
// % x_1 \\
// % x_2
// % \end{pmatrix}
// % +
// % \begin{pmatrix}
// % 1.0 \\
// % \end{pmatrix}
// % =
// % \begin{pmatrix}
// % -0.5 & 0.5 \\
// % 1.0 & 1.0
// % \end{pmatrix}
// % \begin{pmatrix}
// % x_1 \\
// % x_2
// % \end{pmatrix}
// % +
// % \begin{pmatrix}
// % 1.0 \\
// % -1.0
// % \end{pmatrix}
// % \]

== Activation Functions <sec:activation>
Activation functions in NNs are mathematical functions applied to the output of a neuron after the affine transformation. They introduce non-linearity to the network, allowing it to learn complex patterns in the data. Without activation functions, an NN would simply be a linear model, regardless of the number of layers, and would not be able to capture intricate relationships in the data. 

@tab:activation summarizes the most common activation functions used in NNs, their equations, output ranges, and key uses.

#figure(caption: [Summary of Common Neural Network Activation Functions],
  text(size: 0.9em,
  table(
    columns: 4,
    align: left, stroke: none,
    [*Name*], [*Equation*], [*Output Range*], [*Key Use*],
    table.hline(),
    [ReLU], $max(0, x)$, $[0, infinity)$, [Hidden layers, fast train],
    [Sigmoid], $frac(1, 1 + e^(-x))$, $(0, 1)$, [Binary classification],
    [Tanh], $tanh(x)$, $(-1, 1)$, [Hidden layers, zero-centered],
    [Softmax], $frac(e^(x_i), sum_j e^(x_j))$, $(0, 1), sum_i=1$, [Multi-class output],
  ))
) <tab:activation>


=== ReLU (Rectified Linear Unit) <sec:relu>

ReLU is a widely used activation function in neural networks. It is defined as:


$
 relu(x) = max(0, x) = cases(
0 & "if " x <= 0,
x & "if " x > 0
)
$

ReLU(x) is called #highlight[piecewise linear] because it consists of two linear segments as shown in @fig:relu: (i) a constant function that always return $0$ when $x <= 0$, (ii) an identity function that returns $x$ when $x > 0$.
A ReLU activated neuron is said to be _active_ if its input is greater than zero and _inactive_ otherwise.

// #figure(
//   caption: [ReLU (Rectified Linear Unit) function.],  
//   {

//     plot(
//     xmin: -4, xmax: 4,
//     ymin: -2, ymax: 4,
//     width:6, height:4,
//     xlabel: $x$,
//     ylabel: $y$,
//     show-grid: true,
//     (fn: x => if x < 0 {0} else {x}, stroke: red + 1.2pt),
//     )
//   }
// ) <fig:relu>


#figure(
  canvas(length: 0.45cm, {
    import draw: *

    // axes through the origin, with arrowheads
    line((-4.5, 0.0), (4.5, 0.0), mark: (end: ">"), stroke: 1pt)
    line((0.0, -0.5), (0.0, 4.5), mark: (end: ">"), stroke: 1pt)

    // x-axis ticks and labels
    for x in (-4, -2, 0, 2, 4) {
      if x != 0 {
        line((x, -0.1), (x, 0.1), stroke: 0.5pt)
      }
      content((x, -0.4), text(size: 7pt)[#x], anchor: "north")
    }

    // y-axis ticks and labels
    for y in (2, 4) {
      line((-0.1, y), (0.1, y), stroke: 0.5pt)
      content((-0.4, y), text(size: 7pt)[#y], anchor: "east")
    }

    // ReLU curve: flat at zero for x <= 0, then linear for x >= 0
    line((-4.5, 0.0), (0.0, 0.0), stroke: red.darken(20%) + 1.5pt)
    line((0.0, 0.0), (4.5, 4.5), stroke: red.darken(20%) + 1.5pt)
  }),
  caption: [ReLU (Rectified Linear Unit) function.]
) <fig:relu>


#paragraph[Logical encoding][ 
ReLU can be encoded using the following logical formula:

$
y =  relu(x) <==> (x <= 0 and y = 0) or (x > 0 and y = x)
$

In other words, if $x <= 0$, $y$ must be 0; otherwise, $y$ must equal $x$.
]

#example[
In Z3, we can declare ReLU using `If()`
```python
    import z3
    def relu(x): return z3.If(x <= 0, 0, x)

    relu(-1.2)  # returns 0
    relu(0)     # returns 0
    relu(2.8)   # returns 2.8
```]

#paragraph[Nonlinear Property][
Despite being piecewise linear, ReLU is *nonlinear* because it does not satisfy the two core properties of a linear function:

- _Additivity:_ $ relu(x + y) !=  relu(x) +  relu(y)$ in general.
- _Homogeneity:_ $ relu(alpha x) != alpha dot  relu(x)$ when $alpha < 0$.

In simpler terms, ReLU is nonlinear because it does not form a straight line. It has a *kink*---a sharp bend---when $x = 0$, where the slope changes abruptly from $0$ to $1$. This discontinuity in the derivative prevents the function from being globally linear.

This non-linearity makes NNV difficult. In fact, verifying networks with ReLU is $"NP"$-complete, as shown in @sec:complexity. We will use ReLU throughout this book as the default activation function for hidden neurons in an NN.
]

=== Sigmoid <sec:sigmoid>


#figure(
  canvas(length: 1cm, {
    import draw: *

    let sx = 4.0 / 10      // x span -> 4 canvas units wide
    let sy = 4.0 / 1.5      // y span -> 4 canvas units tall
    let pt = (x, y) => (x * sx, y * sy)

    // axes through the origin, with arrowheads
    line(pt(-4.5, 0), pt(4.5, 0), mark: (end: ">"), stroke: 1pt)
    line(pt(0, 0), pt(0, 1.1), mark: (end: ">"), stroke: 1pt)

    // x-axis ticks + labels (tick marks in fixed canvas units)
    for x in (-4, -2, 2, 4) {
      let (px, _) = pt(x, 0)
      line((px, -0.08), (px, 0.08), stroke: 0.6pt)
      content((px, -0.25), text(size: 8pt)[#x], anchor: "north")
    }

    // y-axis ticks + labels
    for y in (0.5, 1) {
      let (_, py) = pt(0, y)
      line((-0.08, py), (0.08, py), stroke: 0.6pt)
      content((-0.2, py), text(size: 8pt)[#y], anchor: "east")
    }

    // sigmoid curve, sampled
    let pts = ()
    let n = 80
    for i in range(0, n + 1) {
      let x = -4.5 + i * (9.0 / n)
      let y = 1 / (1 + calc.exp(-x))
      pts.push(pt(x, y))
    }
    line(..pts, stroke: red.darken(20%) + 1.5pt)
  }),
  caption: [Sigmoid function.]
) <fig:sigmoid>


Sigmoid, shown in @fig:sigmoid, is a smooth---i.e., continuous and differentiable---non-linear activation function that maps any real value to the range $(0, 1)$.
It is continuous, meaning that small changes in the input will result in small changes in the output, and differentiable, meaning that it has a well-defined derivative at every point. Sigmoid is often used in the output layer of a binary classification problem.

$
  "sigmoid"(x) = 1 / (1 + e^(-x))
$

#example[
  $"sigmoid"(-1.2) approx 0.23$, $"sigmoid"(0) = 0.5$, and $"sigmoid"(2.8) approx 0.94$. This means that the sigmoid function maps $-1.2$ to a value close to $0$, $0$ to $0.5$, and $2.8$ to a value close to $1$.
]

=== Hyperbolic Tangent (Tanh) <sec:tanh>

Tanh, shown in @fig:tanh, is similar to sigmoid (@sec:sigmoid)  but maps any real value to the range (-1,1). It is often used in the output layer of a multi-class classification problem.

#figure(
  canvas(length: 1cm, {
    import draw: *

    let sx = 4.0 / 10.0      // x span -> 4 canvas units wide
    let sy = 4.0 / 2.5      // y span -> 4 canvas units tall
    let pt = (x, y) => (x * sx, y * sy)

    // axes through the origin, with arrowheads
    line(pt(-4.5, 0), pt(4.5, 0), mark: (end: ">"), stroke: 1pt)
    line(pt(0, -1.2), pt(0, 1.2), mark: (end: ">"), stroke: 1pt)

    // x-axis ticks + labels (skip 0 to avoid clutter at origin)
    for x in (-4, -2, 2, 4) {
      let (px, _) = pt(x, 0)
      line((px, -0.08), (px, 0.08), stroke: 0.6pt)
      content((px, -0.25), text(size: 8pt)[#x], anchor: "north")
    }

    // y-axis ticks + labels (skip 0)
    for y in (-1, 1) {
      let (_, py) = pt(0, y)
      line((-0.08, py), (0.08, py), stroke: 0.6pt)
      content((-0.2, py), text(size: 8pt)[#y], anchor: "east")
    }

    // tanh curve, sampled  (tanh(x) = (e^x - e^-x) / (e^x + e^-x))
    let tanh = x => {
      let a = calc.exp(x)
      let b = calc.exp(-x)
      (a - b) / (a + b)
    }
    let pts = ()
    let n = 80
    for i in range(0, n + 1) {
      let x = -4.5 + i * (9.0 / n)
      pts.push(pt(x, tanh(x)))
    }
    line(..pts, stroke: red.darken(20%) + 1.5pt)
  }),
  caption: [tanh (hyperbolic tangent) activation function.]
) <fig:tanh>

#example[
$tanh(-1.2) approx -0.83$, $tanh(0) = 0$, and $tanh(2.8) approx 0.99$. This means that the tanh function maps -1.2 to a value close to -1, 0 to 0, and 2.8 to a value close to 1.
]

=== Softmax <sec:softmax>


#figure(
  canvas(length: 1cm, {
    import draw: *

    // independent scale factors -> map data into a ~square box
    // x in [-4.5, 4.5] (span 9), y in [-0.1, 1.1] (span 1.2)
    let sx = 4.0 / 10.0
    let sy = 4.0 / 1.5
    let pt = (x, y) => (x * sx, y * sy)

    // axes through the origin, with arrowheads
    line(pt(-4.5, 0), pt(4.5, 0), mark: (end: ">"), stroke: 1pt)
    line(pt(0, -0.1), pt(0, 1.1), mark: (end: ">"), stroke: 1pt)

    // x-axis ticks + labels (skip 0)
    for x in (-4, -2, 2, 4) {
      let (px, _) = pt(x, 0)
      line((px, -0.08), (px, 0.08), stroke: 0.6pt)
      content((px, -0.25), text(size: 0.8em)[#x], anchor: "north")
    }

    // y-axis ticks + labels
    for y in (0.5, 1) {
      let (_, py) = pt(0, y)
      line((-0.08, py), (0.08, py), stroke: 0.6pt)
      content((-0.2, py), text(size: 0.8em)[#y], anchor: "east")
    }

    // softmax_1(x) = e^x / (e^x + 1)  (solid red)
    let f1 = x => calc.exp(x) / (calc.exp(x) + 1)
    // softmax_2(x) = 1 / (e^x + 1)    (dashed blue)
    let f2 = x => 1 / (calc.exp(x) + 1)

    let sample = f => {
      let pts = ()
      let n = 80
      for i in range(0, n + 1) {
        let x = -4.5 + i * (9.0 / n)
        pts.push(pt(x, f(x)))
      }
      pts
    }

    line(..sample(f1), stroke: red.darken(20%) + 1.5pt)
    line(..sample(f2), stroke: (paint: blue.darken(20%), thickness: 1.5pt, dash: "dashed"))

    // legend, above the plot, two columns
    let top = 4.0 / 1.2 * 1.1   // canvas y of the top of the plot (y = 1.1)
    let ly = top + 0.5

    // entry 1: solid red
    line((-1.7, ly), (-1.1, ly), stroke: red.darken(20%) + 1.5pt)
    content((-1.0, ly), text(size: 0.8em)[$mono("softmax")_1 (x)$], anchor: "west")

    // entry 2: dashed blue
    line((0.9, ly), (1.5, ly), stroke: (paint: blue.darken(20%), thickness: 1.5pt, dash: "dashed"))
    content((1.6, ly), text(size: 0.8em)[$mono("softmax")_2 (x)$], anchor: "west")
  }),
  caption: [Softmax function for 2 classes.]
) <fig:softmax>

Softmax, shown in @fig:softmax, is a generalization of sigmoid (@sec:sigmoid) that maps any real value to the range (0,1) and ensures that the sum of the output values is 1. It is often used in the output layer of a multi-class classification problem.
$
"softmax"(x)_i = e^(x_i) / (sum_(j=1)^n e^(x_j))
$

#example[Softmax Computation][
For a vector $x = [2, 1, 0]$, softmax computes:
$
"softmax"(x) &= [e^2 / (e^2+e^1+e^0), e^1 / (e^2+e^1+e^0), e^0 / (e^2+e^1+e^0)] \
&= [7.389 / (7.389+2.718+1), 2.718 / (7.389+2.718+1), 1 / (7.389+2.718+1)] \
&approx [0.71, 0.24, 0.05]
$
Softmax maps the input vector $x$ to a probability distribution: the first class has probability 0.71, the second 0.24, and the third 0.05.
]

#example[
Use Z3 to encode the network in @fig:dnn and compute its output $x_5$ for the input $(x_1, x_2) = (2.0, 0.5)$ and find an input that maximizes the output $x_5$.

```python
from z3 import Real, If, Solver, Optimize, sat

x1, x2, = Real('x1'), Real('x2')
x3, x3_, = Real('x3'), Real('x3_')
x4, x4_ = Real('x4'), Real('x4_')
x5 = Real('x5')

l2a = x3 = -0.5 * x1 + 0.5 * x2 + 1.0
l2a_ = x3_ = If(x3 > 0, x3, 0)
l2b = x4 =  0.5 * x1 - 0.5 * x2 - 1.0
l2b_ = x4_ = If(x4 > 0, x4, 0)
l3 = x5 = -1.0 * x3_ + 1.0 * x4_ - 1.0

# output for input (x1, x2) = (2.0, 0.5)
s = Solver()
s.add(l2a); s.add(l2b)
s.add(l2a_); s.add(l2b_); s.add(l3)

# specify input values
s.add(x1 = 2.0); s.add(x2 = 0.5)
if s.check() = sat:
  print(s.model())

# find an input that maximizes the output x5
o = Optimize()
o.add(l2a); o.add(l2b)
o.add(l2a_); o.add(l2b_); o.add(l3)

# maximize x5
o.maximize(x5)
if o.check() = sat:
  print(o.model())
```
] <ex:z3-dnn>


#exercise[
Use @ex:z3-dnn as an example and try the following exercises:

+ Use Z3 to encode the network in @fig:dnn and compute the outputs of _all_ neurons for the input $(x_1, x_2) = (-1.3, 3.5)$.
+ Use Z3 to find an input $(x_1, x_2)$ that _maximizes_ the output $x_5$ of the network in @fig:dnn.
+ Add another input $x_("new")$ and update the network accordingly. Then, use Z3 to find an input $(x_1, x_2, x_("new"))$ that _minimizes_ the output $x_5$ of the updated network.
] <prob:z3-dnn>

== Neural Network Architectures and Layers

NNs vary in architecture depending on how information flows through them and how computations are structured. Most common models are variations of the _feedforward network_, with additional structures or constraints layered on top. @tab:nn-types summarizes several common NN architectures and their typical application domains.

#figure(caption: [Popular NN Architectures and Applications],
  text(size: 0.9em,
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    table.hline(),
    table.header(
      [*Name*], [*Acronym*], [*Typical Applications*],
    ),
    table.hline(),
    [Feedforward NN], [FNN / MLP], [General function approximation, tabular data],
    [Convolutional NN], [CNN], [Image processing, video analysis],
    [Residual NN], [ResNet], [Deep image recognition, medical imaging],
    [Recurrent NN], [RNN], [Sequence modeling, NLP, time series],
    [Transformer], [--], [NLP, summarization, code generation, vision],
    [Graph NN], [GNN], [Graph-structured data, molecule modeling, recommendation],
    table.hline(),
  ))
) <tab:nn-types>



=== Feedforward Neural Networks (FNNs) <sec:ffn>

In an FNN, information flows in one direction: from the input layer, through one or more hidden layers, and finally to the output layer. There are no loops or cycles in the computation graph.

Widely used feedforward architectures include fully connected, convolutional, and residual networks. Each architecture has its own strengths and is suited for different types of tasks.

#paragraph[Fully Connected NNs (FCNs)][In FCNs, each neuron in a layer is connected to every neuron in the next layer. Thus, every neuron in the input layer is connected to every neuron in the first hidden layer, every neuron in the first hidden layer is connected to every neuron in the second hidden layer, and so on, until the output layer. Fully connected NNs, sometimes called _dense networks_, are the most basic type of FNNs and are commonly used for tasks like classification.]

// TODO
// \begin{example}
// @fig:dnn earlier is an FCN with two inputs and one hidden layer with two neurons, and one output neuron.~@fig:ffn below shows an FCN with four inputs, two hidden layers with five neurons each, and three output neurons (weights and biases not shown for simplicity).

// \begin{figure}[htp]
//     \centering
//     \begin{tikzpicture}[scale=0.8, transform shape]
//         % Input Layer
//         \node at (0,4) {\textbf{Input Layer}};
//         \foreach \x in {1,2,3,4} {
//             \node[circle, draw=black, fill=white, minimum size=0.6cm] (I\x) at (0,4-\x) {};
//         }

//         % Hidden Layer 1
//         \node at (3,4) {\textbf{Hidden Layer 1}};
//         \foreach \x in {1,2,3,4,5} {
//             \node[circle, draw=black, fill=white, minimum size=0.6cm] (H1\x) at (3,4.5-\x) {};
//         }

//         % Hidden Layer 2
//         \node at (6,4) {\textbf{Hidden Layer 2}};
//         \foreach \x in {1,2,3,4,5} {
//             \node[circle, draw=black, fill=white, minimum size=0.6cm] (H2\x) at (6,4.5-\x) {};
//         }

//         % Output Layer
//         \node at (9,4) {\textbf{Output Layer}};
//         \foreach \x in {1,2,3} {
//             \node[circle, draw=black, fill=white, minimum size=0.6cm] (O\x) at (9,3.5-\x) {};
//         }

//         % Connections
//         \foreach \i in {1,2,3,4}
//             \foreach \j in {1,2,3,4,5}
//                 \draw[->] (I\i) -- (H1\j);

//         \foreach \i in {1,2,3,4,5}
//             \foreach \j in {1,2,3,4,5}
//                 \draw[->] (H1\i) -- (H2\j);

//         \foreach \i in {1,2,3,4,5}
//             \foreach \j in {1,2,3}
//                 \draw[->] (H2\i) -- (O\j);
//     \end{tikzpicture}
//     \caption{A fully connected NN with two hidden layers.}
//     \label{fig:ffn}
// \end{figure}
// \end{example}


#figure(
  canvas(length: 1cm, {
    import draw: *

    let r = 0.3   // node radius (= minimum size 0.6cm / 2)

    // y-centers for each layer (matching the LaTeX coordinates)
    let input-ys = (3, 2, 1, 0)              // x = 0
    let h1-ys    = (3.5, 2.5, 1.5, 0.5, -0.5) // x = 3
    let h2-ys    = (3.5, 2.5, 1.5, 0.5, -0.5) // x = 6
    let out-ys   = (2.5, 1.5, 0.5)            // x = 9

    // draw one layer of nodes, naming each "<prefix><index>"
    let draw-layer(x, ys, prefix) = {
      for (i, y) in ys.enumerate() {
        circle((x, y), radius: r, fill: white, stroke: black + 0.8pt, name: prefix + str(i))
      }
    }
    draw-layer(0, input-ys, "I")
    draw-layer(3, h1-ys, "A")
    draw-layer(6, h2-ys, "B")
    draw-layer(9, out-ys, "O")

    // headers
    content((0, 4), text(weight: "bold")[Input Layer])
    content((3, 4), text(weight: "bold")[Hidden Layer 1])
    content((6, 4), text(weight: "bold")[Hidden Layer 2])
    content((9, 4), text(weight: "bold")[Output Layer])

    // fully-connect two layers (east anchor of source -> west anchor of target)
    let connect(p1, n1, p2, n2) = {
      for i in range(n1) {
        for j in range(n2) {
          line(p1 + str(i) + ".east", p2 + str(j) + ".west", mark: (end: ">"), stroke: 0.5pt)
        }
      }
    }
    connect("I", 4, "A", 5)
    connect("A", 5, "B", 5)
    connect("B", 5, "O", 3)
  }),
  caption: [A fully connected NN with two hidden layers.]
) <fig:ffn>

#example[Classifier][
  A common use case for FCNs is classification. They take an input, e.g., pixels of an image, and predict what the image is (e.g., cat, dog, car). The output layer represents the probabilities of each class (e.g., $y_1$ is the probability of cat, $y_2$ is the probability of dog). Moreover, the outputs are often passed through a `softmax` activation function (@sec:softmax) to convert them into probabilities that sum to 1, and the class with the highest probability is chosen as the predicted label.
]

#paragraph([Convolutional NNs (CNNs)], [
  CNNs replace fully connected layers with _convolutional layers_, which apply local filters across the input space. In CNNs, each neuron receives several inputs, takes a weighted sum over them, passes it through an activation function, and responds with an output. CNNs are commonly used in computer vision and image processing. Despite their local structure, CNNs remain feedforward: data flows forward without cycles.
])



// \begin{figure}[htp]
//     \centering
//     \begin{tikzpicture}[scale=0.8, transform shape]
//     % Parameters
//     \def in pN{4}
//     \def\hidN{3}
//     \def\outN{3}
//     \def\dy{1.5}
//     \def\xInput{0}
//     \def\xHidden{3.2}
//     \def\xOutput{6.4}

//     % Input nodes
//     \foreach \i [evaluate=\i as \lbl using int(\i)] in {1,...,4} {
//         \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$x_{\lbl}$}]
//             (I\i) at (\xInput, {(4-1)*0.5*\dy - (\i-1)*\dy}) {};
//     }

//     % Hidden nodes
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$h_1$}] at (\xHidden, {1.5}) (H1) {};
//     \node[above=0.1cm of H1] (B1) {$0.5$};
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$h_2$}] at (\xHidden, {0}) (H2) {};
//     % \node[above=0.2cm of H2] (B2) {$b=0.5$};
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$h_3$}] at (\xHidden, {-1.5}) (H3) {};
//     % \node[above=0.2cm of H3] (B3) {$b=0.5$};

//     % Output nodes
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$y_1$}] at (\xOutput, {1.5}) (O1) {};
//     \node[above=0.1cm of O1] (B1) {$-1$};
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$y_2$}] at (\xOutput, {0}) (O2) {};
//     \node[circle, draw, fill=white, minimum size=0.4in, label=center:{$y_3$}] at (\xOutput, {-1.5}) (O3) {};

//     % Connections: Input to Hidden (with weight labels spaced to avoid overlap)
//     \draw[->, thick] (I1) -- node[above=2pt, midway, xshift=-2pt, yshift=1pt] {$2$} (H1);
//     \draw[->, thick] (I2) -- node[below=1pt, midway, xshift=2pt] {$-1$} (H1);
//     \draw[->, thick] (I2) -- (H2);
//     \draw[->, thick] (I3) -- (H2);
//     \draw[->, thick] (I3) -- (H3);
//     \draw[->, thick] (I4) -- (H3);

//     % Hidden to Output, one to one
//     \draw[->, thick] (H1) -- node[above=2pt, midway] {$1$} (O1);
//     \draw[->, thick] (H2) -- (O2);
//     \draw[->, thick] (H3) -- (O3);

//     \end{tikzpicture}
//     \caption{1-dimensional CNN <fig:cnn}
// \end{figure}

#figure(
  canvas(length: 1cm, {
    import draw: *

    let r = 0.5   // node radius (~ 0.4in diameter)

    // helper: draw a node with a centered label
    let node(x, y, name, label) = {
      circle((x, y), radius: r, fill: white, stroke: black + 0.8pt, name: name)
      content((x, y), label)
    }

    // input nodes   y = 2.25 - (i-1)*1.5
    node(0, 2.25, "I1", [$x_1$])
    node(0, 0.75, "I2", [$x_2$])
    node(0, -0.75, "I3", [$x_3$])
    node(0, -2.25, "I4", [$x_4$])

    // hidden nodes  (x = 3.2)
    node(3.2, 1.5, "H1", [$h_1$])
    node(3.2, 0.0, "H2", [$h_2$])
    node(3.2, -1.5, "H3", [$h_3$])

    // output nodes  (x = 6.4)
    node(6.4, 1.5, "O1", [$y_1$])
    node(6.4, 0.0, "O2", [$y_2$])
    node(6.4, -1.5, "O3", [$y_3$])

    // bias labels above H1 and O1
    content((3.2, 2.25), text(size: 9pt)[$0.5$])
    content((6.4, 2.25), text(size: 9pt)[$-1$])

    // connections (drawn on top of nodes)
    let edge(a, b) = line(a + ".east", b + ".west", mark: (end: ">"), stroke: 1pt)

    // input -> hidden
    edge("I1", "H1")
    edge("I2", "H1")
    edge("I2", "H2")
    edge("I3", "H2")
    edge("I3", "H3")
    edge("I4", "H3")

    // hidden -> output (one-to-one)
    edge("H1", "O1")
    edge("H2", "O2")
    edge("H3", "O3")

    // weight labels near their edges
    content((1.4, 2.0), text(size: 9pt)[$2$])
    content((1.7, 0.95), text(size: 9pt)[$-1$])
    content((4.8, 1.8), text(size: 9pt)[$1$])
  }),
  caption: [1-dimensional CNN]
) <fig:cnn>


#example[CNN Computation][
@fig:cnn shows a simple CNN with four inputs, three hidden neurons, and three outputs. Given an input vector $bold(x) = [x_1, x_2, x_3, x_4]$, the computation of the first output proceeds as follows. The first hidden unit forms a linear combination of its inputs as $h_1 = 2x_1 - x_2 + 0.5$. This value is then passed through the ReLU activation function, resulting in $hat(h)_1 = relu(h_1) = max(0, 2x_1 - x_2 + 0.5)$. Finally, the first output is simply $y_1 = hat(h)_1 - 1$.
]

#paragraph[Residual Networks (ResNets)][ResNets extend FNNs by adding _skip connections_ --- direct links that bypass one or more layers. ResNets are often used in image recognition and classification.]

// \begin{example}
// \begin{figure}[htp]
//     \centering
//     \begin{tikzpicture}[scale=0.8, transform shape]
//     % Horizontal node positions with labels
//     \node[circle, draw=black, thick, minimum size=0.4in, fill=white, label=center:{$x$}] (H1) at (0,0) {};
//     \node[circle, draw=black, thick, minimum size=0.4in, fill=white, label=center:{$h_1$}] (H2) at (2.5,0) {};
//     \node[circle, draw=black, thick, minimum size=0.4in, fill=white, label=center:{$h_2$}] (H3) at (5,0) {};
//     \node[circle, draw=black, thick, minimum size=0.4in, fill=white, label=center:{$h_3$}] (H4) at (7.5,0) {};
//     \node[circle, draw=black, thick, minimum size=0.4in, fill=white, label=center:{$y$}] (H5) at (10,0) {};

//     % Layer labels
//     \node at (0,2.0) {\textbf{Input}};
//     \node at (5.0,2.0) {\textbf{Hidden Layers}};
//     \node at (10.0,2.0) {\textbf{Output}};

//     % Biases above all except input node
//     \node[above=0.18cm of H2] {$1$};    % bias for h1
//     \node[above=0.18cm of H3] {$-1$}; % bias for h2
//     \node[above=0.18cm of H4] {$0.5$};  % bias for h3
//     \node[above=0.18cm of H5] {$2$};    % bias for y

//     % Main arrows with weights
//     \draw[->, thick] (H1) -- node[above, midway] {$1$} (H2);
//     \draw[->, thick] (H2) -- node[above, midway] {$2$} (H3);
//     \draw[->, thick] (H3) -- node[above, midway] {$-1$} (H4);
//     \draw[->, thick] (H4) -- node[above, midway] {$0.5$} (H5);

//     % Residual (skip) connections with weights
//     \draw[->, thick] (H1) to[out=60,in=120] node[above, pos=0.4] {$1$} (H3);
//     \draw[->, thick] (H3) to[out=60,in=120] node[above, pos=0.4] {$1$} (H5);

//     \end{tikzpicture}
//     \caption{ResNet block with weights on all connections and biases above nodes. Each node is labeled and typical ReLU is applied after each hidden sum. <fig:resnet}
// \end{figure}
#import "@preview/cetz:0.3.4"

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let r = 0.5   // node radius (~ 0.4in diameter)

    // helper: node with centered label
    let node(x, name, label) = {
      circle((x, 0), radius: r, fill: white, stroke: black + 1pt, name: name)
      content((x, 0), label)
    }

    // chain of nodes
    node(0.0, "H1", [$x$])
    node(2.5, "H2", [$h_1$])
    node(5.0, "H3", [$h_2$])
    node(7.5, "H4", [$h_3$])
    node(10.0, "H5", [$y$])

    // layer labels
    content((0.0, 2.0), text(weight: "bold")[Input])
    content((5.0, 2.0), text(weight: "bold")[Hidden Layers])
    content((10.0, 2.0), text(weight: "bold")[Output])

    // biases above nodes (all but input)
    content((2.5, 0.85), text(size: 9pt)[$1$])
    content((5.0, 0.85), text(size: 9pt)[$-1$])
    content((7.5, 0.85), text(size: 9pt)[$0.5$])
    content((10.0, 0.85), text(size: 9pt)[$2$])

    // main arrows with weight labels above midpoint
    let edge(a, b, w, mx) = {
      line(a + ".east", b + ".west", mark: (end: ">"), stroke: 1pt)
      content((mx, 0.3), text(size: 9pt)[#w])
    }
    edge("H1", "H2", [$1$], 1.25)
    edge("H2", "H3", [$2$], 3.75)
    edge("H3", "H4", [$-1$], 6.25)
    edge("H4", "H5", [$0.5$], 8.75)

    // residual (skip) connections as arcs above
    // leave each source at 60deg, enter each target at 120deg
    bezier(
      (0.25, 0.433), (4.75, 0.433),   // boundary points on H1 and H3
      (1.0, 1.732), (4.0, 1.732),     // control points
      mark: (end: ">"), stroke: 1pt,
    )
    content((1.8, 1.55), text(size: 9pt)[$1$])

    bezier(
      (5.25, 0.433), (9.75, 0.433),   // boundary points on H3 and H5
      (6.0, 1.732), (9.0, 1.732),
      mark: (end: ">"), stroke: 1pt,
    )
    content((6.8, 1.55), text(size: 9pt)[$1$])
  }),
  caption: [
    ResNet block with weights on all connections and biases above nodes.
    Each node is labeled and typical ReLU is applied after each hidden sum.
  ]
) <fig:resnet>

#example[ResNet Computation][
@fig:resnet shows an example of a ResNet. Assuming each hidden node applies the ReLU activation, with the weights and biases shown in the diagram, the outputs are:
$
h_1 = relu(x + 1) quad & h_2 = relu(2h_1 + x - 1) \
h_3 = relu(-h_2 + 0.5) quad & y = 0.5h_3 + h_2 + 2
$
]

// % \subsubsection*{Common Layer Types}

// % Feedforward networks, including CNNs and ResNets, are built from layers such as:

// % \begin{itemize}
// %     \item \textbf{Fully Connected (Dense) Layers}: Every neuron is connected to every neuron in the next layer.
// %     \item \textbf{Convolutional Layers}: Local filters scan over inputs to extract spatial features.
// %     \item \textbf{Residual (Skip) Connections}: Enable shortcut paths from earlier to later layers.
// % \end{itemize}

=== Other NN Architectures

Not all neural networks are feedforward.
Some architectures introduce cycles, dynamic connections, or non-Euclidean#footnote[Euclidean data refers to data that can be represented in a flat, two-dimensional space, such as images.] data structures (e.g., graphs).

==== Recurrent Neural Networks (RNNs)
RNNs, often used in natural language processing (NLP) and speech recognition, are designed to recognize patterns in sequences of data. RNNs have _loops_ in them, allowing information to be sent forward and backward.

Currently, most NNV work tackles RNNs by _unrolling_ them into an equivalent feedforward network. While this allows us to apply feedforward verification techniques, it can lead to an exponential increase in the size of the network, making verification more challenging.


// \begin{figure}[h]
//     \begin{center}
// \begin{tikzpicture}[scale=0.5, transform shape]
// % --- Rolled RNN (left diagram) ---
// \begin{scope}
// % Layer labels
// \node at (0,1.5) {\textbf{Input}};
// \node at (2.4,1.5) {\textbf{Hidden}};
// \node at (4.8,1.5) {\textbf{Output}};
// % Nodes
// \node[circle, draw=black, fill=white, thick, minimum size=0.4in, label=center:{$x_t$}] (RI) at (0,0) {};
// \node[circle, draw=black, fill=white, thick, minimum size=0.4in, label=center:{$h_t$}] (RH) at (2.4,0) {};
// \node[circle, draw=black, fill=white, thick, minimum size=0.4in, label=center:{$y_t$}] (RO) at (4.8,0) {};
// % Bias above nodes
// \node[above=0.16cm of RH] {$0.5$};
// \node[above=0.16cm of RO] {$-0.5$};
// % Main arrows with weights
// \draw[->, thick] (RI) -- node[above, pos=0.5] {$2$} (RH);
// \draw[->, thick] (RH) -- node[above, pos=0.5] {$1$} (RO);
// % Recurrent/self-loop at hidden node with recurrent weight
// \draw [->, thick] (RH) edge [out=-120,in=-60,looseness=8] node[below, yshift=-2pt, xshift=10pt] {$-1$} (RH);
// % Caption
// \node[align=center] at (2.4,-2.7) {RNN cell};
// \end{scope}



// % --- Unrolled RNN (right diagram) ---
// \begin{scope}[xshift=8cm]
// % Parameters for vertical node spacing
// \def in pN{4}
// \def\hidN{4}
// \def\outN{4}
// \def\dy{2.0}
// \def\xInput{0}
// \def\xHidden{3.2}
// \def\xOutput{6.4}
// % Layer labels
// \node at (\xInput,{ in pN/2*\dy+0.8}) {\textbf{Input}};
// \node at (\xHidden,{ in pN/2*\dy+0.8}) {\textbf{Hidden}};
// \node at (\xOutput,{ in pN/2*\dy+0.8}) {\textbf{Output}};
// % Input nodes (left column)
// \foreach \i in {1,..., in pN} {
//     \node[circle, draw=black, fill=white, minimum size=0.4in, label=center:{$x_{\i}$}] (I\i) at (\xInput, {( in pN-1)*0.5*\dy - (\i-1)*\dy}) {};
// }
// % Hidden nodes (centered) (as many as input)
// \foreach \i in {1,...,\hidN} {
//     \node[circle, draw=black, fill=white, minimum size=0.4in, label=center:{$h_{\i}$}] (H\i) at (\xHidden, {(\hidN-1)*0.5*\dy - (\i-1)*\dy}) {};
//     \node[above right=0 of H\i] {$0.5$}; % Bias above each hidden
// }
// % Output nodes (centered) (as many as input)
// \foreach \i in {1,...,\outN} {
//     \node[circle, draw=black, fill=white, minimum size=0.4in, label=center:{$y_{\i}$}] (O\i) at (\xOutput, {(\outN-1)*0.5*\dy - (\i-1)*\dy}) {};
//     \node[above=0.16cm of O\i] {$-0.5$}; % Bias above each output
// }
// % RNN input-to-hidden (1-to-1, with weight)
// \foreach \i in {1,...,4} {
//     \draw[->, thick] (I\i) -- node[above, pos=0.5, yshift=2pt] {$2$} (H\i);
// }
// % Hidden-to-hidden (recurrent arrows, with weight)
// \foreach \i [evaluate={\j=int(\i+1);}] in {1,2,3} {
//     \draw[->, thick] ([xshift=4pt]H\i) -- node[above left, pos=0.5, yshift=2pt] {$-1$} ([xshift=-4pt]H\j);
// }
// % Hidden-to-output (1-to-1, with weight)
// \foreach \i in {1,...,4} {
//     \draw[->, thick] (H\i) -- node[above, pos=0.5, yshift=2pt] {$1$} (O\i);
// }
// % Caption
// \node[align=center] at (3.2,-4.0) {Unrolled RNN};
// \end{scope}
// \end{tikzpicture}
// \end{center}
// \caption{RNN cell (left) and unrolled RNN sequence structure (right).
// Weights on connections; biases above hidden and output nodes.}
// \label{fig:rnn}
// \end{figure}

// \begin{example}

#import "@preview/cetz:0.3.4"

#figure(
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *

    let r = 0.5

    // helper: node with centered label
    let node(x, y, name, label) = {
      circle((x, y), radius: r, fill: white, stroke: black + 1pt, name: name)
      content((x, y), label)
    }

    // ===================== Left: rolled RNN cell =====================
    content((0, 1.5), text(weight: "bold")[Input])
    content((2.4, 1.5), text(weight: "bold")[Hidden])
    content((4.8, 1.5), text(weight: "bold")[Output])

    node(0.0, 0, "RI", [$x_t$])
    node(2.4, 0, "RH", [$h_t$])
    node(4.8, 0, "RO", [$y_t$])

    content((2.4, 0.85), text(size: 9pt)[$0.5$])
    content((4.8, 0.85), text(size: 9pt)[$-0.5$])

    line("RI.east", "RH.west", mark: (end: ">"), stroke: 1pt)
    content((1.2, 0.35), text(size: 9pt)[$2$])
    line("RH.east", "RO.west", mark: (end: ">"), stroke: 1pt)
    content((3.6, 0.35), text(size: 9pt)[$1$])

    // recurrent self-loop below the hidden node (out=-120, in=-60)
    bezier(
      (2.15, -0.433), (2.65, -0.433),   // boundary points at -120deg / -60deg
      (1.45, -1.7), (3.35, -1.7),       // control points (looseness -> deep loop)
      mark: (end: ">"), stroke: 1pt,
    )
    content((3.05, -1.0), text(size: 9pt)[$-1$])

    content((2.4, -2.7), [RNN cell])

    // ================ Right: unrolled RNN (shifted +8 in x) ================
    let sx = 8.0
    let ys = (3, 1, -1, -3)   // y = (N-1)*0.5*dy - (i-1)*dy,  N=4, dy=2

    // layer labels  (y = N/2*dy + 0.8 = 4.8)
    content((sx + 0.0, 4.8), text(weight: "bold")[Input])
    content((sx + 3.2, 4.8), text(weight: "bold")[Hidden])
    content((sx + 6.4, 4.8), text(weight: "bold")[Output])

    // node columns + biases
    for (i, y) in ys.enumerate() {
      node(sx + 0.0, y, "UI" + str(i), [$x_#(i + 1)$])
      node(sx + 3.2, y, "UH" + str(i), [$h_#(i + 1)$])
      node(sx + 6.4, y, "UO" + str(i), [$y_#(i + 1)$])
      content((sx + 3.95, y + 0.6), text(size: 8pt)[$0.5$])   // hidden bias (above-right)
      content((sx + 6.4, y + 0.85), text(size: 8pt)[$-0.5$])  // output bias (above)
    }

    // input -> hidden (1-to-1, weight 2)
    for i in range(4) {
      line("UI" + str(i) + ".east", "UH" + str(i) + ".west", mark: (end: ">"), stroke: 1pt)
      content((sx + 1.6, ys.at(i) + 0.35), text(size: 8pt)[$2$])
    }

    // hidden -> hidden (recurrent, downward, weight -1)
    for i in range(3) {
      line("UH" + str(i) + ".south", "UH" + str(i + 1) + ".north", mark: (end: ">"), stroke: 1pt)
      content((sx + 2.65, (ys.at(i) + ys.at(i + 1)) / 2), text(size: 8pt)[$-1$])
    }

    // hidden -> output (1-to-1, weight 1)
    for i in range(4) {
      line("UH" + str(i) + ".east", "UO" + str(i) + ".west", mark: (end: ">"), stroke: 1pt)
      content((sx + 4.8, ys.at(i) + 0.35), text(size: 8pt)[$1$])
    }

    content((sx + 3.2, -4.0), [Unrolled RNN])
  }),
  caption: [
    RNN cell (left) and unrolled RNN sequence structure (right).
    Weights on connections; biases above hidden and output nodes.
  ]
) <fig:rnn>

#example[RNN Computation][
@fig:rnn shows a simple RNN cell. Assume the input sequence is $bold(x) = [x_1, x_2, x_3, x_4]$ and the initial hidden state is $h_0$. For the first time step, $h_1 = relu(2x_1 - h_0 + 0.5)$ and $y_1 = h_1 - 0.5$. For the second time step, $h_2 = relu(2x_2 - h_1 + 0.5)$ and $y_2 = h_2 - 0.5$.
]

==== Transformers
Transformers are designed for long-range dependencies using _self-attention_ rather than recurrence. They dominate applications in natural language processing and are increasingly used in vision and reinforcement learning.

==== Graph Neural Networks (GNNs)
Graph Neural Networks (GNNs) operate on graphs (instead of vectors like FNNs or sequences like RNNs). 
It uses message passing between nodes in the graph and allows each node to aggregate information from its neighbors. GNNs are used in applications involving structured data like molecules or social networks. Currently, most NNV tools do not support GNNs, and we will not focus on them in this book. However, they are an important area of research in the broader field of NNV.

//#import "@preview/cetz:0.3.4"

#figure(
  canvas(length: 1cm, {
    import cetz.draw: *

    let r = 0.45

    // node with centered label
    let node(x, y, name, label, fill: white) = {
      circle((x, y), radius: r, fill: fill, stroke: black + 1pt, name: name)
      content((x, y), label)
    }

    // segment p->q trimmed by da at start and db at end (to land on circle borders)
    let seg(p, q, da, db) = {
      let dx = q.at(0) - p.at(0)
      let dy = q.at(1) - p.at(1)
      let L = calc.sqrt(dx * dx + dy * dy)
      let ux = dx / L
      let uy = dy / L
      ((p.at(0) + ux * da, p.at(1) + uy * da), (q.at(0) - ux * db, q.at(1) - uy * db))
    }

    // node centers (left panel)
    let cv = (0, 0)
    let ca = (-1.9, 1.3)
    let cb = (1.9, 1.3)
    let cc = (-1.9, -1.3)
    let cd = (1.9, -1.3)

    // undirected (structural) edge, boundary to boundary
    let und(p, q) = {
      let (s, e) = seg(p, q, r, r)
      line(s, e, stroke: gray.darken(20%) + 0.9pt)
    }

    // ===================== Left: input graph =====================
    content((0, 2.5), text(weight: "bold")[Input graph $G = (V, E)$])

    und(cv, ca); und(cv, cb); und(cv, cc); und(cv, cd)
    und(ca, cb); und(cc, cd)

    node(..cv, "v", [$v$], fill: blue.lighten(75%))
    node(..ca, "a", [$a$])
    node(..cb, "b", [$b$])
    node(..cc, "c", [$c$])
    node(..cd, "d", [$d$])

    // ================= Right: message passing at v =================
    let sx = 7.0
    let add = p => (p.at(0) + sx, p.at(1))
    let rv = add(cv)
    let ra = add(ca)
    let rb = add(cb)
    let rc = add(cc)
    let rd = add(cd)

    content((sx, 2.5), text(weight: "bold")[Message passing at $v$])

    // structural edges (gray)
    und(rv, ra); und(rv, rb); und(rv, rc); und(rv, rd)
    und(ra, rb); und(rc, rd)

    // nodes
    node(..rv, "rv", [$v$], fill: blue.lighten(75%))
    node(..ra, "ra", [$a$])
    node(..rb, "rb", [$b$])
    node(..rc, "rc", [$c$])
    node(..rd, "rd", [$d$])

    // message arrows (orange, dashed): neighbors -> v, drawn ON TOP so heads show
    let msg(p) = {
      let (s, e) = seg(p, rv, r, r)
      line(s, e, mark: (end: ">"),
        stroke: (paint: orange.darken(10%), thickness: 1.2pt, dash: "dashed"))
    }
    msg(ra); msg(rb); msg(rc); msg(rd)

    // update rule, centered beneath the figure
    content((3.5, -2.8), text(size: 10pt)[
      $ h_v^((k)) = "UPDATE"(h_v^((k-1)), space "AGG"_(u in N(v)) "MSG"(h_u^((k-1)))) $
    ])
  }),
  caption: [
    Graph neural network message passing. Left: an input graph $G = (V, E)$.
    Right: node $v$ updates its representation by aggregating messages
    (dashed orange) from its neighbors $N(v) = {a, b, c, d}$, then combining
    them with its own previous state. Stacking $k$ such layers lets information
    propagate over $k$-hop neighborhoods.
  ]
) <fig:gnn>

== Representing Neural Networks with ONNX <sec:onnx>

*ONNX* (Open Neural Network Exchange) @onnx is an open source and widely adopted standard for representing neural networks. It provides a common format for representing the structure and parameters of neural networks, enabling interoperability between different ML frameworks and tools.


ONNX operators that cover most sequential feedforward networks include:

- `Add, Sub, Gemm, MatMul`: basic arithmetic and matrix operations.
- `ReLU, Sigmoid, SoftMax`: activation functions.
- `AveragePool, MaxPool, Flatten, Reshape`: tensor manipulation.
- `Conv, BatchNormalization, LRN`: CNN layers and normalizations.
- `Concat, Dropout, Unsqueeze`: tensor operations.

// Note: Preprocessing (e.g., normalization) should not be included in the model itself to keep property alignment clear.

#example[
  For the network in @fig:dnn, the ONNX representation would include:

  - Input: $x_1, x_2$.
  - Hidden layer: $x_3 =  relu(-0.5x_1 + 0.5x_2 + 1.0)$, $x_4 =  relu(0.5x_1 - 0.5x_2 + 1.0)$.
  - Output: $x_5 = -x_3 + x_4 - 1$.

  The ONNX representation would look like:

  ```python
  ir_version: 9
  opset_import { version: 13 }
  graph example_nn {
    input: "x"
    output: "x5"

    node { op_type: "Gemm" input: "x" input: "W1" input: "b1"
           output: "h1" }   # h1 = -0.5*x1 + 0.5*x2 + 1
    node { op_type: "relu" input: "h1" output: "x3" }

    node { op_type: "Gemm" input: "x" input: "W2" input: "b2"
           output: "h2" }   # h2 = 0.5*x1 - 0.5*x2 + 1
    node { op_type: "relu" input: "h2" output: "x4" }

    node { op_type: "Neg" input: "x3" output: "nx3" }
    node { op_type: "Add" input: "nx3" input: "x4" output: "s1" }
    node { op_type: "Add" input: "s1" input: "c_minus_1" output: "x5" }

    initializer { name: "W1" values: [-0.5, 0.5] }
    initializer { name: "b1" values: [1.0] }
    initializer { name: "W2" values: [0.5, -0.5] }
    initializer { name: "b2" values: [1.0] }
    initializer { name: "c_minus_1" values: [-1.0] }
  }
  ```
]


#pagebreak()
= Properties <chap:properties>

Similar to traditional software systems, neural networks (NNs) have desirable properties to ensure the network behaves as expected. These could be specific to the applications modeled by the network, e.g., safety properties for a network modelling a collision avoidance system, or general properties that are desired by all networks, e.g., robustness to small perturbations in the input data.

Below we will discuss properties that are relevant to the verification of NNs. Specifically, these properties can be
expressed in a formal language supported by a NNV tool. Additional properties can be found in the literature~\cite{seshia2018formal}.

== Definition <sec:properties-def>

As described in @chap:nn-basics, NNs define functions of the form $f: RR^n -> RR^m$,
where $n$ is the dimension of the input and $m$ is the dimension of the output. Thus, the properties or specifications of an NN---similarly to properties of software program---are defined in terms of its input and output:

#quote[
_For any input $x in RR^n$ satisfying a precondition $P$, the neural network should produce an output $f(x) in RR^m$ that satisfies a postcondition $Q$._
]

This says that if the input $x$ satisfies the precondition $P$, then the output $f(x)$ should satisfy the postcondition $Q$.



== Common Properties in Neural Networks

We now define some commonly studied properties in NNs verification.

=== Robustness <sec:properties-robustness>

*Robustness* ensures that small changes in the input do not drastically change the output. This is a desirable property for all neural networks, especially classifiers, where we want to ensure that similar inputs yield similar outputs. For example, a slightly blurred image of a red light should still be classified as a red light.

There are two types of robustness properties: \emph{local} (robustness around a chosen point) and  \emph{global} (robustness everywhere).




==== Local Robustness
A neural network $f$ is $epsilon$-locally robust at point $x$ with respect to norm $|| dot ||$ if
$
forall x', quad ||x - x'|| <= epsilon => f(x) = f(x').
$
where $|x - x'| <= epsilon$ indicates that the difference between the two points is within a certain (small) threshold $epsilon$.


Thus local robustness says that a network is robust if all nearby inputs $x'$ (within radius $epsilon$) are classified the same as $x$. In other words, no small perturbation around this specific point $x$ will fool the classifier.

Local robustness is what most adversarial robustness papers mean, e.g., checking whether an image of a cat is still classified as a cat under small pixel noise.


#example[Local Robustness: Image Classification][
Consider a neural network $f$ that classifies images into different categories (e.g., dog, cat, etc.). A robustness property requires that if an input image $c$ is classified as a dog, then any perturbed image $x$ that is visually similar to $c$ should also be classified as a dog. This can be expressed as:

$
forall x, quad ||c - x|| <= epsilon => f(x) = f(c)
$

]



==== Global Robustness

A neural network $f$ is $epsilon$-globally robust with respect to norm $|| dot ||$ if
$
forall x_1, x_2, quad ||x_1 - x_2|| <= epsilon => f(x_1) = f(x_2).
$

 This says the property must hold for all pairs of inputs in the domain: whenever two points are within $epsilon$ of each other, they must share the same label.

Global robustness is a very strong definition, and in practice, almost impossible unless the network is trivial (e.g., outputs the same label everywhere).



#problem[Robustness: Image Classification][
Suppose that a network classifies an input image $x$ as digit 7.
We want to ensure that if the image is slightly perturbed (e.g., brightness changed by a small amount $epsilon$),
the network still outputs 7.

#solution[
$
forall x'.  ||x - x'|| <= epsilon => f(x') = f(x) = 7
$
]
]







=== Safety <sec:properties-safety>


*Safety* properties ensure that the network conforms to certain safety constraints. This is particularly important in safety-critical applications, such as autonomous vehicles or medical diagnosis systems, where incorrect outputs can lead to catastrophic consequences. %For example, in a self-driving car, we want to ensure that the car maintains a safe distance from other vehicles and pedestrians under all scenarios.

#example[Collision Avoidance System][

A safety property in a collision avoidance system such as an autonomous vehicle might be that if the intruder is distant and significantly slower than us, then we stay below a certain velocity threshold. Formally, this can be expressed as:

$
d_("intruder") > d_("threshold") ∧ v_("intruder") < v_("threshold") ⇒ v_("us") < v_("threshold")
$

where $d_("intruder")$ is the distance to the intruder, $d_("threshold")$ is a predefined safe distance, $v_("intruder")$ is the speed of the intruder, and $v_("us")$ is our speed.


Unlike robustness properties, which are often desirable in all networks, safety properties are often _specific_ to the application domain. For example, a safety property for an autonomous vehicle may not be relevant for a surgical robot.
]<ex:collision-safety>


#exercise[Safety: Self-Driving Car][ 

A network controlling a self-driving car on a highway might require that:
If the car in front is at least 160 meters away  and moving slower than us,
then we should not accelerate.

// *Solution.*

// $
// d ≥ 160 ∧ v_("front") < v_("us") ⇒ a_("us") ≤ 0
// $
]<problem:safety>
=== Other properties <sec:other-properties>

==== Consistency

*Consistency* requires that a NN behaves consistently when given semantically equivalent or related inputs.

#example[Logical Consistency in LLMs][
Consider queries $q_1$, $q_2$, and $q_3$ about a person's age:

$q_1: "How old is person X?"$

$q_2: "What year was X born if they are currently Y years old?"$

$q_3: "Will X be Z years old in 2025?"$

Thus, if the LLM outputs age $Y$ for $q_1$, then $q_2$ should output `current_year - Y`, and the answer to $q_3$ should be logically consistent with the stated age. This prevents scenarios where an LLM claims someone is 30 years old but was born in 1985 when the current year is 2024.
]

// % \paragraph{Example: Object Position Consistency.}
// % Consider a neural network tracking the position of objects in a video frame. It should not report that an object is on the left in one frame and then immediately claim it is on the right in the next frame.

// % \paragraph{Formal Specification:}
// % \[
// %  { \text{frame } t, \text{ frame } t+1  }
// % quad r_1 >=ts f(x_t), quad r_2 >=ts f(x_{t+1})
// % quad  { \text{consistent}(r_1, r_2)  }
// % \]

==== Monotonicity

*Monotonicity* ensures that the NN maintains a consistent ordering relationship between inputs and outputs: an increase in certain input features always leads to a non-decreasing output value. This property is important in applications where domain knowledge dictates logical ordering constraints, such as fairness-aware systems, medical diagnosis, and scientific applications where physical laws impose natural ordering relationships.

#example[Fairness][

A network modelling the probability of admission to a university should be monotonically non-decreasing with respect to GPA and test scores, regardless of gender. Formally, for applicants with profiles $(p, s, g)$ and $(p', s', g')$ where $p, p'$ are GPAs, $s, s'$ are test scores, and $g, g'$ are gender indicators:

$
p <= p' ∧ s = s' ∧ g ≠ g' ⇒ f(p, s, g) <= f(p', s', g') \
s <= s' ∧ p = p' ∧ g ≠ g' ⇒ f(p, s, g) <= f(p, s', g')
$

where $f$ is the neural network computing admission probability. Additionally, for fairness:

$
f(p, s, "male") = f(p, s, "female")  #h(1.5em) forall p, s
$

ensuring that applicants with identical academic qualifications receive the same treatment regardless of gender.
]

== Counterexamples <sec:properties-counterexamples>

A _counterexample_ (*cex*) is a witness that falsifies the correctness property. Given the property defined in @sec:properties-def, a counterexample is an input $x$ that satisfies the precondition $P$ but produces an output $f(x)$ that violates the postcondition $Q$.


#example[Counterexample to Robustness Property][

For local robustness property (@sec:properties-robustness):

$
f(x) ≠ f(x') ∧ ‖x - x'‖ ≤ ε ⇒ x' " is a counterexample."
$

The goal of NNV (@sec:nnv-problem) is to either prove that a property holds---no cex exist---or find a cex that violates the property.
]



#example[Counterexample: Monotonicity in Admission)][

A network predicts admission probability to a university. Inputs: GPA $p$ and test score $s$.

We want: a higher GPA with same score should not decrease admission probability.

But we observe a case violating this:
- A: GPA = 3.0, score = 1500, prediction = 0.8
- B: GPA = 3.5, score = 1500, prediction = 0.6

Using the numbers in this violating case, write the monotonicity requirement and show how this is a counterexample.


Monotonicity requirement:
$
p ≤ p' ∧ s = s' ⇒ f(p,s) ≤ f(p',s')
$

Counterexample:
$
3.0 ≤ 3.5 ∧ 1500 = 1500 " but " f(3.0,1500)=0.8 > f(3.5,1500)=0.6
$
]

== The VNN-LIB  Specification Language <sec:vnnlib>


The VNN-LIB specification @demarchi2023supporting, @vnnlib defines a standard format to describe neural networks and their properties. This enables the sharing of benchmarks across different tools and platforms, facilitating evaluations and comparisons of their performance. VNN-COMPs @brix2024fifth uses VNN-LIB to evaluate different neural network verification tools.


Specifically, VNN-LIB defines a common format for the following components:
  + *Neural Network (or model) representation* in the ONNX format @onnx.
  + *Property specification* in SMT-LIB format @barrett2010smt (@sec:onnx).

=== VNN-LIB: Property Specification Language

Verification tasks involve proving that the output of a network remains within some desired post-condition $sigma$, given inputs within a bounded set $Pi$.

#paragraph[Formal Specification][Let $nu: D^(n_1 times dots times n_h) -> D^(m_1 times dots times m_k)$ be a neural network, and $x$ and $y$ its input and output tensors. A property is expressed as:
$
forall x in Pi -> nu(x) in sigma
$

This includes:
- *Precondition* $Pi$: constraints on inputs.
- *Postcondition* $sigma$: required properties of outputs.
]

Properties are encoded in *SMT-LIB2*, referencing input/output variable names consistent with ONNX.


#example[ACAS XU VNN-LIB Property][
A typical ACAS XU network maps 5D input to 5D output via 6 layers of 50 ReLU neurons. A property of the network is:
$
-epsilon_i <= x_i <= epsilon_i quad (0 <= i < 5)
$
$
y_0 <= y_1, quad y_0 <= y_2, quad y_0 <= y_3, quad y_0 <= y_4,
$
where $x_i$ are the input variables, $y_i$ are the output variables, and $epsilon_i$ are small perturbation bounds for each input dimension. This property states that if the inputs are perturbed within the bounds $epsilon_i$, then the first output neuron $y_0$ is less than or equal to all other output neurons $y_1, y_2, y_3, y_4$.

The VNN-LIB code for this property is:
```smtlib
; declaring the input variables
(declare-const X_0 Real)
(declare-const X_1 Real)
(declare-const X_2 Real)
(declare-const X_3 Real)
(declare-const X_4 Real)
; declaring neuron outputs
(declare-const Y_0 Real)
(declare-const Y_1 Real)
(declare-const Y_2 Real)
(declare-const Y_3 Real)
(declare-const Y_4 Real)
; asserting the input relations
(assert (<= X_0 eps0))
(assert (>= X_0 -eps0))
(assert (<= X_1 eps1))
(assert (>= X_1 -eps1))
(assert (<= X_2 eps2))
(assert (>= X_2 -eps2))
(assert (<= X_3 eps3))
(assert (>= X_3 -eps3))
(assert (<= X_4 eps4))
(assert (>= X_4 -eps4))
; asserting the output relations
(assert (<= Y_0 Y_1))
(assert (<= Y_0 Y_2))
(assert (<= Y_0 Y_3))
(assert (<= Y_0 Y_4))
```
]


// % \begin{example}[MNIST Network]

// % A CNN model for MNIST uses:
// % \begin{itemize}
// %     \item 2 convolutional layers (5x5 kernel, padding 2), followed by ReLU and MaxPool (2x2).
// %     \item A flatten layer, then a fully connected layer with 10 outputs.
// %     \item Input: $1 \times 28 \times 28$; Output: 10-class classification.
// % \end{itemize}

// % A robustness property around a sample $ hat(x)$ classified as class 9:
// % \[
// % \forall i in [0, 783] :  hat(x)_i - \varepsilon <=q x_i <=q  hat(x)_i + \varepsilon
// % \]
// % \[
// % \forall j in [0,8] : y_j - y_9 <=q 0
// % \]


// % \subsubsection*{Variable Naming Convention}\tvn{what's the purpose of this section?}\hd{seems unnecessary}
// % \begin{itemize}
// %     \item 1D tensor: \texttt{X\_0, X\_1, ..., X\_n}
// %     \item 2D tensor: \texttt{X\_0-0, X\_0-1, ..., X\_n-m}
// %     \item 3D tensor: \texttt{X\_0-0-0, ..., X\_i-j-k}
// % \end{itemize}

// % \paragraph{Example: Tensor Flattening Algorithm}
// % \begin{lstlisting}
// % procedure flatten(x)
// %     idx = 0
// %     for a = 0 to N1
// %       for b = 0 to N2
// %         ...
// %           for k = 0 to Nk
// %             X_idx = x[a][b]...[k]
// %             idx += 1
// % \end{lstlisting}

// % \noindent In SMT-LIB:
// % \begin{lstlisting}
// % (declare-fun X0 () Real) ; or (declare-fun X_0-0-0 () Real)
// % ...
// % (assert (<= X0 (+ Xhat0 eps)))
// % (assert (>= X0 (- Xhat0 eps)))
// % ...
// % (assert (<= (- FC0_0 FC0_9) 0.0))
// % \end{lstlisting}



== Problems

#problem[Robustness + Safety: Drone Controller][
An autonomous drone computes its thrust level using a (neural) network controller $f(w,d)$, where $w$ is wind speed and $d$ the distance to nearest obstacle. State the following properties in formal logic (remember to use quantifiers, e.g., $forall$ and $exists$):

+ Robustness: If the wind speed reading changes by at most 1 unit ($|w-w'| <= 1$) and distance remains the same, then thrust decision should remain the same.
+ Safety: If the obstacle distance is less than 5 meters, then thrust must not be greater than 2.

#solution[
Robustness:
$
forall w, w', d, quad |w-w'| <= 1 => f(w,d) = f(w',d)
$

Safety:
$
forall w, d, quad d < 5 => f(w,d) <= 2
$
]
] <problem:drone>

#problem[Global Consistency: Celsius and Fahrenheit][
An NN answers two related questions:
Q1: "What is the temperature in Celsius?" (input $t_C$)
Q2: "What is the temperature in Fahrenheit?" (input $t_F$)

State the following consistency property in formal logic (remember to use quantifiers, e.g., $forall$ and $exists$): If Q1 outputs $y$, then Q2 must output $1.8y+32$.

#solution[
$
forall t_C, quad f("Q2", t_C times 1.8 + 32) = 1.8 dot f("Q1",t_C) + 32
$
]
]

#problem[Counterexample: Safety in Vehicles][
A neural network computes car acceleration $a$. State a safety property in formal logic (remember to use quantifiers, e.g., $forall$ and $exists$): if distance to obstacle $d<10$, then $a <= 0$. But we observe a scenario where $d=5$ but $a=+2$.

Write the safety requirement and show how this is a counterexample.

#solution[
Safety requirement:
$
forall d, a, quad d < 10 => a <= 0
$

Counterexample:
$
d=5, quad f(d)=a=+2 quad "violates property."
$
]
]

#problem[Z3 Properties][
Consider the neural network shown below. Recall that in this network the hidden neurons ($v_1 ... v_4$) use ReLU activation, but the output neurons ($y_1,y_2$) does not.

- Encode this network using Z3.
  - Try to use Z3 to evaluate the network on various inputs.
- Come up with _three_ properties that this network _does not_ have. Recall that a property often has the form shown in @sec:properties-def.
  - Argue why each property does not hold by providing a counterexample (@sec:properties-counterexamples).
  - (Optional, Easy) Try to use Z3 to show that the properties you came up with do not hold by asking Z3 to find counterexamples (one for each property).
- Come up with _three_ properties that that this network has (i.e., as long as the precondition holds, the postcondition holds).
  - Argue why each property always holds (e.g., for any input satisfying the range X, the first layer outputs values in range Y, etc).
  - (Optional) Show that the properties you came up will always hold by using Z3 to prove that no counterexample exists (i.e., unsat).
] <problem:z3-properties>

// = Verification of Neural Networks <sec:verification}

// This chapter discusses the problem of verifying neural networks, i.e., checking if a given property holds for a neural network.
// We define the NN verification problem in~@sec:nnv-problem and its satisfiability formulation, which is commonly used by NNV tools.

#pagebreak()
= The Neural Network Verification (NNV) Problem <sec:nnv-problem>

#definition[NNV][
  Given a NN $N$ and a property $phi$, the NNV problem asks if $phi$ is a valid property#footnote[@chap:properties provides various examples of properties.] of $N$.

  Typically, $phi$ is a formula of the form

  $
    phi_("in") arrow.r phi_("out"),
  $

  where $phi_("in")$ is the _precondition_, i.e., a condition over the inputs of $N$, and $phi_("out")$ is the _postcondition_, i.e., a condition over the outputs of $N$.

  An NNV tool attempts to find a _counterexample_ input to $N$ that satisfies $phi_("in")$ but violates $phi_("out")$. If no such counterexample exists, $phi$ is a valid property of $N$. Otherwise, $phi$ is not valid and the counterexample can be used to retrain or debug the network @huang2017safety.
] <def:nnv>



#example[Safety Property for Collision Avoidance System][
  In @ex:collision-safety, we defined a safety property (@sec:properties-safety) for a collision avoidance system:

  $
    d_("intruder") > d_("threshold") and v_("intruder") < v_("threshold") arrow.r v_("us") < v_("threshold"),
  $

  where $d_("intruder")$ is the distance to the intruder, $d_("threshold")$ is a predefined safe distance, $v_("intruder")$ is the speed of the intruder, and $v_("us")$ is our speed.

  Here, the precondition is

  $
    phi_("in") = d_("intruder") > d_("threshold") and v_("intruder") < v_("threshold"),
  $

  and the postcondition is

  $
    phi_("out") = v_("us") < v_("threshold").
  $
]




#example[
  #figure(
    [#mydnn(sc:100%)],
    caption: [A simple network (similar to @fig:dnn).],
  ) <fig:dnn-b>

  For the network in~@fig:dnn-b, a _valid_ property is that the output is $x_5 <= 0$ for any inputs $x_1 in [-1, 1], x_2 in [-2, 2]$.

  An _invalid_ property is that $x_5 > 0$ for similar inputs.
  A counterexample showing this property violation is ${x_1 = -1, x_2 = 2}$, from which the network evaluates to $x_5 = -3.5$.
] <ex:dnn-b>


 == Satisfiability Formulation and Checking <sec:satisfiability-and-activation-pattern-search>

As with traditional software verification, NNV is often represented as a satisfiability problem, which can be solved using an SMT solver (e.g., Z3 @de2008z3) or a MILP solver (e.g., Gurobi @gurobi).

#paragraph[Formulation][To formulate the problem, we first define a formula $alpha$ to represent the network.
Typically $alpha$ is a conjunction of constraints representing the affine transformation (@sec:affine) and activation function (@sec:activation) of each neuron in the network.
For example, for a fully-connected neural network (@sec:ffn) with $L$ layers and $N$ ReLU neurons per layer, $alpha$ is:

$ 
alpha =    and.big (i in [1, L], j in [1, N])
    v_(i, j) =
     relu(
      sum_(k in [1, N])
      (w_(i - 1, j, k) dot v_(i - 1, k))
      + b_(i, j)
    )
$


where $v_(i, j)$ is the output of the $j$-th neuron in layer $i$,
$w_(i - 1, j, k)$ is the weight connecting the $k$-th neuron in layer $i - 1$
to the $j$-th neuron in layer $i$, and $b_(i, j)$ is the bias of the
$j$-th neuron in layer $i$. The input layer is layer $0$, i.e.,
$v_(0, j)$ are the input variables.
]

With this, the NNV problem (@def:nnv) can be formulated as checking the validity of the following formula:

$ 
  alpha => (phi_("in") => phi_("out")) 
$<eq:nnv>

@eq:nnv checks if network $N$ satisfies (implies) the property
$phi_("in") => phi_("out")$. This validity checking can be reduced to checking
the satisfiability of the formula:

#emph-block[
$ 
alpha and phi_("in") and not phi_("out") 
$<eq:nnv2>
]

If @eq:nnv2 is unsatisfiable, then $phi$ is a valid property of $N$.
Otherwise, $phi$ is not valid. Moreover, we can extract a counterexample
for the original problem from the satisfying assignment of @eq:nnv2. This formulation is commonly used by NNV tools, as it allows us to leverage powerful SMT/MILP solvers to automatically check properties and find counterexamples.

#problem[
Let $alpha$ represent our network and the robustness property
$abs(x - y) <= epsilon => f(x) = f(y)$.
Form the satisfiability formula (@eq:nnv2) that we need to check.
] <ex-prop-neg1>

#problem[
Let $alpha$ represent our network and the property $y > 0$ for any input
$x_1 in [r_1, r_2], x_2 in [r_3, r_4]$.
Form the satisfiability formula (@eq:nnv2) that we need to check.
] <ex-prop-neg2>

#problem(title: [Validity Formulation])[
Show that the formula $alpha =>   phi_("in") => phi_("out")$ in @eq:nnv is valid if and only if
$alpha and phi_("in") and not phi_("out")$ (@eq:nnv2) is unsatisfiable.

First, do this by hand (on paper) by explicitly writing out the logical
equivalences step by step. Then, verify your result using Z3, i.e., show
that the negation of the first formula is equivalent to the second formula.
] <ex-negation-trick>

#example[
We represent the network in @fig:dnn-b as a formula $alpha$:

$
  x_3 =  relu(-0.5 x_1 + 0.5 x_2 + 1.0) and \
  x_4 =  relu(0.5 x_1 - 0.5 x_2 - 1.0) and \
  x_5 = -x_3 + x_4 - 1.0
$

and the property $x_5 > 0$ for any inputs
$x_1 in [-1, 1], x_2 in [-2, 2]$ as:

$
  phi_("in") = (-1 <= x_1 <= 1) and (-2 <= x_2 <= 2)\
  phi_("out") = (x_5 > 0)
$
] <ex:dnn-sat>

#paragraph[Satisfiability Solving][We can check the satisfiability of
$alpha and phi_("in") and not phi_("out")$ (@eq:nnv2) using constraint solving, e.g.,
the Z3 SMT solver. @sec:se-smt shows how to perform symbolic
execution and use an SMT solver to automatically generate this formula
from a given network and property, and check its satisfiability.
 @sec:using-milp shows how to encode the problem as MILP
constraints, solvable using a MILP solver (e.g., Gurobi).]

#example[For @ex:dnn-sat, the formula is satisfiable, i.e., the property is invalid,
and the solver returns #sat. Any satisfying assignment, e.g.,
$x_1 = -1$ and $x_2 = 2$, is a counterexample
to the property, as it satisfies the
precondition $phi_("in")$ but violates the postcondition $phi_("out")$,
i.e., $x_5 = -3.5$, which is $< 0$.
]


#problem[
Use Z3 to do @ex:dnn-sat. You might find @ex:z3-dnn useful.
Make sure that you also ask Z3 to find a counterexample violating the
property (it does not have to be the same as above).
] <problem-z3-dnn>



#let mydnn2(sc: 100%) = figure(
  scale(sc)[
    #canvas({
      import draw: *
      let r = 0.42
      let x1 = (0,   1)
      let x2 = (0,  -1)
      let x3 = (2.8, 1)
      let x4 = (2.8,-1)
      let x5 = (5,   1)
      let x6 = (5,  -1)

      // (from, to, label, above/below, midway=0.5/near-end=0.75)
      let edges = (
        (x1, x3, "-0.7", "above", 0.5),
        (x1, x4,  "1.2", "below", 0.75),
        (x2, x3,  "0.3", "above", 0.75),
        (x2, x4, "-0.5", "below", 0.5),
        (x3, x5, "-2.0", "above", 0.5),
        (x4, x5,  "3.0", "above", 0.75),
        (x3, x6, "-1.8", "below", 0.75),
        (x4, x6,  "0.7", "below", 0.5),
      )

      // pass 1: lines
      for (a, b, label, side, t) in edges {
        let dx = b.at(0) - a.at(0)
        let dy = b.at(1) - a.at(1)
        let len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / len
        let uy = dy / len
        let start = (a.at(0) + r * ux, a.at(1) + r * uy)
        let end   = (b.at(0) - r * ux, b.at(1) - r * uy)
        line(start, end, stroke: 1pt, mark: (end: ">"))
      }

      // pass 2: edge labels
      for (a, b, label, side, t) in edges {
        let dx = b.at(0) - a.at(0)
        let dy = b.at(1) - a.at(1)
        let len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / len
        let uy = dy / len
        let sign = if side == "above" { 1 } else { -1 }
        let mx = a.at(0) + dx * t + (-uy * 0.25 * sign)
        let my = a.at(1) + dy * t + ( ux * 0.25 * sign)
        content((mx, my), box(fill: white, inset: 1pt, text(size: 9pt)[#label]))
      }

      // pass 3: nodes + bias labels
      for (pos, label, fill-color, bias, bias-pos) in (
        (x1, $x_1$, green.lighten(50%),  none,    none),
        (x2, $x_2$, green.lighten(50%),  none,    none),
        (x3, $x_3$, yellow.lighten(50%), $0.8$,   "above"),
        (x4, $x_4$, yellow.lighten(50%), $-2.0$,  "below"),
        (x5, $x_5$, red.lighten(50%),    $-1.2$,  "above"),
        (x6, $x_6$, red.lighten(50%),    $-0.3$,  "below"),
      ) {
        circle(pos, radius: r, stroke: 1pt, fill: fill-color)
        content(pos, label)
        if bias != none {
          let sign = if bias-pos == "above" { 1 } else { -1 }
          content(
            (pos.at(0), pos.at(1) + (r + 0.2) * sign),
            text(size: 9pt)[#bias]
          )
        }
      }
    })
  ]
) 

// \begin{problem 

#problem[

#figure(
  mydnn2(sc: 100%),
  caption: [A simple network with 2 inputs, 2 hidden ReLU neurons, and 2 outputs.],
) <fig:mydnntwo>

Consider the neural network in @fig:mydnntwo. Do the following:

+ Write the formula $alpha$ representing the network.
+ Create the property $phi$ that the output $x_5 >= x_6$ for any inputs $x_1 in [-1, 1]$, $x_2 in [-1, 1]$.
+ Generate the satisfiability formula $alpha and overline(phi)$ as shown in @eq:nnv2.
+ Use Z3 to check the satisfiability of the formula. If it is satisfiable, extract a counterexample input that violates the property.
 
] <problem:mydnntwo>



// \begin{solution}
// \begin{enumerate}
//     \item The formula $alpha$ representing the network in~@fig:mydnntwo is:
//     \begin{align*}
//     & x_3 = \max(-0.7x_1 + 0.3x_2 + 0.8, 0) ~\land \\
//     & x_4 = \max(1.2x_1 - 0.5x_2 - 2.0, 0) ~\land \\
//     & x_5 = -2.0x_3 + 3.0x_4 - 1.2 ~\land \\
//     & x_6 = -1.8x_3 + 0.7x_4 - 0.3
//     \end{align*}

//     \item The property $phi$ that the output $x_5 >= x_6$ for any inputs $x_1 in [-1,1], x_2 in [-1,1]$ is:
//     \begin{align*}
//     phi_"in" &= (-1 <= x_1 <= 1) \land (-1 <= x_2 <= 1) \\
//     phi_"out" &= (x_5 >= x_6)
//     \end{align*}

//     \item The satisfiability formula $alpha \land phi_"in" \land not phi_"out"$ (see~@eq:nnv2) is:
//     \begin{align*}
//     & x_3 = \max(-0.7x_1 + 0.3x_2 + 0.8, 0) ~\land \\
//     & x_4 = \max(1.2x_1 - 0.5x_2 - 2.0, 0) ~\land \\
//     & x_5 = -2.0x_3 + 3.0x_4 - 1.2 ~\land \\
//     & x_6 = -1.8x_3 + 0.7x_4 - 0.3 ~\land \\
//     & (-1 <= x_1 <= 1) \land (-1 <= x_2 <= 1) ~\land \\
//     & (x_5 < x_6)
//     \end{align*}

//     \item Using Z3 to check satisfiability:
// \begin{lstlisting}[language=python,breaklines=true,basicstyle=\ttfamily\small]
// from z3 import Real, If, Solver, sat

// x1, x2 = Real('x1'), Real('x2')
// x3, x3_, x4, x4_ = Real('x3'), Real('x3_'), Real('x4'), Real('x4_')
// x5, x6 = Real('x5'), Real('x6')

// l2a = x3 = -0.7 * x1 + 0.3 * x2 + 0.8
// l2a_ = x3_ = If(x3 > 0, x3, 0)
// l2b = x4 = 1.2 * x1 - 0.5 * x2 - 2.0
// l2b_ = x4_ = If(x4 > 0, x4, 0)
// l3a = x5 = -2.0 * x3_ + 3.0 * x4_ - 1.2
// l3b = x6 = -1.8 * x3_ + 0.7 * x4_ - 0.3

// s = Solver()
// s.add(l2a, l2a_, l2b, l2b_, l3a, l3b)
// s.add(x1 >= -1, x1 <= 1, x2 >= -1, x2 <= 1)
// s.add(x5 < x6)

// if s.check() = sat:
//     m = s.model()
//     print("Satisfiable - counterexample found:")
//     print(f"x1 = {m[x1]}, x2 = {m[x2]}")
//     print(f"x5 = {m[x5]}, x6 = {m[x6]}")
// else:
//     print("Unsatisfiable - property holds")
// \end{lstlisting}

// The formula is \textbf{satisfiable}, meaning the property is invalid. A counterexample is $x_1 = -1, x_2 = -1$, which gives $x_5 = -1.2$ and $x_6 \approx 0.14$, violating the property since $x_5 < x_6$.
// \end{enumerate}
// \end{solution}
// \end{problem}

== Complexity <sec:complexity>

As shown in @katz2017reluplex @salzer2023reachability ReLU-based NNV is NP-complete by reducing the 3-SAT problem to it. This means that the problem of checking whether a given ReLU-based network satisfies a property is computationally hard, and no polynomial-time algorithm is known to solve it in the general case.

// %  == Challenges} %TODO

// % \subsection{Scalability} Neural networks can be very large, with millions of parameters. This makes it difficult to verify their correctness, as the number of possible inputs grows exponentially with the size of the network.

// % %TODO: put somewhere else
// % For DNN verification, AF is straightforward to reason about because it is a linear function. However, AFs are often followed by non-linear activation functions, described next in~@sec:activation, which make the verification problem more challenging.

// % %TODO: put somewhere else
// % For DNN verification, these non-linear activation functions make verification difficult because it introduces multiple possible outcomes for any input, making it hard to reason about the output of the network. For example, ReLU has two possible outputs for any input: 0 if the input is less than zero, and the input itself otherwise, and Sigmoid has a smooth curve with infinite possible outputs for any input.


// % \subsection{Formalization}


// % \subsection{Expressiveness}



// %  == Challenges in Specifying Properties}\tvn{TODO}

// % Specifying desirable properties for neural networks is not straightforward. Some challenges include:
// % \begin{itemize}
// %     \item \textbf{Incomplete Specifications:} We may not be able to specify all desirable properties.
// %     \item \textbf{Expressiveness} For tasks such as sentiment analysis or image recognition, functional correctness is hard to define precisely.
// % \end{itemize}



// \part{Constraint Solving and Abstraction <part:constraint-solving-abstraction}
#pagebreak()
= Constraint Solving <chap:constraint-solving>

== Symbolic Execution and SMT Solving <sec:se-smt>

As described in @sec:satisfiability-and-activation-pattern-search the Neural Network Verification (NNV) problem can be formulated as a satisfiability problem. Specifically, we encode the network as a logical formula, and use a constraint solver to check that formula satisfies the property of interest.

A straightforward and automated way to do this encoding is using _symbolic execution_ (SE)@baldoni2018survey, @king1976symbolic, a well-known software testing technique for finding bugs.  SE executes a program on symbolic inputs, i.e., inputs represented as symbols rather than concrete values, and tracks the reachability of program state as symbolic expressions, i.e., logical formulae over symbolic inputs. The satisfiability of these formulae is then checked using an SMT solver, and satisfying assignments represent inputs leading to the undesirable (buggy) program state.

=== Symbolic Execution <sec:se>
We can adapt traditional SE to our problem by treating the network as a program and neurons as variables and executing the network on symbolic inputs. Affine transformations can easily be represented as logical formulae because they are linear functions. Activation functions such as ReLUs are translated to disjunctions of linear functions or if-then-else statements:

$
  y =  relu(x)  \
  y = max(x, 0) \
  y = "if" x > 0 "then" x "else" 0\
  (x > 0 and y = x) or (x <= 0 and y = 0)
$

#example[
#figure(
mydnn(sc: 100%),
  caption: [A simple network with two inputs $x_1,x_2$, two hidden neurons $x_3,x_4$, and one output neuron $x_5$.]
) <fig:dnn-a>

To create a logical formula representing the network in @fig:dnn-a, we can symbolically execute the network on symbolic inputs $x_1,x_2$ and track the values of the neurons $x_3, x_4, x_5$ as a set (conjunction) of logical formulae.  SE starts with the inputs $x_1$ and $x_2$ and computes the values of the neurons in the hidden layer, $x_3$ and $x_4$, using the affine transformations, followed by ReLUs. Finally, SE computes the output neuron $x_5$ as a linear combination of the hidden layer neurons.

$ 
x_5 &= -x_3 + x_4 - 1.0 and \
x_3 &= max(-0.5x_1 + 0.5x_2 + 1.0, 0) and \
x_4 &= max(0.5x_1 - 0.5x_2 - 1.0, 0)
$ <eq:se-dnn>
]


=== SMT Solving <sec:smt>
After obtaining the symbolic representation of the network, we can use an SMT solver @barrett2010smt to check the satisfiability of the formula $alpha and phi_("in") and not phi_("out")$ as shown in @eq:nnv2, where $alpha$ is the symbolic representation of the network, $phi_"in"$ is the precondition on the inputs, and $phi_("out")$ is the postcondition on the outputs. 

The solver checks if there exists an assignment to the symbolic inputs that satisfies the formula. If such an assignment exists, it means that the property is violated, and we can extract a counterexample from the satisfying assignment. Otherwise, if no such assignment exists, the property is valid.


#example[ 
  To check that the network in @fig:dnn-a satisfies the property $x_5 > 0$ for any inputs $x_1 in [-1,1], x_2 in [-2,2]$ (@ex:dnn-sat), represented as:
  $
  phi_("in") = (x_1 >= -1) and (x_1 <= 1) and (x_2 >= -2) and (x_2 <= 2)\
  phi_("out") = (x_5 > 0)
  $
We check the satisfiability of $alpha and phi_("in") and not phi_("out")$:
$
x_5 &= -x_3 + x_4 - 1.0 and \
x_3 &= "max"(-0.5x_1 + 0.5x_2 + 1.0, 0) and \
x_4 &= "max"(0.5x_1 - 0.5x_2 - 1.0, 0) and \
     &(x_1 >= -1) and (x_1 <= 1) and (x_2 >= -2) and (x_2 <= 2) and (x_5 <= 0) \
    
$
In this case, the SMT solver returns `sat` and a satisfying assignment, e.g., $x_1=-1$ and $x_2=2$, which is a counterexample to the property. This means that for these inputs, the output $x_5 = -3.5$ violates the property $x_5 > 0$.
]<ex:smt-dnn>

=== Limitations <sec:smt-limitations>

While using symbolic execution and SMT solving is a straightforward way to verify networks, it has several practical limitations:

  - *Path Explosion and Scalability*: the number of paths that the solver has to analyze can grow exponentially with the number of ReLU-based neurons and layers as each ReLU, represented as a disjunction of linear functions, has two possible outputs for any input (i.e., the input value itself or 0).  This leads to the notorious _path explosion_ problem and becoming intractable for large networks. Programming assignment 1 (@sec:pa1) demonstrates this issue.

  - *Non-linearity:* Other non-linear activation functions (@sec:activation), such as Sigmoid or Tanh, might not be easily representable as disjunctions of linear functions as ReLU. This can lead to complex formulae that are hard to reason about and/or result in a large search space for the SMT solver.

  - *Precision Issues:* SMT solvers may struggle with precision when dealing with floating-point arithmetic, which is common in neural networks. This can lead to incorrect results or false positives/negatives in the verification process.

For these reasons, SMT solving is mostly used on toy examples, e.g., in a classroom setting.  Modern NNV tools do not use SMT solving, and instead, rely on more efficient techniques such as abstraction (@chap:abstractions).

// %\tvn{Hai, include some references or results, e.g., from Nguyen's, showing that SMT solvers are not scalable for DNN verification.}\hai{where can I find the results?}\tvn{Not sure, I thought Nguyen record the results/graphs in some TeX document. Could you ask him?}

== MILP <sec:using-milp>

Instead of using SMT solving, we can encode the NNV problem as a Mixed Integer Linear Programming (MILP) constraints (@sec:lp), and then invoke an MILP solver such as Gurobi @gurobi to check their satisfiability or _feasibility_ (@sec:lp-feasibility).


// % The fundamental difference between SMT and MILP solving is that SMT solvers aims to find satisfying assignments that make a given logical formula true. In contrast, MILP solvers aim to find the best solution (according to some objective function) that satisfy a given set of \emph{linear} constraints.
// % Thus, we need to encode the DNN as a set of linear constraints, and use binary indicator variables (@sec:milp-binary) to represent the non-linear activation functions such as ReLU.  This creates an MILP problem solvable using a MILP solver.

// % Due to scalability issues with SMT solvers (@sec:smt-limitations), modern DNN verification techniques ~\cite{wang2018efficient,tjeng2019evaluating,duong2024harnessing} often rely on Mixed Integer Linear Programming (MILP) solving, which is specialized for linear constraints and more efficient for DNN reasoning. %Many state-of-the-art DNN verification tools use the industrial-strength MILP solver Gurobi~\cite{gurobi}.

// % The fundamental distinction between SMT and MILP solving lies in their problem formulation and solution approach.
// % SMT solvers address satisfiability problems: determining whether there exist variable assignments that make a given logical formula true.
// % SMT solvers can handle diverse mathematical theories including non-linear arithmetic.
// % MILP solvers address optimization problems: finding the best solution (according to some objective function) that satisfy a given set of \emph{linear} constraints.


// % MILP solvers cannot directly solve general SMT problems because they are restricted to linear constraints and cannot handle the non-linear theories and complex logical structures that SMT problems often contain.
// % While SMT solvers could theoretically encode MILP problems as satisfiability queries, they are not designed for optimization and would be highly inefficient.
// % Despite both approaches having exponential worst-case complexity, MILP solvers often demonstrate superior practical performance due to their restriction to linear constraints, which enables several key optimizations such as linear relaxations, preprocessing techniques, and specialized algorithms.


// %\paragraph{MILP} Mixed Integer Linear Programming (MILP) is an optimization technique that solves problems involving both continuous variables (real numbers) and integer variables (including binary 0/1 variables), subject to linear constraints. Unlike SMT solvers that handle complex logical formulae with disjunctions, MILP solvers are specifically designed for linear constraints and can leverage decades of optimization research to solve large-scale problems efficiently.


=== ReLU Encoding <sec:relu-encoding>

We first encode non-linear activation functions like ReLU using _binary indicator_ variables and linear constraints. For each neuron, we introduce a binary variable (@sec:milp-binary) that indicates whether the neuron is "active" (output equals input) or "inactive" (output is zero). This transforms the non-linear `max(z,0)` operation into a set of linear inequalities controlled by the binary variable.


#definition[We define
  - $z$: the pre-activation value, i.e., the value that goes into ReLU
  - $hat(z)$: the post-activation value, i.e., the output of ReLU
  - $a in {0,1}$: a binary indicator variable encoding whether the neuron is active ($z >= 0$) or inactive ($z < 0$)
  - $l, u$: lower and upper bounds on $z$ ($l <= z <=u$).
]

#paragraph[Encoding][The MILP encoding of $hat(z) = "max"(z, 0)$ is then (@ex:relu_milp shows a simpler example that does not involve bounds):

$
    &hat(z) >= z \
    &hat(z) >= 0 \
    &hat(z) <= a dot u \
    &hat(z) <= z - l(1-a) \
    &a in {0,1}
$
]


These constraints enforce $hat(z) = z$ when $a = 1$ (active) and $hat(z) = 0$ when $a = 0$ (inactive), which captures the two possible ReLU outputs ($0$ or $z$).
Note that constraints are linear and involve both continuous variable $hat(z)$ and binary variable $a$.

=== Computing Concrete Bounds <sec:pre-relu-bounds>

The mentioned lower and upper bounds (@sec:relu-encoding)---_concrete_ values $l$ and $u$ such that $l <= z <= u$ over the input $z$ to ReLU--- are critical for ensuring that the binary indicator $a$ can only take on values that are _valid_ given the possible range of $z$. For example, if $u < 0$, then $z$ is always negative, so the active phase ($a=1$) is infeasible, and thus can be eliminated.  Similarly, if $l >= 0$, then $z$ is always active.


Either of these cases indicates the neuron is _stable_---always active or always inactive---and thus significantly simplifies the MILP problem because ReLU can be replaced with a linear function (identity or constant 0). Of course, if $l < 0 < u$, then both active and inactive phases are possible, and the MILP solver has to consider both cases. @chap:abstractions discusses abstraction techniques to approximate ReLU outputs.


// %In general, the tightness of the bounds $l$ and $u$ is crucial for the efficiency of the MILP solver and a major focus of DNN reasoning is developing techniques to capture these bounds more precisely (@chap:abstractions).

*Computing Bounds $l <= e <= u$*: Given a linear expression $e$
$
e = a_1 x_1 + a_2 x_2 + dots + b,
$
where each variable $x_i$ ranges over $[l_i, u_i]$, a simple way to compute the bounds $l <= e <= u$ is using _interval_ arithmetic (@sec:interval-abstraction):


- *For the lower bound* ($l_3$): For each $x_i$, use its upper bound $u_i$ if $a_i < 0$, and use its lower bound $l_i$ if $a_i >= 0$.
- *For the upper bound* ($u_3$): For each $x_i$, use $l_i$ if $a_i < 0$, and use $u_i$ if $a_i >= 0$.

This guarantees that the extreme values of $e$ are achieved at some corner of the input box.




#example[ 

#figure(
mydnn(sc: 100%),
caption: [A simple network (similar to @fig:dnn.]
)<fig:dnn-c>

Consider neuron $x_3$ in the network in @fig:dnn-c.
We have $x_3 = -0.5x_1 + 0.5x_2 + 1.0$ as the pre-activation value of $x_3$. The upper $u_3$ and lower $l_3$ bounds on $x_3$ over the input region $x_1 in [-1,1]$ and $x_2 in [-2,2]$ are:
$
    z_3 &= -0.5x_1 + 0.5x_2 + 1.0 \
    l_3 &= -0.5(1) + 0.5(-2) + 1.0 = -0.5 \
    u_3 &= -0.5(-1) + 0.5(2) + 1.0 = 2.5 \
$
Notice that we use different pairs of values to compute the lower (1,-2) and upper (-1,2) bounds.


With the computed bounds, we encode the ReLU output of $x_3$:
$
    &hat(x)_3 >= x_3 \
    &hat(x)_3 >= 0 \
    &hat(x)_3 <= a_3 dot u_3 \
  =>&hat(x)_3 <= a_3 dot 2.5 \
    &hat(x)_3 <= x_3 - l_3(1-a_3) \
  =>  &hat(x)_3 <= x_3 - (-0.5)(1-a_3) \
=>  &hat(x)_3 <= x_3 + 0.5(1-a_3) \
    &a_3 in {0,1}
$

Note that because $l_3 = -0.5$ and $u_3 = 2.5$, $a_3$ can be either 0 or 1, depending on the value of $x_3$. If we had different bounds, e.g., $l_3 = 0.1$, then $a_3$ would be 1, as $x_3$ can never be less than 0.1 (i.e., $x_3$ is a stable neuron because it is always active). Stable neurons replaces ReLU with either 0 or identity function, which significantly simplifies the problem.
]<ex:relu_milp1>


=== Neural Network Encoding
We can encode a neural network as a set of MILP linear constraints as follows:

$
&(a) quad z^i = W^i hat(z)^((i-1)) + b^i; \
&(b) quad y = z^{L};  x = hat(z)^{0}; \
&(c) quad hat(z)_j^i >= {z}_j^i; quad hat(z)_j^i >= 0; \
&(d) quad a_j^i in { 0, 1} ;\
&(e) quad hat(z)_j^i <= {a}_j^i u_j^i; quad hat(z)_j^i <= z_j^i - l_j^i (1 - a_j^i);
$ <eq:mip>

where $x$ is input, $y$ is output, and $z^i$, $hat(z)^i$, $W^i$, and $b^i$ are the pre-activation, post-activation, weight, and bias vectors for layer $i$ ($j$ is the neuron index in layer $i$). 

Thus, we can encode a neural network as a set of linear constraints by:

+ Define the affine transformation computing the pre-activation value for a neuron in terms of outputs in the preceding layer;
+ Define the inputs and outputs in terms of the adjacent hidden layers;
+ Assert that post-activation values are non-negative and no less than pre-activation values;
+ Define that the neuron activation status indicator variables that are either 0 or 1; and
+ Define constraints on the upper, $u_j^{(i)}$, and lower, $l_j^{(i)}$, bounds of the pre-activation value of the $j$th neuron in the $i$th layer.

Deactivating a neuron, $a_j^i = 0$, simplifies the first of the (5) constraints to $hat(z)_j^i <= 0$, and activating a neuron simplifies the second to $hat(z)_j^i <= z_j^i$, which is consistent with the semantics of $hat(z)_j^i = max(z_j^i,0)$.


#example[Full example][ 
We use MILP to formulate and check if the network in @fig:dnn-c satisfies the property $x_5 > 0$ for any inputs $x_1 in [-1,1], x_2 in [-2,2]$. We do this by checking the feasibility of the MILP constraints encoding $alpha and phi_"in" and not phi_"out"$, where $alpha$ is the MILP encoding of the network, $phi_"in"$ is the precondition, and $phi_"out"$ is the postcondition.  We do this in several steps:

+ *Encoding*: *precondition* $phi_"in"$ and *postcondition* $not phi_"out"$:
  $
  phi_"in" &: -1 <= x_1 <= 1;quad -2 <= x_2 <= 2, quad not phi_"out" &: x_5 <= 0
  $
  
  *Hidden layer* (pre- and post-activation):
  $
  z_3 &= -0.5x_1 + 0.5x_2 + 1.0, quad z_4 = 0.5x_1 - 0.5x_2 - 1.0 \
  hat(z)_3 &>= z_3, quad  hat(z)_3 >= 0, quad  hat(z)_4 >= z_4, quad  hat(z)_4 >= 0 \
  a_3&, a_4 in {0, 1} \
  hat(z)_3 &<= a_3 dot u_3, quad  hat(z)_3 <= z_3 - l_3(1 - a_3), quad hat(z)_4 <= a_4 dot u_4, quad  hat(z)_4 <= z_4 - l_4(1 - a_4)
  $

  *Output layer*: $x_5 &= - hat(z)_3 +  hat(z)_4 - 1.0$

+ *Computing* upper and lower bounds over input ranges $x_1 in [-1,1], x_2 in [-2,2]$:
  $
  z_3 &in [-0.5 dot 1 + 0.5 dot (-2) + 1, -0.5 dot (-1) + 0.5 dot 2 + 1] = [-0.5, 2.5] \
  z_4 &in [0.5 dot (-1) - 0.5 dot 2 - 1, 0.5 dot 1 - 0.5 dot (-2) - 1] = [-2.5, 0.5]
  $

  So we set $l_3 = -0.5, u_3 = 2.5$, and $l_4 = -2.5, u_4 = 0.5$.

+ *Substituting bounds* into the constraints:
  $
  hat(z)_3 &<= a_3 dot 2.5, quad  hat(z)_3 <= z_3 - (-0.5)(1 - a_3) = z_3 + 0.5(1 - a_3) \
  hat(z)_4 &<= a_4 dot 0.5, quad  hat(z)_4 <= z_4 - (-2.5)(1 - a_4) = z_4 + 2.5(1 - a_4)
  $

+ *The final MILP encoding:*
$
& -1 <= x_1 <= 1; quad -2 <= x_2 <= 2\
& z_3 = -0.5x_1 + 0.5x_2 + 1.0, quad z_4 = 0.5x_1 - 0.5x_2 - 1.0 \
&  hat(z)_3 >= z_3, quad  hat(z)_3 >= 0, quad hat(z)_4 >= z_4, quad  hat(z)_4 >= 0 \
& a_3, a_4 in  {0, 1 } \
&  hat(z)_3 <= a_3 dot 2.5, quad  hat(z)_3 <= z_3 + 0.5(1 - a_3) quad hat(z)_4 <= a_4 dot 0.5, quad  hat(z)_4 <= z_4 + 2.5(1 - a_4) \
& x_5 = - hat(z)_3 +  hat(z)_4 - 1.0, quad x_5 <= 0 \
& "where" z_3 in [-0.5, 2.5], z_4 in [-2.5, 0.5],  hat(z)_3 in [0, 2.5],  hat(z)_4 in [0, 0.5].
$
// %\tvn{Do we need to specify the ranges (e.g., $z_3 in [-0.5, 2.5]$) at the end or they are redundant?}

+ *Solving* The MILP solver attempts to find a feasible (@sec:lp-feasibility) or satisfying assignment representing a counterexample violating the property.  In this example, it might find $x_1 = -1, x_2 = 2$, which leads to:

$
z_3 &= -0.5(-1) + 0.5(2) + 1.0 = 2.5, quad z_4 = 0.5(-1) - 0.5(2) - 1.0 = -2.5 \
a_3 &= 1,  hat(z)_3 = 2.5 quad ("neuron active"), quad a_4 = 0,  hat(z)_4 = 0 quad ("neuron inactive") \
x_5 &= -2.5 + 0 - 1.0 = -3.5
$
Since $x_5 = -3.5$, this satisfies our search for $x_5 <= 0$ and  thus is a counterexample.

]<ex:milp-dnn>


#problem[
#figure(
    [#mydnn(sc:100%)],
    caption: [A simple network (similar to @fig:dnn).],
  ) <fig:dnn-d>
Use MILP encoding and solving to check if the network @fig:dnn-d satisfies the property $x_5 >= x_6$ for any inputs $x_1 in [-1,1], x_2 in [-1,1]$. Specificaly, do the following steps:

+ Write down the precondition $phi_"in"$ and postcondition $phi_"out"$.
+ Write down the MILP encoding of the network.
+ Compute the upper and lower bounds of the pre-activation values of the neurons in the hidden layer.
+ Substitute the bounds into the MILP encoding.
+ Write down the final MILP encoding of $alpha \land phi_"in" \land not{phi_"out"}$.
+ Check the feasibility of the MILP encoding (e.g., using Z3) and report the result.
]<prob:milp-dnn>


#problem[
As shown in @ex:relu_milp1, the upper and lower bounds of neuron $x_3$ of the network in @fig:dnn-c are $u_3 = 2.5$ and $l_3 = -0.5$.

+ Compute the upper and lower bounds of $x_4$ in the same example.
+ Change the weights and/or biases of the network in @fig:dnn-c, but keep the input ranges $-1 <= x_1 <= 1$ and $-2 <= x_2 <= 2$, such that $x_3$ becomes a stable neuron (always active or always inactive).  Show the new weights and/or biases, and compute the new upper and lower bounds of $x_3$.
] <prob:stable-neuron>

// % \tvn{So far we talk about bounds for pre-ReLU values, right? is that the same as post-ReLU?  In other words, when we talk about abstraction for ReLU, are we talking about these pre-ReLU bounds, which currently use intervals?  or the abstraction for ReLU refer to something else and not these pre-ReLU bounds?}
// % \hd{no, we are referring to post-ReLU bounds. For example, a pre-ReLU interval is  $z_3 in [-0.5, 2.5]$ --- indicating an unstable neuron, and we will abstraction to compute bounds for the post-ReLU e.g., $ hat(z)_3$.}\tvn{I am still confused, see example~@ex:relu_milp .. I am computing the upper and lower bounds of $x_3$, not $ hat(x)_3$. The bounds of $ hat(x)_3$ is always $[0, u_3]$.}

=== Limitations <sec:milp-limitations>

- *Scalability*: While MILP is efficient in dealing with linear constraints, it still cannot be applied directly to real-world neural networks due to the large search space. Each ReLU application to an unstable neuron introduces a binary variable (@sec:relu-encoding), leading to exponential number of possible branches, and real-world networks can have millions of such ReLUs, making the search space intractable.

- *Limited exploitation of network structure and modern hardware*: Off-the-shelf MILP solvers are designed for arbitrary MILP problems and do not exploit specific structures of neural networks and concepts such as activation patterns (@sec:activation-patterns) to prune the search space. Moreover, MILP solvers, even industrial-strength ones such as Gurobi @gurobi, are primarily CPU-based and do not leverage the massive parallelism provided by modern GPUs to improve scalability.


- *Advanced Abstraction and Heuristics*: Interval analysis is efficient and commonly used for computing neuron bounds, but cannot capture dependencies between neurons, leading to precision loss in deeper networks. SOTA NNV tools use more advanced abstract domains such as zonotopes  and polytopes to improve precision (@chap:abstractions).

  Modern NNV tools also employ heuristics to decide which neurons to branch on and to determine stable neurons to avoid unnecessary branching. These heuristics are not available in general MILP solvers.



//%\tvn{Hai, above you mention MILP also employs BaB algorithm, could you write a paragraph or so about how MILP solvers use BaB and briefly show how that would apply to example 4.2.2 (just briefly, no need a full step by step demonstration). Is this BaB algorithm used by MILP very similar to the one used by DNN verification tools (minus the DNN specific optimizations and heuristics)? like the BaB algorithm described in~@alg:bab }
// % ---

// % Let me know if you want this condensed further or expanded into sub-items for even more clarity!



// % Despite its precision, MILP encoding faces severe scalability limitations that prevent its direct application to real-world DNNs.
// % The primary issue is the exponential explosion in the search space: each ReLU neuron introduces a binary variable $a$, and for a network with $n$ ReLU neurons, the MILP solver must potentially explore $2^n$ different activation patterns.
// % While industrial MILP solvers like Gurobi are highly optimized, they are designed for general optimization problems and cannot exploit the specific structure of neural networks.
// % Additionally, MILP solvers are primarily CPU-based and cannot leverage the massive parallelism of GPUs that modern DNNs rely upon, further limiting their computational efficiency.

// % While MILP solvers already employ BaB algorithms, they use general-purpose BaB designed for arbitrary linear programming problems, which cannot exploit the specific structure of neural networks.
// % % This motivates the development of specialized DNN verification algorithms like \reluplex{}~\cite{katz2017reluplex} and custom branch-and-bound techniques that integrate DNN-specific abstractions and propagation methods.
// % Unlike MILP's generic branching on arbitrary variables, DNN-specific BaB algorithms can exploit layer-wise structure, propagate bounds through activation functions using specialized abstract domains (intervals, zonotopes, polyhedra), and employ neuron-specific heuristics to select which neurons to branch.
// % For instance, \reluplex{} extends the Simplex algorithm with custom pivot rules for ReLU constraints, while \neuralsat{} integrates conflict-driven learning tailored to activation patterns and neuron stabilization techniques that can infer neurons proven to be always active or inactive---optimizations that are not available in general MILP frameworks.

// % While interval abstraction provides a foundation for computing bounds, it suffers from significant precision loss that compounds through network layers, necessitating more sophisticated and precise abstractions.
// % The fundamental limitation is that intervals cannot capture correlations between variables---each neuron's bounds are computed independently, ignoring relationships with other neurons which leads to over-approximation that becomes increasingly loose in deeper networks.
// % More advanced abstractions like zonotopes can capture linear relationships between variables, while polytopes can represent arbitrary linear constraints.

#pagebreak()
= Abstractions <chap:abstractions>


As mentioned in @sec:relu-encoding the computation of upper and lower bounds of the neuron values help determine neuron stability and therefore can help scale NNV. Modern NNV tools explore different _abstraction_ techniques to compute these bounds more precisely while balancing computational efficiency.

This chapter discusses the interval, zonotope, and polytope abstract domains commonly used in NNV. Each domain provides a different way to represent and compute the bounds of neurons, with its own trade-offs in terms of precision and computational complexity.

== Overview and Background

// %We will focus on ReLU (@sec:relu) activation functions, which are the most common in DNNs. The goal is to compute the bounds of a post-ReLU neuron $ hat(z)$ given the bounds of its pre-ReLU value $z$ over the input region. For example, for a ReLU neuron $y = \max(0, x)$, we want to compute the bounds $[l_y(x), u_y(x)]$ of $y$ given the bounds $[l_x, u_x]$ on $x$.\tvn{is the pre-Relu bounds always computed like what was described in~@sec:pre-relu-bounds? Is that computation considered interval too? Can that bound computation be obtained using other abstractions?}
// %\hd{yes, concrete bounds will always be computed like what was described in~@sec:pre-relu-bounds IF the bounds of a neurons are presented as linear equations. In other words, abstractions differ in the way they construct the linear equations, concretization step will be the same.}

// %\hd{Zonotope uses a different approach to represent the abstraction, using center and generators, so concretization step will be different. But if we construct the lower and upper equations for a zonotope, the concretization step will be the same.}

// %\hd{Note that, the equations of a neuron are not $e = f(x_1, ..., x_n)$, but
// %\[f_L(x_1, ..., x_n) <= e <= f_U(x_1, ..., x_n)\]
// %So to compute the concrete bounds, $e_L = min(f_L(x_1, ..., x_n))$ and $e_U = max(f_U(x_1, ..., x_n))$, where $min(f_L(x_1, ..., x_n))$ and $max(f_U(x_1, ..., x_n))$ are the concretization steps.}

// %We want to compute the bounds to be as tight as possible, i.e., they should be the largest lower and lowest upper values that $ hat(z)$ can take given the bounds on $z$. This computation is called \emph{abstraction} and is crucial for DNN verification, as it allows us to reason about the behavior of the network without having to enumerate all possible values of the neurons. There are several abstraction techniques that can be used to compute these bounds, each with its own trade-offs in terms of precision and computational complexity.

// \newcommand{ in tervalabstraction}[1]{
//     \begin{tikzpicture}[scale=#1]
//         % Colors
//         \def\lx{-1.0}
//         \def\ux{1.0}
//         \def\ly{0}
//         \def\uy{1.0}
//         % Fill region
//         \fill[yellowfill] (\lx,\ly) rectangle (\ux,\uy);
//         % Axes
//         \draw[thick,->] ({\lx-0.2},0) -- ({\ux+0.3},0) node[right] {$x$};
//         \draw[thick,->] (0,{\ly-0.3}) -- (0,{\uy+0.3}) node[above] {$y$};
//         % Dashed bounds
//         \draw[dashed] (\lx,{\ly-0.1}) -- (\lx,{\uy+0.2});
//         \draw[dashed] (\ux,{\ly-0.1}) -- (\ux,{\uy+0.2});
//         \draw[dashed] (\lx,\uy) -- (\ux,\uy);
//         % ReLU line
//         \draw[ultra thick,myred] (\lx,\ly) -- (0,\ly) -- (\ux,\uy);
//         % Labels
//         \node[below] at (\lx,0) {$l_x$};
//         \node[below] at (\ux,-0.05) {$u_x$};
//         \node[left] at (-0.1,\ly-0.2) {$l_y(x)$};
//         \node[above] at (\ux-0.5,\uy) {$u_y(x)$};
//         \node[below right] at (0,0) {$0$};
//     \end{tikzpicture}
// }
// \newcommand{\zonotopeabstraction}[1]{
//     \begin{tikzpicture}[scale=#1]
//         \def\lx{-1.0} \def\ux{1.0} \def\d{0.5}
//         \coordinate (A) at (\lx, \d*\lx+0.1);
//         \coordinate (B) at (\lx, 0.2);
//         \coordinate (E) at (\ux, \ux+0.01);
//         \coordinate (F) at (\ux, \ux-\d*\ux-0.1);
//         \fill[yellowfill] (A) -- (B) -- (E) -- (F) -- cycle;
//         \draw[thick,->] ({\lx-0.2},0) -- ({\ux+0.3},0) node[right] {$x$};
//         \draw[thick,->] (0,-0.6) -- (0,{\ux+0.2}) node[above] {$y$};
//         \draw[dashed] (\lx,-0.6) -- (\lx,{\ux+0.1});
//         \draw[dashed] (\ux,-0.6) -- (\ux,{\ux+0.1});
//         \draw[dashed] (\lx, 0.2) -- (\ux, \ux+0.01);
//         \draw[dashed] (\lx, \d*\lx+0.1) -- (\ux, \ux-\d*\ux-0.1);
//         \draw[ultra thick,myred] (\lx,0) -- (0,0) -- (\ux,\ux);
//         \node[below] at (\lx-0.1,0) {$l_x$};
//         \node[below] at (\ux+0.12,-0.05) {$u_x$};
//         \node[below] at ({\lx/2},-0.3) {$l_{y}(x)$};
//         \node[above] at (\ux/2,\ux/2+0.3) {$u_{y}(x)$};
//         \node[below right] at (0,0) {$0$};
//     \end{tikzpicture}
// }

// \newcommand{\polytopeabstraction}[1]{
//     \begin{tikzpicture}[scale=#1]
//         \def\lx{-1.0} \def\ux{1.0} \def\d{0.5}
//         \coordinate (A) at (\lx, 0);
//         \coordinate (B) at (\lx, 0.01);
//         \coordinate (E) at (\ux, \ux+0.01);
//         \coordinate (F) at (\ux, 0);
//         \fill[yellowfill] (A) -- (B) -- (E) -- (F) -- cycle;
//         \draw[thick,->] ({\lx-0.2},0) -- ({\ux+0.3},0) node[right] {$x$};
//         \draw[thick,->] (0,-0.4) -- (0,{\ux+0.2}) node[above] {$y$};
//         \draw[dashed] (\lx,-0.3) -- (\lx,{\ux+0.1});
//         \draw[dashed] (\ux,-0.3) -- (\ux,{\ux+0.1});
//         \draw[dashed] (\lx, 0) -- (\ux, \ux+0.01);
//         \draw[dashed] (\lx, 0) -- (\ux, 0);
//         \draw[ultra thick,myred] (\lx,0) -- (0,0) -- (\ux,\ux);
//         \node[below] at (\lx-0.1,0) {$l_x$};
//         \node[below] at (\ux+0.12,-0.05) {$u_x$};
//         \node[below] at ({\lx/2},-0.01) {$l_{y}(x)$};
//         \node[above] at (\ux/2,\ux/2+0.3) {$u_{y}(x)$};
//         \node[below right] at (0,0) {$0$};
//     \end{tikzpicture}
// }

// \begin{figure}[h]
//     \centering
//     % First row
//     \begin{subfigure}{0.3\linewidth}
//         \centering
//          in tervalabstraction{1.5}
//         \caption{Interval}
//         \label{fig:relu-interval-abstraction}
//     \end{subfigure}
//     \hfill
//     \begin{subfigure}{0.3\linewidth}
//         \centering
//         \zonotopeabstraction{1.5}
//         \caption{Zonotope}
//         \label{fig:relu-zonotope-abstraction}
//     \end{subfigure}
//     \hfill
//     % Second row
//     \begin{subfigure}{0.3\linewidth}
//         \centering
//         \polytopeabstraction{1.5}
//         \caption{Polytope (lower flat)}
//         \label{fig:relu-polytope-abstraction}
//     \end{subfigure}
//     \caption{Abstractions of $\myrelu(x) = \max(0,x)$ over $x in [l_x, u_x]$ using (a) interval, (b) zonotope, (c) polytope abstractions.}
//     \label{fig:relu-all-abstractions}
// \end{figure}




// TikZ line widths: thick = 0.8pt, ultra thick = 1.6pt
#let thick = 0.8pt
#let ultra-thick = 1.6pt

// ============ \intervalabstraction{scale} ============
#let interval-abstraction(scale: 1.0) = canvas(length: scale * 1cm, {
  import draw: *
  let (lx, ux) = (-1.0, 1.0)
  let (ly, uy) = (0.0, 1.0)

  // Fill region
  rect((lx, ly), (ux, uy), fill: yellow.lighten(50%), stroke: none)

  // Axes
  line((lx - 0.2, 0), (ux + 0.3, 0), stroke: thick, mark: (end: "stealth", fill: black))
  content((ux + 0.3, 0), $x$, anchor: "west", padding: 2pt)
  line((0, ly - 0.3), (0, uy + 0.3), stroke: thick, mark: (end: "stealth", fill: black))
  content((0, uy + 0.3), $y$, anchor: "south", padding: 2pt)

  // Dashed bounds
  line((lx, ly - 0.1), (lx, uy + 0.2), stroke: (dash: "dashed"))
  line((ux, ly - 0.1), (ux, uy + 0.2), stroke: (dash: "dashed"))
  line((lx, uy), (ux, uy), stroke: (dash: "dashed"))

  // ReLU line
  line((lx, ly), (0, ly), (ux, uy), stroke: (paint: red, thickness: ultra-thick))

  // Labels
  content((lx, 0), $l_x$, anchor: "north", padding: 2pt)
  content((ux, -0.05), $u_x$, anchor: "north", padding: 2pt)
  content((-0.1, ly - 0.2), $l_y (x)$, anchor: "east", padding: 2pt)
  content((ux - 0.5, uy), $u_y (x)$, anchor: "south", padding: 2pt)
  content((0, 0), $0$, anchor: "north-west", padding: 2pt)
})

// ============ \zonotopeabstraction{scale} ============
#let zonotope-abstraction(scale: 1.0) = canvas(length: scale * 1cm, {
  import draw: *
  let (lx, ux, d) = (-1.0, 1.0, 0.5)

  // Coordinates
  let A = (lx, d * lx + 0.1)
  let B = (lx, 0.2)
  let E = (ux, ux + 0.01)
  let F = (ux, ux - d * ux - 0.1)

  // Fill region (closed polygon)
  line(A, B, E, F, close: true, fill: yellow.lighten(50%), stroke: none)

  // Axes
  line((lx - 0.2, 0), (ux + 0.3, 0), stroke: thick, mark: (end: "stealth", fill: black))
  content((ux + 0.3, 0), $x$, anchor: "west", padding: 2pt)
  line((0, -0.6), (0, ux + 0.2), stroke: thick, mark: (end: "stealth", fill: black))
  content((0, ux + 0.2), $y$, anchor: "south", padding: 2pt)

  // Dashed bounds
  line((lx, -0.6), (lx, ux + 0.1), stroke: (dash: "dashed"))
  line((ux, -0.6), (ux, ux + 0.1), stroke: (dash: "dashed"))
  line((lx, 0.2), (ux, ux + 0.01), stroke: (dash: "dashed"))
  line((lx, d * lx + 0.1), (ux, ux - d * ux - 0.1), stroke: (dash: "dashed"))

  // ReLU line
  line((lx, 0), (0, 0), (ux, ux), stroke: (paint: red, thickness: ultra-thick))

  // Labels
  content((lx - 0.1, 0), $l_x$, anchor: "north", padding: 2pt)
  content((ux + 0.12, -0.05), $u_x$, anchor: "north", padding: 2pt)
  content((lx / 2, -0.3), $l_y (x)$, anchor: "north", padding: 2pt)
  content((ux / 2, ux / 2 + 0.3), $u_y (x)$, anchor: "south", padding: 2pt)
  content((0, 0), $0$, anchor: "north-west", padding: 2pt)
})

// ============ \polytopeabstraction{scale} ============
#let polytope-abstraction(scale: 1.0) = canvas(length: scale * 1cm, {
  import draw: *
  let (lx, ux, d) = (-1.0, 1.0, 0.5)

  // Coordinates
  let A = (lx, 0)
  let B = (lx, 0.01)
  let E = (ux, ux + 0.01)
  let F = (ux, 0)

  // Fill region (closed polygon)
  line(A, B, E, F, close: true, fill: yellow.lighten(50%), stroke: none)

  // Axes
  line((lx - 0.2, 0), (ux + 0.3, 0), stroke: thick, mark: (end: "stealth", fill: black))
  content((ux + 0.3, 0), $x$, anchor: "west", padding: 2pt)
  line((0, -0.4), (0, ux + 0.2), stroke: thick, mark: (end: "stealth", fill: black))
  content((0, ux + 0.2), $y$, anchor: "south", padding: 2pt)

  // Dashed bounds
  line((lx, -0.3), (lx, ux + 0.1), stroke: (dash: "dashed"))
  line((ux, -0.3), (ux, ux + 0.1), stroke: (dash: "dashed"))
  line((lx, 0), (ux, ux + 0.01), stroke: (dash: "dashed"))
  line((lx, 0), (ux, 0), stroke: (dash: "dashed"))

  // ReLU line
  line((lx, 0), (0, 0), (ux, ux), stroke: (paint: red, thickness: ultra-thick))

  // Labels
  content((lx - 0.1, 0), $l_x$, anchor: "north", padding: 2pt)
  content((ux + 0.12, -0.05), $u_x$, anchor: "north", padding: 2pt)
  content((lx / 2, -0.01), $l_y (x)$, anchor: "north", padding: 2pt)
  content((ux / 2, ux / 2 + 0.3), $u_y (x)$, anchor: "south", padding: 2pt)
  content((0, 0), $0$, anchor: "north-west", padding: 2pt)
})

// ============ Usage example ============
#figure(
  grid(
    columns: 3,
    //gutter: 1.5cm,
    row-gutter:0.7em,
    column-gutter:2.5em,
    align:center,
    interval-abstraction(scale: 1.5),
    zonotope-abstraction(scale: 1.5),
    polytope-abstraction(scale: 1.5),
    [(a) Interval], [(b) Zonotope], [(c) Polytope]
  ),
  caption: [Abstractions of $relu(x) = max(0,x)$ over $x in [l_x, u_x]$ using (a) interval, (b) zonotope, (c) polytope abstractions.]
) <fig:relu-all-abstractions>

#paragraph[Abstractions for ReLU][
We use ReLU to illustrate different abstractions.
Our goal is to approximate the bounds of the post-ReLU value of a neuron given the bounds of its pre-ReLU value. For example, for a ReLU neuron $y = max(0, x)$, we want to compute the bounds $[l_y(x), u_y(x)]$ of $y$ given the bounds $[l_x, u_x]$ of $x$.
]



@fig:relu-all-abstractions illustrates common abstractions (or _over-approximations_) for the ReLU function $y = max(0, x)$, where $x in [l_x, u_x]$ and $y in [l_y(x), u_y(x)]$. The values of ReLU are shown as points on the #highlight(fill:red.lighten(50%))[red line], which is non-convex and consists of two linear segments: one for $x < 0$ (where $y = 0$) and another for $x >= 0$ (where $y = x$).
To compute the bounds $l_y(x)$ and $u_y(x)$, we can use different abstractions:

+ *Interval Abstraction*: Interval represents the post-ReLU value as an interval $[l_y(x), u_y(x)]$ where $l_y(x) = 0$ and $u_y(x) = u_x$. Interval is a simple and efficient abstraction, but it can be _imprecise_, e.g., it does not capture the relationship between the input and output of ReLU. %, and simply assumes that the output can take any value between 0 and the upper bound of the input. 
  
  In @fig:relu-all-abstractions(a), the #highlight[yellow rectangle] (box) represents the interval abstraction in the 2D space of $(x, y)$. As can be seen, this box is too large of an over-approximation (too coarse or loose), as it includes many points that are not achievable by ReLU, e.g., the point $(0.5, 0.0)$ is not on the red line.

+ *Zonotope Abstraction*: Zonotopes, commonly represented using center and generators, can capture linear relationships between variables more effectively. 

  In @fig:relu-all-abstractions(b), the #highlight[a parallelogram]---a zonotope in 2D---is arguably tighter than the interval in @fig:relu-all-abstractions(a).  It captures the linear relationship between $x$ and $y$ and excludes points that are not achievable by ReLU, e.g., the point $(0.5, 0.0)$ that was included in the interval abstraction is not included in the zonotope. However, it still includes non-ReLU points and is also not strictly better than interval, e.g., the point $(0.5, -0.5)$ is included in the zonotope but not in the interval abstraction (or ReLU).

+ *Polytope Abstraction*: Polytopes can represent arbitrary linear constraints and provide very precise bounds. We can construct a polytope that tightly encloses the non-convex shape of the ReLU function. 

  In @fig:relu-all-abstractions(c), the polytope is shown as a #highlight[trapezoid] that captures the linear segments of ReLU. The lower bound is $l_y(x) = 0$ and the upper bound is $u_y(x) = u_x$. 
//%\tvn{this is similar to the interval abstraction, as both have the same bounds, right?}\hd{you mean the same lower bound equation? Yes. Upper bound equation is different. However given a single neuron abstraction like in those figures, the concrete bounds (not the equations) are the same.}

// \end{itemize}


// % \tvn{Hai, create concrete examples with numbers to show how the abstractions work, e.g., for interval, zonotope, polytope, etc. We want to use one example to show the differences in the approximation,  not multiple examples which would be less effective.}

== Geometric Representations <sec:geometric-representations>

Our abstract domains, e.g., interval, zonotope, and polytopes, are all geometric shapes. There are two common ways to describe a geometric shape:


- *Corner-based representation*: Define the shape by listing all of its corner points (_vertices_). For example, a rectangle in 2D is defined by its four corners, and a box in 3D is defined by its eight corners. This representation is intuitive and directly shows the boundaries of the shape.

- *Generator-based representation*: Define the shape using a _center point_ and several direction vectors (_generators_) that define how the shape can stretch or tilt. Instead of listing all corners, it specifies how to reach any point in the shape by starting from the center and moving along the generators within certain limits.  This representation is often more compact, especially for higher-dimensional shapes.

@fig:interval-rectangle-two-views uses corner-based and generator-based representations to represent a 2D rectangle, which is an interval abstraction over two variables.  The left side shows the corner-based view, where the rectangle is defined by its 4 corners.  The right side shows the generator-based view, where the rectangle is represented as a zonotope with a center point $c$ and two orthogonal generators $g_1$ and $g_2$.


#figure(
  canvas(length: 1.1cm, {
    import draw: *

    let sx = -3.8

    // rectangle
    rect((sx + 0, 0), (sx + 2, 1.4), fill: yellow.lighten(80%), stroke: none)
    rect((sx + 0, 0), (sx + 2, 1.4), stroke: (thickness: 0.8pt))

    // corner points
    for (x, y) in ((0, 0), (2, 0), (0, 1.4), (2, 1.4)) {
      circle((sx + x, y), radius: 0.04, fill: blue, stroke: none)
    }

    // labels
    content((sx + 1.0, 1.8), text(size: 0.8em)[Corner-based view])
    content((sx + 1.0, -0.4), text(size: 0.8em)[Defined by vertices])

    let rx = 3.8

    // rectangle (same shape)
    rect((rx + 0, 0), (rx + 2, 1.4), fill: yellow, stroke: none)
    rect((rx + 0, 0), (rx + 2, 1.4), stroke: (thickness: 0.8pt))

    // center
    let c = (rx + 1.0, 0.7)
    circle(c, radius: 0.04, fill: black, stroke: black)
    content((rx + 1.0, 0.7), $c$, anchor: "north-east", padding: 3pt)

    // generator arrows
    line(c, (rx + 2.0, 0.7), stroke: (paint: blue, thickness: 0.8pt), mark: (end: "stealth", fill: black))
    content((rx + 2.0, 0.7), $g_1$, anchor: "west", padding: 2pt)
    line(c, (rx + 1.0, 1.4), stroke: (paint: blue, thickness: 0.8pt), mark: (end: "stealth", fill: black))
    content((rx + 1.0, 1.4), $g_2$, anchor: "south", padding: 2pt)

    // labels
    content((rx + 1.0, 1.8), text(size: 0.8em)[Generator-based view])
    content((rx + 1.0, -0.4), text(size: 0.8em)[Built from $c + epsilon_1 g_1 + epsilon_2 g_2$])

    // center arrow
    content((0, 0.7), text(size: 1em)[$arrow.l.r.long.double$])
  }),
  caption: [Two equivalent descriptions of a 2D interval abstraction (a rectangle). Left: defined by its four corners (independent variable bounds). Right: represented as a zonotope with center $c$ and orthogonal generators $g_1$, $g_2$.],
) <fig:interval-rectangle-two-views>
#import "@preview/cetz:0.3.4"

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // number line
    line((-3.0, 0.0), (3.5, 0.0), mark: (end: ">"), stroke: 1pt)
    content((3.5, 0.0), [$x$], anchor: "west")

    // interval region
    rect((-2.0, 0.0), (3.0, 0.25), fill: orange.lighten(80%), stroke: none)
    line((-2.0, 0.0), (3.0, 0.0), stroke: orange.darken(30%) + 1pt)

    // center point
    circle((0.5, 0.12), radius: 0.04, fill: blue.darken(30%), stroke: none)
    content((0.5, 0.12), [$c = 0.5$], anchor: "south", padding: 0.1)

    // labels
    line((-2.0, 0.0), (-2.0, 0.5), stroke: (dash: "dashed"))
    content((-2.0, 0.5), [$-2$], anchor: "south")

    line((3.0, 0.0), (3.0, 0.5), stroke: (dash: "dashed"))
    content((3.0, 0.5), [$3$], anchor: "south")

    content((0.5, -0.4), [$x = c + epsilon g$])

    // epsilon arrows
    line((-2.0, 0.25), (3.0, 0.25), mark: (start: ">", end: ">"), stroke: orange.darken(20%) + 1pt)
    content((0.5, 0.7), [$epsilon in [-1, 1]$ moves along $g = 2.5$], fill: orange.darken(30%))
  }),
  caption: [An interval $[-2, 3]$ is a 1D zonotope with center $c = 0.5$, generator $g = 2.5$, and parameter $epsilon in [-1, 1]$. Varying $epsilon$ covers the entire interval.]
) <fig:interval-zonotope>
// \begin{figure}
// \centering
// \begin{tikzpicture}[scale=1.1,>=stealth]

// % == LEFT: corner-based rectangle ===
// \begin{scope}[shift={(-3.8,0)}]
//   % rectangle
//   \fill[blue!10] (0,0) rectangle (2,1.4);
//   \draw[blue!70!black, thick] (0,0) rectangle (2,1.4);

//   % corner points
//   \foreach \x/\y in {0/0,2/0,0/1.4,2/1.4}{
//     \fill[blue!70!black] (\x,\y) circle (1.5pt);
//   }

//   % labels
//   \node[blue!70!black] at (1.0,1.8) {\small Corner-based view};
//   \node at (1.0,-0.4) {\small Defined by vertices};
// \end{scope}


// % == RIGHT: Generator-based rectangle (interval abstraction) ===
// \begin{scope}[shift={(3.8,0)}]
//   % rectangle (same shape)
//   \fill[orange!15] (0,0) rectangle (2,1.4);
//   \draw[orange!80!black, thick] (0,0) rectangle (2,1.4);

//   % center
//   \coordinate (c) at (1.0,0.7);
//   \filldraw[blue!80!black] (c) circle (1.5pt) node[below left] {\small $c$};

//   % generator arrows
//   \draw[->,blue!70!black,thick] (c) -- ++(1.0,0) node[right] {\small $g_1$};
//   \draw[->,blue!70!black,thick] (c) -- ++(0,0.7) node[above] {\small $g_2$};

//   % labels
//   \node[orange!80!black] at (1.0,1.8) {\small Generator-based view};
//   \node at (1.0,-0.4) {\small Built from $c+\epsilon_1g_1+\epsilon_2g_2$};
// \end{scope}

// % center arrow
// \node at (0,0.7) {\Large $\Longleftrightarrow$};

// \end{tikzpicture}
// \caption{Two equivalent descriptions of a 2D interval abstraction (a rectangle).
// Left: defined by its four corners (independent variable bounds).
// Right: represented as a zonotope with center $c$ and orthogonal generators $g_1$, $g_2$.}
// \label{fig:interval-rectangle-two-views}
// \end{figure}



#example[Interval as Zonotope][
An interval for a single variable is a line segment defined by its two endpoints. Equivalently, it can be represented as a zonotope with a center point and a single generator:
$
[l, u] = { c + epsilon g mid epsilon in [-1, 1] }
$
where $c = (l + u)/2$ is the center, $g = (u - l)/2$ is the generator, and $epsilon$ controls how far we move along the generator.
] <ex:interval-zonotope>

#example[Interval $[-2, 3]$ as Zonotope][
Consider the interval $x in [-2, 3]$, shown in @fig:interval-zonotope. We compute:
$
c = (-2 + 3)/2 = 0.5, quad g = (3 - (-2))/2 = 2.5, quad epsilon in [-1, 1].
$
Thus, any point $x$ in this interval can be written as $x = 0.5 + epsilon dot 2.5$, where $epsilon in [-1, 1]$. For example:
$
epsilon = -1 => x = -2, quad epsilon = 0 => x = 0.5, quad epsilon = +1 => x = 3.
$
As $epsilon$ varies between $-1$ and $+1$, we cover the entire interval $[-2, 3]$.
]

// \begin{example}

//     Consider the interval:
//     \[
//     x in [-2, 3].
//     \]
//     We can express this interval using a single generator as shown in~@fig:interval-zonotope.



//     \begin{figure}
//     \centering
//     \begin{tikzpicture}[scale=1.2,>=stealth]

//     % number line
//     \draw[->, thick] (-3.0,0) -- (3.5,0) node[right] {$x$};

//     % interval region
//     \fill[orange!20] (-2,0) rectangle (3,0.25);
//     \draw[orange!70!black, thick] (-2,0) -- (3,0);

//     % center point
//     \filldraw[blue!70!black] (0.5,0.12) circle (1.5pt) node[above] {$c=0.5$};

//     % labels
//     \draw[dashed] (-2,0) -- (-2,0.5) node[above, black] {$-2$};
//     \draw[dashed] (3,0) -- (3,0.5) node[above, black] {$3$};
//     \node at (0.5,-0.4) {\small $x = c + \epsilon g$};

//     % epsilon arrows
//     \draw[<->, orange!80!black, thick] (-2,0.25) -- (3,0.25);
//     \node[orange!70!black] at (0.5,0.7) {\small $\epsilon in [-1,1]$ moves along $g=2.5$};

//     \end{tikzpicture}
//     \caption{An interval $[-2,3]$ is a 1D zonotope with center $c=0.5$, generator $g=2.5$, and parameter $\epsilon in [-1,1]$. Varying $\epsilon$ covers the entire interval.}
//     \label{fig:interval-zonotope}
//     \end{figure}


//     \begin{equation}
//     \begin{aligned}
//     c = \frac{-2 + 3}{2} = 0.5, & quad\text{the midpoint of the interval}\\
//     quad g = \frac{3 - (-2)}{2} = 2.5, &  quad\text{the half-width (distance from the center to each end)}\\
//     \epsilon in [-1, 1], & quad\text{acts as a knob to move along the generator}
//     \end{aligned}
//     \end{equation}

//     Thus, any point \(x\) in this interval can be written as:
//     \[
//     x = c + \epsilon g \text{ or } x = 0.5 + \epsilon dot 2.5,
//     quad \text{where} quad \epsilon in [-1, 1].
//     \]


//     For example:
//     \[
//     \epsilon = -1 \Rightarrow x = -2,
//     quad
//     \epsilon = 0 \Rightarrow x = 0.5,
//     quad
//     \epsilon = +1 \Rightarrow x = 3.
//     \]

//     As \(\epsilon\) varies between \(-1\) and \(+1\), we cover the entire interval \([-2, 3]\).

// \end{example}



=== Transformer Functions <sec:transformer-functions>

The concept of computing abstractions is central to program analysis, e.g., through _abstract interpretation_ techniques. It allows us to reason about the behavior of a program without evaluating it on all concrete inputs---which may be infinite. Instead, we use an _abstract domain_, such as interval, to summarize sets of concrete values, enabling sound and scalable approximation.

==== Abstraction Functions

In abstract interpretation, we have the _abstraction function_
$
alpha : D -> D^a,
$
which maps a concrete value from the domain $D$ to an element in a finite or simpler abstract domain $D^a$.

#example[Odd/Even][
The `odd/even` or parity abstraction is defined as:
$
alpha_("parity")(x in ZZ) = cases(
  "even" & "if" x mod 2 = 0,
  "odd"  & "if" x mod 2 = 1
)
$
Even though $ZZ$ is infinite, this abstraction maps all integers to a finite set ${"odd", "even"}$.
]

==== Transformer Functions

Once we have values in the abstract domains, we often define an _abstract transformer function_
$
f^a : D^a -> D^a,
$
for each operation $f$ to reason about its behavior on abstract values.

#example[
Consider the function $f(x) = x + 1$. We define the abstract transformers $f^a$ for different abstract domains $D^a$:

- *Odd/Even abstraction*: $D^a = {"odd", "even"}$. Then:
  $ f^a ("odd") = "even", quad f^a ("even") = "odd" $

- *Sign abstraction*: $D^a = {"neg", "zero", "pos"}$. Then:
  $ f^a ("neg") = {"neg", "zero"}, quad f^a ("zero") = "pos", quad f^a ("pos") = "pos" $

- *Interval abstraction*: $D^a = {[a, b] mid a <= b in ZZ union {-infinity, +infinity}}$. Then:
  $ f^a ([a, b]) = [a+1, b+1] $

Notice that the input and output of the abstract transformer $f^a$ are both in the abstract domain $D^a$ (e.g., odd/even, sign, or interval).
]

== Abstract Domains <sec:abstract-domains>

We now introduce several abstract domains that are commonly used in NNV. Each domain has its own abstract transformer functions to compute the bounds of neurons.

Note that the input to the transformer functions (@sec:transformer-functions) are the abstract values and the output is also an abstract value. For example, for interval transformers, the input is an interval $[l, u]$ and the output is also an interval $[l', u']$. Similarly for zonotope transformers, the input is a zonotope defined by center and generators, and the output is also a zonotope.
== Interval <sec:interval-abstraction>

Interval is a very simple abstraction which represents the possible values of a variable as an interval $[l, u]$, where $l$ is the lower bound and $u$ is the upper bound.
For example, the set of values ${ -2.5, -8.2, -10.7, 2, 4.7, 5.1 }$ can be represented as $[-10.7, 5.1]$.

*Definition.*
The interval for one variable $v$ is defined as:
$ v in [l, u] = { v in RR | l <= v <= u } $

For $n$ variables, the interval becomes a box (like a rectangle in 2D, a cuboid in 3D, or a hyperrectangle in $n$D):
$ [v_1, v_2, dots, v_n] in [l_1, u_1] times [l_2, u_2] times dots times [l_n, u_n] $

=== Affine Transformer <sec:interval-affine-transformer>

For the linear or affine function $f$ in @sec:affine
$ f(v_1, v_2, ..., v_n) = sum_(i=1)^n w_i v_i + b $
where $w_i$ is the weight for the input $v_i$, $n$ is the number of output nodes from the previous layer and $b$ is the bias term, the abstract transformer $f^a$ is:
$
f^a ([l_1, u_1], ..., [l_n, u_n]) = [f^a_L, f^a_U] =
[b + sum_(i=1)^n min(w_i l_i, w_i u_i),; b + sum_(i=1)^n max(w_i l_i, w_i u_i)].
$

#example[Affine Transformer][
Consider the network in @fig:dnn with inputs $x_1 in [1, 2]$ and $x_2 in [-1, 3]$. The affine function for the neuron $x_3$ is:
$ f(x_1, x_2) = -0.5 x_1 + 0.5 x_2 + 1.0 $

Then the interval for $x_3$ can be computed as:
$
f^a ([1,2],[-1,3]) &= [ 1 + min(-0.5 dot 1, -0.5 dot 2) + min(0.5 dot (-1), 0.5 dot 3), \
& quad 1 + max(-0.5 dot 1, -0.5 dot 2) + max(0.5 dot (-1), 0.5 dot 3)] \
&= [1 - 1.0 - 0.5, 1 - 0.5 + 1.5] \
&= [-0.5, 2.0]
$
] <ex:transformer-affine1>

=== ReLU Transformer

For $relu(x) = max(0, x)$, the abstract transformer is defined as:
$ relu^a ([l, u]) = [relu(l), relu(u)] = [max(0, l), max(0, u)] $

This is equivalent to three cases shown in @fig:relu-interval-cases:
+ If $u < 0$, then $relu^a ([l, u]) = [0, 0]$. If inputs are negative, the output is also negative.
+ If $l >= 0$, then $relu^a ([l, u]) = [l, u]$. If inputs are positive, the output is exactly the same.
+ If $l < 0 < u$, then $relu^a ([l, u]) = [0, u]$. If inputs are mixed, the output is approximated to $[0, u]$.

#import "@preview/cetz:0.3.4"

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // helper to draw one ReLU panel, shifted by dx
    let panel(dx, input-rect, output-rect, input-label, output-label, output-label-pos) = {
      // axes
      line((dx - 1.5, 0.0), (dx + 2.0, 0.0), mark: (end: ">"), stroke: 1pt)
      content((dx + 2.0, 0.0), [$x$], anchor: "west")
      line((dx + 0.0, -0.3), (dx + 0.0, 1.5), mark: (end: ">"), stroke: 1pt)
      content((dx + 0.0, 1.5), [$y$], anchor: "south")

      // ReLU curve
      line(
        (dx - 1.5, 0.0), (dx + 0.0, 0.0), (dx + 1.8, 1.3),
        stroke: 1.2pt
      )

      // input interval (blue)
      let ((ix0, iy0), (ix1, iy1)) = input-rect
      rect((dx + ix0, iy0), (dx + ix1, iy1), fill: blue.lighten(85%), stroke: blue.darken(30%) + 1pt)
      content((dx + (ix0 + ix1) / 2, -0.3), text(size: 8pt, fill: blue.darken(30%))[input $[l,u]$])

      // output interval (orange)
      let ((ox0, oy0), (ox1, oy1)) = output-rect
      rect((dx + ox0, oy0), (dx + ox1, oy1), fill: orange.lighten(80%), stroke: orange.darken(30%) + 1pt)
      content((dx + (ox0 + ox1) / 2, output-label-pos), text(size: 8pt, fill: orange.darken(30%))[#output-label])
    }

    // --- (1) Inactive case: [l,u] below 0 ---
    panel(
      -4.0,
      ((-1.0, 0.0), (-0.3, 0.2)),
      ((1.0, 0.0), (1.7, 0.2)),
      "input",
      [output $[0,0]$],
      -0.3,
    )

    // --- (2) Active case: [l,u] above 0 ---
    panel(
      0.0,
      ((0.5, 0.0), (1.5, 0.2)),
      ((0.5, 0.5), (1.5, 0.7)),
      "input",
      [output $[l,u]$],
      0.9,
    )

    // --- (3) Unstable case: [l,u] crosses 0 ---
    panel(
      4.0,
      ((-0.8, 0.0), (0.8, 0.2)),
      ((0.0, 0.0), (0.8, 0.7)),
      "input",
      [output $[0,u]$],
      0.9,
    )
  }),
  caption: [
    ReLU transformer for intervals.
    Left: all inputs negative $=> [0,0]$.
    Middle: all inputs positive $=>$ unchanged.
    Right: interval crosses zero $=> [0,u]$.
    The ReLU function clamps negative parts to zero while preserving positive regions.
  ]
) <fig:relu-interval-cases>

#example[ReLU Interval][
For @ex:transformer-affine1, applying $relu^a$ to neuron $x_3$ gives:
$ relu^a ([-0.5, 2.0]) = [relu(-0.5), relu(2.0)] = [0, 2.0]. $
]

#problem[Interval Abstraction][
Apply interval abstraction to the network in @fig:dnn with inputs $x_1 in [1, 2]$ and $x_2 in [-1, 3]$. Compute the bounds for all neurons. Clearly indicate the steps (e.g., results after affine and ReLU transformers).
] <prob:int-abs>

=== Efficiency and Precision

Interval is very efficient and scales well to large networks. The affine transformer only requires a linear number of multiplications and min/max operations, and ReLU reduces to only three matching cases.
However, the cost of efficiency is _precision_.

#example[Interval Overapproximation][
Suppose we have $v_1 in [0, 1]$, $v_2 = -v_1$, and $z = v_1 + v_2$.
The concrete value of $z$ would always be 0, but interval abstraction gives $z in [-1, 1]$, which is a very loose over-approximation.
Moreover, if we apply ReLU, then the output would be $relu(z) = relu(0) = 0$, but the interval gives $relu^a ([-1, 1]) = [0, 1]$, which is again a loose over-approximation.
] <ex:interval-overapproximation>

Interval overapproximation grows quickly as we propagate through many layers of a large network, i.e., it keeps "inflating" the bounds, leading to a loose approximation of the output and becoming unable to verify valid properties. For example, $z <= 0$ is a valid property for @ex:interval-overapproximation, but the interval abstraction gives $z in [0, 1]$, which is not tight (precise) enough to show this property.

Nonetheless, interval domain remains popular due to its simplicity and efficiency. In some cases, despite being imprecise, it can still successfully verify properties of neural networks, e.g., for @ex:interval-overapproximation if we want to verify that $z <= 2$, then the interval $z in [0, 1]$ would suffice.

#problem[Correct Abstraction][
Suppose $y$ can take values from 0 to 3. Student A computes an interval abstraction $y in [-2, 4]$, while student B computes $y in [1, 2]$.
+ Which student's abstraction is correct? If both are correct, which is more precise? Explain your answer.
+ Using the correct abstraction (if both are correct, use the more precise one), can we use it to verify the property $y <= 3$? How about $y <= 5$? Explain your answers.
] <prob:correct-abs>


== Zonotope <sec:zonotope-abstraction>


Interval abstraction (@sec:interval-abstraction) treats each variable independently. For example, if $x_1 in [1, 2]$ and $x_2 in [3, 4]$, interval assumes any combination of $x_1$ and $x_2$ is possible. But variables can correlate: e.g., when $x_1$ increases, $x_2$ also increases. Zonotopes can capture such correlations and therefore provide a tighter abstraction.

*Definition.*

A zonotope is often represented using a generator-based representation as illustrated in @sec:geometric-representations.
It is built by starting from a center point and then stretching along several directions defined by generator vectors.
Each generator can move forward or backward within a certain range, and together these movements sweep out the entire shape.
Zonotope generalizes the idea of an interval, which itself is a zonotope (e.g., see @fig:interval-zonotope).

Formally, a *zonotope* $cal(Z)$ in $RR^n$ is defined as:
$ cal(Z) = { c + sum_(i=1)^n epsilon_i g_i | epsilon_i in [-1, 1] } $
where:
- $c in RR^n$ is the _center_ (analogous to the midpoint of an interval),
- $g_i in RR^n$ are _generator vectors_ (directions of variability), and
- $epsilon_i in [-1, 1]$ are independent coefficients that determine how much we move along each generator. For example, $epsilon_i = -1$ moves in the negative direction, $epsilon_i = 0$ stays at the center, and $epsilon_i = +1$ moves in the positive direction.

#import "@preview/cetz:0.3.4"

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // === Left: independent generators ===
    let dx1 = -3.8

    // filled rectangle
    line(
      (dx1 + 0.0, 0.0), (dx1 + 2.0, 0.0), (dx1 + 2.0, 1.5), (dx1 + 0.0, 1.5),
      close: true,
      fill: blue.lighten(90%),
      stroke: blue.darken(30%) + 1pt,
    )

    // center point
    circle((dx1 + 1.0, 0.75), radius: 0.04, fill: blue.darken(20%), stroke: none)

    // generators
    line((dx1 + 1.0, 0.75), (dx1 + 2.0, 0.75), mark: (end: ">"), stroke: blue.darken(20%) + 1pt)
    content((dx1 + 2.0, 0.75), text(size: 8pt, fill: blue.darken(20%))[$g_1 = (1,0)$], anchor: "west")

    line((dx1 + 1.0, 0.75), (dx1 + 1.0, 1.5), mark: (end: ">"), stroke: blue.darken(20%) + 1pt)
    content((dx1 + 1.0, 1.5), text(size: 8pt, fill: blue.darken(20%))[$g_2 = (0,1)$], anchor: "south")

    // caption label
    content((dx1 + 1.0, -0.5), text(size: 9pt)[Independent $=>$ Rectangle])

    // === Right: correlated generators ===
    let dx2 = 3.8

    // filled parallelogram
    line(
      (dx2 + 0.0, 0.0), (dx2 + 2.0, 0.5), (dx2 + 1.0, 2.0), (dx2 - 1.0, 1.5),
      close: true,
      fill: orange.lighten(85%),
      stroke: orange.darken(20%) + 1pt,
    )

    // center point
    circle((dx2 + 0.5, 1.0), radius: 0.04, fill: orange.darken(20%), stroke: none)

    // generators
    line((dx2 + 0.5, 1.0), (dx2 + 1.5, 1.25), mark: (end: ">"), stroke: orange.darken(20%) + 1pt)
    content((dx2 + 1.5, 1.25), text(size: 8pt, fill: orange.darken(20%))[$g_1 = (1, 0.25)$], anchor: "west")

    line((dx2 + 0.5, 1.0), (dx2 + 1.0, 2.0), mark: (end: ">"), stroke: orange.darken(20%) + 1pt)
    content((dx2 + 1.0, 2.0), text(size: 8pt, fill: orange.darken(20%))[$g_2 = (0.5, 1)$], anchor: "south-west")

    // caption label
    content((dx2 + 0.5, -0.5), text(size: 9pt)[Correlated $=>$ Parallelogram])
  }),
  caption: [
    Left: independent generators produce an axis-aligned rectangle (interval abstraction).
    Right: correlated generators tilt the shape into a parallelogram, capturing dependency between $x_1$ and $x_2$.
  ]
) <fig:zonotope-correlated-generators>

#example[Zonotope Parallelogram][
A common zonotope in 2D is a parallelogram. It can be defined by its center point and two generator vectors that define its sides. For instance, the parallelogram on the right side of @fig:zonotope-correlated-generators has the center $c = (1, 1)$ and the generators $g_1 = (1, 0.25)$ and $g_2 = (0.5, 1)$. This zonotope represents all points that can be reached by moving along these generators within the range $[-1, 1]$:
$ cal(Z) = { (1, 1) + epsilon_1 (1, 0.25) + epsilon_2 (0.5, 1) | epsilon_1, epsilon_2 in [-1, 1] } $
This zonotope includes points like:
$ (1, 1) + (-1)(1, 0.25) + (1)(0.5, 1) = (-1, 2.5) $
$ (1, 1) + (1)(1, 0.25) + (-1)(0.5, 1) = (3, -0.5) $
]

#example[Correlated vs Independent Generators][
In @fig:zonotope-correlated-generators the parallelogram zonotope on the right captures points with correlated $x_1$ and $x_2$ values, e.g., increasing $x_1$ by moving along $g_1$ also increases $x_2$ due to the non-zero second component of $g_1$.
In contrast, the rectangle zonotope on the left, which represents an interval abstraction, has independent generators, i.e., changing $x_1$ does not affect $x_2$, and therefore cannot capture the correlation.
]

=== Computing Bounds of a Zonotope <sec:zonotope-bounds>

In NNV, we often need to compute the bounds of each variable represented by a zonotope. This allows us to determine stable neurons, which in turn helps optimize the verification process.

For each coordinate (dimension) of the zonotope, we compute its lower and upper bounds as follows:
$
l_j = min_(epsilon_i in [-1,1]) (c_j + sum_(i=1)^n epsilon_i g_(i,j)), quad
u_j = max_(epsilon_i in [-1,1]) (c_j + sum_(i=1)^n epsilon_i g_(i,j)),
$
where $c_j$ is the $j$-th component of the center and $g_(i,j)$ is the $j$-th component of the $i$-th generator.

*A simpler way.*
Since each $epsilon_i in [-1, 1]$, each term $epsilon_i g_(i,j)$ can vary between $-|g_(i,j)|$ and $+|g_(i,j)|$.
Hence:
$ l_j = c_j - sum_(i=1)^n |g_(i,j)|, quad u_j = c_j + sum_(i=1)^n |g_(i,j)|. $

*Example (1D).* Given the interval zonotope:
$ x = 3 + epsilon_1 (2), quad epsilon_1 in [-1, 1], $
the bounds are computed as:
$ [l, u] = [3 - |2|, 3 + |2|] = [1, 5]. $

*Example (2D).*
$ cal(Z) = { vec(1, 2) + epsilon_1 vec(0.5, 1.0) + epsilon_2 vec(-0.3, 0.2), quad epsilon_1, epsilon_2 in [-1, 1] }. $
Then for each coordinate:
$
l_1 &= 1 - (|0.5| + |-0.3|) = 0.2, quad & u_1 &= 1 + (|0.5| + |-0.3|) = 1.2, \
l_2 &= 2 - (|1.0| + |0.2|) = 0.8, quad & u_2 &= 2 + (|1.0| + |0.2|) = 3.2.
$



// % \begin{figure}
// % \centering
// % \begin{tikzpicture}[scale=1.1,>=stealth]

// % % == LEFT: Vertex-based ===
// % \begin{scope}[shift={(-3.8,0)}]
// %   % Parallelogram (same shape as right)
// %   \fill[blue!10] (0,0) -- (2,0.4) -- (2.4,1.6) -- (0.4,1.2) -- cycle;
// %   \draw[blue!70!black, thick] (0,0) -- (2,0.4) -- (2.4,1.6) -- (0.4,1.2) -- cycle;

// %   % Corner dots
// %   \foreach \x/\y in {0/0, 2/0.4, 2.4/1.6, 0.4/1.2} {
// %     \fill[blue!70!black] (\x,\y) circle (1.5pt);
// %   }

// %   % Labels
// %   \node[blue!70!black] at (1.2,2.0) {\small Corner-based view};
// %   \node at (1.2,-0.4) {\small Defined by vertices};
// % \end{scope}

// % % == RIGHT: Generator-based ===
// % \begin{scope}[shift={(3.8,0)}]
// %   % Parallelogram (same shape)
// %   \fill[orange!15] (0,0) -- (2,0.4) -- (2.4,1.6) -- (0.4,1.2) -- cycle;
// %   \draw[orange!80!black, thick] (0,0) -- (2,0.4) -- (2.4,1.6) -- (0.4,1.2) -- cycle;

// %   % Center
// %   \coordinate (c) at (1.2,0.8);
// %   \filldraw[blue!80!black] (c) circle (1.5pt) node[below left] {\small $c$};

// %   % Generators
// %   \draw[->,blue!70!black,thick] (c) -- ++(1.0,0.2) node[right] {\small $g_1$};
// %   \draw[->,blue!70!black,thick] (c) -- ++(0.2,0.6) node[above right] {\small $g_2$};

// %   % Labels
// %   \node[orange!80!black] at (1.4,2.0) {\small Generator-based view};
// %   \node at (1.2,-0.4) {\small Built from $c+\epsilon_1g_1+\epsilon_2g_2$};
// % \end{scope}

// % % Connecting text
// % \node at (1.5,0.8) {\Large $\Longleftrightarrow$};

// % \end{tikzpicture}
// % \caption{Two equivalent descriptions of a 2D zonotope (a parallelogram).}
// % \label{fig:zonotope-two-views}
// % \end{figure}


// % \paragraph{Zonotope vs Box (Interval)}

// % @fig:zonotope-vs-box illustrates the difference between zonotopes and boxes (intervals) in 2D.
// % The blue box represents an interval abstraction, which is axis-aligned and cannot capture correlations between variables.
// % The orange parallelogram represents a zonotope, which can tilt and better fit the shape of correlated variables.

// % \begin{figure}
// % \centering
// % \begin{tikzpicture}[scale=1.3,>=stealth]

// % % Axes
// % \draw[->, thick] (-0.5,0) -- (3.5,0) node[right] {$x_1$};
// % \draw[->, thick] (0,-0.5) -- (3.5,3.5) node[above] {$x_2$};

// % % Interval box
// % \fill[blue!10] (0.5,0.5) rectangle (2.5,2.5);
// % \draw[blue, thick] (0.5,0.5) rectangle (2.5,2.5);
// % \node[blue!60!black] at (1.5,2.7) {\small Interval (Box)};

// % % Zonotope parallelogram
// % \fill[orange!15, rotate around={20:(2,1)}] (1,0.5) rectangle (3,2.5);
// % \draw[orange, thick, rotate around={20:(2,1)}] (1,0.5) rectangle (3,2.5);
// % \node[orange!70!black] at (3.3,2.1) {\small Zonotope (Tilted Box)};

// % % Legend arrows
// % \draw[blue,->] (2.6,2.0) to[bend left] (3.3,2.0);
// % \draw[orange,->] (1.8,0.8) to[bend right] (0.6,0.8);

// % \end{tikzpicture}
// % \caption{Intervals produce axis-aligned boxes (blue), while zonotopes can tilt to fit correlated variables (orange).}
// % \label{fig:zonotope-vs-box}
// % \end{figure}

==== Affine Transformer

Recall that the affine function $f$ in @sec:affine is
$ f(v_1, v_2, dots, v_n) = sum_(i=1)^n w_i v_i + b, $
where $w_i$ is the weight associated with input $v_i$, $n$ is the number of inputs, and $b$ is the bias term.

More formally, given a zonotope
$ cal(Z) = { c + sum_(j=1)^m epsilon_j g_j | epsilon_j in [-1, 1] }, $

the abstract transformer $f^a$ for the affine function $f$ is:
$
f^a (v_1, v_2, dots, v_n) &= sum_(i=1)^n w_i v_i + b \
&= sum_(i=1)^n w_i underbrace((c_i + sum_(j=1)^m epsilon_j g_(i j)), v_i) + b \
&= sum_(i=1)^n w_i c_i + sum_(i=1)^n w_i sum_(j=1)^m epsilon_j g_(i j) + b \
&= underbrace((sum_(i=1)^n w_i c_i + b), "new center") + sum_(j=1)^m epsilon_j underbrace((sum_(i=1)^n w_i g_(i j)), "new generators")
$

That is, the new zonotope has:
- *center:* $f^c (c) = sum_(i=1)^n w_i c_i + b$
- *generators:* each generator $g_j$ becomes $f^g (g_j) = sum_(i=1)^n w_i g_(i j)$

Applying an affine transformation to a zonotope transforms its center by the same affine rule (weights and bias) and transforms each generator by the linear part (weights only).
In other words, affine operations _preserve_ the structure of zonotopes exactly: no approximation needed.

$ f^a (cal(Z)) = { f^c (c) + sum_(j=1)^m epsilon_j f^g (g_j) | epsilon_j in [-1, 1] } $

#example[Zonotope Affine Transformer][
Consider the network in @fig:dnn with inputs $x_1 in [1, 2]$ and $x_2 in [-1, 3]$.
The affine function for neuron $x_3$ is:
$ f(x_1, x_2) = -0.5 x_1 + 0.5 x_2 + 1.0 $
We want to compute the bounds for $x_3$ using zonotope abstraction.

*Represent the input as a zonotope.*
We represent the input intervals $x_1 in [1, 2]$ and $x_2 in [-1, 3]$ as a zonotope ${ c + sum_(i=1)^n epsilon_i g_i | epsilon_i in [-1, 1] }$.

The center $c_i$ represents the midpoint of each input interval:
$ c_1 = (1 + 2) / 2 = 1.5, quad c_2 = (-1 + 3) / 2 = 1.0, $
and the generator $g_i$ captures the half-width of each interval:
$ g_1 = (2 - 1) / 2 = 0.5, quad g_2 = (3 - (-1)) / 2 = 2.0 $

Thus, the input zonotope is
$ cal(Z) = { (1.5, 1.0) + epsilon_1 (0.5, 0) + epsilon_2 (0, 2.0), quad epsilon_1, epsilon_2 in [-1, 1] }. $

*Apply the affine transformation.* We apply $f(x_1, x_2) = -0.5 x_1 + 0.5 x_2 + 1.0$ to $cal(Z)$:
$
f^a (cal(Z))
  &= f^c (c_1, c_2) + epsilon_1 f^g (g_1) + epsilon_2 f^g (g_2) \
  &= (-0.5 c_1 + 0.5 c_2 + 1.0) + epsilon_1 (-0.5 g_(1 x) + 0.5 g_(1 y)) + epsilon_2 (-0.5 g_(2 x) + 0.5 g_(2 y)) \
  &= (-0.5(1.5) + 0.5(1.0) + 1.0) + epsilon_1 (-0.5(0.5) + 0.5(0)) + epsilon_2 (-0.5(0) + 0.5(2.0)) \
  &= 0.75 - 0.25 epsilon_1 + 1.0 epsilon_2.
$
Hence, the output zonotope for $x_3$ is
$ { 0.75 + epsilon_1 (-0.25) + epsilon_2 (1.0), quad epsilon_1, epsilon_2 in [-1, 1] }. $

*Compute output bounds.* From the output zonotope, the bounds for $x_3$ are:
$
f^a_L &= c' - (|g'_1| + |g'_2|) = 0.75 - (0.25 + 1.0) = -0.5, \
f^a_U &= c' + (|g'_1| + |g'_2|) = 0.75 + (0.25 + 1.0) = 2.0.
$
Thus, the output range of $x_3$ is $[-0.5, 2.0]$.

Note that the reason for computing the bounds from the zonotope representation is to determine _stable neurons_ as described in @sec:pre-relu-bounds. If the lower bound is non-negative, ReLU will be active; if the upper bound is non-positive, ReLU will be inactive. In these cases, ReLU can be simplified to either the identity function or zero, respectively, which helps reduce overapproximation in subsequent layers.

For this simple example, both interval (@sec:interval-affine-transformer) and zonotope abstractions yield identical bounds $[-0.5, 2.0]$.
The benefit of zonotopes becomes clear in deeper layers, where they preserve linear correlations that interval abstractions lose.
] <ex:zonotope_linear_example>

#problem[Zonotope Abstraction for $x_4$][
Compute the bounds for $x_4$ in @fig:dnn using zonotope abstraction, with inputs $x_1 in [1, 2]$ and $x_2 in [-1, 3]$, and the affine function for $x_4$ is:
$ f(x_1, x_2) = 0.5 x_1 - 0.5 x_2 - 1 $
] <prob:zonotope_linear_example_x4>


==== ReLU Transformer

Activation functions like ReLU are non-affine and do not preserve zonotope structure.
For $relu(x) = max(0, x)$, the shape of the input region changes at $x = 0$: $x < 0$ maps to $0$ (a flat line), while $x >= 0$ maps to $x$ (a slanted line). Thus, we over-approximate these shapes with a new zonotope --- a parallelogram --- that contains the entire ReLU output region.

We can distinguish three possible cases of ReLU depending on the bounds $[l, u]$ of the input zonotope:
- *Active case* ($l >= 0$): All values are non-negative, so $relu^a (x) = x$ (identity function), i.e., the output zonotope is the same as the input zonotope.
- *Inactive case* ($u <= 0$): All values are negative, so $relu^a (x) = { 0 }$, i.e., the output zonotope is a single point at zero.
- *Unstable case* ($l < 0 < u$): The range crosses zero, requiring over-approximation using a parallelogram that bounds ReLU over $[l, u]$ as described below.

*Building parallelogram.*
Given the input zonotope $x = { c + sum_(i=1)^n epsilon_i g_i | epsilon_i in [-1, 1] }$ with $x$ ranging over $[l, u]$ where $l < 0 < u$ (i.e., the unstable case), we construct a parallelogram that bounds ReLU over this interval using two linear constraints representing its upper and lower edges:
- *Upper bound constraint:* $y <= lambda x - lambda l$, where $lambda = u / (u - l)$ is the slope of the line connecting points $(l, 0)$ and $(u, u)$.
- *Lower bound constraint:* $y >= lambda x$ is the line with the same slope $lambda$ passing through $(0, 0)$.

Merging these two constraints, we get the following equation describing all points $(x, y)$ within the parallelogram:
$
lambda x <= quad &y quad <= lambda x - lambda l \
arrow.l.r.double quad &y = lambda x - alpha lambda l, quad alpha in [0, 1]
$
The parameter $alpha$ interpolates between the lower and upper bounds of the parallelogram.
When $alpha = 0$, we are on the lower bound $y = lambda x$; when $alpha = 1$, we are on the upper bound $y = lambda x - lambda l$.

Our zonotope requires $epsilon_i in [-1, 1]$, thus we substitute:
$ alpha = (1 + epsilon_"new") / 2, quad epsilon_"new" in [-1, 1] $

For example, when $epsilon_"new" = -1$, we have $alpha = 0$ (lower bound); when $epsilon_"new" = 1$, we have $alpha = 1$ (upper bound).

The output zonotope after ReLU transformation is then:
$
y &= lambda x - alpha lambda l \
&= lambda x - (1 + epsilon_"new") / 2 dot lambda l \
&= lambda underbrace((c + sum_(i=1)^m epsilon_i g_i), x) - epsilon_"new" (lambda l) / 2 - (lambda l) / 2 \
&= underbrace((lambda c - (lambda l) / 2), "new center") + underbrace(sum_(i=1)^m epsilon_i (lambda g_i) - epsilon_"new" (lambda l) / 2, "new generators")
$

#example[ReLU on Zonotope][
Continuing from @ex:zonotope_linear_example, applying ReLU to the zonotope output of $x_3$:
$ x_3 = 0.75 + epsilon_1 (-0.25) + epsilon_2 (1.0), quad epsilon_1, epsilon_2 in [-1, 1]. $

*Determine the bounds.* As shown in @ex:zonotope_linear_example, the output zonotope (before ReLU) has bounds $[-0.5, 2.0]$. Since $l = -0.5 < 0 < 2.0 = u$, this is an unstable neuron requiring over-approximation.

*Approximate slope.* We compute the slope of the upper bound line of the parallelogram (connecting points $(-0.5, 0)$ and $(2.0, 2.0)$):
$ lambda = (u - 0) / (u - l) = 2.0 / (2.0 - (-0.5)) = 2.0 / 2.5 = 0.8. $

*Transform zonotope.* The new center becomes:
$ c' = lambda c - (lambda l) / 2 = 0.8 dot 0.75 - (0.8 dot (-0.5)) / 2 = 0.6 + 0.2 = 0.8 $

Existing generators are scaled by $lambda$:
$
g'_1 &= lambda g_1 = 0.8 dot (-0.25) = -0.2, \
g'_2 &= lambda g_2 = 0.8 dot 1.0 = 0.8
$

*New generator for approximation error.* A new generator is introduced to capture the ReLU approximation error:
$ g'_3 = -(lambda l) / 2 = -(0.8 dot (-0.5)) / 2 = 0.2 $

*Result:* The output zonotope is
$ 0.8 + epsilon_1 (-0.2) + epsilon_2 (0.8) + epsilon_3 (0.2), quad epsilon_i in [-1, 1], $
with concrete bounds:
$
l' &= 0.8 - 0.2 - 0.8 - 0.2 = -0.4 -> 0 quad ("clamp negative values") \
u' &= 0.8 + 0.2 + 0.8 + 0.2 = 2.0
$
Thus, the final bounds after ReLU are $[0, 2.0]$.
] <ex:zonotope_relu_example>



// % \subsection{Polytope}
// % \tvn{not yet done, skip}
// % In the previous section, we have seen the abstract domain of zonotopes, which is more expressive than the interval domain. Specifically, instead of approximating functions using a hyper-rectangle, the zonotope domain allows us to approximate functions using a zonotope, e.g., a parallelogram, capturing relations between different dimensions. In this section, we look at an even more expressive abstract domain, the polyhedron (or polytope) domain.

// % Unlike the zonotope domain, the polyhedron domain allows us to approximate functions using arbitrary convex polyhedra. A polyhedron in \(\mathbb{R}^n\) is a region made of straight (as opposed to curved) faces; a convex shape is one where the line between any two points in the shape is completely contained in the shape. Convex polyhedra can be specified as a set of linear inequalities of the form:

// % \[
// % Ax <=q b
// % \]

// % where \(A in \mathbb{R}^{m \times n}\) and \(b in \mathbb{R}^m\) for some \(m\), specifying \(m\) half-spaces whose intersection forms the polyhedron.

// % Using a set of convex polyhedra, we can more precisely approximate activation functions like ReLU. For instance, to approximate ReLU, we can describe the tightest convex over-approximation by the following constraints:

// % \[
// % x <=q y, quad 0 <=q y, quad y <=q lambda x + \mu
// % \]

// % where \(lambda\) and \(\mu\) are parameters chosen based on the bounds of \(x\).

// % \begin{figure}[h]
// %     \centering
// %      in cludegraphics[width=0.5\linewidth]{figure/3-lines-polytope.png}
// %     \caption{The tightest Convex Polyhedral Approximation of ReLU.}
// %     \label{fig:enter-label}
// % \end{figure}
// % % \begin{figure}
// % %     \centering
// % %      in cludegraphics[width=0.5\linewidth]{3-lines-polytope.png}
// % %     \caption{Enter Caption}
// % %     \label{fig:enter-label}
// % % \end{figure}

// % This is the smallest convex polyhedron that soundly approximates ReLU, and is strictly more precise than the interval and zonotope abstractions, as can be seen visually.

// % \subsection{Affine Functions}

// % Affine transformations map convex polyhedra to convex polyhedra.
// % Given an affine transformation \(f(x) = Wx + b\), where \(W\) is a matrix and \(b\) is a bias vector, we can transform a polyhedron \( {x \mid A x <=q b }\) through \(f\) by substitution:

// % \[
// %  {x \mid A (W^{-1}(x - b)) <=q b }
// % \]

// % if \(W\) is invertible. More commonly in practice, when applying affine transformations in neural networks (layer-wise), we modify the constraints accordingly by propagating through the weights and biases.

// % Thus, affine layers can be handled exactly under polyhedral abstraction without any need for relaxation or over-approximation.

// % \subsection{Activation Functions}

// % Handling non-linear activation functions, such as ReLU, with polyhedral abstraction is challenging because non-linearities generally map polytopes to non-convex shapes. Therefore, over-approximations are required.

// % The key idea is to approximate the graph of the non-linear function by a convex polyhedron that covers all possible cases. For ReLU, the previously mentioned three constraints:

// % \begin{equation <minimum_polyhedron}
// % x <=q y, quad 0 <=q y, quad y <=q lambda x + \mu
// % \end{equation}


// % construct a tight convex relaxation.

// % For other activations like sigmoid or tanh, the approximation involves linearizing the curve between the lower and upper bounds of the input variable, but the number of constraints can quickly grow, increasing computational complexity.

// % \paragraph{DeepPoly.}
// % By containing two lower polyhedra constraints for \(y\), the approximation in \ref{minimum_polyhedron} inherently suffers from a potential blow-UB in number of constraints as the analysis proceeds. Due to scalability issues associated with general polyhedral representations, DeepPoly \cite{singh2019abstract} was proposed as a precise and scalable abstract domain. DeepPoly introduces a specialized form of polyhedral abstraction combined with interval bounds.

// % More specifically,  DeepPoly only allows for one lower bound in \ref{minimum_polyhedron}, the selection of which lower constraint depends on which constraint provides the tighter approximation.

// % Returning to our example, the area of the approximation in Fig.~4(b) is given by \( 0.5 dot u dot (u - l) \), while the area in Fig.~4(c) is given by \( 0.5 dot (-l_i) dot (u_i - l_i) \). To achieve a tighter relaxation, we select the approximation with the smaller area. Specifically, when \( u <=q -l \), we apply the constraints and bounds derived from \(x <=q y\).
// % In addition, each neuron \(x_j\) is bounded above and below by affine expressions of the input neurons:

// % \[
// % l_j(x) <=q x_j <=q u_j(x)
// % \]

// % where \(l_j\) and \(u_j\) are affine functions.

// % \subsection{DeepPoly Transformers}

// % The DeepPoly abstract domain defines a scalable and precise framework for verifying deep neural networks by combining interval and polyhedral abstractions. Each neuron is bounded from above and below using affine expressions of the input neurons:

// % \[
// % l_j(x) <=q x_j <=q u_j(x)
// % \]

// % where \(l_j(x)\) and \(u_j(x)\) are affine functions representing lower and upper bounds respectively. DeepPoly then defines **abstract transformers** to propagate these bounds through different types of neural network layers.

// % \subsubsection{Affine Layer Transformer}

// % Given an affine transformation:
// % \[
// % x^{(l+1)} = W x^{(l)} + b
// % \]

// % we define the transformation of the bounds by propagating the affine expressions directly:
// % \begin{align*}
// % l_j^{(l+1)}(x) &= \sum_i w_{ji}^+ dot l_i^{(l)}(x) + w_{ji}^- dot u_i^{(l)}(x) + b_j \\
// % u_j^{(l+1)}(x) &= \sum_i w_{ji}^+ dot u_i^{(l)}(x) + w_{ji}^- dot l_i^{(l)}(x) + b_j
// % \end{align*}

// % Here, \(w^+_{ji} = \max(w_{ji}, 0)\), and \(w^-_{ji} = \min(w_{ji}, 0)\), ensuring correct handling of sign-dependent propagation.

// % \subsubsection{ReLU Transformer}

// % The ReLU transformer in DeepPoly uses a convex relaxation that is tighter than previous abstractions by selecting only one lower bound constraint depending on the sign and tightness. Suppose \(x_j = \text{ReLU}(x_i)\). Let \([l_i, u_i]\) be the lower and upper bounds for \(x_i\).

// % \begin{itemize}
// %     \item If \(l_i >= 0\): ReLU is linear, so
// %     \[
// %     l_j(x) = l_i(x), quad u_j(x) = u_i(x)
// %     \]

// %     \item If \(u_i <=q 0\): ReLU is constant 0, so
// %     \[
// %     l_j(x) = u_j(x) = 0
// %     \]

// %     \item If \(l_i < 0 < u_i\): ReLU is approximated with:
// %     \[
// %     u_j(x) = \frac{u_i}{u_i - l_i} dot (x_i - l_i)
// %     \]
// %     and only one lower bound is selected:
// %     \[
// %     l_j(x) =
// %     \begin{cases}
// %         0, & \text{if area under lower 0 line is smaller} \\
// %         x_i, & \text{if area under identity line is smaller}
// %     \end{cases}
// %     \]
// % \end{itemize}

// % The decision is made based on which convex region has smaller area to achieve a tighter abstraction, following the principle:
// % \[
// % \text{Choose constraint with smaller area:} quad 0.5 dot u_i dot (u_i - l_i) quad \text{vs} quad 0.5 dot (-l_i) dot (u_i - l_i)
// % \]


// % By maintaining only upper and lower affine bounds, DeepPoly avoids the full complexity of manipulating arbitrary polytopes while retaining significantly more precision than intervals or zonotopes.

// % ...

// % Thus, DeepPoly achieves a practical balance between precision and scalability for verifying deep neural networks.

// % \subsection{Example}

// % Consider again the DNN in~@fig:dnn. Suppose the input set is defined by box constraints \(x_1 in [-1,1]\) and \(x_2 in [-2,2]\). These can be represented initially by 4 inequalities.

// % Applying the affine transformation for the hidden layer, we obtain a new set of inequalities describing the hidden layer nodes. Upon applying ReLU, we would use the convex polyhedral relaxation as depicted in~@fig:3_lines_polytope. The output layer similarly results from affine operations on the polyhedra describing the hidden layer.

// % In a DeepPoly setting, instead of carrying full inequalities, we track only the lower and upper affine bounds per neuron, leading to an efficient verification process.

// % \subsection{Comparison to Zonotope Abstraction}

// % While zonotope abstraction captures dependencies between variables better than intervals, it still assumes symmetrical dependencies around a center point and cannot easily model arbitrary convex shapes.

// % Polyhedral abstraction, on the other hand, allows representing arbitrary convex shapes precisely, enabling much tighter approximations, especially after ReLU activations.

// % However, traditional polyhedral methods suffer from:
// % \begin{itemize}
// %     \item High computational complexity,
// %     \item Rapid growth in the number of constraints,
// %     \item Difficulty scaling to large networks.
// % \end{itemize}

// % DeepPoly addresses these challenges by:
// % \begin{itemize}
// %     \item Restricting to simple upper and lower affine bounds,
// %     \item Maintaining polynomial scalability,
// %     \item Achieving higher precision than zonotopes or intervals,
// %     \item Providing efficient transformers for common layers in DNNs.
// % \end{itemize}

// % Therefore, DeepPoly achieves a balance, combining the expressiveness of polyhedral domains with the efficiency required for deep network verification.


// %  == Abstractions for Other Activation Functions}

// %  == Problems}
// % \subsection{Interval Abstraction}

// % \begin{example}[Full Example of Interval Abstraction]\label{ex:interval-abstraction-full}
// % \begin{figure}[h]
// %     \centering
// %      in cludegraphics[width=1.2\linewidth]{figure/2_layers_example.png}
// %     \caption{Feed-forward neural network with 6 layers and 2 neurons per layer.}
// %     \label{fig:interval-network}
// % \end{figure}
// % In~@fig:interval-network, we aim to verify whether \(x_{11}\ >=\ x_{12}\) given a bounded input range on \(x_1\) and \(x_2\). To do this using interval abstraction, we propagate intervals layer by layer.

// % Suppose the inputs \(x_1\) and \(x_2\) satisfy:
// % \[
// % x_1 in [-1, 1], quad x_2 in [-1, 2]
// % \]

// % Let an affine neuron (e.g., \(x_3\)) compute:
// % \[
// % x_3 = 1 x_1 + 1 x_2 + 2
// % \]

// % Then we apply the affine abstract transformer:
// % \begin{equation}
// % \begin{aligned}
// %   x_3 in & ~[\min(1\times-1, 1\times1) + \min(1\times-1, 1\times3) + 2, \\
// %           & ~\max(1\times-1, 1\times-1) + \max(-1\times-1, -1\times3) + 2] = \\
// %           & [0,6]
// % \end{aligned}
// % \end{equation}

// % So we over-approximate \(x_3\) as:
// % \[
// % x_3 in [0, 6]
// % \]

// % This process is repeated for each layer until we reach the output layer.
// % Here we can see that by using Interval abstraction, the property \(x_{11}\ >=\ x_{12}\) or  \(x_{11}\ - x_{12} >= 0\) is \textit{UNSAT}\hd{seems incorrect} due to
// % \[
// % -2.5 - 0  <=q x_{11}\ -\ x_{12} <=q 12 - 5
// % \]
// % \end{example}


#pagebreak()
// \part{The Branch and Bound Approach <part:bab}
= The Branch and Bound Search Algorithm <chap:bab>

As shown in @chap:constraint-solving, NNV can be formulated as a satisfiability problem, solvable using a constraint solver,  e.g., SMT and MILP solvers.  However, such solvers do not scale to large networks due to the complexity of the underlying formulae. Thus, modern NNV techniques reframe the problem to search for _activation patterns_ that satisfy the constraints, and use the _Branch-and-Bound_ algorithm to explore the space of possible activation patterns.


== Activation Pattern Search <sec:activation-patterns>

Neural networks with piecewise linear activation functions have a special
structure that can be exploited for verification. For example, each ReLU
function has two _activation statuses_: active and inactive. Each status
partitions the input space into two regions---one where the neuron is active
and one where it is inactive. Within each region, the network behavior can be
encoded as _a linear constraint_, which can be efficiently analyzed.

Thus, the NNV problem reduces to checking that none of these linear regions
contains a counterexample. More specifically, we can rewrite the satisfiability
formulation as a disjunction:
$
  or.big_(p in P) (alpha_p and phi_"in" and not phi_"out")
$ <eq:nnv3>

where $P$ is the set of all possible _activation patterns_---boolean
assignments of activation statuses of all neurons---of the network, and
$alpha_p$ is the formula $alpha$ restricted to the linear region defined by the
activation pattern $p$. This means that $alpha_p$ includes additional
constraints that fix the activation status of each neuron according to $p$. For
example, if $p$ specifies that neuron $n_i$ is active, then $alpha_p$ includes
the constraint $z_i >= 0$, indicating that the pre-activation value $z_i$ of
$n_i$ is non-negative. Similarly, if $n_i$ is inactive, then $alpha_p$
includes $z_i < 0$.

As long as one of the disjuncts in @eq:nnv3 is satisfiable, i.e., a
counterexample exists in one of the linear regions, the entire formula is
satisfiable, indicating that the property is invalid. Conversely, if all
disjuncts are unsatisfiable, the property is valid because no counterexample
exists.

This allows us to break down the verification problem into smaller subproblems,
each searching for an activation pattern that satisfies the formula. Modern NNV
techniques all adopt this idea and search for a satisfying activation pattern
to find a counterexample.


=== Activation Patterns

#definition(title: "Activation Pattern")[
  Let $N$ be a neural network with ReLU neurons $n_1, dots, n_m$. An
  _activation pattern_ is a Boolean assignment of the activation status of a
  subset (or all) of the neurons. If a neuron $n_i$ is active, we set
  $b_i = #raw("true")$ (meaning $z_i >= 0$); if it is inactive,
  $b_i = #raw("false")$ (meaning $z_i < 0$).
] <def:activation-pattern>

#definition(title: "Complete Activation Pattern")[
  A _complete activation pattern_ assigns an activation status to *every*
  neuron in the network:
  $
    p = chevron.l b_1, b_2, dots, b_m chevron.r in {#raw("true"), #raw("false")}^m.
  $
] <def:complete-pattern>

#definition(title: "Partial Activation Pattern")[
  A _partial activation pattern_ assigns activation statuses to only a *subset*
  of the neurons:
  $
    q = chevron.l b_1, b_2, *, b_4, *, dots, b_m chevron.r
      in {#raw("true"), #raw("false"), *}^m,
  $
  where $*$ means "undetermined" or "don't care". Each partial activation
  pattern represents multiple complete activation patterns.
] <def:partial-pattern>

#example[
  Consider a network with three ReLU neurons $n_1, n_2, n_3$. A complete
  activation pattern might be
  $
    p = chevron.l #raw("true"), #raw("false"), #raw("true") chevron.r,
  $
  which means $n_1$ and $n_3$ are active while $n_2$ is inactive.

  In contrast, a partial activation pattern such as
  $
    q = chevron.l #raw("true"), #raw("false"), * chevron.r
  $
  represents *both* complete patterns
  $chevron.l #raw("true"), #raw("false"), #raw("true") chevron.r$ and
  $chevron.l #raw("true"), #raw("false"), #raw("false") chevron.r$.
]

#definition(title: "Empty Activation Pattern")[
  An _empty_ activation pattern is a partial pattern that assigns *no*
  activation statuses to any neurons:
  $
    p = chevron.l *, *, dots, * chevron.r in {#raw("true"), #raw("false"), *}^m.
  $
  It thus represents all $2^m$ complete activation patterns.
] <def:empty-pattern>

#problem[
  Consider an NN with 3 ReLU neurons:
  + How many complete activation patterns are there?
  + How many partial patterns of size 2 (i.e., fixing 2 neurons but leaving 1
    unspecified) are there?
  + Give an explicit example of one partial pattern and list all the complete
    patterns it represents.

#solution[
  
  + $2^3 = 8$ complete patterns.
  + Choose 2 neurons to fix: $binom(3,2) = 3$ ways. For each, $2^2 = 4$ assignments. Total $= 12$ partial patterns.
  + Example: $p' = {n_1 = sans("true"), n_3 = sans("false")}$ represents
  ${n_1 = sans("true"), n_2 = sans("true"), n_3 = sans("false")}$ and
  ${n_1 = sans("true"), n_2 = sans("false"), n_3 = sans("false")}$.
]    
] <problem:pattern-enumeration>



#problem[
  Suppose we have a network with $m = 10$ ReLU neurons. Consider a partial
  pattern $p'$ that fixes 4 neurons.
  + How many complete patterns extend $p'$?
  + Suppose we restrict $p'$ further by adding 2 more neuron assignments. How
    many extensions now?
  + Generalize: if $p'$ fixes $k$ neurons out of $m$, how many complete
    patterns are there?

#solution[
  + $2^(10-4) = 2^6 = 64$.

  + $2^(10-6) = 2^4 = 16$.

  + General: $2^(m-k)$.
]    
] <problem:counting-patterns>



=== Set Notation of Activation Patterns <sec:pattern-notation>

We can use _set notation_ to represent activation patterns more concisely by
listing only the neurons whose activation statuses are fixed. For example, the
activation pattern
$
  p = chevron.l #raw("true"), #raw("false"), *, #raw("true"), #raw("false") chevron.r
$
can be represented as
$
  p = {n_1 = #raw("true"), n_2 = #raw("false"), n_3 = *, n_4 = #raw("true"), n_5 = #raw("false")},
$
or more compactly
$
  p = {n_1, overline(n_2), n_4, overline(n_5)},
$
where $n_i$ indicates that neuron $n_i$ is active, $overline(n_i)$ indicates
that it is inactive, and the absence of $n_3$ indicates that its activation
status is unspecified.

Thus, given a set of neurons, we can construct an activation pattern by
specifying which neurons are active and which are inactive. If the set includes
all neurons, it is a complete pattern; otherwise, it is a partial pattern (and
if it is an empty set $emptyset$, it is the empty pattern as in
@def:empty-pattern).


=== State Space Reduction <sec:pattern-reduction>

Once having an activation pattern $p$, we can simplify the formula $alpha$
representing the network by replacing each ReLU function with a linear
constraint according to the activation status specified in $p$. For example,
if $p$ specifies that neuron $n_i$ is active, we replace $ relu(z_i)$ with
$z_i >= 0$. Otherwise, if $n_i$ is inactive, we replace $ relu(z_i)$ with
$z_i < 0$. This gives us the formula $alpha_p$ corresponding to the linear
region defined by $p$.

A complete activation pattern $p$ defines a unique linear region of the
network because with a complete pattern, $alpha_p$ becomes a purely linear
formula. In contrast, a partial activation pattern $q$ defines multiple linear
regions, one for each complete pattern it represents. With $q$, $alpha_q$ may
still contain some ReLU functions that are not fixed by $q$. However, since $q$
fixes the status of some neurons, we can simplify $alpha$ by replacing those
neurons' ReLU functions with linear constraints.

In any case, given an activation pattern, we can reduce the complexity of the
satisfiability check by fixing the activation status of some neurons. Thus,
checking the satisfiability of $alpha_p and phi_"in" and not phi_"out"$ is
easier than checking that of $alpha and phi_"in" and not phi_"out"$.

#example[
  Recall the network from @fig:dnn-b can be represented as the formula $alpha$
  $
    & hat(x)_3 = -0.5x_1 + 0.5x_2 + 1.0 \
    & hat(x)_4 = 0.5x_1 - 0.5x_2 - 1.0 \
    & x_3 =  relu(hat(x)_3) \
    & x_4 =  relu(hat(x)_4) \
    & x_5 = -x_3 + x_4 - 1.0,
  $
  where $hat(x)_3$ and $hat(x)_4$ are the pre-activation values of the ReLU
  neurons $x_3$ and $x_4$, respectively. Thus, if we fix the the activation status of $x_3$
  and $x_4$, we can simplify $alpha$ by replacing the ReLUs with linear constraints.

  - A *complete* activation pattern specifies the status of both ReLU neurons. For instance,
    $
      p = {x_3, overline(x_4)}
    $
    means $x_3$ is active while $x_4$ is inactive; that is, $hat(x)_3 >= 0$ (so
    $x_3 = hat(x)_3$) while $hat(x)_4 < 0$ (so $x_4 = 0$). In this case,
    $alpha$ reduces to a single linear constraint:
    $
      x_5 = -(-0.5x_1 + 0.5x_2 + 1.0) + 0 - 1.0 = 0.5x_1 - 0.5x_2 - 2.0.
    $
  
    This reduction significantly simplifies the satisfiability check: we no
    longer have to reason about the non-linearity of ReLU, and can directly check
    whether the linear constraint is satisfiable with the input and output
    constraints.
  
  - A *partial* pattern specifies only some activation statuses. For example,
    $
      q = {x_3}
    $
    means $hat(x)_3 >= 0$ but places no restriction on $hat(x)_4$. Here,
    $alpha$ reduces to:
    $
      & hat(x)_4 = 0.5x_1 - 0.5x_2 - 1.0 \
      & x_4 =  relu(hat(x)_4) \
      & x_5 = -(-0.5x_1 + 0.5x_2 + 1.0) + x_4 - 1.0.
    $
    Because $q$ does not fix the status of $x_4$, we cannot simplify the ReLU
    for $x_4$. Thus, the formula still contains a ReLU which splits $x_4$ into
    two linear regions. Note that this is still simpler than the original $alpha$
    because we have simplified the ReLU for $x_3$.
]

#problem[
  Consider the network in @fig:dnn-b. Suppose we fix the activation pattern
  $p = {x_3, x_4}$.

  + Provide the constraints $alpha$ induced by $p$.
  + Consider an invalid property $x_5 > 0$ for inputs $x_1 in [-1,1]$,
    $x_2 in [-2,2]$. Find an activation pattern that satisfies the formula
    $alpha_p and phi_"in" and not phi_"out"$. In other words, find a pattern
    that contains a counterexample to the property.
] <problem:nnv-pattern>

== The Branch and Bound Algorithm <sec:bab-alg>

Many modern NNV tools adopt the Branch-and-Bound (#bab) approach to explore the space of possible neuron activation patterns (@sec:activation-patterns). #bab splits (_branch_) the verification problem into smaller subproblems by fixing activation statuses of neurons, and uses abstraction (_bound_) techniques to compute upper and lower bounds on the output values for these subproblems. If the bounds, computed using abstraction (@chap:abstractions), indicate infeasible (cannot contain a counterexample), the subproblem is pruned from the search space. This process continues until either a counterexample is found or all subproblems are exhausted, proving the property holds.

Note that because #bab splits ReLU neurons into active and inactive cases, it is also called _"neuron-splitting"_, which contrasts with _"input-splitting"_ techniques (@sec:input-splitting) that partition the input space.

#figure(
  placement: top,
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [Branch and Bound (#bab) Algorithm for Neural Network Verification],
pseudocode-list(hooks:0.5em)[
  + *Input*: network $cal(N)$, property $phi_"in" => phi_"out"$
  + *Output*: $"unsat"$ if property is valid, otherwise ($"sat"$, $"cex"$)
  - \
  + $"ActPatterns" <- {emptyset}$ \//initialize verification problem  #line-label(<line:babinit>)
  
  + *while* $"ActPatterns" !=  emptyset$ #line-label(<line:babstart>)
    + $sigma_i <- "Select"( "ActPatterns" )$ \// process problem $i^"th"$ #line-label(<line:babselect>) 
    + *if* $"Deduce"(cal(N), phi_"in" => phi_"out", sigma_i)$ \// check satisfiability #line-label(<line:babdeduce>) 
      + *if* (found a valid $"cex"$)
        + *return* ($"sat"$, $"cex"$) #line-label(<line:babsat>)
      + $v_i <- "Decide"(cal(N), sigma_i)$ #line-label(<line:babdecide>)
      - \// create new activation pattern
      + $"ActPatterns" <- "ActPatterns" union {sigma_i union {v_i}; sigma_i union {not v_i}}$ #line-label(<line:babadd>) 
    + \  #line-label(<line:babend>)
  + *return* "unsat" #line-label(<line:babunsat>)
]) <alg:bab>



#paragraph[Reference BaB Algorithm][@alg:bab shows #bab, a reference @nakagawa2014consolidating
 Branch and Bound architecture for NNV. #bab takes as input a ReLU-based network $cal(N)$ and a formulae $phi_"in" => phi_"out"$ representing the property of interest.
#bab maintains a set of activaion patterns ($"ActPatterns"$) that represent the current activation pattern of the network. Initially, $"ActPatterns"$ is initialized with an empty activation pattern (@line:babinit).
]

In each #bab iteration $i$ (@line:babstart), the algorithm selects and removes an activation pattern $sigma_i$ from $"ActPatterns"$s (@line:babselect).
It then calls $"Deduce"$ to _quickly_ determine if the current problem, i.e., the original satisfiability problem with  activation pattern $sigma_i$, is feasible. For example, it can use interval abstraction (@chap:abstractions) to quickly computes the bounds of the output values with respect to $sigma_i$, e.g., by replacing ReLU functions according to the activation statuses specified in $sigma_i$ (@sec:pattern-reduction).

// If the computed bounds indicate that no counterexample can exist, e.g., the lower bound of the output is greater than 0 when checking $y < 0$, then the problem is \emph{infeasible}. Otherwise, the problem is \emph{potentially feasible} (because the bounds are over-approximations).

// (Note that we do this even on the empty activation pattern, which is the initial state of the search, because the problem might be trivially infeasible, in which case we can exit and return \unsat{} immediately (@line:babunsat).)
// \begin{itemize}

// \item If \Deduce determines that the problem is infeasible, \bab{} discards the current processing activation pattern and loops back (to~@line:babstart) to process the next activation pattern. In other words, it prunes the current search branch with activation pattern $sigma_i$.
// When there are no more activation patterns to process, \bab{} returns \unsat{} (@line:babunsat), indicating that it cannot find counterexamples and the property is valid.


// \item If \Deduce determines that the problem is feasible, \bab{} checks the satisfiability of the problem using an LP solver (@line:bablp)\footnote{The problem is formulated as a MILP problem as described in~@sec:using-milp and checked using an LP solver. Note that we use LP and MILP interchangeably here for simplicity. In practice, most LP solvers such as Gurobi handles MILP problems as well. Just like SMT solvers handle both SAT and SMT problems.}. If the solver finds a satisfying assignment, it returns \sat{} and the counterexample represented by the satisfying assignment (@line:babsat), indicating that the property is invalid.
// Otherwise, \mycode{LP} returns unsatisfiable, and \bab{} calls \Decide to select a neuron $v_i$ to split, i.e., to fix the activation status of $v_i$ as either active or inactive (@line:babdecide).  This means the problem is split into two independent subproblems: one with $v_i$ (active) and the other with $\overline{v_i}$ (inactive).
// By splitting (or fixing the neuron status), we create two \emph{simpler} subproblems (less neurons to abstract) that are easier to solve. Thus, this step \emph{refines} the precision of abstract interpretation.
// \bab{} then adds the two new activation patterns $sigma_i \land v_i$ and $sigma_i \land \overline{v_i}$ to $"ActPatterns"$s. \bab{} then loops back to~@line:babstart to process the next activation pattern.
// \end{itemize}


#paragraph[Deduce vs. LP][The difference between #smallcaps[Deduce] and #smallcaps[LP] is that the former uses abstraction to compute over-approximated bounds to determine feasibility, while the latter uses an LP solver to check exact satisfiability.
Abstraction is (very) quick but may yield false positives (declaring feasible when it is not), while LP is precise but more computationally expensive.  Their combination allows #smallcaps[BaB] to efficiently prune infeasible branches while accurately checking for counterexamples.]


// %\tvn{shows that \bab{} often does not exhaust all activation patterns, but rather prunes the search space by deducing infeasibility of some activation patterns.  May be use a tree example to illustrate this?}

// %it analyzes the conflict and adds a new clause to the set of clauses (\texttt{clauses}) to prevent the same activation pattern from being selected again.
// %The algorithm continues until there are no more activation patterns to process, at which point it returns \unsat, indicating that the property is valid. If a counterexample is found during the search, it returns \sat along with the counterexample.




// %To add proof generation capability, \bab{} is instrumented with a proof tree (\texttt{proof}) variable (@line:prooftree) to record these branching decisions. The proof is represented as a binary tree structure, where each node represents a neuron and its left and right edges represent its activation decision (active or inactive). %The proof tree is then used to generate a proof in the \prooflang{} format (@sec:proof-format).





#example[BaB Illustration][
Consider verifying that a network has the property
$
(x_1, x_2) in [-2.0, 2.0] times [-1.0, 1.0] => (y_1 > y_2),
$
i.e., no counterexample exists where $y_1 <= y_2$ for inputs in the given range.

First, #bab initializes $"ActPatterns"$ with an empty activation pattern $emptyset$ (i.e., no neurons fixed). Then #bab enters its main loop.

+ *First iteration.* #bab selects the only available activation pattern $emptyset$, i.e., $sigma_i = emptyset$, and calls _Deduce_ to check the feasibility of the problem.

  Here, _Deduce_ determines that the problem is feasible — the computed bounds of $y_1$ and $y_2$ indicate that $y_1 <= y_2$ can be satisfied. Next, #bab calls an LP solver to check satisfiability. The LP solver returns unknown — the problem is too complex without fixing any neuron status. Thus we need to refine by _splitting_ a neuron.

  #bab selects a neuron to split (_Decide_). Assume it chooses $v_4$, spawning two independent subproblems: one with $v_4$ active and one with $v_4$ inactive. Both activation patterns ${v_4}$ and ${overline(v_4)}$ are added to $"ActPatterns"$.

+ *Second iteration.* For the subproblem with pattern ${v_4}$, _Deduce_ finds it feasible but the LP solver is inconclusive, so $v_2$ is split, adding ${v_4, v_2}$ and ${v_4, overline(v_2)}$. For the subproblem with $overline(v_4)$, _Deduce_ determines infeasibility and prunes this branch.

+ *Third iteration.* For pattern ${v_4, v_2}$, #bab splits $v_1$, adding ${v_4, v_2, v_1}$ and ${v_4, v_2, overline(v_1)}$. For pattern ${v_4, overline(v_2)}$, _Deduce_ determines infeasibility; pruned.

+ *Fourth iteration.* Both remaining patterns ${v_4, v_2, v_1}$ and ${v_4, v_2, overline(v_1)}$ are determined infeasible and pruned.

+ *Fifth iteration.* $"ActPatterns"$ is empty; #bab returns #unsat, proving the property holds.

Notice that while there are $2^4 = 16$ possible activation patterns for the four ReLU neurons, #bab only explores 6 of them — infeasibility pruning avoids exploring the rest.
] <ex:bab>

#problem[BaB Detailed Steps][
Do @ex:bab but come up with concrete values for each step, e.g., what are the bounds computed by _Deduce_, what does the LP solver return, etc., to illustrate the process in more detail.
] <prob:bab-detailed>

#problem[BaB Counterexample][
Do @ex:bab again but make the property invalid and find a counterexample. It is also OK to change the problem (e.g., the input bounds or the property itself) to make it invalid.
] <prob:bab-counterexample>

#problem[BaB with Interval Abstraction][
Apply #bab on the network in @fig:dnn to verify the property $x_5 > 0$ for any inputs $x_1 in [-1,1], x_2 in [-2,2]$. Use interval abstraction to compute bounds. For LP solving, use any LP solver or solve manually. Show all steps: iterations, activation patterns, bounds computed, LP results, etc.
] <prob:bab-interval>

#problem[BaB Understanding][
Test your understanding of #bab and activation patterns by answering the following questions:
+ In the #bab algorithm, what happens if _Deduce_ always returns infeasible?
+ What happens if _Deduce_ always returns feasible but the LP solver always returns satisfiable?
+ What is the maximum number of activation patterns that #bab may need to explore in the worst case for a network with $m$ ReLU neurons?
+ What is the minimum number of activation patterns that #bab may need to explore in the best case for a network with $m$ ReLU neurons? What are these patterns?
] <prob:bab-understanding>

=== Beyond the Basic

What is described above is the basic and minimal #bab algorithm. Modern NNV tools implement many optimizations and strategies to improve the performance of the search. For example, they apply various engineering tricks to eliminate easy cases or find easy counterexamples (@chap:adversarial-attacks) before running the full #bab search.

Even the #bab search itself is optimized to avoid exploring the entire search space. For example, if the _Deduce_ step determines infeasibility, a smarter #bab variant (e.g., #tool) can analyze the conflict and add a new clause to prevent the same activation pattern from being selected again. This is similar to conflict-driven clause learning (CDCL) in modern SAT solvers and is implemented in #tool @duong2025neuralsat. In addition, heuristics are used to select, e.g., which neuron to split next (_Decide_). We explore these optimizations and strategies in later chapters (e.g., @chap:neuralsat).




#pagebreak()
= Adversarial Attacks <chap:adversarial-attacks>


A full branch and bound (#bab) search (@chap:bab) is typically expensive and slow on large networks. Thus most NNV tools implement optimizations to improve performance. A common optimization is to use _adversarial attack_ techniques to find counterexamples before running #bab. Examples of such techniques include randomized attacks @das2021fast and gradient-based attacks @madry2017towards.

Modern verification tools have two phases: (i) attempt to _falsify_ the property with adversarial attacks, and (ii) if no counterexample is found, attempt to _verify_ the property using search algorithms such as #bab (@chap:bab). Of course, during the verification phase, the verifier may also discover counterexamples that the falsify phase misses.

== Random Search Attack

*Random search* is a simple adversarial attack method. It randomly samples points in the allowed input ranges and checks if any samples violate the property; if so, a counterexample is found.

#example[Random Search][
Suppose the network input ranges are:
$ -1 <= x_1 <= 1, quad -2 <= x_2 <= 2 $
and the network output is:
$ y = 2x_1 - 1.5x_2 + 1. $
We wish to find a counterexample to the property $y > 0$, i.e., find inputs $(x_1, x_2)$ in the given ranges producing $y <= 0$.

- Try 1: $x_1 = 0.2, x_2 = -0.5$: $ y = 2 times 0.2 - 1.5 times (-0.5) + 1 = 0.4 + 0.75 + 1 = 2.15 > 0.$ Not a violation.
- Try 2: $x_1 = -1, x_2 = 2$: $ y = 2 times (-1) - 1.5 times 2 + 1 = -2 - 3 + 1 = -4 < 0.$ *Counterexample found*: $(x_1 = -1, x_2 = 2)$.
] <ex:random-search>

#problem[Random Search Exercise][
Consider the input ranges $-1 <= x_1 <= 1, quad -1 <= x_2 <= 1$ and network output $y = 3x_1 + 2x_2 - 2$.

Use random search to find a counterexample to the property $y > 0$:
+ Randomly sample three valid points and compute $y$ at each point.
+ Check if any sample violates the property. Note, if none violates, that's OK; just report the results.
+ Based on your samples, discuss whether random search is likely to be efficient for this problem.
]

== Projected Gradient Descent (PGD)

*PGD* is a powerful and widely used adversarial attack that builds on the idea of _gradient descent_. Gradient descent repeatedly moves the input a small amount in the direction that most rapidly decreases some objective by following the negative gradient.

Specifically, at each step PGD computes the gradient of the network output with respect to the input and takes a small gradient-descent step that pushes the input toward a stronger property violation. Next, PGD _projects_ (clips) the updated input back into the allowed domain if the step goes outside the input bounds.

We reuse @ex:random-search to illustrate PGD. The input ranges are $-1 <= x_1 <= 1, -2 <= x_2 <= 2$, the output is $y = 2x_1 - 1.5x_2 + 1$, and the goal is to find a counterexample producing $y <= 0$.

+ *Initialize.* Choose a valid starting input, e.g., $(x_1^((0)), x_2^((0))) = (0, 0)$. This satisfies the input ranges but does not violate $y > 0$ since $y = 1 > 0$. Proceed.

+ *Iterative update.* For each step $t = 0, 1, 2, ...$:

  a. *Compute the gradient.* The gradient $nabla_x y$ indicates how sensitive $y$ is to each input:
    $ nabla_x y = ((partial y)/(partial x_1), (partial y)/(partial x_2), ..., (partial y)/(partial x_n)) $
    It represents the direction of steepest _increase_ in $y$. To minimize $y$ (make violation $y <= 0$ more likely), move in the _opposite_ direction $-nabla_x y$.

    For $y = 2x_1 - 1.5x_2 + 1$: $(partial y)/(partial x_1) = 2$, $(partial y)/(partial x_2) = -1.5$, so $nabla_x y = (2, -1.5)$.

  b. *Gradient update.* Move distance $eta$ (the _step size_) in the negative gradient direction:
    $ x_1^((t+1)) = x_1^((t)) - eta dot 2, quad x_2^((t+1)) = x_2^((t)) - eta dot (-1.5) $
    With $eta = 0.5$ from $(0, 0)$: $x_1^((1)) = -1.0$, $x_2^((1)) = +0.75$.

  c. *Project (Clip) to valid range.* If new values are outside bounds, clip them:
    $ x_1^((t+1)) = max(-1, min(x_1^((t+1)), 1)), quad x_2^((t+1)) = max(-2, min(x_2^((t+1)), 2)) $
    The candidate $(-1.0, +0.75)$ is already within range; no clipping needed.

  d. *Check for violation.* Compute $y = 2(-1) - 1.5(0.75) + 1 = -2.125 < 0$. PGD finds counterexample $(x_1, x_2) = (-1, 0.75)$.

#example[PGD with Clipping][
Using step size $eta = 1.0$ from $(0, 0)$:
$
x_1^((1)) &= 0 - 1.0 times 2 = -2.0 \
x_2^((1)) &= 0 - 1.0 times (-1.5) = +1.5
$
$x_1^((1)) = -2.0$ is outside $[-1, 1]$, so clip to $x_1^((1)) = -1$. $x_2^((1)) = 1.5$ is within $[-2, 2]$; unchanged.

Projected input: $(-1, 1.5)$. Output: $y = 2(-1) - 1.5(1.5) + 1 = -3.25 < 0$. Counterexample found.
]

#example[Gradient Computation][
Consider $y = x_1^2 + 3x_2$. The gradient is:
$ nabla_x y = ((partial y)/(partial x_1), (partial y)/(partial x_2)) = (2x_1, 3). $
At $(x_1, x_2) = (1, 2)$: $nabla_x y = (2, 3)$. Near $(1,2)$, increasing $x_1$ raises $y$ twice as fast as increasing $x_2$ would.
]

#problem[Compute Gradients][
For each output function below, compute $nabla_x y = ((partial y)/(partial x_1), (partial y)/(partial x_2))$ and explain what the gradient tells you about how $y$ changes:
+ $y = 2x_1 - x_2 + 1$
+ $y = -x_1^2 + 4x_2$
+ $y = 3x_1 x_2 - x_2^2$
] <prob:compute-gradients>

#problem[PGD Iterations][
Let $y = 2x_1 - 3x_2 + 1$, with $-1 <= x_1, x_2 <= 1$. Starting from $(0, 0)$ with step size $eta > 0$, use PGD to minimize $y$ and violate $y > 0$. Find two step sizes $eta_1$ and $eta_2$ such that:
+ With $eta_1$, PGD finds a counterexample in _one_ iteration.
+ With $eta_2$, PGD finds a counterexample in _two or more_ iterations.

#solution[
The gradient is $nabla_x y = (2, -3)$. PGD update: $x_1^((t+1)) = x_1^((t)) - 2eta$, $x_2^((t+1)) = x_2^((t)) + 3eta$.

*Case A: $eta_1 = 0.5$.*
- Iteration 1: $x_1^((1)) = 0 - 0.5(2) = -1$, $x_2^((1)) = 0 + 0.5(3) = 1.5$. Clip $x_2$ to 1. Check: $y = 2(-1) - 3(1) + 1 = -4 < 0$. *Counterexample* $(-1, 1)$ in one iteration.

*Case B: $eta_2 = 0.07$.*
- Iteration 1: $x_1^((1)) = -0.14$, $x_2^((1)) = 0.21$. Check: $y = 2(-0.14) - 3(0.21) + 1 = 0.09 > 0$. Continue.
- Iteration 2: $x_1^((2)) = -0.28$, $x_2^((2)) = 0.42$. Check: $y = 2(-0.28) - 3(0.42) + 1 = -0.82 < 0$. *Counterexample* $(-0.28, 0.42)$ in two iterations.
]
] <prob:pgd-iterations>

#pagebreak()
= Proof Generation and Checking <chap:proof-gen-check>

As NNV tools become more complex (e.g., state-of-the-art tools have 20K+ lines of code), they are more prone to bugs. VNN-COMP'23 @brix2023fourth showed that 3 of the top 7 participants produced unsound results by claiming unsafe networks are safe, i.e., they return #unsat on problems that are actually #sat.

While checking counterexamples is straightforward (we evaluate the network on the input), checking #unsat results---proving no counterexample exists---is more challenging as it requires tracing the reasoning steps of the verifier. In this chapter, we discuss work @duong2025generating on generating and checking proofs of #unsat results generated by BaB-based NNV tools.

== Proof Generation for Branch and Bound Algorithms <sec:proofgen>

The #bab algorithm splits the problem into smaller subproblems and uses abstraction to compute bounds to prune the search space. This structure allows proof generation capabilities to be added with minimal overhead to existing \#bab-based NNV tools.

#smallcaps[ProofGen] extends the basic #bab algorithm with proof generation. The key idea is to introduce a *proof tree* and record the branching decisions into it. The proof tree has a binary structure, where each node represents a neuron and its left and right edges represent its activation decision (active or inactive). At the end of verification, the proof tree is returned as the proof of #unsat.

```
Algorithm: ProofGen (BaB with Proof Generation)
Input:  NN N, property phi_in => phi_out
Output: (unsat, ProofTree) if valid, else (sat, counterexample)

ActPatterns = {∅}     // initialize with empty activation pattern
ProofTree   = {}      // initialize empty proof tree

while ActPatterns is not empty:
  σ_i = Select(ActPatterns)
  if Deduce(N, phi_in, phi_out, σ_i):        // feasible
    cex = LP(N, phi_in, phi_out, σ_i)
    if cex: return (sat, cex)                // counterexample found
    v_i = Decide(N, σ_i)                    // pick neuron to split
    ActPatterns += {σ_i ∪ {v_i}, σ_i ∪ {v̄_i}}
  else:                                      // infeasible — prune
    ProofTree += {σ_i}                       // record in proof

return (unsat, ProofTree)
```

#example[ProofGen Illustration][
We reuse @ex:bab to illustrate #smallcaps[ProofGen]. The goal is to verify the property $(x_1, x_2) in [-2.0, 2.0] times [-1.0, 1.0] => (y_1 > y_2)$.

#smallcaps[ProofGen] first splits neuron $v_4$, creating two subproblems. The inactive-$v_4$ subproblem is determined to be #unsat (leaf node 3). The active-$v_4$ subproblem is further split on $v_2$. The inactive-$v_2$ subproblem is #unsat (leaf node 5). The active-$v_2$ subproblem is split on $v_1$. Both resulting subproblems (leaf nodes 6 and 7) are #unsat. Since all branches lead to #unsat, the property is valid and the proof tree is returned.
]

#problem[Proof Tree Construction][
Consider the following network:
$
hat(x)_3 &= x_1 - 2x_2 + 1, quad x_3 = relu(hat(x)_3) \
hat(x)_4 &= -x_1 + x_3 + 0.5, quad x_4 = relu(hat(x)_4) \
y &= -x_3 + 2x_4
$
The input region is $(x_1, x_2) in [-1,1] times [-1,1]$ and the property to verify is $y <= 5$.

A verifier uses BaB with neuron splitting on $x_3$ and $x_4$ in order:
+ First split on $x_3$.
+ For the active-$x_3$ branch, split on $x_4$.

The solver determines: (a) inactive $x_3$ is #unsat, (b) active $x_3$ + inactive $x_4$ is #unsat, (c) both active is also #unsat.

Do the following:
+ Draw the _proof tree_, labeling each split node with the neuron being split.
+ For each split, explain: which constraints are added (e.g., $hat(x)_3 >= 0$ or $hat(x)_3 <= 0$), how equations simplify, and why the subproblem is #unsat.
+ Explain why the proof tree is a correctness proof — why showing all leaf nodes are #unsat proves $y <= 5$ is valid.
] <prob:proof-tree>



== Proof Language <sec:prooflang>

Rather than recording the generated proof tree in a verifier-specific format, it is more desirable to have a standard format that is human-readable, compact, efficiently generated by verification tools, and independently processable by proof checkers.

#smallcaps[ProofLang] is designed to meet these requirements. It is inspired by the SMTLIB format @barrett2010smt used for SMT solving, which has also been adopted by the VNNLIB language @vnnlib to specify neural network properties (see @sec:vnnlib for examples).

A #smallcaps[ProofLang] proof is composed of *declarations* and *assertions*. The grammar is:

```
<proof>        ::= <declarations> <assertions>
<declarations> ::= <declaration> | <declaration> <declarations>
<declaration>  ::= (declare-const <input-vars>  Real)
                 | (declare-const <output-vars> Real)
                 | (declare-pwl   <hidden-vars> <activation>)
<activation>   ::= ReLU | LeakyReLU | ...
<assertions>   ::= <assertion> | <assertion> <assertions>
<assertion>    ::= (assert <formula>)
<formula>      ::= (<op> <term> <term>)
                 | (and <formula>+) | (or <formula>+)
<term>         ::= <input-var> | <output-var> | <hidden-var> | <constant>
<op>           ::= < | <= | > | >=
<input-var>    ::= X_<constant>
<output-var>   ::= Y_<constant>
<hidden-var>   ::= N_<constant>
```

_Input variables_ (prefixed `X`) and _output variables_ (prefixed `Y`) are declared as reals. _Hidden variables_ (prefixed `N`) correspond to internal neurons and are declared with their piecewise-linear activation function (e.g., ReLU). Assertions over input variables are _preconditions_ and those over output variables are _postconditions_. The hidden constraints encode the activation patterns of the proof tree, where each `and` clause represents one tree path.

Below is a #smallcaps[ProofLang] proof for the example in @ex:bab:

```python
; Declare variables
(declare-const X_0 X_1 Real)
(declare-const Y_0 Y_1 Real)
(declare-pwl N_1 N_2 N_3 N_4 ReLU)

; Input constraints (precondition)
(assert (>= X_0 -2.0))
(assert (<= X_0  2.0))
(assert (>= X_1 -1.0))
(assert (<= X_1  1.0))

; Output constraint (negated postcondition)
(assert (<= Y_0 Y_1))

; Hidden constraints (proof tree paths — one per leaf)
(assert (or
    (and (<  N_4 0))
    (and (<  N_2 0) (>= N_4 0))
    (and (>= N_2 0) (>= N_1 0) (>= N_4 0))
    (and (>= N_2 0) (<  N_1 0) (>= N_4 0))
))
```

#example[ProofLang Format][
The `(and (< N_4 0))` clause corresponds to the rightmost path of the proof tree with $overline(v_4)$ (leaf 3). The `(and (< N_2 0) (>= N_4 0))` clause corresponds to the path with $v_4 and overline(v_2)$ (leaf 5).
]

#smallcaps[ProofLang] intentionally omits network weights and biases — these are available in the standard ONNX format @onnx, which any #smallcaps[ProofLang] checker can access independently. The explicit DNF (disjunctive normal form) structure enables easy parallelization of proof checking.


== Proof Checker <sec:proofchecking>

#smallcaps[ProofCheck] is a verifier-independent proof checker for #smallcaps[ProofLang] proofs generated by \#bab-based NNV tools.

=== The Core Algorithm

The goal of #smallcaps[ProofCheck] is to verify that each _leaf_ node of the proof tree is #unsat. To check a leaf, #smallcaps[ProofCheck] forms an MILP problem (@sec:using-milp) consisting of the NNV constraints (@eq:nnv2) — network, input condition, negated output — augmented with the activation-pattern constraints encoded by the tree path to that leaf. It then invokes an LP solver; infeasibility certifies that leaf.

```
Algorithm: ProofCheck
Input:  Network N, property phi_in => phi_out, ProofTree
Output: certified if proof valid, else uncertified

if not RepOK(ProofTree): raise Error("Invalid proof tree")

model = CreateStabilizedMILP(N, phi_in, phi_out)
node  = null

while ProofTree is not empty:
  node  = Select(ProofTree, node)         // get next leaf to check
  model = AddConstrs(model, node)         // add leaf's activation constraints
  if Feasible(model):
    return uncertified                    // LP found a satisfying point
  // (leaf is infeasible — continue)

return certified
```

#smallcaps[ProofCheck] first validates the proof tree structure (@sec:prooflang). It then creates an MILP model for the network and property. The main loop selects leaf nodes one at a time, adds their activation-pattern constraints to the model, and calls the LP solver. If any leaf is found feasible, the proof is invalid. After all leaves are verified infeasible, #smallcaps[ProofCheck] returns #smallcaps[certified].

#example[ProofCheck on BaB Example][
For the #smallcaps[ProofLang] proof in @sec:prooflang, #smallcaps[ProofCheck] must certify the four leaf nodes 3, 5, 6, and 7. Suppose it first selects node 3, which has the single constraint $overline(v_4)$, i.e., $0.6v_1 + 0.9v_2 - 0.1 <= 0$. It conjoins this with the NNV constraints for the input region and network, then invokes the LP solver. The LP is infeasible — leaf 3 is certified. #smallcaps[ProofCheck] continues for the remaining three leaves and returns #smallcaps[certified] once all are verified.
]

=== Optimizations

While the core algorithm is minimal, it can be inefficient for large proofs. #smallcaps[ProofCheck] employs several optimizations.

*Neuron Stabilization.*

A primary challenge in NNV is the presence of large numbers of piecewise-linear constraints (e.g., ReLU), which generate many branches and yield large proof trees. In the MILP formulation this creates many disjunctions that are hard to solve. #smallcaps[ProofCheck] uses _neuron stabilization_ @duong2024harnessing to identify neurons that are _stable_ (always active or always inactive) for all inputs satisfying the property precondition. For stable neurons, the disjunctive ReLU constraint is replaced by a simpler linear constraint, reducing MILP complexity.

*Pruning Leaf Nodes.* A child node in the proof tree adds constraints to its parent's constraints (the child's activation pattern is strictly more constrained). Therefore, if a parent node is #unsat, all its descendants must also be #unsat. #smallcaps[ProofCheck] exploits this by using a *backtracking* mechanism: after certifying a leaf $l$, it checks the parent $p$; if $p$ is #unsat, the sibling subtree of $l$ is pruned. This backjumping can proceed up to $N$ levels at a time. The default $N = 2$ balances pruning benefit against the cost of solving less-constrained (harder) parent problems.

*Parallelization.* The DNF structure of a #smallcaps[ProofLang] proof tree is inherently parallel — each tree path is an independent sub-proof. #smallcaps[ProofCheck] uses a parameter $k$ to check $k$ leaf nodes concurrently using multiprocessing.

// % == Rounding Errors <sec:rounding-errors}

// %\tvn{Give concrete examples of rounding errors in VNN-COMP}


// %  == Evaluation <sec:evaluation}
// % Our goals are to understand how checking of \prooflang{}s performs, how it can be optimized, and how robust checking is to
// % verification optimizations.
// % We focus our evaluation on the following research questions:

// % \noindent\mbox{~~}\textbf{RQ1} (@sec:rq1): How does \proofcheck{} perform and how does it compare prior work?

// % \noindent\mbox{~~}\textbf{RQ2} (@sec:rq2): How does proof checking optimization improve performance?

// % \noindent\mbox{~~}\textbf{RQ3} (@sec:rq3): How does proof checking performance vary with verification algorithms and optimizations?



// % \subsection{Experimental Design <sec:exp_design}
// % We describe the selection of benchmarks, baselines, metrics, and treatments used
// % to explore the above RQs.

// % \ignore{
// % \begin{table*}[t]
// %     \footnotesize
// %     \centering
// %     \caption{Benchmark instances. U: \texttt{unsat}, S: \texttt{sat}, ?: \texttt{unknown}. <tab:benchmarks}
// %     % \vspace*{-3mm}
// %     % \resizebox{\textwidth}{!}{
// %     \begin{tabular}{c|ccrr|cc}
// %         \toprule
// %         % \multirow{2}{*}{\textbf{Benchmarks}} &\multicolumn{3}{c}{\textbf{Networks}}  &\multicolumn{2}{|c}{\textbf{Tasks}}\\
// %         % \multirow{2}{*}{\textbf{Benchmarks}} &\multicolumn{2}{c}{\textbf{Networks}} &  \multicolumn{2}{c|}{\textbf{Per Network}} &\multicolumn{2}{c}{\textbf{Tasks}}\\
// %         \multirow{2}{*}{\textbf{Benchmarks}} &\multicolumn{4}{c}{\textbf{Networks}} & \multicolumn{2}{|c}{\textbf{Tasks}}\\
// %         & Type & Networks & Neurons & Parameters & Properties & Instances (U/S/?)\\

// %         \midrule
// %         \multirow{4}{*}{FNN\_SMALL}         & \multirow{4}{*}{FNN + ReLU} & 2 x FNN(32) &   64 & 27K & 25 & 25/0/0 \\
// %                                             &                             & 4 x FNN(32) &  128 & 29K & 25 & 25/0/0 \\
// %                                             &                             & 2 x FNN(64) &  128 & 55K & 25 & 25/0/0 \\
// %                                             &                             & 4 x FNN(64) &  256 & 63K & 25 & 25/0/0 \\

// %         \midrule
// %         \multirow{4}{*}{FNN\_MEDIUM}        & \multirow{4}{*}{FNN + ReLU} & 2 x FNN(256)  &    512 &  269K & 25 & 25/0/0 \\
// %                                             &                             & 4 x FNN(256)  &   1024 &  401K & 25 & 25/0/0 \\
// %                                             &                             & 6 x FNN(256)  &   1536 &  532K & 25 & 25/0/0 \\
// %                                             &                             & 6 x FNN(512)  &   3072 & 1.7M & 25 & 25/0/0 \\
// %         \midrule
// %         \multirow{4}{*}{CNN\_SMALL}         & \multirow{4}{*}{CNN + ReLU} & 1 x CNN(3, 21), 1 x FNN(128)  &   320 & 27K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(3, 19), 1 x FNN(128)  &   428 & 41K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(3, 17), 1 x FNN(128)  &   560 & 58K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(3, 13), 1 x FNN(128)  &   896 & 100K & 25 & 25/0/0 \\
// %         \midrule
// %         \multirow{4}{*}{CNN\_MEDIUM}        & \multirow{4}{*}{CNN + ReLU} & 1 x CNN(3, 9), 1 x CNN(5, 11), 1 x FNN(128)  &   1828 & 67K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(3, 7), 1 x CNN(5, 9),  1 x FNN(128)  &   2560 & 128K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(5, 9), 1 x CNN(7, 11), 1 x FNN(128)  &   2828 & 96K & 25 & 25/0/0 \\
// %                                             &                             & 1 x CNN(5, 7), 1 x CNN(7, 9),  1 x FNN(128)  &   3920 & 180K & 25 & 25/0/0 \\
// %         \midrule
// %         \textbf{Total}                      &                             & \textbf{16}                  &     &   & \textbf{400} & \textbf{400/0/0} \\
// %         \bottomrule
// %     \end{tabular}
// %     % }
// % \end{table*}
// % }


// % \paragraph{Benchmarks}
// % Evaluating these research questions requires neural network verification problems
// % that are valid, i.e., their formulation as satisfiability problems is UNSAT.

// % The yearly VNN-COMP competitions~\cite{brix2023first,brix2023fourth,bak2021second} includes a wide-variety of benchmarks,
// % but the competitions organizers observed that many benchmarks are too easy.
// % They contain large numbers SAT problems that can be solved by adversarial attacks
// % or UNSAT problems that can be solved, without any state splitting, using coarse overapproximations.
// % They conclude that there is a need
// % for benchmarks to be ``not so easy that every tool can solve all of them''~\cite{brix2023first}.
// % For this reason, we base our benchmark selection on a recent paper~\cite{duong2024harnessing} that developed harder
// % UNSAT benchmarks including:
// % ACAS Xu, RESNET\_A/B, CIFAR2020, MNISTFC, and MNIST\_GDVB.

// % We selected problems from these based on the applicability of our
// % current \proofcheck{} implementations.

// % We chose not to use ACAS Xu, because those problems have a very small
// % input dimension (5 dimensions) which triggers a divide-and-conquer problem
// % decomposition optimization in verifiers, like \neuralsat{} and \crown{}.
// % This results in a set of relatively small proofs, each of which
// % can be expressed in \prooflang{}, but whose simplicity do not add
// % value beyond the selected benchmarks discussed below.

// % We chose not to use the RESNET benchmarks because  \proofcheck{} does not currently handle residual blocks.  This is an engineering limitation and there is no fundamental reason the checking algorithm is not applicable.

// % Of the CIFAR2020 networks, one contains BatchNorm layers which are not currently
// % supported by \proofcheck{}, but we note that adding this support is a straightforward
// % engineering issue.
// % The remaining CIFAR2020 benchmarks contain very large numbers of convolutional
// % kernels, which generates complex constraints that can be challenging to solve.
// % We adapt the smallest of the CIFAR2020 benchmarks, by varying the size of the
// % convolutional kernels and the number of CNN layers, to produce
// % the CNN benchmark in the second row of~@tab:benchmarks.
// % \begin{table}[t]
// %     \footnotesize
// %     \centering
// %     \caption{Benchmarks consist of a 8 neural networks comprised of varying numbers of CNN (C) and FNN (F) layers, neurons, and parameters, each paired with 25 properties to form verification instances that have been confirmed to be UNSAT. <tab:benchmarks}
// %     % \vspace*{-3mm}
// %     % \resizebox{\textwidth}{!}{
// %     \begin{tabular}{c|cccc|c}
// %         \toprule
// %         \multirow{2}{*}{\textbf{Name}} &\multicolumn{4}{c|}{\textbf{Networks}} & \textbf{Properties}\\
// %         & Num. & Layers & Neurons & Param. & Num. \\

// %         \midrule
// %         FNN        & 8 & 2-6F &  64-3072 & 27K-1.7M & 200  \\
// %         \midrule
// %         CNN        & 8 & 1-2C;1F  &  320-3920 & 41K-180K & 200  \\
// %         \bottomrule
// %     \end{tabular}
// %     % }
// % \end{table}

// % The MNISTFC and MNIST\_GDVB benchmarks contain 41 networks and a total of 106 UNSAT verification problems.
// % From those we selected 8 networks with varying numbers of layers and neurons, resulting
// % in models spanning several orders of magnitude in terms of parameters, to produce
// % the FNN benchmark in the first row of~@tab:benchmarks.

// % For each of the networks, following the approach from~\cite{duong2024harnessing},
// % we randomly selected centerpoints and radii for local-robustness properties until we found 25 property specifications that yielded UNSAT results.  This yielded 200 properties
// % each for the FNN and CNN benchmarks for a total of 400 verification problems and
// % their associated proofs.

// % \paragraph{Baselines}
// % To the best of our knowledge there is a single prior work published
// % on DNN verification proof checking~\cite{desmartin2023towards}.
// % That checker is designed to work only with a single verifier, \marabou{},
// % unlike \proofcheck{}.

// % While not strictly a baseline we also use the time to verify problems
// % as a baseline.  This is because it is instructive to understand
// % the cost of proof checking after having generated a proof.
// % We have adapted two verifiers: \crown{} and \neuralsat{}, to
// % generate \prooflang{} proofs for this study.

// % For RQ1 our focus is on proof checking performance, so we compare
// % \marabou{} and its proof checker with a single verifier, \neuralsat{},
// % and \proofcheck{}.
// % RQ2 explores \proofcheck{} optimizations and it uses the unoptimized
// % \proofcheck{} performance as a baseline.
// % For RQ3 our goal is to understand how well \proofcheck{} accommodates
// % proofs generated by different verification algorithm variants, since no
// % other proof checker can do this there is no baseline for comparison.

// % \begin{figure}[t]
// %     \centering
// %     \begin{minipage}[t]{0.4\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/fnn.pdf}
// %     \end{minipage}
// %     \begin{minipage}[t]{0.4\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/cnn.pdf}
// %     \end{minipage}

// %     % \begin{minipage}[t]{0.45\textwidth}
// %     %     \centering
// %     %      in cludegraphics[width=\linewidth]{figure/MNIST_CNN_SMALL.pdf}
// %     % \end{minipage}
// %     % \hfill
// %     % \begin{minipage}[t]{0.45\textwidth}
// %     %     \centering
// %     %      in cludegraphics[width=\linewidth]{figure/MNIST_CNN_MEDIUM.pdf}
// %     % \end{minipage}
// %     \caption{Cactus-plots for verifiers and proof checkers of FNN (top) and CNN (bottom) benchmarks.}
// %     \label{fig:cactus-plots}
// % \end{figure}
// % \paragraph{Treatments}
// % RQ1 compares the best performing versions of \marabou{}'s proof checker and \proofcheck{}.
// % For RQ2, we consider two of the three optimizations
// % implemented in \proofcheck{} : proof tree pruning (X), and
// % proof stabilization (S).  We kept a third optimization that controls the
// % degree of parallelization in proof checking fixed at a value of 64 to mitigate
// % experimental cost; since the independence of sub-proofs means that
// % proof checking is amenable to linear speedUB we felt this aspect of experimentation
// % was less valuable.
// % For RQ3, we use both \neuralsat{} and \crown{} to generate proofs; this
// % constitutes a treatment for this research question as it varies the
// % verification algorithm.
// % For each verifier, we explore a base version of the verifier and an optimization:
// % the stabilization optimization for \neuralsat{} and replacing
// % the default branch-and-bound decision heuristic with the BaBSR~\cite{bunel2020branch} heuristic
// % in \crown{}.

// % \paragraph{Metrics}
// % In the verification community there are two metrics commonly used to
// % assess performance: time to solve the problems and number of problems solved
// % from a benchmark.  We report them both here.

// % For each \proofcheck{} problem we record:
// % the time to verify that the problem is UNSAT, the time to generate a proof,
// % the time for \proofcheck{} to finish.
// % If the sum of these for a problem is less than a specified timeout,
// % 1000 seconds in our evaluation, then we say the problem is ``solved''.
// % For verifiers run alone, a problem is solved if the verification completes
// % within the timeout.

// % For each benchmark, we provide cactus plots which plot the time for a problem on the y-axis, and the number of problems solved on the x-axis; problems are sorted on the x-axis from least to largest.
// % As shown in~@fig:cactus-plots, these plots allow one to observe both the time difference between baselines and treatments (vertical distance between lines at a point on the x-axis) and the ability of techniques to solve problems (the maximum x-coordinate for a given line).

// % We also report the size of proof trees that are generated in \prooflang{}.
// % In the absence of optimizations this defines the \textit{number of sub-proofs}
// % that need to be checked, but with optimizations the number of sub-proofs may
// % be reduced, e.g., when an interior node in the tree can be proven.
// % The complexity of  sub-proofs
// % may vary significantly, so to provide a more detailed characterization we
// % also report \textit{MILP complexity}. ~@eq:mip defines the general form
// % of each MILP problem, but the problems will vary based on how many of the $a$ variables
// % defined in~@eq:mip(d) have a fixed value -- either 0 or 1.   When this
// % happens the constraint in~@eq:mip(e) are simplified.
// % Consequently, we measure MILP complexity as the number of neurons that do \textit{not}
// % have a fixed value, i.e., the number of unstable neurons.
// % \ignore{This does not account for the contribution of~@eq:mipa,b which is directly
// % related to network size and input/output dimension.   Is there any way to measure that?}
// % % \hd{I see. It seems hard since "a"s and constraints do not have the same unit.}

// % \paragraph{Experimental Setup}
// % All experiments were run on a Linux machine with an AMD Threadripper 64-core 4.2GHZ CPU, 128GB RAM, and an NVIDIA GeForce RTX 4090 GPU with 24 GB VRAM.
// % We used a timeout of 1000 seconds for the combined time of running the verifier,
// % generating the proof, and then checking that proof.

// % \subsection{RQ1 : Proof Checking Performance}
// % \label{sec:rq1}
// %~@fig:cactus-plots presents data on the performance
// % of \proofcheck{} relative to both an underlying verifier, \neuralsat{}, and prior work on neural network proof checking, \marabou{}'s proof checker.
// % In cactus plots like this, lines that extend further on the x-axis
// % are better -- more problems solved -- and lines that are lower are better -- faster solve times.
// % Another way to view these is to pick a point on the x-axis where the plots for two techniques are defined and think of the areas under the two curves as the ``total cost'' to solve that number of problems.
// % The dashed lines in the plots show the performance of the verifier and the solid lines show the performance of the verifier, proof generation, and the proof checker.  Several configurations of
// % \proofcheck{} are shown, but in this RQ we draw the readers attention
// % to the plots for the \proofcheck{}(S+X) configurations; the rest are discussed in detail below.

// % The cactus plot for the FNN benchmark (top)
// % shows that \marabou{} and its checker are able to solve 69 problems or 35\% of the benchmark, whereas \proofcheck{} can solve 186 or 93\%.
// % For the CNN benchmark (bottom) \marabou{} and its checker can solve a single benchmark, whereas \proofcheck{} can solve 177 problems or 89\%.
// % In total, \proofcheck{} solved 363 problems or 91\%, whereas \marabou{}  solved 70 problems or 18\% of all instances.

// % \begin{figure*}[t]
// % \begin{subfigure}{0.4\linewidth}
// %     \centering
// %     %
// %     \begin{minipage}[t]{0.75\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/SUB_PROOFS_NONE.pdf}
// %     \end{minipage}
// %     %
// %     \begin{minipage}[t]{0.235\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/SUB_PROOFS_SX.pdf}
// %     \end{minipage}
// %     \caption{Number of sub-proofs per problem with (right) and without (left) \proofcheck{} optimizations.}
// %     \label{fig:sub-proofs-plots}
// % \end{subfigure}
// % \hfill
// % \begin{subfigure}{0.59\linewidth}
// %     \centering
// %     %
// %     \begin{minipage}[t]{0.5\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/MILP_COMPLEXITY_NONE.pdf}
// %     \end{minipage}%
// %     \begin{minipage}[t]{0.5\textwidth}
// %         \centering
// %          in cludegraphics[width=\linewidth]{figure/MILP_COMPLEXITY_SX.pdf}
// %     \end{minipage}

// %     \caption{Number of constraints of a given complexity per problem with (right) and without (left) \proofcheck{} optimizations.}
// %     \label{fig:constrs-proofs-plots}
// % \end{subfigure}
// % \caption{Data on proof size and complexity.   Y-axes are log-scale due to the range of values.}
// % \end{figure*}

// % % \matt{Some of the line number references are no longer resolving below.}
// % The shape of these cactus plots indicates a high-degree of variability in the cost of proof
// % checking relative to verification.
// % From~@fig:algorithm it is clear that both the number of leaves in the tree
// % structure,~@line:get_leaf, and the complexity of the model to be checked,~@line:proof_check_objective1, are factors that contribute to the cost of proof checking.
// % To explore those factors we plot their variation across the benchmarks when running \proofcheck{}.

// %~@fig:sub-proofs-plots (left) plots a histogram of the number of sub-proofs solved per verification
// % problem, i.e., the number of nodes of the proof tree.
// % When interpreting these plots, understand that the y-axis log scale means that vertical
// % distances have a different meaning as you move upward in the plot.
// % While the vast majority of the verification problems have proof trees of fewer then 2000 leaves, but 17 of them have larger trees up to a maximum of more than 10000 leaves.
// % Note also that even among the smaller sized proof trees, there are some problems that cannot be solved.
// % This is due to complexity of solving the MILP constraints at the leaves of those proof trees.

// %~@fig:constrs-proofs-plots (top) plots a histogram of the number of occurrences of MILP problems of
// % a given complexity across the benchmarks.  Here again we see a spread in data, but unlike with the number of sub-proofs the CNN benchmarks seem to have consistently larger constraints and there is a clear bias among the unsolved problems towards larger constraint size.
// % To optimize proof checking, we must address both of these sources of complexity.

// % \begin{tcolorbox}[left=1pt,right=1pt,top=1pt,bottom=1pt]
// % \textbf{RQ1 Findings}: Proof checking performance varies with both the size of the proof tree and the complexity of the MILP problems at the nodes of the tree.  \proofcheck{} can solve 91\% of the problems across the benchmarks and improves on prior work which can solve less than 18\%.
// % % \tvn{are these numbers correct?  the 2nd paragraph of RQ1 says prior work can do 24\% and \proofcheck{} can do 92\%}
// % \end{tcolorbox}

// % \subsection{RQ2 : Proof Checking Optimizations}
// % \label{sec:rq2}
// % The performance cactus plots~@fig:cactus-plots present an ablation
// % study of the
// % pruning (X) and stabilization (S) optimizations of \proofcheck{}.
// % The trend across both benchmarks is consistent with pruning (yellow) and stabilization (blue)
// %  improving the number of problems solved by 5\% and 36\%, respectively, over the unoptimized
// % \proofcheck{} (green).
// % The combination of optimizations (red) improves the number of solved problems by 46\%, which is more than the sum of their individual improvements demonstrating that the methods create opportunities for one another for further optimization.
// % \ignore{
// % - neither X nor S: 168 (F) + 88 (C) = 256
// % - X: 175 (F) + 93 (C) = 268
// % - S: 178 (F) + 170 (C) = 348
// % }

// % The~@fig:sub-proofs-plots (right) and~@fig:constrs-proofs-plots (right) explore the impact of the S and X optimizations on the number of sub-proofs and MILP complexity.  Across the benchmarks optimizations reduce
// % the number of sub-proofs is to less than 1000 and
// % MILP complexity to less than 2000.
// % The reduction in sub-proofs directly contributes to the increase
// % in performance of \proofcheck{}, but the reduction in
// % MILP complexity is more subtle.
// % Integer programming, and thus MILP, is known to be
// % NP-Hard in general~\cite{garey1979computers}.
// % The stabilization optimization addresses this complexity by
// % calculating sets of variables that are forced to take on specific
// % values based on other constraints in the MILP problem.  For each
// % such variable, the constraints associated with it is effectively
// % eliminated.  We can observe this in comparing the left and
// % right of~@fig:constrs-proofs-plots where we see both
// % constraints of higher complexity eliminated and the peak of
// % the constraint distribution shifted downward from 400 to 100
// % constraints.

// % \ignore{
// % Sub-problem size
// % - without S+X:
// %     + mean: 388
// %     + std: 1062
// % - with S+X
// %     + mean: 142
// %     + std: 152

// % MILP complexity
// % - without S+X:
// %     + mean: 329
// %     + std: 274
// % - with S+X
// %     + mean: 493
// %     + std 449

// % We performed an analysis of the relationship between size of constraints and number of sub-proofs and determined that these factors are not strongly correlated.
// % For example, there is a 1 layer CNN model with 27k parameters whose verification
// % generates 680 sub-proofs where the complexity of the constraints in that proof are at most 109.
// % On the other end of the spectrum, verification of a 2 layer CNN model with 180k parameters only requires 81 sub-proofs, but those proofs consist of constraints with complexity of at least 1721.
// % }

// % \begin{tcolorbox}[left=1pt,right=1pt,top=1pt,bottom=1pt]
// % \textbf{RQ2 Findings}: The \proofcheck{} optimizations each independently increase the number of proofs that can be checked and in combination they allow
// % an additional 46\% of the proofs in the benchmarks to be checked.
// % \end{tcolorbox}

// % \subsection{RQ3 : Proof Checking and Verifier Optimizations}
// % \label{sec:rq3}
// %~@fig:algvariation shows cactus-plots for two configurations of \neuralsat{} and \crown{} generated proofs across the benchmarks.   The performance of the verifiers, dashed lines, differ across configurations and they are able to
// % verify between 337 and 400 problems in the benchmark.
// % \ignore{Number of Verified/Proved problems
// %     + abcrown(babsr):   337/335 = 99.4%
// %     + abcrown:          368/366 = 99.4%
// %     + neuralsat(SX):    387/363 = 93.7%
// %     + neuralsat(S)(SX): 400/384 = 96%
// % }
// % For both of the verifiers and configurations,
// % \proofcheck{} is able to check between 93.7\% and 99.4\% of the proofs that are generated.
// % This demonstrates that the \prooflang{} is able to encode proofs
// % generated by differing neural network verification algorithms, and
// % that \proofcheck{} can check them.

// % %~@tab:sizestats.
// % \begin{figure}[t]
// %     \centering
// %      in cludegraphics[width=0.8\linewidth]{figure/ablation.pdf}
// %     \caption{\proofcheck{} performance with different verification algorithms.}
// %     \label{fig:algvariation}
// % \end{figure}

// % \begin{table}[t]
// %     \caption{Proof statistics for best verifier configurations.}
// %     \label{tab:sizestats}
// %     \centering
// %     \begin{tabular}{c|cc|cc}
// %         \toprule
// %          \multirow{2}{*}{\textbf{Verifier}} & \multicolumn{2}{c}{\textbf{Num. Sub-Proofs}} & \multicolumn{2}{|c}{\textbf{MILP Complexity}}\\
// %          & Mean & Median & Mean & Median \\
// %          \midrule
// %          \neuralsat{}(S) & 95 & 36 & 601 & 545 \\
// %          \midrule
// %          \crown{} & 230 & 180 & 414 & 179\\
// %          \bottomrule
// %     \end{tabular}
// % \end{table}

// % We performed an analysis of both the number of sub-proofs and MILP complexity for the proofs generated by the two best performing verifier
// % configurations.  These values follow a skewed
// % distribution, so we report the mean and median values in~@tab:sizestats.   One can observe variation in the
// % structure of the proofs generated by these verifiers.
// % \neuralsat{} generates smaller proof trees, but where the
// % MILP problems are more complex.
// % In contrast, \crown{} generates significantly larger proof trees,
// % but with less complex MILP problems.
// % This variation suggests potential avenues for future work, especially,
// % when proof checking is important.

// % For example, \neuralsat{} might include an option to generate larger proof trees, but with smaller MILP problems.  Such proofs would then
// % be amenable to higher-degrees of parallel solving and mitigate the
// % performance bottleneck presented by MILP solver implementations.
// % One might even consider strategies that use fast verification
// % options during development and then when all properties are proven, shift to slower verification options that are more amenable to proof checking.

// % \ignore{
// % 1. Longer verification time means proof tree will be larger since verifier has to explore larger space
// % 2. If an instance is verified by \crown{}, it will likely be proved by \proofcheck{}. In other words, most of timeout instances are due to \crown{} cannot verify (1st phase).

// % - MILP complexity:
// %     + neuralsat(S)(SX)  : mean=601.36, std=475.88, median=545.00, min=3, max=1944
// %     + neuralsat(SX)     : mean=492.40, std=448.81, median=342.00, min=2, max=1956
// %     + abcrown           : mean=414.35, std=447.02, median=179.00, min=0, max=1957
// %     + abcrown(babsr)    : mean=409.00, std=448.89, median=166.00, min=0, max=1952

// % They share the same MILP base model since their base models are all generated from SX setting.
// % neuralsat(S)(SX) has larger MILP complexity in average means that its proof trees are often shallower than others. In other words, neuralsat(S) explores smaller space than others -- which is true.

// % - number of sub proofs:
// %     + neuralsat(S)(SX): mean=95.11,   std=117.13, median=36.00,  min=0, max=829
// %     + neuralsat(SX)   : mean=142.00,  std=151.72, median=106.00, min=1, max=1132
// %     + abcrown         : mean=229.96,  std=199.23, median=180.00, min=0, max=1152
// %     + abcrown(babsr)  : mean=228.10,  std=170.88, median=188.00, min=0, max=857

// % - Number of leaves:
// %     + neuralsat(S)(SX): mean=236.59,   std=447.80,   median=37.50,  min=0, max=3627
// %     + neuralsat(SX)   : mean=902.25,   std=4957.22,  median=219.00, min=6, max=91318
// %     + abcrown         : mean=3007.42,  std=12742.09, median=561.00, min=0, max=138918
// %     + abcrown(babsr)  : mean=11714.62, std=41909.72, median=781.50, min=0, max=509765
// % }


// % \begin{tcolorbox}[left=1pt,right=1pt,top=1pt,bottom=1pt]
// % \textbf{RQ3 Findings}: \prooflang{} is robust to variation in different verification algorithms and \proofcheck{} is applicable to any such proof and effective in checking
// % the vast majority of those arising from the benchmarks.
// % \end{tcolorbox}

#pagebreak()
= Common Engineerings and Optimizations <chap:common-engineering>

In addition to adversarial attacks (@chap:adversarial-attacks), NNV tools often employ a range of optimizations and engineering techniques to improve performance. This chapter discusses some of those common techniques.

== Input Splitting <sec:input-splitting>

Many verifiers use a technique called _input splitting_ to quickly deal with networks with verification problems involving low-dimensional networks, such as those in the ACAS Xu benchmark where the networks have a small number of inputs (e.g., $<= 50$).
The idea is to split the original verification problem into subproblems, each checking whether the network produces the desired output from a smaller input region and returns #unsat if all subproblems are verified and #sat if a counterexample is found in any subproblem. Input splitting avoids BaB search (@chap:bab)---which performs _neuron splitting_---and is often used to quickly eliminate easy cases.

Moreover, each subproblem now has a smaller input region, thus the verifier can often verify them more quickly than the original problem.
Finally, because each task can be solved independently, the verifier can solve them in parallel to further speed up the verification process.

#example[
Given a problem with input region ${ x_1 in [-1,1] , x_2 in [-2,2] }$, input splitting splits the input region into four subregions:
${ x_1 in [-1,0] , x_2 in [-2,0] }$,
${ x_1 in [-1,0] , x_2 in [0,2] }$,
${ x_1 in [0,1] , x_2 in [-2,0] }$, and
${ x_1 in [0,1], x_2 in [0,2] }$.
The verifier then checks if the network produces the desired output from each of these subregions.

Note that the formula $-1 <= x_1 <= 1 and -2 <= x_2 <= 2$ representing the original input region is equivalent to the formula $(-1 <= x_1 <= 0 or 0 <= x <= 1) and (-2 <= x_2 <= 0 or 0 <= x_2 <= 2)$ representing the combination of the created subregions.
]


== Bounds Tightening <sec:boundstigthten>

=== Input Bounds Tightening <sec:inputboundstigthten>

When the verifier splits on a neuron (e.g., $hat(x)_i <= 0$ or $hat(x)_i > 0$),
it adds new linear constraints that further restrict the feasible input region.
As a result, the original input bounds (e.g., $-1 <= x_1 <= 1$) may no longer reflect the true range of values that satisfy all current constraints.
*Input Bound tightening* recomputes the smallest possible ranges for each input variable under these constraints.
These tighter input bounds propagate through the network and yield tighter neuron and output bounds, which in turn helps prune subproblems earlier.

#example[
Recall the network from @fig:dnn-b can be represented as:
$
  hat(x)_3 = -0.5x_1 + 0.5x_2 + 1.0 and \
  hat(x)_4 = 0.5x_1 - 0.5x_2 + 1.0 and \
  x_3 = relu(hat(x)_3) and \
  x_4 = relu(hat(x)_4) and \
  x_5 = -x_3 + x_4 - 1.0,
$
and input property $phi_"in"$: $-1 <= x_1 <= 1 and -2 <= x_2 <= 2$.

Suppose we make a split on $x_3$, which gives us two subproblems, represented by the constraints:
$-0.5x_1 + 0.5x_2 + 1.0 <= 0$
and
$-0.5x_1 + 0.5x_2 + 1.0 > 0$.
We can use the new constraint to tighten the input bounds of $x_1$ and $x_2$ for each subproblem.

For the first subproblem, we can create an optimization problem to tighten the bounds.
For example, to tighten the upper bounds of $x_1$, we can create an optimization problem as follows:
$
  "maximize" & x_1 quad "s.t." \
  & -0.5x_1 + 0.5x_2 + 1.0 <= 0 \
  & -1 <= x_1 <= 1 \
  & -2 <= x_2 <= 2
$

We can apply the same approach to tighten the lower bounds of $x_1$ using a minimization problem. Similarly, we can create optimization problems to tighten both the bounds of $x_2$.
] <ex:inputboundstigthten>

Note that this approach works well for networks with small inputs, e.g., the ACAS Xu benchmark with 5 inputs, and is adopted by many modern NNV tools, including #smallcaps[Marabou] and #smallcaps[nnenum].
For larger input dimensions networks, it will take much time as we need to run $2 times$ the number of inputs to tighten all the input bounds (for each input, we need to tighten the upper and lower bounds individually).

To reduce the time complexity, we can prioritize the input variables to tighten first, e.g., deciding the variable with the largest bounds first, and only tighten up to a maximum number of inputs, e.g., 10 inputs.

=== Neuron (Hidden) Bounds Tightening <sec:neuronboundstigthten>

Instead of tightening the input bounds, we can tighten the bounds of the hidden neurons.
There are a couple of advantages of tightening the bounds of the hidden neurons:
+ In some networks, numbers of hidden neurons are _fewer_ than the number of inputs, e.g., the MNISTFC 2x256 network has $28 times 28 = 784$ inputs and only 512 hidden neurons.
+ We don't necessarily tighten all hidden neurons, as some hidden neurons are already stable, i.e., their lower bounds are greater than 0 or their upper bounds are less than 0.
+ More importantly, if a hidden neuron is stabilized after tightening its bounds, e.g., its lower bound becomes greater than 0 or its upper bound becomes less than 0, we no longer need to branch on that particular neuron.

#example[
Let's revisit @ex:inputboundstigthten; after splitting $x_4$, we can tighten the upper bounds of $x_4$ (suppose that $l_{x_4} < 0 < u_{x_4}$, e.g., unstable and not split yet) by solving the following optimization problem:
$
  "maximize" & x_4 quad "s.t." \
  & 0.5x_1 - 0.5x_2 + 1.0 <= 0 \
  & -1 <= x_1 <= 1 \
  & -2 <= x_2 <= 2
$
If the optimization result yields a maximum value of $x_4$ less than 0, e.g., $u_{x_4} < 0$, we can conclude that $x_4$ is stabilized and no longer need to branch on $x_4$, thus reducing the number of branches made by the verifier.
There will be many tweaks to make the optimization problem more efficient, e.g., setting an early stopping condition: if the maximum value of $x_4$ is less than 0, we can stop the optimization. This is because, if the upper bound of $x_4$ is already less than 0, $x_4$ will be considered as _inactive_ no matter what the _optimal_ upper bound is.

Note that in both cases optimization problems are independent (between inputs/neurons and lower/upper bounds) and thus can be solved in parallel, e.g., optimizing both upper and lower bounds of $x_1$ (input) and $x_4$ (neuron) simultaneously.
] <ex:neuronboundstigthten>


== Batch Processing <sec:batchprocessing>

*Matrix Form for Interval Computation*

While the min/max formulation, e.g., for abstraction @sec:interval-abstraction, is intuitive, it can be efficiently implemented using matrix operations.
We can decompose the weight matrix $W$ into positive and negative components:
$
  W^+ = max(W, 0) quad quad W^- = min(W, 0)
$
where the max and min operations are applied element-wise.

Then the interval bounds can be computed as:
$
  f^a_L &= W^+ dot bold(l) + W^- dot bold(u) + bold(b) \
  f^a_U &= W^+ dot bold(u) + W^- dot bold(l) + bold(b)
$
where $bold(l) = [l_1, l_2, dots, l_n]^T$ and $bold(u) = [u_1, u_2, dots, u_n]^T$ are the vectors of lower and upper bounds.

#example[
We can verify that the matrix form produces identical results to the min/max approach using the same network from @ex:transformer-affine1.

Given the weight $w_1 = -0.5$, $w_2 = 0.5$, and bias $b = 1.0$, we decompose:
$W^+ = [max(-0.5, 0), max(0.5, 0)] = [0, 0.5]$
$W^- = [min(-0.5, 0), min(0.5, 0)] = [-0.5, 0]$

For inputs $x_1 in [1, 2]$ and $x_2 in [-1, 3]$, the lower vector $bold(l) = [1, -1]$ and the upper vector $bold(u) = [2, 3]$:
$
  f^a_L &= W^+ dot bold(l) + W^- dot bold(u) + b \
  &= [0, 0.5] dot [1, -1] + [-0.5, 0] dot [2, 3] + 1 \
  &= 0 dot 1 + 0.5 dot (-1) + (-0.5) dot 2 + 0 dot 3 + 1 \
  &= 0 - 0.5 - 1.0 + 0 + 1 = -0.5
$

$
  f^a_U &= W^+ dot bold(u) + W^- dot bold(l) + b \
  &= [0, 0.5] dot [2, 3] + [-0.5, 0] dot [1, -1] + 1 \
  &= 0 dot 2 + 0.5 dot 3 + (-0.5) dot 1 + 0 dot (-1) + 1 \
  &= 0 + 1.5 - 0.5 + 0 + 1 = 2.0
$

This gives us $f^a([1,2],[-1,3]) = [-0.5, 2.0]$, which matches exactly the result from the min/max approach in @ex:transformer-affine1.
] <ex:matrix-form-equivalence>

The matrix formulation of interval arithmetic is equivalent to the min/max approach but enables efficient batch processing of multiple input regions simultaneously.
This is particularly useful when splitting input regions into multiple subproblems and computing abstraction in parallel.

Consider an input region that needs to be split for improving abstraction precision.
For example, we can split the input region ${ x_1 in [-1,1], x_2 in [-2,2] }$ along the first dimension into two subproblems:
+ Subproblem 1: ${ x_1 in [-1,0], x_2 in [-2,2] }$
+ Subproblem 2: ${ x_1 in [0,1], x_2 in [-2,2] }$

Using the matrix form in @ex:matrix-form-equivalence, we can process both subproblems simultaneously by stacking the bounds into matrices:
$
  bold(L) = mat(-1, -2; 0, -2), quad
  bold(U) = mat(0, 2; 1, 2)
$
where each row represents the lower and upper bounds for one subproblem.

Next, for a linear layer with weight matrix $W$ and bias vector $bold(b)$, we can compute the bounds for all subproblems simultaneously:
$
  bold(O)_L &= bold(L) dot (W^+)^T + bold(U) dot (W^-)^T + bold(b) \
  bold(O)_U &= bold(U) dot (W^+)^T + bold(L) dot (W^-)^T + bold(b)
$

#example[
Consider the network from @ex:transformer-affine1 with weight $W = [-0.5, 0.5]$ and bias $b = 1.0$. We split the input region ${ x_1 in [-1,1], x_2 in [-2,2] }$ into two subproblems as described above.

First, we decompose the weight:
$W^+ = [0, 0.5] quad quad W^- = [-0.5, 0] quad quad bold(b) = [1.0, 1.0]$
The bias vector is the same for both subproblems, thus just duplicate it for each subproblem.
Then we compute bounds for both subproblems:
$
  bold(L) dot (W^+)^T = mat(-1, -2; 0, -2) mat(0; 0.5) = mat(-1.0; -1.0)
$

$
  bold(U) dot (W^-)^T = mat(0, 2; 1, 2) mat(-0.5; 0) = mat(0.0; -0.5)
$

$
  bold(O)_L = mat(-1.0; -1.0) + mat(0.0; -0.5) + mat(1.0; 1.0) = mat(0.0; -0.5)
$

Similarly for upper bounds:
$
  bold(U) dot (W^+)^T = mat(0, 2; 1, 2) mat(0; 0.5) = mat(1.0; 1.0)
$

$
  bold(L) dot (W^-)^T = mat(-1, -2; 0, -2) mat(-0.5; 0) = mat(0.5; 0.0)
$

$
  bold(O)_U = mat(1.0; 1.0) + mat(0.5; 0.0) + mat(1.0; 1.0) = mat(2.5; 2.0)
$

Therefore:
- Subproblem 1: $x_3 in [0.0, 2.5]$
- Subproblem 2: $x_3 in [-0.5, 2.0]$

We can verify these results by computing each subproblem individually using the original formulation, which yields identical results.
] <ex:batch-processing>


== GPU Processing <sec:gpu>

By using matrix operations, we can leverage GPUs natively to speed up the computation.
As expected, the computation time is reduced significantly using GPUs when the size of matrices (weights, bias, inputs, etc.) becomes larger @fig:gpu-benchmarking.

#figure(
  image("figure/gpu-benchmarking.png", width: 70%),
  caption: [GPU Benchmarking Results.],
) <fig:gpu-benchmarking>

```python
import torch

# weights and bias
W = torch.tensor([[0, 0.5], [-0.5, 0]]).cuda()
b = torch.tensor([1.0, 1.0]).cuda()

# input bounds
L = torch.tensor([[-1, -2], [0, -2]]).cuda()
U = torch.tensor([[0, 2], [1, 2]]).cuda()

# decompose weights
W_plus = W.clamp(min=0)
W_minus = W.clamp(max=0)

# compute bounds
O_L = L @ W_plus.T + U @ W_minus.T + b
O_U = U @ W_plus.T + L @ W_minus.T + b
```

#pagebreak()
= The #tool Algorithm <chap:neuralsat>

#tool @duong2025neuralsat @duong2024harnessing is a relatively new competitor in NNV, but it has quickly become a strong contender, consistently placed among the top tools at NNV competitions (@chap:vnncomps).

At its core, #tool is #bab, but follows a DPLL(T) framework @davis1962machine and includes specialized optimizations and heuristics to improve its search.
Thus, #tool is essentially an SMT solver (@sec:smt-solvers) with respect to a theory, in this case, the theory of DNNs.


== Overview <sec:neuralsat:overview>

// TODO: <fig:overview> NeuralSAT architecture figure (DPLL components + theory solver) — not yet added
#figure(caption: [_TODO: NeuralSAT overview figure not yet added_])[_placeholder_] <fig:overview>

@fig:overview gives an overview of #tool, which consists of standard DPLL components (light shades) and the theory solver (dark shade).
#tool first constructs a propositional formula over Boolean variables that represent the activation status of neurons (_Boolean Abstraction_). Clauses in the formula assert that each neuron, e.g., neuron $i$, is active or inactive, e.g., $v_i or overline(v_i)$.
This representation enables using standard DPLL to search for truth values satisfying these clauses and a neural network-specific theory solver to check the feasibility of truth assignments---_activation patterns_ (@sec:activation-patterns)---with respect to the constraints encoding the network and the property of interest.

#tool now enters an iterative process to find activation pattern (truth assignment) satisfying the activation clauses.
First, #tool assigns a truth value to an unassigned variable (_Decide_), detects unit clauses caused by this assignment, and infers additional assignments (_Boolean Constraint Propagation_).
Next, #tool invokes the theory solver or T-solver (_Deduction_), which uses LP solving and abstraction to check the feasibility of the constraints of the current assignment with the property of interest.

If the T-solver confirms feasibility, #tool continues with new assignments (_Decide_). Otherwise, #tool detects a conflict (_Analyze Conflict_) and learns clauses to remember it and backtrack to a previous decision (_Backtrack_).
If #tool detects local optima, it would restart (_Restart_) the search by clearing all decisions that have been made, but save the conflict clauses learned so far to avoid reaching the same state in the next runs.
Restarting especially benefits challenging NNV problems by enabling better clause learning and exploring different decision orderings.

This iterative process repeats until #tool can no longer backtrack, and returns #unsat, indicating the network has the property, or it finds a total assignment for all boolean variables, and returns #sat.

== Illustration <sec:neuralsat:illustration>

We use #tool to prove that for inputs $x_1 in [-1, 1], x_2 in [-2,2]$ the network in @fig:dnn produces the output $x_5 <= 0$.
#tool takes as input the formula $alpha$ representing the network:

$
  x_3 &= op("ReLU")(-0.5x_1 + 0.5x_2 + 1) quad and \
  x_4 &= op("ReLU")(x_1 + x_2 - 1) quad and \
  x_5 &= -x_3 + x_4 - 1.0
$

and the formula $phi$ representing the property:

$ phi : -1 <= x_1 <= 1 and -2 <= x_2 <= 2 quad => quad x_5 <= 0. $ <eq:valid_prop>

To prove $alpha => phi$, #tool needs to show that _no_ values of $x_1, x_2$ satisfying the input properties would result in $x_5 > 0$. In other words, #tool needs to return `unsat` for:

$ alpha and -1 <= x_1 <= 1 and -2 <= x_2 <= 2 and x_5 > 0. $ <eq:negprop>

*Notation:* In the following, we write $x |-> v$ to denote that the variable $x$ is assigned with a truth value $v in {T, F}$. This assignment can be either decided by `Decide` or inferred by `BCP`. We also write $x@d l$ and $overline(x)@d l$ to indicate the respective assignments $x |-> T$ and $x |-> F$ at decision level $d l$.

#paragraph[Boolean Abstraction][First, #tool creates two Boolean variables $v_3$ and $v_4$ to represent the activation status of the hidden neurons $x_3$ and $x_4$, respectively. For example, $v_3 = T$ means $x_3$ is `active` and thus gives the constraint $-0.5x_1 + 0.5x_2 + 1 > 0$. Similarly, $v_3 = F$ means $x_3$ is `inactive` and therefore gives $-0.5x_1 + 0.5x_2 + 1 <= 0$. Next, #tool forms two clauses ${v_3 or overline(v_3) ; v_4 or overline(v_4)}$ ensuring that these variables are either `active` or `inactive`.]

#paragraph[DPLL(T) Iterations][#tool searches for a satisfying _activation pattern_---truth assignment for the Boolean variables to satisfy the clauses and the constraints they represent with respect to the formula in @eq:negprop.
For this example, #tool uses four iterations, summarized in @tab:valid, to determine that no such assignment exists and the problem is thus #unsat.

#figure(
  caption: [#tool's run producing #unsat. The notation $x@d l$ and $overline(x)@d l$ mean the assignments $x |-> T$ and $x |-> F$ at decision level $d l$, respectively.],
  table(
    columns: 7,
    align: center,
    table.header(
      [Iter], [*BCP*], table.cell(colspan: 2)[*Deduction*], [*Decide*], table.cell(colspan: 2)[*Analyze Conflict*],
      [], [], [Constraints], [Bounds], [], [Bt], [Learned Clauses],
    ),
    [Init], [-], [$I = -1 <= x_1 <= 1;$ \ $-2 <= x_2 <= 2$], [$-1 <= x_1 <= 1;$ \ $-2 <= x_2 <= 2$], [-], [-], [$C = {v_3 or overline(v_3); v_4 or overline(v_4)}$],
    [1], [-], [$I$], [$x_5 <= 1$], [$overline(v_4)@1$], [-], [-],
    [2], [-], [$I; x_4 = $ `off`], [$x_5 <= -1$], [-], [0], [$C = C union {v_4}$],
    [3], [$v_4@0$], [$I; x_4 = $ `on`], [$x_3 >= 0.5; x_5 <= 0.5$], [$v_3@0$], [-], [-],
    [4], [-], [$I; x_3 = $ `on`$; x_4 = $ `on`], [-], [-], [*-1*], [$C = C union {overline(v_4)}$],
  )
) <tab:valid>

In _iteration 1_, as shown in @fig:overview, #tool starts with `BCP`, which has no effects because the current clauses and (empty) assignment produce no unit clauses.
In `Deduction`, #tool uses an LP solver to determine that the current set of constraints, which contains just the initial input bounds, is feasible#footnote[We use the terms feasible, from the LP community, and satisfiable, from the SAT community, interchangeably.]. #tool then uses abstraction to approximate an output upper bound $x_5 <= 1$ and thus deduces that satisfying the output $x_5 > 0$ might be feasible. #tool continues with `Decide`, which uses a heuristic to select the unassigned variable $v_4$ and sets $v_4 = F$---essentially a _guess_ that neuron $x_4$ is inactive. #tool increments the decision level ($d l$) to 1 and associates $d l = 1$ to the assignment, i.e., $overline(v_4)@1$.

In _iteration 2_, `BCP` again has no effect because it does not detect any unit clauses. In `Deduction`, #tool determines that the current set of constraints, which contains $x_1 + x_2 - 1 <= 0$ due to the assignment $v_4 |-> F$ (i.e., $x_4 = $ `off`), is feasible. #tool then approximates a new output upper bound $x_5 <= -1$, which means satisfying the output $x_5 > 0$ constraint is _infeasible_.

#tool now enters `AnalyzeConflict` and determines that $v_4$ causes the conflict ($v_4$ is the only variable assigned so far). From the assignment $overline(v_4)@1$, #tool learns a "backjumping" clause $v_4$, i.e., $v_4$ must be $T$. #tool now backtracks to $d l$ $0$ and erases all assignments decided _after_ this level. Thus, $v_4$ is now unassigned and the constraint $x_1 + x_2 - 1 <= 0$ is also removed.

In _iteration 3_, `BCP` determines that the learned clause is also a unit clause $v_4$ and infers $v_4@0$. In `Deduction`, we now have the new constraint $x_1 + x_2 - 1 > 0$ due to $v_4 |-> T$ (i.e., $x_4 = $ `on`). With the new constraint, #tool approximates the output upper bound $x_5 <= 0.5$, which means $x_5 > 0$ might be satisfiable.
Also, #tool computes new bounds $0.5 <= x_3 <= 2.5$ and $0 < x_4 <= 2.0$, and deduces that $x_3$ must be positive because its lower bound is 0.5.
Thus, #tool has a new assignment $v_3@0$ ($d l$ stays unchanged due to the implication).
This new assignment inference from the T-solver is known as _theory propagation_ in DPLL(T).

In _iteration 4_, `BCP` has no effects because we have no new unit clauses. In `Deduction`, #tool determines that the current set of constraints, which contains the new constraint $-0.5x_1 + 0.5x_2 + 1 > 0$ (due to $v_3 |-> T$), is _infeasible_. Thus, #tool enters `AnalyzeConflict` and determines that $v_4$, which was set at $d l = 0$ (by `BCP` in iteration 3), causes the conflict.
#tool then learns a clause $overline(v_4)$ (the conflict occurs due to the assignment ${v_3 |-> T; v_4 |-> T}$, but $v_3$ was implied and thus making $v_4$ the conflict).
However, because $v_4$ was assigned at decision level 0, #tool can no longer backtrack and thus sets $d l = -1$ and returns #unsat, i.e., the property is valid.]


== #tool vs. #bab <sec:restart-tree>

// TODO: <fig:tree>, <fig:treea>, <fig:treeb> — NeuralSAT vs BaB search tree comparison figures, not yet added
#figure(caption: [_TODO: NeuralSAT vs BaB combined search tree figure not yet added_])[_placeholder_] <fig:tree>
#figure(caption: [_TODO: NeuralSAT search tree (smaller space) not yet added_])[_placeholder_] <fig:treea>
#figure(caption: [_TODO: BaB search tree (larger space) not yet added_])[_placeholder_] <fig:treeb>

Note that this process of selecting and assigning (guessing) values to variables representing neurons is the _branching_ phase in #bab. It is also commonly called _neuron splitting_ because it splits the search tree into subtrees corresponding to the assigned values (e.g., see @sec:restart-tree).

As mentioned in @sec:complexity, ReLU-based NNV is NP-complete, and for difficult problem instances NNV tools often have to exhaustively search a very large space, making scalability a main concern for modern NNV approaches.

@fig:tree shows the difference between #tool and another NNV tool (e.g., using the popular Branch-and-Bound (#bab) approach) in how they navigate the search space. We assume both tools employ similar abstraction and neuron splitting.
@fig:treeb shows that the other tool performs splitting to explore different parts of the tree (e.g., splitting $v_1$ and explore the branches with $v_1 = T$ and $v_1 = F$ and so on). Note that the other tool needs to consider the tree shown regardless if it runs sequentially or in parallel.

In contrast, #tool has a smaller search space shown in @fig:treea.
#tool follows the path $v_1$, $v_2$ and then $overline(v_2)$ (just like the tool on the right).
However, because of the learned clause $v_2 or v_3$, #tool performs a BCP step that sets $v_3$ (and therefore prunes the branch with $overline(v_3)$ that needs to be considered in the other tree).
Then #tool splits $v_4$, and like the other tool, determines infeasibility for both branches. Now #tool's conflict analysis determines from learned clauses that it needs to backtrack to $v_3$ (yellow node) instead of $v_1$. Without learned clauses and non-chronological backtracking, #tool would backtrack to decision $v_1$ and continues with the $overline(v_1)$ branch, just like the other tool in @fig:treeb.

Thus, #tool was able to generate non-chronological backtracks and use BCP to prune various parts of the search tree. In contrast, the other tool would have to move through the exponential search space to eventually reach the same result.


#pagebreak()
= The #smallcaps[Reluplex] Algorithm <chap:reluplex>

#smallcaps[Reluplex] @katz2017reluplex is a classical BaB (@chap:bab) approach for NNV. The technique extends the _simplex_ method @nelder1965simplex to support the ReLU activation function (*Reluplex* = *Relu* + Sim#strong[plex]). #smallcaps[Reluplex] has been succeeded by the more efficient #smallcaps[Marabou] tool @katz2019marabou. However, the core ideas of #smallcaps[Reluplex] are still relevant and thus presented here as another example of \#bab-based NNV techniques.

== Algorithm Overview <sec:reluplex-overview>


#smallcaps[Reluplex] extends the classical simplex method to handle the
non-linear ReLU constraints $hat(x) = max(x, 0)$.
Like simplex, #smallcaps[Reluplex] maintains a set of _basic_ variables whose values are determined by other (non-basic) variables, and updates them through pivot operations.

*Initialization* The constraints representing the network are first rewritten into a basic form by introducing basic or _slack_ variables. #smallcaps[Reluplex] also forms the lower and upper bounds for each variable based the input constraints and semantics ReLU, e.g., for a ReLU variable $hat(x)_i$, the lower bound is 0.

All variable values are then initially set to some guess, such as $0$, even if these values violate bounds. This initial configuration acts as the starting point for #smallcaps[Reluplex] to iteratively refine the variable values to satisfy all constraints.

*Fixing bound violations* #smallcaps[Reluplex] repeatedly checks all variables to see if any violate their bounds.
If a non-basic variable violates its bounds, it can be directly updated to a valid value; the update is then propagated into the basic variables using the defining linear equations.
If a basic variable violates its bounds, #smallcaps[Reluplex] cannot adjust it directly; instead it performs a _pivot_, swapping that basic variable with one of the non-basic variables appearing in its defining equation.
After pivoting, the out-of-bounds variable becomes non-basic and can then be directly fixed.

*Handling ReLU violations* When all variable bounds are satisfied, #smallcaps[Reluplex] next checks the ReLU relations $hat(x)_i = max(x_i, 0)$.
If a pair $(x_i, hat(x)_i)$ is inconsistent (e.g., $x_i > 0$ but $hat(x)_i = 0$), then the algorithm repairs it in the same way: if the violated variable is non-basic, it is simply updated; if it is basic, a pivot is performed so it can be updated.

*Termination* If no variable violates bounds or ReLU relations, the current configuration is a feasible assignment that satisfies all constraints, and #smallcaps[Reluplex] returns #sat.
If #smallcaps[Reluplex] explores all possible pivoting options without finding any feasible configuration, it concludes #unsat.


== Illustration <ex:reluplex>


#figure(
    [#mydnn(sc:100%)],
    caption: [A simple network (similar to @fig:dnn).],
  ) <fig:dnn-replux>

We demonstrate #smallcaps[Reluplex] using the network in @fig:dnn-replux. This network has inputs $x_1, x_2$, two hidden neurons $x_3, x_4$ with ReLU activations, and one output $x_5$. It can be represented by the following equations:

$
x_3 = x_1 - x_2, quad hat(x)_3 = max(x_3, 0), \
x_4 = x_1 + x_2, quad hat(x)_4 = max(x_4, 0), \
x_5 = 0.5 hat(x)_3 - 0.2 hat(x)_4
$

We want to check that the network has the property

$ (0 <= x_1 <= 0.5 and -2 <= x_2 <= -1) => (x_5 < 0 or x_5 > 0.5). $ <eq:prop1>

That is, when the inputs $x_1, x_2$ fall within certain ranges, then the result $x_5$ has certain values.
As shown in @sec:satisfiability-and-activation-pattern-search, we turn this into a satisfiability problem by negating the property:

$ (0 <= x_1 <= 0.5 and -2 <= x_2 <= -1) and 0 <= x_5 <= 0.5, $ <eq:negprop1>

and checking whether there exists a counterexample satisfying the negated property.

We now use #smallcaps[Reluplex] to check whether there exists an assignment satisfying the negated property in @eq:negprop1.
We start by introducing three _basic_ (auxilliary or slack) variables to represent the relationships between the variables in the network:

$a_1 = x_1 - x_2 - x_3$ <eq:reluplex2a>

$a_2 = x_1 + x_2 - x_4$ <eq:reluplex2b>

$a_3 = 0.5 hat(x)_3 - 0.2 hat(x)_4 - x_5$ <eq:reluplex2c>

These basic variables are used to maintain the relationships between the variables in the constraints and are updated during the search process.
In contrast, a _non-basic_ variable is one that does not represent the relationship between other variables in the constraints. In this example, all variables except $a_1, a_2, a_3$ are non-basic.

#smallcaps[Reluplex] first assigns 0 to all variables in the equations in @eq:reluplex2a -- @eq:reluplex2c. This will likely violate some bounds, which #smallcaps[Reluplex] uses an iterative process, represented by a sequence of _configurations_, to refine.

@tab:reluplex1 shows the initial configuration with all values assigned to 0.
The lower (LB) and upper (UB) bounds of the inputs $x_1, x_2$ and output $x_5$ are specified in @eq:negprop1. The LBs of $hat(x)_i$'s representing ReLUs are 0s, and the other hidden variables are unbounded (i.e., $-infinity$ to $infinity$).

#figure(caption: [Configuration \#1],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [*0*], [0], [0], [0], [0], [0], [0], [0], [0],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex1>

@tab:reluplex1 also shows that $x_2$ is out-of-bounds because $0 in.not [-2,-1]$. To fix $x_2$, which is non-basic, #smallcaps[Reluplex] updates it to a valid value, e.g., $x_2 += -1.0 = -1.0$ by adding $-1.0$ to the current value of $x_2$.

Now, because $a_1 = x_1 - x_2 - x_3$ and $a_2 = x_1 + x_2 - x_4$ depend on $x_2$ as shown in @eq:reluplex2a and @eq:reluplex2b, this update to $x_2$ also changes $a_1, a_2$:

$
a_1 += 1.0 = 1.0, \
a_2 += -1.0 = -1.0.
$

#figure(caption: [Configuration \#2],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [*-1*], [0], [0], [0], [0], [0], [*1*], [*-1*], [0],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex2>

@tab:reluplex2 shows the new configuration, which now has $a_1, a_2$ violating their bounds and need to be fixed. Assume #smallcaps[Reluplex] picks $a_1$. To fix the basic variable $a_1$, #smallcaps[Reluplex] pivots (swaps) it with a variable it depends on from the constraint $a_1 = x_1 - x_2 - x_3$ in @eq:reluplex2a. Assume #smallcaps[Reluplex] pivots $a_1$ with $x_3$, we get

$ x_3 = x_1 - x_2 - a_1. $ <eq:reluplex5>

#smallcaps[Reluplex] now updates the non-basic $a_1$ to 0 ($a_1 += -1.0 = 0$). This also changes $x_3$ to 1.0 ($x_3 += 1.0 = 1.0$) because $x_3$ depends on $a_1$ as shown in @eq:reluplex5.

#figure(caption: [Configuration \#3],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [-1], [*1*], [0], [0], [0], [0], [*0*], [-1], [0],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex3>

@tab:reluplex3 shows the new configuration, which now has the basic variable $a_2$ out-of-bound. To fix it, #smallcaps[Reluplex] pivots $a_2$ with a variable it depends on from the constraint $a_2 = x_1 + x_2 - x_4$ in @eq:reluplex2b. Assume #smallcaps[Reluplex] pivots $a_2$ with $x_4$, we get

$ x_4 = x_1 + x_2 - a_2. $ <eq:reluplex6>

Now $a_2$ becomes non-basic and is updated to 0 through $a_2 += 1.0 = 0$. As $x_4$ depends on $a_2$ as shown in @eq:reluplex6, we make the change $x_4 -= 1.0 = -1.0$.

#figure(caption: [Configuration \#4],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [-1], [1], [0], [*-1*], [0], [0], [0], [*0*], [0],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex4>

@tab:reluplex4 shows the new configuration.
At this point, we no longer have out-of-bound variables, but have inconsistent values for the pair of ReLU variables $x_3, hat(x)_3$. This is because $hat(x)_3 = max(x_3, 0)$ but we have $x_3 = 1$ thus $max(1, 0) = 1$, which is not $hat(x)_3 = 0$. Thus, #smallcaps[Reluplex] needs to fix either $hat(x)_3$ or $x_3$.

Assume #smallcaps[Reluplex] picks $hat(x)_3$. Because $hat(x)_3$ is non-basic, we simply update it, i.e., $hat(x)_3 += 1 = 1$. As $a_3$ depends on $hat(x)_3$, i.e., $a_3 = 0.5 hat(x)_3 - 0.2 hat(x)_4 - x_5$, #smallcaps[Reluplex] also makes the change $a_3 += 0.5 times 1.0 = 0.5$.

#figure(caption: [Configuration \#5],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [-1], [1], [*1*], [-1], [0], [0], [0], [0], [*0.5*],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex5>

@tab:reluplex5 shows the new configuration.
In the new configuration, $a_3$ is out-of-bound. To fix this basic variable, we pivot $a_3$ with one of the variables $hat(x)_3, hat(x)_4, x_5$ because of the constraint $a_3 = 0.5 hat(x)_3 - 0.2 hat(x)_4 - x_5$ in @eq:reluplex2c. Assume we pivot $a_3$ with $x_5$, we get

$ x_5 = 0.5 hat(x)_3 - 0.2 hat(x)_4 - a_3. $ <eq:reluplex7>

Now, $a_3$ becomes non-basic and we update it to 0 through $a_3 += -0.5 = 0$. As $x_5$ depends on $a_3$ as shown in @eq:reluplex7, we make the change $x_5 += 0.5 = 0.5$.

#figure(caption: [Configuration \#6],
  text(size: 0.85em,
  table(
    columns: 11,
    align: center, stroke: none,
    [], [$x_1$], [$x_2$], [$x_3$], [$hat(x)_3$], [$x_4$], [$hat(x)_4$], [$x_5$], [$a_1$], [$a_2$], [$a_3$],
    table.hline(),
    [LB], [0], [-2], [$-infinity$], [0], [$-infinity$], [0], [0], [0], [0], [0],
    [Val], [0], [-1], [1], [*1*], [-1], [0], [*0.5*], [0], [0], [*0*],
    [UB], [0.5], [-1], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [0.5], [0], [0], [0],
  ))
) <tab:reluplex6>

@tab:reluplex6 shows the new configuration.
At this point, #smallcaps[Reluplex] no longer sees any out-of-bound or inconsistent values, and thus stops and returns #sat with the values in the *Val* row in @tab:reluplex6 as the satisfying assignment for the formula in @eq:negprop1.

Thus, the property in @eq:prop1 is _not valid_ for the network in @fig:dnn-replux because for inputs $x_1 = 0, x_2 = -1$, the network gives the output $x_5 = 0.5$, violating the property.


#problem[#smallcaps[Reluplex] by Hand][
Read the example in @ex:reluplex again carefully. Then:
- Rewrite the steps in @ex:reluplex on paper, showing all the calculations for each step. The goal of handwriting the steps is to help you understand how #smallcaps[Reluplex] works in detail.
- Provide feedback on this example. Is it clear? Are there any steps or terminologies that are confusing? How can we improve the explanation?
] <problem:reluplex-hand>


#problem[Basic vs. Non-Basic Variables][
Consider the description of #smallcaps[Reluplex] in @sec:reluplex-overview and the example in @ex:reluplex.

+ Explain the difference between a _basic_ and a _non-basic_ variable in #smallcaps[Reluplex].
+ Why can #smallcaps[Reluplex] update a non-basic variable directly, but must perform a pivot before updating a basic variable? Use an example if necessary.
+ Explain why #smallcaps[Reluplex] must _still_ consider ReLU violations after all bound violations have been fixed. Why is all variables (excluding ReLU ones) within bounds not sufficient? Use an example if necessary.
] <problem:reluplex-basic-nonbasic>

#pagebreak()


#counter(heading).update(0)

#set heading(
  numbering: "A.1",
  supplement: "Advanced Topics",
)



// % = DNN Verification Benchmarks <chap:benchmarks}
// % Here we survey the latest benchmarks in DNN verification and how SOTA tools perform on them.  These results are taken from the Verification Neural Network Competitions (VNN-COMP)~\cite{brix2024fifth} and the recent work by Duong et al.~\cite{duong2024harnessing}.


// %  == VNN-COMP Benchmarks}

// % %Artifacts for all benchmarks are available in the repository\footnote{\url{https://github.com/ChristopherBrix/vnncomp2024_benchmarks/tree/main/benchmarks}}.

// % \tvn{check this table with VNN-COMP'24 reports. The Report seems to have a lot more benchmarks for regular tracks. Also many numbers don't quite match. We should probably use the benchmarks from VNN-COMP'24 report. I also ? on place for you to fill in}

// % \begin{table}
// %     \caption{Benchmark instances. U: \texttt{unsat}, S: \texttt{sat}, ?: \texttt{unknown}. <tab:benchmarks}
// %     \resizebox{\textwidth}{!}{
// %     \begin{tabular}{c|ccccc|cc}
// %         \toprule
// %         \multirow{2}{*}{\textbf{Benchmarks}} &\multicolumn{2}{c}{\textbf{Networks}} &  \multicolumn{3}{c|}{\textbf{Per Network}} &\multicolumn{2}{c}{\textbf{Tasks}} \\
// %         & Type & Networks & Neurons & Parameters & Input Dim & Properties & Instances (U/S/?) \\
// %         \midrule
// %       cGan &  Conv. + Vision Trans. & & & 500K--68M & 5 &  &  \\
// %       NN4Sys & ReLU + Sigmoid       & & & 33k--37M & 1--308 & & \\
// %       LinearizeNN & FC. + Conv. + & && 203k & 4 && \\
// %       &Vision Trans. + Res. + ReLU &&&&&&\\
// %       \midrule
// %       Collins RUL CNN & Conv. + ReLU, Dropout  &&& 60k--262k  & 400--800 &&\\
// %       cifar100 &FC + Conv. + Res., & &&2.5M--3.8M & 3072 & &\\
// %                                              &ReLU + BatchNorm &&&&&&\\
// %       tinyimagenet &FC + Conv. + Res., &&& 3.6M & 9408 & &\\
// %       & ReLU + BatchNorm &&&&&&\\
// %       Metaroom & Conv. + FC, ReLU &&& 466k--7.4M & 5376 & &\\

// %       \midrule

// %       TLL Verify Bench & Two-Level Lattice NN (FC. + ReLU)  &&& 17k--67M & 2 &&\\
// %       Acas XU & FC. + ReLU &45&300& 13k & 5 &10&139/47/0\\
// %       %ACAS Xu & FNN & 45 & 300 & 13305 & 5 & 10 & 139/47/0 \\
// %       Dist Shift & FC. + ReLU + Sigmoid &&& 342k -- 855k & 792 &&\\
// %       safeNLP & FC. + ReLU &&& 4k & 30 &&\\
// %       CORA & FC. + ReLU &&& 575k, 1.1M & 784, 3072 &&\\


// %         % MNISTFC & FNN & 3 &  0.5--1.5K & 269--532K & & 30 & 56/23/11\\

// %         % %CIFAR2020 & FNN+CNN & 3 &  17--62K & 2.1--2.5M && 203 & 149/43/11 \\
// %         % \midrule

// %         % RESNET\_A/B & CNN+ResNet & 2 & 11K & 354K & & 144 & 49/23/72 \\
// %         % \midrule

// %         % CIFAR\_GDVB & FNN+CNN & 42 & 9--49K & 0.08--58M && 39 & 60/0/0 \\
// %         % \midrule
// %         % \midrule
// %         % VGGNet16 & CNN + ReLU + MaxPool& ? & ? & 138M & 150K & ? & ? \\
// %         \bottomrule
// %         \end{tabular}
// %     }
// % \end{table}



// % \subsection{ACAS Xu <sec:acasxu}
// % \paragraph{Networks} The ACASXu benchmark consists of 10 properties defined over 45 neural networks used to issue turn advisories to aircraft to avoid collisions. The neural networks have 300 neurons arranged in 6 layers, with ReLU activation functions. There are 5 inputs corresponding to the aircraft states, and 5 network outputs, where the minimum output is used as the turn advisory the system ultimately produces.

// % \paragraph{Specifications} VNN-COMP uses the original 10 properties~\cite{katz2017reluplex}, where properties 1--4 are checked on all 45 networks as was done in later work by the original authors~\cite{katz2019marabou}. Properties 5--10 are checked on a single network. The total number of benchmarks is therefore 186.\tvn{does not match table}


// % \subsection{Cifar2020}

// % \paragraph*{Motivation} This benchmark combines two convolutional CIFAR10 networks from last year's VNN-COMP 2020 with a new, larger network with the goal to evaluate the progress made by the whole field of Neural Network verification.

// % \paragraph*{Networks} The two ReLU networks \texttt{cifar\_10\_2\_255} and \texttt{cifar\_10\_8\_255} with two convolutional and two fully-connected layers were trained for $\ell_ in fty$ perturbations of $\epsilon = \frac{2}{255}$ and $\frac{8}{255}$, respectively, using COLT \cite{balunovic:20}  and the larger \texttt{ConvBig} with four convolutional and three fully-connected networks, was trained using adversarial training \cite{madry:17} and $\epsilon = \frac{2}{255}$.

// % \paragraph*{Specifications} We draw the first 100 images from the CIFAR10 test set and for every network reject incorrectly classified ones. For the remaining images, the specifications describe a correct classification under an $\ell_ in fty$-norm perturbation of at most $\frac{2}{255}$ and $\frac{8}{255}$ for \texttt{cifar\_10\_2\_255} and \texttt{ConvBig} and \texttt{cifar\_10\_8\_255}, respectively and allow a per sample timeout of 5 minutes.


// % \subsection{VGGNET16}
// % \paragraph*{Proposed by} Stanley Bak, Stony Brook University

// % \paragraph*{Motivation} This benchmark tries to scale up the size of networks being analyzed by using the well-studied VGGNET-16 architecture~\cite{simonyan2014very} that runs on ImageNet. Input-output properties are proposed on pixel-level perturbations that can lead to image misclassification.

// % \paragraph*{Networks} All properties are run on the same network, which includes 138 million parameters. The network features convolution layers, ReLU activation functions, as well as max pooling layers.

// % \paragraph*{Specifications} Properties analyzed ranged from single-pixel perturbations to perturbations on all 150528 pixles (L-infinity perturbations). A subset of the images was used to create the specifications, one from each category, which was randomly chosen to attack. Pixels to perturb were also randomly selected according to a random seed.

// % \paragraph*{Link} \url{https://github.com/stanleybak/vggnet16_benchmark2022/}





// % % \begin{table}[h]
// % %     \centering
// % %     \caption{Overview of all scored benchmarks. <tab:my_label}
// % %     \resizebox{\textwidth}{!}{
// % %     \renewcommand{\arraystretch}{1.4}
// % %     \begin{tabular}{ccccccc}
// % %     \toprule
// % %     Category &
// % %     Benchmark &
// % %     Application &
// % %     Network Types &
// % %     \# Params &
// % %     Effective Input Dim &
// % %     Track
// % %     \\
// % %     \midrule
// % %     \multirow{8}{*}{Complex}
// % %     %& Carvana UNet  & Image Segmentation & Complex UNet              & 275k - 373k & 4.3k \\
// % %     & cGAN & \makecell{Image Generation \\ \& Image Prediction} & Conv. + Vision Transformer & 500k - 68M & 5 & regular \\
// % %     & NN4Sys & \makecell{Dataset Indexing \\ \&  Cardinality Prediction}   & ReLU + Sigmoid & 33k - 37M & 1-308 & regular \\
// % %     %& ml4acopf & Power System & Complex (ReLU + Trigonometric + Sigmoid) & 4k-680k & 22 - 402 & extended \\
// % %     %& ViT & Vision & Conv. + Residual + Softmax + BatchNorm & 68k - 76k & 3072 & extended \\
// % %     %& Collins Aerospace & - & FC + Conv. + Residual, LeakyReLU + MaxPool + Square & 1.8M & 1.2M & extended \\
// % %     %& LSNC & Lyapunov stability of NN controllers & FC + Residual, ReLU + Sin + Cos & 210, 406 & 8 & extended \\
// % %     %& CCTSDB & - & FC + Conv. + Residual, ReLU +  MaxPool + Clip & 100k & 2 & extended \\
// % %     %\cmidrule(lr){1-7}
// % %     %\multirow{7}{*}{\makecell{CNN \\ \& ResNet}}
// % %     % & Cifar Bias Field      & Image Classification & Conv. + ReLU  & 45k   & 16 \\

// % %     % & Large ResNets         & Image Classification & ResNet (Conv. + ReLU)  & 55k - 286k   & 3.1k - 12k \\
// % %     % & Oval21 & Image Classification & Conv. + ReLU  & 3.1k - 6.2k   & 3.1k \\
// % %     % & SRI ResNet A/B & Image Classification  & ResNet (Conv. + ReLU)  & 11k   & 3.1k \\
// % %     %& VGGNet16 & Image Classification & Conv. + ReLU + MaxPool    & 138M & 150k & extended \\
// % %     & Traffic Signs Recognition & Image Classification & Conv. + Sign + MakPool + BatchNorm & 905k - 1.7M & 2.7k - 12k & extended \\

// % %     % & Yolo & - & FC + Conv. + Residual, ReLU + Sigmoid & 22k - 37M & 1 - 308 & extended \\
// % %     % %
// % %     % \cmidrule(lr){1-7} %
// % %     % \multirow{5.5}{*}{\makecell{FC}}
// % %     % %& MNIST FC & Image Classification & FC. + ReLU    & 512 - 1.5k & 784 \\
// % %     % %& Reach Prob Density    & Probability density estimation & FC. + ReLU    & 64 - 192 & 3 - 14 \\
// % %     % %& RL Benchmarks  & Reinforcement Learning & FC. + ReLU    & 128 - 512  & 4 - 8 \\
// % %     \bottomrule
// % %     \end{tabular}
// % %     }
// % % \end{table}


// % \subsection{cGAN}
// % \paragraph*{Proposed by} Feiyang Cai, Ali Arjomandbigdeli, Stanley Bak (Stony Brook Univ.). Link: \url{https://github.com/feiyang-cai/cgan_benchmark2023}

// % This benchmark targets robustness verification for generative models—an area often overlooked compared to discriminative networks.
// % It uses conditional GANs trained to generate images of vehicles at specific distances. The generator takes a 1D distance input and a 4D noise vector; the discriminator outputs a real/fake score and a predicted distance.
// % Models vary in architecture (CNNs, vision transformers) and image size (32×32, 64×64).
// % The verification task checks whether the predicted distance from the generated image matches the input condition, under small input perturbations.


// % \paragraph*{Motivation}
// % While existing neural network verification benchmarks focus on discriminative models, the exploration of practical and widely used generative networks remains neglected in terms of robustness assessment.
// % This benchmark introduces a set of image generation networks specifically designed for verifying the robustness of the generative networks.
// % \paragraph*{Networks}
// % The generative networks are trained using conditional generative adversarial networks (cGAN), whose objective is to generate camera images that contain a vehicle obstacle located at a specific distance in front of the ego vehicle, where the distance is controlled by the input distance condition.
// % The network to be verified is the concatenation of a generator and a discriminator.  The generator takes two inputs: 1) a distance condition (1D scalar) and 2) a noise vector controlling the environment (4D vector). The output of the generator is the generated image. The discriminator takes the generated image as input and outputs two values: 1) a real/fake score (1D scalar) and 2) a predicted distance (1D scalar).
// % Several different models with varying architectures (CNN and vision transformer) and image sizes (32x32, 64x64) are provided for different difficulty levels.
// % \paragraph*{Specifications}
// % The verification task is to check whether the generated image aligns with the input distance condition, or in other words, verify whether the input distance condition matches the predicted distance of the generated image.
// % In each specification, the inputs (condition distance and latent variables) are constrained in small ranges, and the output is the predicted distance with the same center as the condition distance but with slightly larger range.

// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// % \pagebreak
// % \subsection{NN4Sys}
// % \paragraph*{Proposed by} the $alpha,\!\beta$-CROWN team with collaborations with Cheng Tan, Haoyu He and Shuyi Lin at Northeastern University.
// % \paragraph*{Application}
// % The benchmark contains networks for database learned index, video streaming learned adaptive bitrate, and learned cardinality
// % estimation which map inputs from various dimensions to 1-dimension outputs.

// % \begin{itemize}

// % \item \textit{Background}: learned index, learned cardinality, and learned
// %     adaptive bitrate are all instances in neural networks for computer systems
// %         (NN4Sys), which are neural network based methods performing system
// %         operations. These classes of methods show great potential but have one
// %         drawback---the outputs of an NN4Sys model (a neural network) can be
// %         arbitrary, which may lead to unexpected issues in systems.

// % \item \textit{What to verify}: our benchmark provides multiple pairs of (1) trained NN4Sys model
// % and (2) corresponding specifications. We design these pairs with different parameters such
// % that they cover a variety of user needs and have varied difficulties for verifiers.
// % We describe benchmark details in our NN4SysBench report:
// %         \url{http://naizhengtan.github.io/doc/papers/nn4sys23lin.pdf}.

// % \item \textit{Translating NN4Sys applications to a VNN benchmark}:
// % the original NN4Sys applications have some sophisticated structures that are hard to verify.
// % We tailored the neural networks and their specifications to be suitable for VNN-COMP.
// % For example, learned index~\cite{kraska18case} contains multiple NNs in a tree structure that together serve one purpose.
// % However, this cascading structure is inconvenient/unsupported to verify
// % because there is a ``switch" operation---choosing one NN in the second stage
// % based on the prediction of the first stage's NN.
// % To convert learned indexes to a standard form, we train a monolithic (larger) NN.

// % \item \textit{A note on broader impact}: using NNs for systems is a broad topic, but many existing works
// % lack strict safety guarantees. We believe that NN Verification can help system developers gain confidence
// % to apply NNs to critical systems. We hope our benchmark can be an early step toward this vision.

// % \end{itemize}

// % \paragraph*{Networks}
// % This benchmark has twelve networks with different parameters: two for learned
// % indexes, four for learned cardinality estimation and six for learned adaptive bitrate.
// % The learned index uses fully-connected feed-forward neural networks. The other
// % two---the learned cardinality and the learned adaptive bitrate---has a
// % relatively sophisticated internal structure. Please see our NN4SysBench report
// % (URL listed above) for details


// % \paragraph*{Specifications}
// % For learned indexes,
// % the specification aims to check if the prediction error is bounded.
// % The specification is a collection of pairs of input and output intervals such that
// % any input in the input interval should be mapped to the corresponding output interval.
// % For learned cardinality estimation and learned adaptive bitrate,
// % the specifications check the prediction error bounds (similar to the learned indexes)
// % and monotonicity of the networks.
// % By monotonicity specifications, we mean that for two inputs, the network should produce a larger
// % output for the larger input, which is required by cardinality estimation or adaptive bitrate.


// % \paragraph{Link:} \url{https://github.com/Khoury-srg/VNNComp23_NN4Sys}



// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: LinearizeNN %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{LinearizeNN}
// % \paragraph*{Proposed by}  Ali Arjomandbigdeli, Stanley Bak (Stony Brook University).
// % \paragraph*{Motivation}
// % Assuming having a neural network controller approximation with a piecewise linear model in the form of a set of linear models with added noise to account for local linearization error. The objective of this benchmark is to investigate the neural network output falls within the range we obtain from our linear model output plus some uncertainty.

// % The idea of this benchmark came from one of our recent paper~\cite{ArjomandBigdeli2024} in which we approximated the NN controller with a piecewise linear model, and we wanted to check if the neural network output falls within the range we obtained from our linear model output plus some uncertainty.
// % \paragraph*{Networks} The neural network controller we used in this benchmark is an image-based controller for an Autonomous Aircraft Taxiing System whose goal is to control an aircraft's taxiing at a steady speed on a taxiway. This network was introduced  in the paper "Verification of Image-based Neural Network Controllers Using Generative Models"~\cite{katz2021veri}. The neural network integrates a concatenation of the cGAN (conditional GAN) and controller, resulting in a unified neural network controller with low-dimensional state inputs. In this problem, the inputs to the neural network consist of two state variables and two latent variables. The aircraft's state is determined by its crosstrack position (p) and heading angle error ($\theta$) with respect to the taxiway center line. Two latent variables with a range of -0.8 to 0.8 are introduced to account for environmental changes.

// % Because in this case the output spec depends on both the input and output and considering the VNN-LIB limitation, we added a skip-connection layer to the neural network to have the input values present in the output space. We also added one linear layer after that to create a linear equation for each local model.
// % \paragraph*{Specifications} As mentioned earlier, the aim of this benchmark is to examine whether the neural network output stays within the range defined by the linear model's output, including a margin for uncertainty.Given input $x in X$ and output $Y = f_{NN}(x)$, the query is of the form: $A_{mat}\times X + b + U_{lb} <=q Y <=q A_{mat}\times X + b + U_{ub}$ for each linear model in its abstraction region.
// % \paragraph*{Link} \url{https://github.com/aliabigdeli/LinearizeNN_benchmark2024}

// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
// % \pagebreak
// % % \subsection{Cifar Bias Field}

// % % \paragraph{Proposed by} The VeriNet team.

// % % \paragraph*{Motivation} This benchmark considers verification of a Cifar 10 network against bias field perturbations. The bias field perturbations are encoded by creating augmented networks with only 16 input parameters; thus, the problem has a significantly lower input dimensionality than many other image-based benchmarks.

// % % \paragraph*{Networks} For each image to be verified, a separate bias field transform network is created~\cite{Henriksen+21} which consists of the FC transform layer followed by the Cifar CNN. The Cifar CNN consists of 8 convolutional layers followed by ReLUs. Each bias field transform network has 363k parameters and 45k nodes.

// % % \paragraph*{Specifications} The specification considers bias field perturbations of the input. The task is reduced to a standard $\ell_ in fty$ specification by encoding bias field the bias field transformation into fully connected layers which are prepended to the network under consideration. The bias field perturbations used $\epsilon = 0.06$ (as described in~\cite{Henriksen+21}) and a timeout of 5 minutes.


// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: ml4acopf %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{ml4acopf}
// % \paragraph*{Proposed by} Haoruo Zhao, Michael Klamkin, Mathieu Tanneau, Wenbo Chen, and Pascal Van Hentenryck (Georgia Institute of Technology), and Hassan Hijazi, Juston Moore, and Haydn Jones (Los Alamos National Laboratory).

// % \paragraph*{Motivation}
// % Machine learning models are utilized to predict solutions for an optimization model known as AC Optimal Power Flow (ACOPF) in the power system. Since the solutions are continuous, a regression model is employed. The objective is to evaluate the quality of these machine learning model predictions, specifically by determining whether they satisfy the constraints of the optimization model. Given the challenges in meeting some constraints, the goal is to verify whether the worst-case violations of these constraints are within an acceptable tolerance level.

// % \paragraph*{Networks}
// % The neural network designed comprises two components. The first component predicts the solutions of the optimization model, while the second evaluates the violation of each constraint that needs checking. The first component consists solely of general matrix multiplication (GEMM) and rectified linear unit (ReLU) operators. However, the second component has a more complex structure, as it involves evaluating the violation of AC constraints using nonlinear functions, including sigmoid, quadratic, and trigonometric functions such as sine and cosine. This complex evaluation component is incorporated into the network due to a limitation of the VNNLIB format, which does not support trigonometric functions. Therefore, these constraints violation evaluation are included in the neural network.

// % \paragraph*{Specifications}
// % In this benchmark, four different properties are checked, each corresponding to a type of constraint violation:
// % \begin{enumerate}
// %     \item Power balance constraints: the net power at each bus node is equal to the sum of the power flows in the branches connected to that node.
// %     \item Thermal limit constraints: power flow on a transmission line is within its maximum and minimum limits.
// %     \item Generation bounds: a generator's active and reactive power output is within its maximum and minimum limits.
// %     \item Voltage magnitude bounds: a voltage's magnitude output is within its maximum and minimum limits.
// % \end{enumerate}

// % The input to the model is the active and reactive load. The chosen input point for perturbation is a load profile for which a corresponding feasible solution to the ACOPF problem is known to exist. For the feasibility check, the input load undergoes perturbation. Although this perturbation does not exactly match physical laws, the objective is to ascertain whether a machine learning-predicted solution with the perturbation can produce a solution that does not significantly violate the constraints.

// % The scale of the perturbation and the violation threshold are altered by testing whether an adversarial example can be easily found using projected gradient descent with the given perturbation. The benchmark, provided with a fixed random seed, is robust against the simple projected gradient descent that is implemented.

// % \paragraph*{Link} \url{https://github.com/AI4OPT/ml4acopf_benchmark}


// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: ViT %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{ViT}
// % \paragraph*{Proposed by} the $alpha,\!\beta$-CROWN team.
// % \paragraph*{Motivation}
// % Transformers~\cite{vaswani2017attention} based on the self-attention mechanism have much more complicated architectures and contain more kinds of nonlinerities, compared to simple feedforward networks with relatively simple activation functions.
// % It makes verifying Transformers challenging. We aim to encourage the development of verification techniques for Transformer-based models, and we also aim to benchmark neural network verifiers on relatively complicated neural network architectures and more general nonlinearities. Therefore, we propose a new benchmark with Vision Transformers (ViTs)~\cite{dosovitskiy2020image}. This benchmark is developed based on our work on neural network verification for models with general nonlinearities~\cite{shi2024genbab}.

// % \paragraph*{Networks}
// % The benchmark contains two ViTs, as shown in \Cref{tab:vits}.
// % Considering the difficulty of verifying ViTs, we modify the ViTs and make the models relatively shallow and narrow, with significantly reduced number of layers and attention heads.
// % Following \cite{shi2019robustness}, we also replace the layer normalization with batch normalization.
// % The models are mainly trained with PGD training~\cite{madry2017towards}, and we also add a weighted IBP~\cite{gowal2018effectiveness,shi2021fast} loss for one of the models as a regularization.

// % \begin{table}[ht]
// % \centering
// % \caption{Networks in the ViT benchmark.}
// % \label{tab:vits}
// % \begin{tabular}{ccc}
// % \toprule
// % Model & \texttt{PGD\_2\_3\_16} & \texttt{IBP\_3\_3\_8} \\
// % \midrule
// % Layers & 2 & 3\\
// % Attention heads & 3 & 3\\
// % Patch size & 16 & 8\\
// % Weight of IBP loss & 0 & 0.01\\
// % Training $\epsilon$ & $\frac{2}{255}$ & $\frac{1}{255}$\\
// % Clean accuracy & 59.78\% & 62.21\%\\
// % \bottomrule
// % \end{tabular}
// % \end{table}

// % \paragraph*{Specifications}
// % The specifications are generated from the robustness verification problem with $\ell_ in fty$ perturbation.
// % We use the CIFAR-10 dataset with perturbation size $\epsilon=\frac{1}{255}$ at test time.
// % We have filtered the CIFAR-10 test set to exclude instances where either adversarial examples can be found (by PGD attack~\cite{madry2017towards} with 100 steps and 1000 restarts) or the vanilla CROWN-like method~\cite{zhang2018efficient,shi2019robustness} can already easily verify.
// % We randomly keep 100 instances for each model, with a timeout threshold of 100 seconds.
// % Note that since instances with adversarial examples have mostly been excluded during the filtering process, this version of the benchmark may not be able to reflect soundness issues in verifiers, and we refer readers to \cite{zhou2024testing} for discussions on testing soundness with models including ViT.

// % \paragraph*{Link} \url{https://github.com/shizhouxing/ViT_vnncomp2023}


// % \subsection{LSNC}

// % \paragraph*{Proposed by} the $alpha,\!\beta$-CROWN team.
// % \paragraph*{Motivation}
// % We develop a benchmark for the problem of verifying the Lyapunov stability of NN controllers in nonlinear dynamical systems within a region-of-intrest and a region-of-attraction. This is important for providing stability guarantees that are essential for safety-critical applications with NN controllers. It is also a useful application of neural network verification as recently demonstrated in \cite{yang2024lyapunov,shi2024certified}, and we refer readers to those works for more details on the problem.
// % \paragraph*{Networks and Specifications}
// % Models are adopted from \cite{yang2024lyapunov}.
// % We adopt two models for the 2D quadrotor dynamical system with state feedback and output feedback, respectively. Each model consists of a controller which is a shallow ReLU network, a Lyapunov function which is a quadratic function, and nonlinear operators modelling the dynamics of a 2D quadrotor. The model for output feedback further consists of a shallow LeakyReLU network as the observer. The verification objective of the Lyapunov stability has been encoded in the ONNX graphs and VNNLIB specifications. Specifications for the benchmark are randomly generated and consist of random sub-regions within the original region-of-interest. The size of the random sub-regions is controlled by a factor $\epsilon~(0<\epsilon<=q 1)$ which is applied to each input dimension, and it has been adjusted for a suitable difficulty given the timeout. For the state feedback model, we set $\epsilon=0.5$ and the timeout is 100s; for the output feedback model, we set $\epsilon=0.3$ and timeout is 200s. For each of the two models, we randomly generate 20 instances.
// % \paragraph*{Link} \url{https://github.com/shizhouxing/LSNC_VNNCOMP2024}

// % \subsection{Collins-RUL-CNN}
// % \paragraph*{Proposed by} Collins Aerospace, Applied Research \& Technology (\href{https://www.collinsaerospace.com/what-we-do/capabilities/technology-and-innovation/applied-research-and-technology}{website}).

// % \paragraph*{Motivation} Machine Learning (ML) is a disruptive technology for the aviation industry. This particularly concerns safety-critical aircraft functions, where high-assurance design and verification methods have to be used in order to obtain approval from certification authorities for the new ML-based products. Assessment of correctness and robustness of trained models, such as neural networks, is a crucial step for demonstrating the absence of unintended functionalities~\cite{ForMuLA, kirov2023formal}. The key motivation for providing this benchmark is to strengthen the interaction between the VNN community and the aerospace industry by providing a realistic use case for neural networks in future avionics systems~\cite{kirov2023benchmark}.

// % \paragraph*{Application} Remaining Useful Life (RUL) is a widely used metric in Prognostics and Health Management (PHM) that manifests the remaining lifetime of a component (e.g., mechanical bearing, hydraulic pump, aircraft engine). RUL is used for Condition-Based Maintenance (CBM) to support aircraft maintenance and flight preparation. It contributes to such tasks as augmented manual inspection of components and scheduling of maintenance cycles for components, such as repair or replacement, thus moving from preventive maintenance to \emph{predictive} maintenance (do maintenance only when needed, based on component’s current condition and estimated future condition). This could allow to eliminate or extend service operations and inspection periods, optimize component servicing (e.g., lubricant replacement), generate inspection and maintenance schedules, and obtain significant cost savings. Finally, RUL function can also be used in airborne (in-flight) applications to dynamically inform pilots on the health state of aircraft components during flight. Multivariate time series data is often used as RUL function input, for example, measurements from a set of sensors monitoring the component state, taken at several subsequent time steps (within a time window). Additional inputs may include information about the current flight phase, mission, and environment. Such highly multi-dimensional input space motivates the use of Deep Learning (DL) solutions with their capabilities of performing automatic feature extraction from raw data.

// % \paragraph*{Networks} The benchmark includes 3 convolutional neural networks (CNNs) of different complexity: different numbers of filters and different sizes of the input space. All networks contain only convolutional and fully connected layers with ReLU activations. All CNNs perform the regression function. They have been trained on the same dataset (time series data for mechanical component degradation during flight).

// % \paragraph*{Specifications} We propose 3 properties for the NN-based RUL estimation function. First, two properties (robustness and monotonicity) are local, i.e., defined around a given point. We provide a script with an adjustable random seed that can generate these properties around input points randomly picked from a test dataset. For robustness properties, the input perturbation (delta) is varied between 5\% and 40\%, while the number of perturbed inputs varies between 2 and 16. For monotonicity properties, monotonic shifts between 5\% and 20\% from a given point are considered. Properties of the last type ("if-then") require the output (RUL) to be in an expected value range given certain input ranges. Several if-then properties of different complexity are provided (depending on range widths).

// % \paragraph*{Link} \url{https://github.com/loonwerks/vnncomp2022}

// % \paragraph*{Paper} Available in~\cite{kirov2023benchmark} or on request.




// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: Traffic Signs Recognition %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{Traffic Signs Recognition}
// % \paragraph*{Proposed by} M\u{a}d\u{a}lina Era\c{s}cu and Andreea Postovan (West University of Timisoara, Romania)
// % \paragraph*{Motivation} Traffic signs play a crucial role in ensuring road safety and managing traffic flow in both city and highway driving. The recognition of these signs, a vital component of autonomous driving vision systems, faces challenges such as susceptibility to adversarial examples~\cite{szegedy2013intriguing} and occlusions~\cite{zhang2020lightweight}, stemming from diverse traffic scene conditions.

// % \paragraph*{Networks} Binary neural networks (BNNs) show promise in computationally limited and energy-constrained environments within the realm of autonomous driving~\cite{hubara2016binarized}. BNNs, where weights and/or activations are binarized to $\pm 1$, offer reduced model size and simplified convolution operations for image recognition compared to traditional neural networks (NNs).

// % We trained and tested various BNN architectures using the German Traffic Sign Recognition Benchmark (GTSRB) dataset~\cite{GTSRB}. This multi-class dataset, containing images of German road signs across 43 classes, poses challenges for both humans and models due to factors like perspective change, shade, color degradation, and lighting conditions. The dataset was also tested using the Belgian Traffic Signs \cite{BelgianTrafficSignDatabase} and Chinese Traffic Signs \cite{ChineseTrafficSignDatabase} datasets. The Belgium Traffic Signs dataset, with 62 classes, had 23 overlapping classes with GTSRB. The Chinese Traffic Signs dataset, with 58 classes, shared 15 classes with GTSRB. Pre-processing steps involved relabeling classes in the Belgium and Chinese datasets to match those in GTSRB and eliminating non-overlapping classes (see \cite{postovan2023architecturing} for details).

// % We provide three models with the structure in Figures \ref{fig:Acc-Efficient-Arch-GTSRB-Belgium}, \ref{fig:Acc-Efficient-Arch-Chinese}, and \ref{fig:XNOR(QConv)-arch}. They contain QConv, Batch Normalization (BN), Max Pooling (ML), Fully Connected/Dense (D) layers.  Note that the QConv layer binarizes the corresponding convolutional layer. All models were trained for 30 epochs. The model from Figure \ref{fig:Acc-Efficient-Arch-GTSRB-Belgium} was trained with images having the dimension 64px x 64 px, the one from Figure \ref{fig:Acc-Efficient-Arch-Chinese} with 48px x 48 px and the one from Figure \ref{fig:XNOR(QConv)-arch} with 30px x 30 px. The two models involving Batch Normalization layers introduce real valued parameters besides the binary ones, while the third one contains only binary parameters (see Table \ref{tab:stats}) for statistics.

// % \begin{figure}[h]
// %   \centering
// %      in cludegraphics[width=0.7\textwidth]{figure/AccEfficientGTSRBBelgium.png}
// %     \caption{Accuracy Efficient Architecture for GTSRB and Belgium dataset}
// %     \label{fig:Acc-Efficient-Arch-GTSRB-Belgium}
// % \end{figure}

// % \begin{figure}[h]
// %   \centering
// %      in cludegraphics[width=0.7\textwidth]{figure/AccEfficientArchChinese.png}
// %     \caption{Accuracy Efficient Architecture for Chinese dataset}
// %     \label{fig:Acc-Efficient-Arch-Chinese}
// % \end{figure}

// % \begin{figure}[h]
// %   \centering
// %      in cludegraphics[width=0.3\textwidth]{figure/XNORQConv.png}
// %     \caption{XNOR(QConv) architecture}
// %     \label{fig:XNOR(QConv)-arch}
// % \end{figure}

// % % Please add the following required packages to your document preamble:
// % % \usepackage{multirow}
// % \begin{table}[h]
// % \caption{Training and Testing Statistics}
// % \label{tab:stats}
// % \centering
// % \scriptsize
// % \begin{tabular}{|c|c|ccc|ccc|}
// % \hline
// % \multirow{2}{*}{\textbf{Input size}} & \multirow{2}{*}{\textbf{Model name}} & \multicolumn{3}{c|}{\textbf{Accuracy}}                                      & \multicolumn{3}{c|}{\textbf{\#Params}}                                      \\ \cline{3-8}
// %                             &                             & \multicolumn{1}{c|}{\textbf{German}} & \multicolumn{1}{c|}{\textbf{China}} & \textbf{Belgium} & \multicolumn{1}{c|}{\textbf{Binary}}  & \multicolumn{1}{c|}{\textbf{Real}} & \textbf{Total}   \\ \hline
// % 64px $\times$ 64px          & Figure \ref{fig:Acc-Efficient-Arch-GTSRB-Belgium}                  & \multicolumn{1}{c|}{96.45}  & \multicolumn{1}{c|}{81.50} & 88.17   & \multicolumn{1}{c|}{1772896} & \multicolumn{1}{c|}{2368} & 1775264 \\ \hline
// % 48px $\times$ 48px          & Figure \ref{fig:Acc-Efficient-Arch-Chinese}                  & \multicolumn{1}{c|}{95.28}  & \multicolumn{1}{c|}{83.90} & 87.78   & \multicolumn{1}{c|}{904288}  & \multicolumn{1}{c|}{832}  & 905120  \\ \hline
// % 30px $\times$ 30px          & Figure \ref{fig:XNOR(QConv)-arch}                  & \multicolumn{1}{c|}{81.54}  & \multicolumn{1}{c|}{N/A}   & N/A     & \multicolumn{1}{c|}{1005584} & \multicolumn{1}{c|}{0}    & 1005584 \\ \hline
// % \end{tabular}
// % \end{table}
// % \paragraph*{Specifications} To evaluate the \emph{adversarial robustness} of the networks above, we assessed perturbations within the infinity norm around zero, with the radius denoted as $\epsilon =  {1, 3, 5, 10, 15 }$. This involved randomly selecting three distinct images from the GTSRB dataset's test set for each model and generating \textsc{VNNLIB} files for each epsilon in the set. In total, we created 45 \textsc{VNNLIB} files. Due to a 6-hour total timeout constraint for solving all instances, each instance had a maximum timeout of 480 seconds. To review the generated \textsc{VNNLIB} specification files submitted to VNNCOMP 2023, as well as to generate new ones, please refer to \url{https://github.com/apostovan21/vnncomp2023}.

// % \paragraph*{Link} \url{https://github.com/apostovan21/vnncomp2023}



// % \subsection{CIFAR100}

// % \paragraph*{Proposed by} the $alpha,\!\beta$-CROWN team.
// % \paragraph*{Motivation} This benchmark is reused from VNN-COMP 2022 with a reduced complexity (only two out of the four models with medium sizes are retained).
// % See details in Section 4.5 of the report of VNN-COMP 2022~\cite{muller2022vnncomp}.

// % \paragraph*{Networks} We provide two ResNet models on CIFAR-100 with different model widths and depths (input dimension $32 \times 32 \times 3$, 100 classes):
// % \begin{itemize}
// %     \item \texttt{CIFAR100-ResNet-medium}: 8 residual blocks, 17 convolutional layers + 2 linear layers
// %     \item \texttt{CIFAR100-ResNet-large}: 8 residual blocks, 19 convolutional layers + 2 linear layers (almost identical to standard ResNet-18 architecture)
// % \end{itemize}

// % \paragraph*{Specifications}
// % We randomly select 100 images from the CIFAR-100 test set with a verification timeout of 100 seconds for each of the two models.
// % We filtered out the samples which can be verified by vanilla CROWN (which is used during training) to make the benchmark more challenging. The filtering process is done offline on a machine with a GPU due to the large sizes of these models.
// % A small proportion of instances (around 18\%) with adversarial examples have been retained for potentially identifying unsound results.

// % \paragraph*{Link} \url{https://github.com/huanzhang12/vnncomp2024_cifar100_benchmark}


// % \subsection{TinyImagenet}

// % \paragraph*{Proposed by} the $alpha,\!\beta$-CROWN team.
// % \paragraph*{Motivation} This benchmark is reused from VNN-COMP 2022. See details in Section 4.5 of the report of VNN-COMP 2022~\cite{muller2022vnncomp}.

// % \paragraph*{Networks} We provide a ResNet for TinyImageNet (input dimension $64 \times 64 \times 3$, 200 classes):
// % \begin{itemize}
// %     \item \texttt{TinyImageNet-ResNet-medium}: 8 residual blocks, 17 convolutional layers + 2 linear layers
// % \end{itemize}

// % \paragraph*{Specifications} We randomly select 200 images from the TinyImageNet test set with a verification timeout of 100 seconds for each of the two models. A filtering procedure has been adopted similar to the CIFAR100 benchmark.

// % \paragraph*{Link} \url{https://github.com/huanzhang12/vnncomp2024_tinyimagenet_benchmark}



// % \subsection{TLL Verify Bench}
// % \paragraph*{Proposed by} James Ferlez (University of California, Irvine)

// % \paragraph*{Motivation} This benchmark consists of Two-Level Lattice (TLL) NNs, which have been shown to be amenable to fast verification algorithms (e.g. \cite{FerlezKS22}). Thus, this benchmark was proposed as a means of comparing TLL-specific verification algorithms with general-purpose NN verification algorithms (i.e. algorithms that can verify arbitrary deep, fully-connected ReLU NNs).

// % \paragraph*{Networks}  The networks in this benchmark are a subset of the ones used in \cite[Experiment 3]{FerlezKS22}. Each of these TLL NNs has $n=2$ inputs and $m=1$ output. The architecture of a TLL NN is further specified by two parameters: $N$, the number of local linear functions, and $M$, the number of selector sets. This benchmark contains TLLs of sizes $N = M = 8, 16, 24, 32, 40, 48, 56, 64$, with $30$ randomly generated examples of each (the generation procedure is described in \cite[Section 6.1.1]{FerlezKS22}). At runtime, the specified verification timeout determines how many of these networks are included in the benchmark so as to achieve an overall 6-hour run time; this selection process is deterministic. Finally, a TLL NN has a natural representation using multiple computation paths \cite[Figure 1]{FerlezKS22}, but many tools are only compatible with fully-connected networks. Hence, the ONNX models in this benchmark implement TLL NNs by ``stacking'' these computation paths to make a fully connected NN (leading to sparse weight matrices: i.e. with many zero weights and biases). The \texttt{TLLnet} class (\url{https://github.com/jferlez/TLLnet}) contains the code necessary to generate these implementations via the \texttt{exportONNX} method.

// % %\vfill
// % %\pagebreak
// % \paragraph*{Specifications}  All specifications have as input constraints the hypercupe $[-2,2]^2$. Since all networks have only a single output, the output properties consist of a randomly generated real number and a randomly generated inequality direction. Random output samples from the network are used to roughly ensure that the real number property has an equal likelihood of being within the output range of the NN and being outside of it (either above or below all NN outputs on the input constraint set). The inequality direction is generated independently and with each direction having an equal probability. This scheme biases the benchmark towards verification problems for which counterexamples exist.

// % \paragraph*{Link} \url{https://github.com/jferlez/TLLVerifyBench}
// % \paragraph*{Commit}
// % 199d2c26d0ec456e62906366b694a875a21ff7ef





// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{safeNLP}

// % \begin{figure}[htbp]
// %     \centering
// %      in cludegraphics[width=0.9\columnwidth]{./figure/NLP-Flow.png}
// %     \caption{\small\emph{Generic approach to generating the NLP verification pipelines~\cite{casadio2023antonio,casadio2024nlp} deployed to obtain the safeNLP benchmark.}}
// %    \label{fig:antonio}
// % \end{figure}

// % \paragraph*{Proposed by} Marco Casadio, Ekaterina Komendantskaya, Luca Arnaboldi, Tanvi Dinkar.

// % \paragraph*{Motivation}
// % While considerable research has been dedicated to the verification of DNN-based systems in domains such as computer vision, there has been a notable lack of focus on the verification of natural language processing (NLP) systems. This is particularly critical given the rise of conversational agents across various domains, where inaccurate or misleading responses can cause real-world harm. For example, recent EU legislation~\cite{EUlaw} requires chatbots to disclose their non-human nature when queried, and developers of the chatbots should provide firm, and if possible, formal, guarantees that such disclosure will be given in an accurate manner. Medical assistants give another example where formal guarantees about the conversational agent responses are needed in order to safeguard against chatbots  generating harmful medical advice~\cite{bickmore2018patient}. While some initial work has been done in this area of NLP verification~\cite{jia2019certified,huang2019achieving,welbl2020towards,zhang2021certified,wang2023robustness,ko2019popqorn,du2021cert,shi2020robustness,bonaert2021fast}, no agreement on commonly  accepted benchmarks has been reached in this domain. To address this gap, we introduce safeNLP, the first such benchmark.

// % \paragraph*{Application}
// % In~\cite{casadio2024nlp}, we have undertaken a large-scale study of the existing literature on  NLP verification, and distilled common patterns among the existing approaches. Usually, given a dataset consisting of sentences divided into classes, Large Language Models (LLMs) are used to embed these sentences into real-vector spaces, after which smaller neural networks are trained to classify the embedded vectors (relative to the originally given classes). For verification, one can generate meaning-preserving sentence perturbations, again embed them into vector spaces, and verify that subspaces that contain the (embeddings of) the perturbed sentences are classified correctly. Also, in line with classical verification pipelines~\cite{CasadioKDKKAR22}, one can use these input subspaces to train the neural network to be robust on them.  The problem was that each of the existing approaches~\cite{jia2019certified,huang2019achieving,welbl2020towards,zhang2021certified,wang2023robustness,ko2019popqorn,du2021cert,shi2020robustness,bonaert2021fast} used parts of this pipeline in different ways, which made it difficult to compare or audit the results. In~\cite{casadio2023antonio,casadio2024nlp}, we made a generic implementation of this pipeline,
// % %(released as a Python package ANTONIO),
// % where each of the components of the pipeline is implemented in a modular and transparent way. For example, we can choose  and vary embedding functions, training modes, algorithms for sentence perturbations and algorithms for robust training, independently and modularly; as shown in Figure~\ref{fig:antonio}. This implementation was used to generate the presented VNNCOMP benchmark.

// % \begin{itemize}
// %     \item \emph{Datasets:} Although there was no clear consensus in~\cite{jia2019certified,huang2019achieving,welbl2020towards,zhang2021certified,wang2023robustness,ko2019popqorn,du2021cert,shi2020robustness,bonaert2021fast}, the most frequently used dataset in prior works was the IMDB dataset containing film reviews. Its disadvantage is unclear relation to safety critical domains that usually motivate verification efforts. On the other hand, none of the previously used datasets concerned safety-critical applications of NLP. We decided to address this problem, and therefore applied our generic NLP verification pipeline on two safety-critical datasets:  R-U-A-Robot~\cite{gros2021ruarobot}, which focuses on the chatbot disclosure problem, and Medical~\cite{abercrombie2022risk}, which addresses the issue of harmful advice provided by medical chatbots. Both datasets are pre-processed into two classes, positive and negative, to simplify the verification task. For further details on the pre-processing steps and datasets, see~\cite{casadio2024nlp} and the \href{https://github.com/ANTONIONLP/safeNLP}{benchmark GitHub repository}.
// %     \item \emph{Input Space:} In both datasets, sentences are transformed into fixed-size vector representations, i.e. embeddings, which serve as the inputs to the neural networks. For this VNNCOMP benchmark, we used Sentence-BERT~\cite{reimers-gurevych-2019-sentence}.
// %     %This part is handled by ANTONIO, which employs .
// %     \item \emph{What to Verify:} For each dataset, we generated meaning-preseving sentence perturbations at character and word level as in Moradi et al.~\cite{moradi2021evaluating} and at sentence level with Vicuna~\cite{vicuna2023}. For each positive sentence in the dataset, the smallest hypercupe containing the embeddings of all of its obtained perturbations formed one input subspace for verification. Such subspaces were obtained for all positive sentences from the given data set, and were subject to VNCCOMP verification challenge.
// %     %ANTONIO’s modular approach allows us to independently chose both the perturbation algorithms and the subspaces form.
// %     %The goal is to verify that every point within these subspaces is classified as positive by the network.
// %     \item \emph{A note on broader impact:} Verified models can serve as filters for larger NLP systems: e.g. to screen inputs to ensure they meet safety criteria before being passed on to more complex models.
// % \end{itemize}

// % \paragraph*{Networks} The safeNLP benchmark includes two neural networks, each corresponding to a different dataset (R-U-A-Robot and Medical). Both networks share the same architecture, consisting of two fully-connected layers. The hidden layer has 128 units with a ReLU activation function, while the output layer has 2 units representing the two classification classes (positive/negative). To enhance the robustness of the networks to the specified safety requirements, they are trained using a custom PGD (Projected Gradient Descent)~\cite{madry2018towards} adversarial training technique. In particular, the PGD attack explores the above-mentioned subspaces of the input space (cf. also Figure~\ref{fig:antonio}).
// % %ANTONIO plays a crucial role in this process, allowing us to
// % %flexibly select the training mode and robustness algorithm. Specifically, we
// % %customise the PGD algorithm to work effectively with the subspaces used in our specifications.

// % \paragraph*{Specifications} The benchmark uses hyper-rectangles in the 30-dimensional embedding space as the subspaces of choice, offering a computationally efficient way to define more precise and adaptable regions compared to the traditional $\epsilon$-cupes.
// % %These hyper-rectangles are defined by a series of lower and upper bounds.
// % The specifications require verifying that, for a given network and hyper-rectangle, every point within the hyper-rectangle is classified as the positive class by the network. To meet time constraints, we randomly select 1,080 such specifications, each linked to one of the two networks and a corresponding hyper-rectangle, with a timeout of 20 seconds per specification.

// % \paragraph*{Link} \url{https://github.com/ANTONIONLP/safeNLP}


// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: dist_shift %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{Real-world distribution shifts}
// % \paragraph*{Proposed by} the Marabou team.
// % \paragraph*{Motivation}
// % While robustness against handcrafted perturbations (e.g., norm-bounded) for perception networks are more commonly investigated, robustness against real-world distribution shifts~\cite{wu2022toward} are less studied but of practical interests. This benchmark set contains queries for verifying the latter type of robustness.
// % \paragraph*{Networks} The network is a concatenation of a generative model and a MNIST classifier. The generative model is trained to take in an unperturbed image and an embedding of a particular type of distribution shifts in latent space, and produce a perturbed image. The distribution shift captured in this case is the "shear" perturbation.
// % \paragraph*{Specifications} The verification task is to certify that a classifier correctly classifies all images in a perturbation set, which is a set of images generated by the generative model given a fixed image and a ball centering the mean perturbations on this image (in the latent space). This mean perturbation is computed by a prior network.
// % \paragraph*{Link} \url{https://github.com/wu-haoze/dist-shift-vnn-comp}


// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % %%%% sec: cora %%
// % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % \subsection{CORA Benchmark}
// % \paragraph*{Proposed by} the CORA team.
// % \paragraph*{Motivation}
// % The verification of neural networks can be quite slow, i.e., the verification of a single instance can take multiple days -- which is often hard to justify, particularly in safety-critical scenarios. To encourage the fast verification of neural networks, our benchmark focuses on the verification time by setting a small timeout and testing three different (adversarial) training techniques that aim to ease the verifiability.


// % \paragraph*{Networks} The benchmark consists of one ReLU-neural network architecture (7x250 + ReLU), which was trained on three datasets, (MNIST, SVHN, and CIFAR10), using three different (adversarial) training methods, i.e., standard (point), interval-bound propagation, and set-based. Both interval-bound propagation and set-based training are training methods that improve the robustness of the trained neural network and aim to ease later verification. The neural networks are taken from the first evaluation run of~\cite{koller_et_al_2024}; please refer to~\cite{koller_et_al_2024} for the training details.
// % \paragraph*{Specifications} All networks are trained on classification tasks. The goal is to verify that no image within a given input set is incorrectly classified.
// % \paragraph*{Link} \url{https://github.com/kollerlukas/cora-vnncomp2024-benchmark}

// %  == Results}


// % \paragraph{Results}~@tab:score shows the results. We report the Rank (\textbf{\#}) and  \textbf{\%} is the percentage of solved problems over all problem instances of the corresponding benchmark.   The last two columns break down the number of problems each verifier was able to verify and falsify. For example, for ACAS Xu, all tools other than \crowndefault{} were able to verify all 186 problems (139 + 47), and \crowndefault{} was only able to solve 113 problems (78 + 35), which is 60.8\% of the total problems.

// % \newcommand{\nsTwentyFour}{\texttt{NeuralSAT}$_\text{VNN-COMP'24}$}
// % \newcommand{\ns}{\texttt{NeuralSAT}}

// % \begin{table}
// %   \small
// %   \centering
// %   \caption{Results over VNN-COMP'24 Benchmarks <tab:score}
// %        \renewcommand{\arraystretch}{0.6}
// %   \begin{tabular}{c|ccr|rr}
// %     \toprule
// %     \textbf{Benchmark} & \textbf{\#} & \textbf{Tool} & \textbf{\%} & \textbf{Verify} & \textbf{Falsify}  \\

// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{ACAS Xu}}
// % & 1 & \crown{} & 100.0\% & \textbf{139} & \textbf{47} \\
// % & 1 & \ns{} & 100.0\% & \textbf{139} & \textbf{47} \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{139} & \textbf{47} \\
// % & 4 & \crowndefault{} & 60.8\% & 78 & 35 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Cgan}}
// % & 1 & \crown{} & 100.0\% & \textbf{8} & \textbf{13} \\
// % & 1 & \ns{} & 100.0\% & \textbf{8} & \textbf{13} \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{8} & \textbf{13} \\
// % & 4 & \crowndefault{} & 33.3\% & 0 & 7 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Cifar100}}
// % & 1 & \crown{} & 77.5\% & \textbf{123} & \textbf{32} \\
// % & 2 & \ns{} & 76.5\% & 122 & 31 \\
// % & 3 & \crowndefault{} & 71.0\% & 110 & \textbf{32} \\
// % & 4 & \nsTwentyFour{} & 64.5\% & 98 & 31 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Collins Rul CNN}}
// % & 1 & \crown{} & 100.0\% & \textbf{30} & \textbf{32} \\
// % & 1 & \crowndefault{} & 100.0\% & \textbf{30} & \textbf{32} \\
// % & 1 & \ns{} & 100.0\% & \textbf{30} & \textbf{32} \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{30} & \textbf{32} \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Cora}}
// % & 1 & \crown{} & 43.9\% & \textbf{24} & \textbf{134} \\
// % & 1 & \crowndefault{} & 43.9\% & \textbf{24} & \textbf{134} \\
// % & 1 & \ns{} & 43.9\% & \textbf{24} & \textbf{134} \\
// % & 1 & \nsTwentyFour{} & 43.9\% & \textbf{24} & \textbf{134} \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Dist Shift}}
// % & 1 & \crown{} & 100.0\% & \textbf{64} & \textbf{8} \\
// % & 1 & \ns{} & 100.0\% & \textbf{64} & \textbf{8} \\
// % & 3 & \nsTwentyFour{} & 98.6\% & 63 & \textbf{8} \\
// % & 4 & \crowndefault{} & 94.4\% & 60 & \textbf{8} \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Linearize NN}}
// % & 1 & \crown{} & 100.0\% & \textbf{59} & \textbf{1} \\
// % & 1 & \ns{} & 100.0\% & \textbf{59} & \textbf{1} \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{59} & \textbf{1} \\
// % & 4 & \crowndefault{} & 68.3\% & 40 & \textbf{1} \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Meta Room}}
// % & 1 & \crown{} & 98.0\% & \textbf{91} & \textbf{7} \\
// % & 1 & \ns{} & 98.0\% & \textbf{91} & \textbf{7} \\
// % & 1 & \nsTwentyFour{} & 98.0\% & \textbf{91} & \textbf{7} \\
// % & 4 & \crowndefault{} & 0.0\% & 0 & 0 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Nn4sys}}
// % & 1 & \crown{} & 100.0\% & \textbf{194} & 0 \\
// % & 1 & \ns{} & 100.0\% & \textbf{194} & 0 \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{194} & 0 \\
// % & 4 & \crowndefault{} & 4.1\% & 8 & 0 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Safe NLP}}
// % & 1 & \crown{} & 98.1\% & \textbf{411} & \textbf{648} \\
// % & 1 & \ns{} & 98.1\% & \textbf{411} & \textbf{648} \\
// % & 3 & \crowndefault{} & 96.9\% & 401 & 646 \\
// % & 4 & \nsTwentyFour{} & 94.3\% & 378 & 640 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{Tiny ImageNet}}
// % & 1 & \crown{} & 91.5\% & \textbf{140} & \textbf{43} \\
// % & 2 & \ns{} & 91.0\% & 139 & \textbf{43} \\
// % & 3 & \crowndefault{} & 89.5\% & 136 & \textbf{43} \\
// % & 4 & \nsTwentyFour{} & 72.5\% & 102 & \textbf{43} \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{TLL Verify Bench}}
// % & 1 & \crown{} & 100.0\% & \textbf{15} & \textbf{17} \\
// % & 1 & \ns{} & 100.0\% & \textbf{15} & \textbf{17} \\
// % & 1 & \nsTwentyFour{} & 100.0\% & \textbf{15} & \textbf{17} \\
// % & 4 & \crowndefault{} & 65.6\% & 5 & 16 \\
// % \midrule
// % \multirow{4}{*}{\rotatebox[origin=c]{0}{\textbf{Overall}}}
// % & 1 & \crown{} & 88.8\% & \textbf{1298} & \textbf{982} \\
// % & 2 & \ns{} & 88.7\% & 1296 & 981 \\
// % & 3 & \nsTwentyFour{} & 84.7\% & 1201 & 973 \\
// % & 4 & \crowndefault{} & 71.9\% & 892 & 954 \\
// % \bottomrule
// %   \end{tabular}
// % \end{table}


= VNN-COMPs <chap:vnncomps>

As NNV matured, it became increasingly difficult to compare approaches. Papers often evaluated tools on different benchmarks, under different hardware assumptions, and using different specification languages. This fragmentation made it hard to assess the true state of the art, identify open challenges, and drive progress. This chapter describes the VNN-COMPs, which were created to address this problem by providing a common platform for evaluating and comparing NNV tools, and discusses common features of SOTA tools.

== VNN-COMPs

Inspired by the success of other formal methods competitions (e.g., SAT, SMT, model checking), the International Verification of Neural Networks Competition (*VNN-COMP* @kaulen20256thinternationalverificationneural @brix2024fifth @brix2023fourth) encourages the standardization of tool interfaces and brings together the NNV community. To this end, VNN-COMP uses standardized formats for networks (ONNX @onnx) and specification (VNN-LIB @vnnlib), and evaluates tools using a common set of benchmarks on a common platform (AWS instances).

*VNN-COMP'25 Results.* In the latest 2025 VNN-COMP iteration @kaulen20256thinternationalverificationneural, 7 teams participated on a diverse set of 16 regular and 6 extended benchmarks. @fig:vnn-comp25 presents the overall scores and rankings of the tools (Tab. 6 in @kaulen20256thinternationalverificationneural) and a cactus plot of tool performance on all benchmark instances (Fig. 6 in @kaulen20256thinternationalverificationneural). In summary, #tool ranks 2nd overall, behind $alpha beta$-CROWN, a regular winner of VNN-COMPs, and ahead of PyRAT.

#figure(
  table(
    columns: 3,
    table.hline(),
    [*\#*], [*Tool*], [*Score*],
    table.hline(),
    [1], [$alpha beta$-CROWN], [1566.9],
    [2], [#tool], [1430.2],
    [3], [PyRAT], [1228.4],
    [4], [CORA], [987.2],
    [5], [NNV], [796.4],
    [6], [nnenum], [740.3],
    [7], [SobolBox], [593.3],
    table.hline(),
  ),
  caption: [VNN-COMP'25 results @kaulen20256thinternationalverificationneural.]
) <fig:vnn-comp25>

== Common Features of SOTA Tools

#figure(
  table(
    columns: 2,
    table.hline(),
    [*Feature*], [*Supported*],
    table.hline(),
    [Network Type], [Acyclic computation graphs, e.g., Feed-forward, Residual],
    [Layer Type], [FC, CNN, MaxPool, BatchNorm, Softmax],
    [Activation Function], [ReLU, Sigmoid, Tanh, Sign, Exp],
    [Abstract Domain], [Polytope, Interval],
    [Search Algorithm], [Parallel DPLL(T)],
    [Hardware], [Multi-core CPU, GPU],
    [Optimization], [Adv. Attacks, Input splitting, Large Output Opt., MILP solving],
    [Property], [Robustness, Safety],
    [Input], [Pytorch, ONNX, VNN-LIB],
    [Output], [(sat, unsat, timeout), counter-examples],
    table.hline(),
  ),
  caption: [Common features of SOTA NNV tools.],
) <tab:features>

*Network Types and Activation Functions.* Currently, most NNV tools work with fully connected (FC), convolutional (CNN), residual (ResNet), and batch normalization (BatchNorm) networks. Some also support mixtures of different types, e.g., VAEs which are large residual CNN-based networks @duong2025compositional. In addition to ReLU, SOTA tools support other major activation functions including sigmoid, tanh, and power @kaulen20256thinternationalverificationneural.

*Standard Input and Output Formats.* VNN-COMPs and major NNV tools support input networks in the standard ONNX format @onnx and properties in VNNLIB format @vnnlib. Some SOTA tools, e.g., #tool, also work directly with networks in Pytorch. The output is reported as `unsat` (property proved), `sat` (property disproved), or `unknown`/`timeout` (property cannot be proved). NNV tools also generate counterexamples for `sat` results. However, few tools generate unsat proofs, a topic of ongoing research as discussed in @chap:proof-gen-check.

*Engineering Optimizations.* As with most high-performance analysis tools, engineering matters! SOTA NNV tools use various engineering optimizations to improve performance. For example, they employ adversarial attack techniques such as derivative-free sampling-based @yu2016derivative and gradient-based @madry2017towards methods to quickly find counterexamples. They also preprocess and apply heuristics that automatically select appropriate abstractions and algorithms based on input network structures and properties @duong2025neuralsat @duong2024harnessing. They use input splitting @duong2025neuralsat @wang2021beta @bak2021nnenum @zhang2022general for networks with low input dimension and neuron splitting for other networks.

*Commodity Hardware.* NNV tools heavily leverage the power of modern hardware, including multi-core CPUs and GPUs. For example, the parallel search in #tool uses multi-threading, allowing multiple search subspaces to be processed simultaneously on different CPU cores. Abstraction techniques, e.g., the LiRPA library @xu2020automatic, are often implemented to run on GPUs, which significantly speeds up the computation of neuron bounds. However, real-world networks are growing rapidly in size, and we need to explore new paradigms beyond simply leveraging commodity hardware to scale verification.

*Parameter Tuning and Extensibility.* NNV tools are powerful and flexible and have many parameters that can be tuned to further optimize performance for specific problems. Common parameters include decision heuristics, restart strategies, timeouts, CPU threads for parallelism, etc. #tool, in contrast to most other SOTA tools, is designed to be fully automatic so that for end-users it _"just works"_ --- #tool runs on all VNN-COMP benchmarks with _zero_ tuning. Some tools are designed in a modular and extensible way, allowing users to easily add new heuristics, optimizations, or new search algorithms. For example, #tool consists of a small core BnB/DPLL search algorithm, and other heuristics and optimizations are implemented as independent functions that can be easily replaced or extended (e.g., in current implementation decision heuristics or restart functionalities are less than 50 SLOC).




// %For example, \neuralsat{} allows users to configure the number of threads, restart strategies, decision heuristics, timeout, etc. These options are useful for experts who want to explore different settings and optimize the performance of \neuralsat{} for their specific problems.

// %While leveraging hardware is common in DNN verification, the implementation is highly specific to the tool and requires careful engineering to achieve high performance. In VNN-COMP'24\footnote{VNN-COMP'24 no longer measures verification runtime and instead uses timeout.}, \toolu{} was one of the fastest tools, often outperforming other top competitors.




// % \subsubsection*{Extensibility.} As mentioned, \toolu{} has many optimizations, and 
// % their addition was facilitated by the use of DPLL(T). The DPLL(T) framework in \toolu{} is modular and extensible, consisting of a small core search algorithm and allows users to: add new decision or restart heuristics for DPLL, add new adversarial attacks in preprocessing, or extend the T-solver with additional abstraction or optimizations for DNN analysis. For example, the neuron stabilization optimization described in~@sec:overview is an independent function with fewer than 100 SLOCs and integrated via a hook method call into the core DPLL search. Similarly, heuristics are implemented as independent functions and can be easily replaced or extended (e.g., in current implementation decisions and restarts are less than 50 SLOC). 
// % \toolu{} also uses the Gurobi LP solver as a black box and thus can switch to different solvers, e.g, Xpress~\cite{xpress}, dReal~\cite{dreal}.



// %  == The 2025 Edition at a Glance}

// % VNN-COMP 2025 continued the trend toward increased automation, standardization, and scale. In this iteration:

// % Eight teams participated (with one team withdrawing during evaluation).

// % Tools were evaluated on 16 regular benchmarks and 9 extended benchmarks, covering a diverse range of network architectures and property types.

// % All tools were run on cost-equivalent cloud hardware, ensuring fairness across different computational strategies.

// % The entire evaluation process was driven by an automated pipeline, minimizing human intervention and improving reproducibility.

// % The competition evaluated tools under realistic constraints that reflect how verification systems are used in practice, rather than under hand-tuned, tool-specific experimental setups.

// %  == Standardization Efforts}

// % A defining feature of VNN-COMP is its emphasis on standardization. Without common standards, meaningful comparison between tools is nearly impossible. The 2025 competition standardized three key aspects.

// % 4.1 Neural Network Format: ONNX

// % All neural networks in VNN-COMP 2025 were provided in the ONNX (Open Neural Network Exchange) format. ONNX serves as a common intermediate representation supported by many machine learning frameworks.

// % Using ONNX provides several benefits:

// % Tool developers can focus on verification rather than framework-specific parsing.

// % Benchmarks are reusable across tools and across years.

// % Networks can be generated from real-world training pipelines.

// % 4.2 Specification Format: VNN-LIB

// % Specifications were expressed using VNN-LIB, a standardized specification language designed specifically for neural network verification. VNN-LIB builds on ideas from SMT-LIB, enabling precise and unambiguous descriptions of verification properties.

// % Typical VNN-LIB specifications describe:

// % Input constraints (e.g., bounded perturbations around an image).

// % Output constraints (e.g., the correct class has the highest score).

// % By enforcing a common specification language, VNN-COMP ensures that all tools are solving the same formal problem.

// % 4.3 Evaluation Infrastructure

// % All tools were evaluated using a uniform, automated pipeline based on AWS cloud instances. Participants selected from a predefined set of cost-equivalent configurations, allowing different trade-offs between CPU and GPU resources while maintaining fairness.

// % Crucially:

// % Tools were executed with parameters chosen before the final benchmark sets were released.

// % No manual tuning was allowed after benchmarks became public.

// % This setup prevents overfitting to specific benchmarks and mirrors realistic deployment scenarios.

// %  == Organization and Timeline}

// % The organization of VNN-COMP 2025 followed a well-defined timeline:

// % February 2025: Call for participation.

// % March–May 2025: Rule discussion and finalization.

// % April–June 2025: Benchmark proposal and discussion.

// % Spring–Summer 2025: Development of automated submission and testing infrastructure.

// % Mid-July 2025: Tool submission deadline.

// % July 22, 2025: Presentation of final results at SAIV.

// % All discussions were conducted transparently via public GitHub repositories, covering rules, benchmarks, and tool submissions. Final benchmarks and results were archived in separate repositories to ensure long-term availability and reproducibility.

// % \subsection{Competition Contribution Papers}

// % A notable addition in the 2025 edition was the introduction of Competition Contribution papers in the SAIV proceedings. Tool developers and benchmark contributors were invited to submit short papers describing:
// % \begin{itemize}
// % \item Tool architectures and verification techniques.
// % \item Benchmark construction methodologies.
// % \item Lessons learned from participating in the competition.
// % \end{itemize}

// % These papers were reviewed by a program committee composed primarily of tool-team members. While lighter-weight than traditional conference papers, these contributions serve as valuable documentation of the state of the art and complement the raw competition results.

// %  == Perspective: Why VNN-COMP Matters}

// % From a broader perspective, VNN-COMP plays a role similar to that of SAT, SMT, and model-checking competitions in earlier decades. Those competitions were instrumental in transforming formal methods from primarily theoretical pursuits into robust, industrially relevant technologies.

// % In my view, VNN-COMP is essential infrastructure for the neural network verification community. It forces clarity, discourages vague claims, and exposes real bottlenecks. Equally importantly, it highlights that no single technique dominates across all problem classes—progress will likely come from hybrid approaches, better benchmarks, and tighter integration with learning pipelines.

// % As neural networks continue to enter safety-critical systems, the importance of rigorous, reproducible evaluation frameworks like VNN-COMP will only grow.


// \part{Background <part:background}
// \renewcommand{\appendixname}{Background}
// \appendix
#pagebreak()


#counter(heading).update(0)

#set heading(
  numbering: "A.1",
  supplement: "Background",
)


= Formal Methods <chap:formal-methods>

Neural network verification (NNV) is a rising topic that applies #highlight[formal methods] (FM) to ML systems, particularly neural networks (NN).  This chapter explains FM techniques, how verification differs from testing and debugging, and key concepts such as specifications and common FM techniques.

== What Are Formal Methods (FM)?

FM are techniques for analyzing systems, e.g., computer software, using _mathematical models and reasoning_. In FM the behavior of a program is described and analyzed using logic and mathematics rather than informal reasoning or empirical testing. This allows FM to provide \emph{guarantees} about system properties. For example, an FM might prove that a sorting algorithm always produces a correctly ordered list for any input list

#paragraph[Compared to Testing][To motivate the need for FM, consider a simple function that computes the absolute value of an integer, where the goal is to show that the function always returns a non-negative number.
]

```python
def abs_val(x):
    if x >= 0:
        return x
    else:
        return -x
```
We might _test_ `abs_val` by running it on a few inputs and checking the outputs:

```python
assert(abs_val(3) = 3)
assert(abs_val(-5) = 5)
assert(abs_val(0) = 0)
...
```

The program works correctly on these inputs, returning non-negative values as expected. We could run many more tests with different inputs to increase our confidence. However, we can never test all possible integers, and therefore cannot be certain that the function works correctly for all possible inputs.
This is precisely where bugs can hide, and why testing---no matter how extensive---alone cannot provide absolute guarantees about program correctness, as observed by Dijkstra:

#quote(block:true, attribution: [#text(size:0.85em)[*Edsger Dijkstra*]])[_"Testing can only show the presence of bugs, not their absence"_]

In contrast, an FM technique would instead reason directly about the structure of the code and atempts to prove the statement:

$ "For all integers" x, "abs_val"(x) >= 0. $ <eq:abs_val_nonneg>

If FM can prove this statement, we have a mathematical guarantee that the function behaves correctly for _all integers_---not just the ones we used in testing.

Thus, the _fundamental difference_ between FM and testing is that FM provides mathematical guarantees about program behavior---without even running the program---, while testing can only provide empirical evidence based on a finite set of inputs that we run the program on.

== Specifications

At the heart of FM is a #highlight[specification]---a precise description of what it
means for a system to be correct (or safe, or robust, etc.). A specification
defines the properties we want to verify about a system.

Software engineers often write specifications informally in natural language,
e.g., an algorithm should be "correct" and "fast", or a web server should be
"robust against attacks". However, these informal specifications are often
ambiguous and imprecise, making them vulnerable to misinterpretation and error.
For example, what is correct? How fast is fast enough? How much perturbation
should a system be able to handle to be considered "robust"?

#problem("Sorting Specification")[
  Give the formal specification for a sorting function `sort(l1)` that
  takes a list of integers `l1` and returns a list of integers
  `l2`. The specification should define what it means for the output
  `l2` to be a correct sorting of the input `l1`.
]

In contrast, a formal specification must be _unambiguous_ and _mathematically
expressible_---typically using logic. It precisely defines the conditions under
which the system is considered correct.

For example, a desirable property of neural networks used for image
classification is being _robust_ to small perturbations of the input image.
For this property, an informal specification might say:

#block(inset: (left: 1.5em))[
  _"Small changes to the input image shouldn't cause the neural network to
  change its classification label."_
]

In contrast, a formal specification of robustness would instead say:

#block(inset: (left: 1.5em))[
  _"For an input image $x$, for all images $x'$ such that the distance between
  $x$ and $x'$ is at most $epsilon$, the output label of a network $N$ for $x'$
  must be the same as for $x$."_
]

This statement is more precise. It defines exactly what inputs are allowed
(those within distance $epsilon$ of $x$) and exactly what behavior is required
(the output label must remain the same). Typically, we go further and express
this property in formal logic:

$
  forall x', norm(x - x') <= epsilon ==> N(x') = N(x)
$ <eq:robustness>

Once having a formal specification like this, we can apply formal verification
techniques to prove or disprove it.

=== Pre and Post Conditions

A common way to express formal specifications is using #highlight[preconditions] and
#highlight[postconditions]. A precondition describes the assumptions about the inputs to
a function, while a postcondition describes the guarantees about the outputs
given that the preconditions hold. Typically, preconditions and postconditions
are expressed using logical formulae and together form the specification of the
form:

$ P ==> Q, $

which means: _"if the precondition $P$ holds for the inputs, then the
postcondition $Q$ must hold for the outputs"_.

#paragraph[Postcondition][A postcondition is a logical statement that must be true
after a function has executed, assuming the precondition held. It typically
describes the _expected behavior_ and _outcomes_ of the function with respect
to its inputs. For example, the postcondition for `sqrt(x)` might state
that the output $y$ must be non-negative and that $y^2 = x$. For
`idiv(a, b)`, the postcondition might state that the output $q$ must
satisfy $a = b dot q + r$ for some remainder $r$ such that $0 <= r < |b|$.

We want the postcondition to be as strong as possible, i.e., it should as
precisely as possible describe the expected behavior of the function. For
example, for `idiv(a, b)`, a (weak) postcondition might simply state
that the output is an integer, while a (strong) postcondition would specify the
exact relationship between inputs and outputs as described above. Similarly,
for `sqrt(x)`, a weak postcondition might state that the output is a
real number, while a strong postcondition would specify the exact relationship
$y^2 = x$.]

#paragraph[Precondition][A precondition is a logical statement that must be true before
a function is executed. It typically lists _assumptions_ and _constraints_ on
the inputs. For example, a `sqrt(x)` function might have the
precondition that `x` must be non-negative. Similarly, an integer
division function `idiv(a, b)` might have the precondition that
`b` must be non-zero to avoid division-by-zero errors.

The precondition should be as weak as possible, i.e., it should not impose
unnecessary restrictions or assumptions that limit the applicability of the
function. Moreover, the user might not even be aware of all the assumptions
needed for the function to work correctly, and therefore a strong precondition
might be unrealistic. Ideally, there should be _no_ precondition at all (i.e.,
as weak as possible), meaning the function works for all possible inputs. For
example, for `sqrt(x)` we can have a weak precondition that `x`
is any real number, and the postcondition would then specify that if the input
is negative the output is NaN (not a number), and otherwise the output is
non-negative and its square equals `x`.
]

#problem("Minimum Specification")[
  Give a specification for a function `m = min(l)` that takes a list of
  integers `l` and returns the minimum integer `m` in the list.
  Clearly state the precondition and postcondition for the function.
]

#problem("Duplicate")[
  Give a specification for a function `l2 = remove_duplicates(l)` that
  takes a list of integers `l` and returns a list of integers `l2`
  that contains the same integers as`l` but with all duplicates removed.
  Clearly state the precondition and postcondition for the function.
] <prob:remove_duplicates>

// #solution[
//   *Precondition:*

//   - `l` is a list of integers.

//   *Postcondition:*

//   Let `l2 = remove_duplicates(l)`. Then:

//   + For all $x in$ `l2`, we have $x in$ `l` (all elements of
//     `l2` appear in `l`).

//   + For all $x in$ `l`, we have $x in$ `l2` (all unique elements
//     of `l` appear in `l2`).

//   + All elements in `l2` are distinct. Formally, for all indices $i, j$
//     such that
//     $ 0 <= i < j < |"l2"|, $
//     we have
//     $ "l2"[i] != "l2"[j]. $

//   Equivalently,
//   $ "set"("l2") = "set"("l"). $

//   For example, if `l = [1, 2, 3, 2, 4, 1, 5]`, then a valid output is
//   `l2 = [1, 2, 3, 4, 5]`.
// ]


== FM Techniques

At a high level, an FM technique is an algorithm, often implemented as a
software tool, that analyzes a system. The FM tool takes as _inputs_:

+ A _model_ of the system to be analyzed
+ A _specification_ of the desired property of the system or program

and applies a _reasoning process_ to determine whether the model satisfies the
specification. The tool produces an _output_ indicating whether the property
holds, does not hold, or is unknown.

#paragraph[System Model][The FM tool takes as input a _model_ of the system to be
analyzed. This model is a mathematical abstraction of the system's behavior. It
may be a program written in a language such as C or Python, a neural network in
ONNX format, or other representations such as state machines or transition
systems. This model, e.g., the program code, is created by the programmer and is
intended to capture the desired specification of the system. However, the model
might contain bugs or inaccuracies that violate the intended specification,
which is what the FM tool aims to detect.]

#example("Clip")[
  Consider the following simple system that "clips" an input value into the
  range $[0, 10]$. This system is modeled by the following Python function:

  ```python
  def clip(x):
      if x < 0: return 0          
      elif x > 10: return 10          
      else: return x          
  ```
] <example:clip>

The formal specification of the `clip` system is:

$ forall x in RR, quad 0 <= "clip"(x) <= 10. $

*FM Reasoning Process.* Once the model and specification are given, an FM tool
applies a _reasoning process_---an algorithm---to determine whether the model
satisfies the specification. The next section describes several major classes of
FM techniques, each with its own reasoning process.

// % Different formal-methods techniques use different reasoning processes:

// % * Exploring all reachable states
// % * Constructing logical proofs
// % * Solving constraint systems
// % * Computing sound approximations

// % What matters is that the reasoning process is **well-defined**. Given the same inputs, the tool will always reason the same way.



// Finally, the FM algorithm/tool produces one of the \emph{three} possible results:
// \begin{enumerate}
// \item Proved:  the model satisfies the specification. 
// \item Disproved: the model does not satisfy the specification. Typically a counterexample is also provided to show the violation (bug).
// \item Unknown: the FM tool cannot determine whether the model satisfies the specification within its resource limits (e.g., time, memory).
// \end{enumerate}
// % ## Soundness and Completeness of Formal-Methods Tools

// % Formal-methods tools are evaluated not by speed or convenience alone, but by two fundamental properties: **soundness** and **completeness**.

// % ---

// % ### Soundness

// % A formal-methods tool is **sound** if it never produces an incorrect proof.

// % Formally:

// % > If the tool says “the property holds,” then the property truly holds in the model.

// % Soundness is about **trustworthiness**.

// % In the `clip` example, a sound tool will never claim that the output is always between 0 and 10 unless this is mathematically true for all inputs.

// % Soundness is non-negotiable in safety-critical settings. A tool that is fast but unsound is worse than useless—it is dangerous.

// % ---

// % ### Completeness

// % A formal-methods tool is **complete** if it can prove every true property (within its domain).

// % Formally:

// % > If the property holds in the model, the tool is guaranteed to prove it.

// % Completeness is about **power**, not trust.

// % ---

// % ### The Tradeoff

// % In practice, most formal-methods tools are:

// % * **Sound but incomplete**

// % This means:

// % * They never lie
// % * But they may fail to prove some true properties

// % This tradeoff is intentional. For complex systems, achieving both soundness and completeness is often computationally infeasible.

// % For example, a tool might fail to prove that `clip(x)` always returns a value ≤ 10—not because the property is false, but because the tool’s reasoning technique is too conservative.

// % This result is acceptable. A false negative (failure to prove a true property) is inconvenient. A false positive (proving a false property) is unacceptable.

// % ---

=== Major Classes of Formal Methods Algorithms <sec:fm-techniques>

// *(Using One Running Example)*

We now introduce the major classes of formal-methods techniques. In contrast to
dynamic or testing-based analysis, which execute the program on specific inputs,
these formal methods _statically_ analyze the program's structure and logic to
reason about all possible behaviors.

We will use the `clip` function (@example:clip) as a running example to demonstrate how
each technique reasons about the same model and specification.


#paragraph[Model Checking][
Model checking (MC) works by _exploring all possible states_ of a system and
checking whether _bad states_ that violate the specification are reachable. At a high level, MC constructs a state machine to model the system's behavior and systematically checks whether any execution path leads to a violation of the specification.

MC works well for systems with a finite number of states---such as hardware
designs and communication protocols---because these systems have finite state
spaces that can be exhaustively explored. However, MC struggles with systems
involving continuous variables or infinite state spaces, e.g., a program with
loops.]

#example[
  For #code("clip"), MC would build a state machine representing all possible
  execution paths of the program for different inputs. It would then check
  whether any path leads to a state where the output is $< 0$ or $> 10$.

  A standard (naïve) MC would struggle here because the number of states is
  huge (the input $x$ is a real number). So MC would need to discretize or
  _bound_ the input space---e.g., by considering only integer values of $x$ from
  $-1000$ to $1000$---to make the reasoning more feasible.
]


#paragraph[Interactive Theorem Proving][
An interactive theorem prover (ITP) or _proof assistant_ attempts to reason
about the program using _logical inference rules_ to construct a formal proof
that the specification holds for all possible inputs. The reason it is called
"interactive" is that the user is often involved to guide the proof process by providing lemmas,
definitions, and strategies to help the prover construct the proof.

ITPs are powerful and can prove deep, rich properties about programs. However,
they may require significant human guidance to construct the proofs and do not
scale well to large or complex systems.]

#example[
  For #code("clip"), a theorem prover might reason as follows:

  + *Case 1:* If #code("x < 0"), #code("clip") returns $0$, which is in
    $[0, 10]$.
  + *Case 2:* If #code("x > 10"), #code("clip") returns $10$, which is in
    $[0, 10]$.
  + *Case 3:* Otherwise, $0 <= x <= 10$, so #code("clip") returns #code("x"),
    which is in $[0, 10]$.
]


#paragraph[Satisfiability Checking (SAT) and Satisfiability Modulo Theories (SMT) Solving][
SAT and SMT solving are _automated reasoning_ techniques#footnote[
  _Automated reasoning_ (AR) is the subfield of CS focused on algorithms that
  draw logical conclusions automatically, of which SAT/SMT solvers are a key
  example. FM is one major application of AR: it uses these reasoning engines
  to verify real systems against formal specifications.
]---also referred to as
_automatic theorem proving_---that reduce the verification problem to a question
of _logical satisfiability_. These solvers take as input a set of logical
formulae representing the program and the _negation_ of the specification, and
determine whether there exists an assignment of variables that makes the
formulae true (satisfiable) or not (unsatisfiable). If the formulae are
unsatisfiable, the property is proved. If satisfiable, the property is
disproved, and the solver provides a concrete counterexample demonstrating the
violation.

SAT/SMT solving is crucial to modern formal methods and software verification
tools due to its automation and ability to handle complex logical constraints.
However, pure SAT/SMT solving might struggle with scalability (e.g., to analyze large neural networks).
This leads to the development of hybrid techniques that combine SAT/SMT solving
with other methods such as abstract interpretation (described below).]

#example[
  For #code("clip"), a SAT/SMT solver would encode the program as logical
  constraints:

  $
    & (x < 0 ==> y = 0) \
    & quad and (x > 10 ==> y = 10) \
    & quad and (0 <= x <= 10 ==> y = x)
  $

  and the negation of the specification:

  $ (y < 0) or (y > 10) $

  It would then check whether these constraints are satisfiable. In this case,
  the solver would find that the constraints are _unsatisfiable_, proving that
  #code("clip") always returns a value in $[0, 10]$.
]


#paragraph[Abstract Interpretation][
Abstract interpretation (AbsInt) analyzes a program by automatically computing
_over-approximations_ of its behavior. Instead of tracking exact values, AbsInt
tracks abstract properties such as ranges or signs of variables---e.g., instead
of saying "#code("x = 5")", AbsInt might say "#code("x")$ in [0, 10]$" or
"#code("x") is non-negative".

Because AbsInt is fully automated and uses over-approximations, it is efficient
and scales well to large programs. However, over-approximation comes at the cost
of precision: it can cause AbsInt to produce false positives by reporting
potential violations that are not real bugs.
]

#example[
  For #code("clip"), an AbsInt tool might reason:

  + Input #code("x") is in $(-infinity, +infinity)$ and output #code("y") is
    unknown initially.
  + After the #code("if x < 0") branch, output #code("y") is in $[0, 0]$.
  + After the #code("if x > 10") branch, output #code("y") is in $[10, 10]$.
  + After the else branch, output #code("y") is in $[0, 10]$.
  + Combining all branches, output #code("y") is in $[0, 10]$.
]

For neural network verification, AbsInt is often used to compute bounds on the
outputs of neural network layers given bounds on the inputs (@chap:abstractions). AbsInt is necessary
because neural networks are very large and have complex nonlinear functions such
as ReLU that are difficult to analyze exactly.


=== Soundness and Completeness in FM

Two core concepts in FM are _soundness_ and _completeness_. These
describe the correctness and power of an FM
algorithm.#footnote[Mike Hicks wrote a good blog post on this topic:
#link("http://www.pl-enthusiast.net/2017/10/23/what-is-soundness-in-static-analysis/").]

#definition[
  An FM algorithm is *sound* if every property it claims to prove is actually
  true. In other words, if it says _"this property holds in this system,"_ then
  the property truly holds. Conversely, an FM algorithm is _not_ sound if it
  can claim that a false property is true.
]

#definition[
  An FM algorithm is *complete* if it can prove every true property. That is,
  if the property holds, the verifier will always be able to prove it.
  Conversely, an FM algorithm is *incomplete* if there exist true properties
  that it cannot prove.
]

Some notes:

- While a sound FM algorithm never claims a false property is true, it _may_
  claim that a true property is false (i.e., it can give false counterexamples).
  Thus, an extremely conservative FM algorithm that claims every property is
  false is still sound. Similarly, an FM algorithm that returns "unknown" for
  every property is also sound.

  Similarly, while a complete FM algorithm can prove every true property, it may
  also claim that a false property is true (i.e., it can produce false proofs).
  Thus, an extremely reckless (and untrustworthy) FM algorithm that claims every
  property is true is still complete. An FM algorithm that returns "unknown" for
  every property is also complete.

- It is important to distinguish between an FM algorithm and its implementation
  (the software tool). An FM algorithm may be sound (or complete), but its
  implementation---typically written by humans (or AI nowadays)---may contain
  bugs that cause it to produce unsound (or incomplete) results.

Ideally, an FM algorithm should be both sound and complete: never proving a
false property and able to prove every true property. However, achieving both is
often computationally infeasible for complex systems. Between the two, soundness
is typically prioritized in safety-critical settings because it is better to be
unsure about a system (and say "unknown", or even claim that it is unsafe) than
to incorrectly claim that it is safe when it is not. Thus, most practical FM
algorithms are designed to be _sound but incomplete_.

#pagebreak()
= Logics <chap:logics>

The topic of neural network verification (NNV) relies heavily on two fundamental
areas: #highlight[logic] (to formalize and reason about properties as logical formulae)
and #highlight[optimization] (to formulate and reason about numerical constraints). This
chapter provides the necessary background on both topics in detail, starting
with propositional logic and satisfiability, and then moving to linear and
mixed-integer programming.


== Propositional Logic and Satisfiability <sec:propositional-logic>

Propositional, or Boolean, logic is the branch of logic that studies formulae
built from Boolean variables, where each variable can take only the values
`True` or `False`. These formulae are combined using logical connectives such
as `and`, `or`, and `not`, and their evaluation always reduces to a single
truth value.

=== Syntax <sec:syntax>

A _propositional variable_ is a symbol (e.g., $x, y, z$). Logical formulae
are built _inductively_ from these variables using logical connectives as
follows:

- *Variables:* Any propositional variable $p$ is a formula.
- *Constants:* $top$ and $bot$ are formulae.
- *Negation:* If $phi$ is a formula, then so is $not phi$.
- *Binary connectives:* If $phi, psi$ are formulae, then so are
  $(phi and psi)$, $(phi or psi)$, and $(phi => psi)$.

#example[
  $
    (x or y) and (not x or z)
  $
  is a formula involving three variables $x, y, z$.
]

*Special connectives.* In addition to the standard connectives, we define some
special connectives that are often useful:

- _Implication_: $phi -> psi equiv not phi or psi$
- _Biconditional_ (or _equivalence_): $phi <-> psi equiv (phi -> psi) and (psi -> phi)$

#emph-block[
Notice here that we purely define the _syntax_ of propositional logic, which
allows us to construct valid formulae. We will discuss the _semantics_ or
meanings of formulae in @sec:propositional-semantics.
]

*Conjunctive Normal Form (CNF).* A formula is in CNF if it is a _conjunction_
of _clauses_, where each clause is a _disjunction_ of _literals_, where a
literal is either a variable $p$ or its negation $not p$.

#example[
  The formula
  $
    (x or y) and (not x or z)
  $
  is in CNF. Each clause $(x or y)$, $(not x or z)$ is a disjunction of
  literals.
]

*Transforming to CNF.* Any formula can be transformed into CNF. The transformation process
generally involves the following steps:

+ Eliminate biconditionals and implications.
+ Move negations inward using De Morgan's laws.
+ Distribute disjunctions over conjunctions.

#problem[
  Transform the following formula into CNF:
  $
    (x -> y) and (y -> z)
  $
]

=== Semantics <sec:propositional-semantics>

A logical formula in propositional logic has a truth value, which can be either
`True` or `False`. For example, the formula $x or not x$ is always `True`,
while the formula $x and y$ is `True` if both $x$ and $y$ are `True`, and
`False` otherwise. This is the _semantics_ of the formula.

An _assignment_ $sigma$, which is a mapping from propositional variables to
truth values, evaluates each formula to `True` or `False`. The truth value of
a propositional formula over the connectives $top, bot, not, and, or, =>$ under
an assignment $sigma$ is defined recursively:

$
  sigma(top) &= "True", \
  sigma(bot) &= "False", \
  sigma(not phi) = "True" quad &"iff" quad sigma(phi) = "False", \
  sigma(phi and psi) = "True" quad &"iff" quad sigma(phi) = "True" "and" sigma(psi) = "True", \
  sigma(phi or psi) = "True" quad &"iff" quad sigma(phi) = "True" "or" sigma(psi) = "True", \
  sigma(phi => psi) = "True" quad &"iff" quad sigma(phi) = "False" "or" sigma(psi) = "True".
$

#problem[
  For the formula
  $
    (x or y) and (not x or z),
  $
  evaluate its truth value under all $2^3 = 8$ possible assignments of
  $x, y, z$.
]


== Satisfiability and Validity

#definition(title: "Satisfiability")[
  A formula $phi$

  - is _satisfiable_ if there exists *some* assignment $sigma$ that satisfies
    it, i.e., $exists sigma. space sigma(phi) = "True"$.
  - is _unsatisfiable_ if *no* assignment satisfies it, i.e.,
    $forall sigma. space sigma(phi) = "False"$.
  - is _valid_ if *all* assignments satisfy it, i.e.,
    $forall sigma. space sigma(phi) = "True"$.
] <def:sat-validity>

#example[
  The formula $p$ is satisfiable (i.e., $exists sigma. space sigma(p) = "True"$).

  The formula
  $
    (p) and (not p)
  $
  is unsatisfiable (no assignment works). In contrast,
  $
    (p or not p)
  $
  is valid.
]

#problem[
  Show that $(phi => psi)$ is equivalent to $(not phi or psi)$.
  (Hint: construct a truth table.)
]

#problem[
  Assume $p, q$ are boolean variables.

  + Can a formula be satisfiable but not valid? If yes, provide an example of
    such a formula over $p, q$.
  + Can a formula be valid but not satisfiable? If yes, provide an example of
    such a formula over $p, q$.
  + Give a formula over $p, q$ that is satisfiable under exactly 1 assignment.
  + Let $phi$ be a formula over $p, q$. If $phi$ is valid, how many
    assignments satisfy it?
] <problem:short-questions>



=== SAT Checking <sec:sat-solving>

A _SAT solver_ takes a propositional formula, typically in CNF, as input and
determines its satisfiability by searching for a satisfying assignment $sigma$
that makes the formula true. If one exists it returns #sat (and optionally
$sigma$); otherwise it reports unsat.

#example[
  $
    phi_1 &= (x or y) and (not x or z) quad => #sat \
    phi_2 &= (x) and (not x) quad => #unsat
  $
]

#problem[
  Use the Z3 solver to check whether
  $
    (x or y) and (not x or y) and (x or not y)
  $
  is satisfiable. Provide a satisfying assignment if it exists.
]


=== Validity Checking <sec:validity-checking>

A formula $alpha$ is valid if all assignments satisfy it. This is equivalent to
its negation $not alpha$ being unsatisfiable:
$
  "valid"(alpha) <==> "unsat"(not alpha).
$
Thus, to check that $alpha$ is valid, we can use a SAT solver to check that
$not alpha$ is #unsat.


=== Complexity of SAT <sec:complexity-sat>

SAT checking (and therefore validity checking) of propositional formulae is
NP-Complete. This means it is unlikely that an efficient (polynomial-time)
algorithm exists for all SAT instances, and in the worst case any SAT solving
algorithm may need to explore an exponential number of assignments. SAT solvers
therefore employ heuristics and optimizations to handle practical instances
efficiently, even though worst-case complexity remains exponential. We discuss
DPLL, a popular SAT solving algorithm, next.


== Satisfiability Modulo Theories (SMT) <chap:smt>

SAT solvers only reason about propositional formulae, which contain only Boolean
variables and logical operators such as $and, or$. However, in verification
problems we often need to reason about arithmetic constraints such as
$2x + 3y <= 7$, $x >= 0$, $x, y in ZZ$.

This leads to _Satisfiability Modulo Theories (SMT)_:

- SMT generalizes propositional logic by adding background theories (e.g.,
  linear arithmetic, bit-vectors, arrays).
- An SMT formula mixes Boolean structure with constraints from these theories.

#example[
  Is the formula $2x = 1$ satisfiable?

  The answer depends on the chosen theory. Over the reals ($RR$) it is #sat
  (e.g., $x = 0.5$), but over the integers ($ZZ$) it is #unsat.
] <ex:smt2>


== SMT Solvers <sec:smt-solvers>

Popular SMT solvers include Z3 (Microsoft Research), CVC5, and dReal. They
combine:

- A SAT solver for the Boolean skeleton.
- A _theory solver_ or T-solver (e.g., linear arithmetic) for the numeric
  parts.

The SAT solver guesses a truth assignment for the Boolean structure. The
T-solver checks whether the corresponding arithmetic constraints are feasible.
This loop continues until either a satisfying assignment is found or #unsat is
proven.

#problem[
  Decide the satisfiability of:
  $
    (x > 3) and (y < 2) and (x + y < 1).
  $
  First reason informally by hand, then confirm with an SMT solver such as Z3.
]


=== Z3 SMT Solver <sec:z3>

Z3 is a well-known SMT solver developed by Microsoft Research. Here we show how
to use it to check propositional formulae and SMT formulae involving linear
arithmetic constraints.

*Installing.* You can install Z3 using your package manager:

```sh
brew install z3          # Homebrew
pip install z3-solver    # pip
apt install z3 python3-z3  # apt (Debian-based Linux)
conda install z3solver   # conda
```

Then try its Python interface:

```python
from z3 import *
x = Int('x')
y = Int('y')
solve(x > 2, y < 10, x + 2*y = 7)
```

#example(title: "Propositional Logic")[
  We use Z3 to check satisfiability of propositional formulae and generate
  counterexamples.

  ```python
  from z3 import *

  x, y = Bools('x y')
  formula = And(Or(x, y), Or(Not(x), y))
  s = Solver()
  s.add(formula)
  print(s.check())   # output: sat
  print(s.model())   # a possible model is {x=True, y=True}
  ```
] <ex:z3-propositional>

#problem[
  Modify the code in the propositional logic example above to check
  $
    (x and not x).
  $
  Confirm that the result is `unsat`.
] <prob:z3-0>

#example(title: "Linear Constraints")[
  We now use Z3 as an SMT solver to check linear constraints.

  ```python
  from z3 import *
  x, y = Reals('x y')

  # example 1
  s = Solver()
  s.add(x > 0, y > 0, 2*x + y <= 1)
  print(s.check())  # Output: unsat

  # example 2
  s = Solver()
  s.add(x + y <= 4, x >= 0, y >= 0)
  print(s.check())  # Output: sat
  print(s.model())  # Output: {x=0, y=0}

  # example 3
  x, y = Ints('x y')
  s = Solver()
  s.add(Implies(x > 3, y > 2))
  print(s.check())  # Output: sat
  print(s.model())  # Output: {x=0, y=0}
  ```
] <ex:z3-linear-constraints>

#problem[
  Use Z3 to check whether the constraints
  $
    x + y = 5, quad x >= 0, quad y >= 0
  $
  are satisfiable, and if so, ask Z3 for a model.
] <prob:z3-1>

#problem[
  Use Z3 to check the formula given in the SMT example above. Do it for both
  the reals and integers.
] <prob:z3-2>

#problem[
  Use Z3 to formulate and check the statement
  _"If $x > 3$ then $y > 2$ AND $x <= 1$"_. Is it satisfiable? What model
  does Z3 return?
] <prob:z3-3>

#example(title: "DNN-style checking")[
  Consider a one-neuron ReLU: $y = max(0, x - 1)$. We want to check if the
  property _"For all $x <= 0$, we have $y = 0$"_ holds.

  ```python
  x, y = Reals('x y')
  s = Solver()

  # y = max(0, x-1)
  s.add(y >= x-1, y >= 0)
  s.add(Or(y = x-1, y = 0))  # ReLU
  s.add(x <= 0, y != 0)        # Negation of property

  print(s.check())  # Output: unsat, property holds
  ```
]

#problem[
  Modify the above to check the property:
  _"For all $x >= 2$, we have $y >= 1$."_
  What does Z3 return?
]

#pagebreak()
= SAT Solving Algorithms <chap:sat-solving-algorithms>

== DPLL <sec:dpll>

#figure(
  image("figure/dpll.pdf", width: 70%),
  caption: [The DPLL algorithm for SAT solving.]
) <fig:dpll>

@fig:dpll gives an overview of the *DPLL* algorithm---a SAT solving technique introduced in 1961 by Davis, Putnam,
Logemann, and Loveland. DPLL is an iterative algorithm that takes as input a
propositional formula and (i) decides an unassigned variable and assigns it a
truth value, (ii) performs Boolean constraint propagation (BCP, also called
Unit Propagation), which detects single-literal clauses that either force a
literal to be true or give rise to a conflict, (iii) analyzes the conflict to
backtrack to a previous decision level `dl`, and (iv) erases assignments at
levels greater than `dl` to try new assignments.

These steps repeat until DPLL finds a satisfying assignment and returns `sat`,
or decides that it cannot backtrack (`dl = -1`) and returns `unsat`.


=== Decide <sec:decide>

The _Decide_ step selects an unassigned variable and assigns it a truth value.
Decision is the main source of state-space explosion in DPLL because it uses
random choices or heuristics (e.g., VSIDS) to select the variable and truth
value. Thus, value assignments can be _wrong_, leading to conflicts later on.

In addition, each decision creates a new _decision level_. The decision level starts at 0
and increases by 1 with each new assignment. Decision level is used to manage
backtracking and erasing of assignments when conflicts occur.

#example[Simple Decision][
  Consider the CNF:
  $
    phi = (x_1 or x_2) and (not x_1 or x_3).
  $
  All variables are initially unassigned. DPLL may choose:
  $
    "Decide: " x_1 = "True" quad ("Decision level " 1).
  $
]

#example(title: "Decision Using a Heuristic")[
  Given:
  $
    phi = (x_1 or x_3) and (x_3 or x_4) and (not x_3 or x_2),
  $
  a heuristic such as VSIDS may choose the most frequent variable:
  $
    "Decide: " x_3 = "False".
  $
]


=== Boolean Constraint Propagation (BCP) <sec:bcp>

BCP detects _unit clauses_, i.e., clauses with exactly one unassigned literal
and all other literals set to False. Such clauses force the remaining literal
to be assigned True.

BCP is very useful because it can determine variable assignments directly
without guessing (which is Decide as described in @sec:decide). For example, if we have the clause $(not x_1 or x_2)$ and
$x_1$ is True, then BCP forces $x_2$ to be True to satisfy the clause. 

BCP is often
invoked after each decision to propagate the consequences of the assignment.

#example(title: "Single Propagation")[
  $
    phi = (x_1) and (not x_1 or x_2).
  $
  The unit clause $(x_1)$ forces $x_1 = "True"$. Now $(not x_1 or x_2)$
  becomes $("False" or x_2)$, hence $x_2 = "True"$.
]

#example(title: "Propagation Leading to Conflict")[
  $
    phi = (x_1) and (not x_1).
  $
  BCP assigns $x_1 = "True"$, immediately contradicting $(not x_1)$.
]

#example(title: "Cascade of Propagations")[
  $
    phi = (x_1) and (not x_1 or x_2) and (not x_2 or x_3).
  $
  BCP yields:
  $
    x_1 = "True" => x_2 = "True" => x_3 = "True".
  $
]


=== Conflict Analysis and Backtracking <sec:conflict-analysis>

A _conflict_ occurs when the formula is False under the current assignment
$sigma$. Since the formula is in CNF, a conflict arises when at least one
clause is False (i.e., all its literals are False).

#example[
  $
    phi = (not x_1 or x_2) and (not x_2) and (x_1).
  $
  Assignments $x_1 = "True"$ and $x_2 = "False"$ make
  $(not x_1 or x_2) = ("False" or "False")$, producing a conflict.
]

*Conflict Analysis.* Conflict analysis explains why the conflict occurred and
generates a _learned clause_ that prevents the solverfrom revisiting the same
conflicting assignment. Most modern solvers use the 1st-UIP (Unique Implication
Point) learning scheme.

#example[Simple Learned Clause][
  $
    (x_1) and (not x_1).
  $
  The conflict directly yields the learned clause $not x_1 or x_1$. Because
  this is always false, the solver concludes the formula is unsatisfiable.
]

#example[UIP Conflict Analysis][
  Assume decision levels:
  $
    x_1 = "True" space (d l = 1), quad x_2 = "False" space (d l = 2).
  $
  Clauses:
  $
    (not x_1 or x_2 or x_3), quad (not x_2 or x_3), quad (not x_3).
  $
  Propagation yields $x_3 = "False"$, causing a conflict with $(not x_3)$.
  The learned clause (1st-UIP) is:
  $
    (not x_2 or not x_1).
  $
]

*Backtracking.* Given a learned clause, DPLL backtracks to the decision level
at which the clause becomes unit.

#example(title: "Non-Chronological Backtracking")[
  Decision levels:
  $
    d l = 1: x_1 = "True", quad d l = 2: x_2 = "True", quad d l = 3: x_3 = "False".
  $
  Conflict analysis produces the learned clause $(not x_1 or x_3)$. The
  highest decision level in the clause except the most recent UIP is 1, so the
  solver backtracks to level 1, undoing assignments to $x_2$ and $x_3$.
]


== CDCL <sec:cdcl>

Modern DPLL solving improves the original version with Conflict-Driven Clause
Learning (CDCL) @bayardo1997using, @marques1999grasp, @569607. DPLL with CDCL _learns new clauses_ to avoid past conflicts
and backtrack more intelligently (e.g., using non-chronological backjumping).
Due to its ability to learn new clauses, CDCL can significantly reduce the
search space and allow SAT solvers to scale to large problems. 

In the following, whenever we
refer to DPLL hereafter, we mean DPLL with CDCL.


== DPLL(T) <sec:dpll-t>

DPLL(T) @nieuwenhuis2006solving extends DPLL for propositional formulae to check SMT formulae involving
non-Boolean variables, e.g., real numbers and data structures such as strings,
arrays, and lists. DPLL(T) combines DPLL with dedicated _theory solvers_ to
analyze formulae in those
theories.#footnote[SMT stands for Satisfiability Modulo Theories; the T in
DPLL(T) stands for Theories.]
For example, to check a formula involving linear arithmetic over the reals
(LRA), DPLL(T) may use a theory solver that applies linear programming to check
the constraints in the formula. 

Modern DPLL(T)-based SMT solvers such as Z3 @de2008z3 and
CVC4 @barrett2011cvc4 include solvers supporting a wide range of theories including linear
arithmetic, nonlinear arithmetic, strings, and arrays @kroening2016decision.

#pagebreak()
= Linear Programming (LP) <chap:lp>

Linear Programming (LP) and its generalization Mixed-Integer Linear Programming
(MILP) form the optimization backbone of many NNV techniques. This chapter
provides an overview of LP and MILP in the context of NNV.


== Linear Constraints and Objectives <sec:lp>

At a high level, LP is a method for optimizing an objective with respect to
certain constraints. In LP, both the objective and the constraints are _linear_.

*Linear Constraints.* Linear constraints are inequalities involving linear
combinations of variables. A linear inequality has the general form
$
  c_1 x_1 + c_2 x_2 + dots + c_n x_n <= b,
$
where $c_i, b in RR$. These constraints limit the feasible values the variables
$x_i$ can take. The set of points satisfying all constraints is called the
_feasible region_.

#example[
  Consider the following linear constraints:
  $
    x + y <= 4, quad x >= 0, quad y >= 0.
  $
  The feasible region is a triangle with vertices at $(0,0)$, $(4,0)$,
  $(0,4)$.
] <ex:lp-constraints>

*Linear Objective Functions.* A linear objective function $z$ has the general
form
$
  z(x_1, x_2, dots, x_n) = c_1 x_1 + c_2 x_2 + dots + c_n x_n,
$
where $c_i in RR$ are coefficients and $x_i in RR$ are decision variables.

*Optimizing Goals.* The goal is to optimize (maximize or minimize) $z$ subject
to a set of linear constraints:
$
  & "maximize" quad z \
  & "subject to" \
  & quad {c_1 x_1 + dots + c_n x_n <= b, dots}
$

#example[
  Maximize $1.5x + 2y$ subject to $x + y <= 4$, $x >= 0$, $y >= 0$.

  Solving for the intersection points gives the vertices of the feasible region:
  $(0,0)$, $(4,0)$, $(0,4)$.

  Evaluating the objective at each vertex:
  #align(center,
  table(
    columns: 3,
    stroke:none,
    table.header[$x$][$y$][$z = 1.5x + 2y$],
    table.hline(),
    $0$, $0$, $0$,
    $4$, $0$, $6$,
    $0$, $4$, $8$,
  ))

  The maximum value of $z$ is $8$, achieved at vertex $(0, 4)$.
] <ex:lp-example1>

#example[
  Minimize $z = x + y$ subject to $2x + y >= 3$, $x + 2y >= 4$,
  $x >= 0$, $y >= 0$.

  Solving the boundary equations gives the vertices of the feasible region:
  $(0, 3)$, $(4, 0)$, $(2/3, 5/3)$.

  Evaluating the objective at each vertex:

  #align(center,
  table(
    columns: 3,
    stroke:none,
    table.header[$x$][$y$][$z = x + y$],
    table.hline(),
    $0$, $3$, $3$,
    $4$, $0$, $4$,
    $2/3$, $5/3$, $7/3$,
  ))

  The minimum value of $z$ is $7/3$, achieved at $(2/3, 5/3)$.
] <ex:lp-example2>

#problem[
  Maximize $z = 4x + 5y$ subject to $x + y <= 20$, $2x + 4y <= 72$.

  + Identify the corner points.
  + Evaluate the objective function at each corner point.
] <ex:lp-problem2>


== Mixed-Integer Linear Programming (MILP) <sec:milp-basics>

LP assumes continuous variables over real numbers. A mixed-integer linear
program---MILP---extends LP by requiring some variables to be integers (often
binary 0 or 1). This is useful for modeling discrete decisions and logical
constraints, e.g., on/off decisions, yes/no choices, and active/inactive ReLU.

*Linear Constraints.* In MILP, a linear constraint can involve both integer and
continuous decision variables:
$
  c_1 x_1 + dots + c_n x_n + d_1 y_1 + dots + d_m y_m <= b,
$
where $x_i in RR$ are continuous variables, $y_j in ZZ$ are integer variables,
and $c_i, d_j, b in RR$.

*Objective Function.* A linear objective function in MILP:
$
  z = c_1 x_1 + dots + c_n x_n + d_1 y_1 + dots + d_m y_m.
$

*Optimizing Goals.*
$
  & "maximize" quad z(x_1, dots, x_n, y_1, dots, y_m) \
  & "subject to" \
  & quad {c_1 x_1 + dots + c_n x_n + d_1 y_1 + dots + d_m y_m <= b}
$

#example[
  A company sells a chair for \$50 and a table for \$120. Production costs are
  \$20 per chair and \$70 per table. It takes 3 hours and 5 units of wood to
  produce a chair, and 1 hour and 20 units of wood to produce a table.

  Maximize profit without exceeding a monthly budget of 200 units of wood,
  80 hours of labor, and \$800 in production costs.

  *Decision variables:* $x$ = number of chairs, $y$ = number of tables.

  *Objective:*
  $
    P = 50x + 120y - 20x - 70y = 30x + 50y.
  $

  *Constraints:*
  $
    5x + 20y <= 200 & quad => quad x + 4y <= 40, \
    3x + y <= 80, \
    20x + 70y <= 800 & quad => quad 2x + 7y <= 80, \
    x >= 0, quad y >= 0.
  $

  The feasible vertices are $(0,0)$, $(0,10)$, $(80/3, 0)$, and
  $(280/11, 40/11)$. Evaluating $P$:
  #align(center,
  table(
    columns: 3,
    stroke:none,
    table.header[$x$][$y$][$P = 30x + 50y$],
    table.hline(),
    $0$, $0$, $0$,
    $0$, $10$, $500$,
    $80/3$, $0$, $800$,
    $280/11$, $40/11$, $945.45$,
  ))

  The maximum is \$945.45 at $(280/11, 40/11)$. Since fractional production
  is not possible, the company should produce 24 chairs and 4 tables per week
  for a profit of \$920.00.
] <ex:lp-example3>


=== Encoding Binary Variables <sec:milp-binary>

MILP problems often involve conditions where the answer _depends_ on some
condition. We can encode such logical implications using _binary variables_ ($z in {0,1}$)
and a _large constant_ $M$ (e.g., $infinity$).

#example[
  To encode "if $z = 1$ then $x >= 5$", use:
  $
    x >= 5 - M(1 - z), quad z in {0, 1}.
  $
  This works because:
  - $z = 1 => x >= 5 - M(0) => x >= 5$.
  - $z = 0 => x >= 5 - M$, which is vacuously true for large $M$.
]

#problem[
  Encode the disjunction $x >= 5 or x <= 3$ in MILP.
]

#solution[
  Use two constraints:
  - $x >= 5 - M(1 - z)$ (if $z = 1$, this enforces $x >= 5$)
  - $x <= 3 + M z$ (if $z = 0$, this enforces $x <= 3$)
]

#example[Encoding ReLU in MILP][
  To encode the ReLU activation function $y = max(0, x)$, use:
  $
    & y >= x, \
    & y >= 0, \
    & y <= x + M(1 - z), \
    & y <= M z, \
    & z in {0, 1}.
  $
  This works because $z = 1 => y = x$ and $z = 0 => y = 0$.
] <ex:relu_milp>

#problem[
  Consider again the ReLU encoding above but now $x$ has bounds $L <= x <= U$.
  Modify the MILP encoding so that $L$ and $U$ are used _directly_ instead of
  a large constant $M$.
] <problem:relu-milp-bounds>

#solution[
  $
    & y >= x, \
    & y >= 0, \
    & y <= x + (U - x)(1 - z), \
    & y <= U z, quad z in {0, 1}, \
    & L <= x <= U.
  $
]


== Using Z3 to Solve LP and MILP

We can use Z3's optimization capabilities to solve both LP and MILP problems.
In practice, dedicated solvers such as Gurobi or CPLEX are preferred for large
problems, but Z3 is effective for demonstration purposes.

#example[
  We solve the LP example from @ex:lp-example1 using Z3:

  ```python
  from z3 import *

  x, y = Reals("x y")
  opt = Optimize()
  opt.add(x + y <= 4, x >= 0, y >= 0)

  z = 1.5*x + 2*y
  h = opt.maximize(z)

  if opt.check() = sat:
      print("Optimal sol:", opt.model())  # [x = 0, y = 4]
      print("Max value:", opt.upper(h))   # 8
  ```
] <ex:lp-z3>

#problem[
  Solve @ex:lp-problem2 using Z3.
]

#problem[
  Solve @ex:lp-example3 using Z3.
]

#problem[
  Find two interesting MILP problems online, formulate each as a MILP, solve
  by hand (showing all steps), and implement in Z3. 
  
  For each problem: write
  down the problem statement and cite the source, clearly state the objective
  and constraints, and document the Z3 code with comments.
] <ex:milp-online>

#problem[
  Minimize $z = x + y$ subject to:
  $
    x + 2y >= 3, quad 3x + y >= 3, quad x, y >= 0, quad x, y in RR.
  $

Remember to:
  + State the constraints and objective function.
  + Find the corner or candidate points.
  + Evaluate the objective at each corner point.
  + State the optimal solution.
] <problem:milp-hand>

// #solution[
//   *1. Constraints and Objective Function:*

//   Minimize $z = x + y$ subject to $x + 2y >= 3$, $3x + y >= 3$, $x, y >= 0$.

//   *2. Corner Points:*

//   - $x = 0$ and $x + 2y = 3$: $(0, 1.5)$. Check: $3(0) + 1.5 = 1.5 < 3$, not feasible.
//   - $y = 0$ and $x + 2y = 3$: $(3, 0)$. Check: $3(3) = 9 >= 3$, feasible.
//   - $x = 0$ and $3x + y = 3$: $(0, 3)$. Check: $0 + 2(3) = 6 >= 3$, feasible.
//   - $y = 0$ and $3x + y = 3$: $(1, 0)$. Check: $1 + 0 = 1 < 3$, not feasible.
//   - Intersection of $x + 2y = 3$ and $3x + y = 3$: $x = 3/5$, $y = 6/5$, feasible.

//   Feasible corner points: $(3, 0)$, $(0, 3)$, $(3/5, 6/5)$.

//   *3. Objective Values:*

//   #table(
//     columns: 3,
//     table.header[$x$][$y$][$z = x + y$],
//     $3$, $0$, $3$,
//     $0$, $3$, $3$,
//     $3/5$, $6/5$, $1.8$,
//   )

//   *4. Optimal Solution:*

//   The minimum value of $z$ is $9/5 = 1.8$, achieved at $(3/5, 6/5)$. Both
//   constraints are binding (active) at this point.
// ]

=== Using LP as Feasibility Checking <sec:lp-feasibility>

In addition to optimization, LP can be used for _feasibility checking_ of linear constraints: are there any values for the variables that satisfy all the constraints? This is achieved by running the LP solver with a constant objective (e.g., "minimize 0"), in which case it tries to find _any_ point in the feasible region or show that _none_ exists. This makes LP solving useful for property checking and verification.

The main difference between LP feasibility and SMT satisfiability checking is the type of constraints they handle. SMT supports richer logics involving booleans, integers, nonlinear arithmetic, and other theories, while LP feasibility is limited to linear equalities/inequalities over real numbers. For NNV problems that involve only linear real arithmetic, LP feasibility is sufficient and often more efficient.

#example[
  For the constraints ${x + y <= 4,x >= 0,y >= 0}$, running an LP solver
  with objective $min 0$ will return a point (e.g., $x = 0, y = 0$) within the
  feasible region.
]


// #solution[
//   *1. Satisfiable but not valid:*

//   Yes. A formula is satisfiable if _some_ assignment makes it true, while
//   validity requires _all_ assignments to make it true.

//   Example: $p$ is satisfiable (true when $p = "True"$) but not valid (false
//   when $p = "False"$). Another example: $p and q$ is true only when both are
//   `True`.

//   *2. Valid but not satisfiable:*

//   No. If a formula is valid it is true under every assignment, hence certainly
//   true under _some_ assignment. Every valid formula is also satisfiable.

//   *3. Formula satisfiable under exactly 1 assignment:*

//   Example: $p and not q$ is satisfiable only when $p = "True"$ and
//   $q = "False"$. Checking all four assignments:

//   - $p = "True",  q = "True"$: $(p and not q) = ("True" and "False") = "False"$
//   - $p = "True",  q = "False"$: $(p and not q) = ("True" and "True") = "True"$
//   - $p = "False", q = "True"$: $(p and not q) = ("False" and "False") = "False"$
//   - $p = "False", q = "False"$: $(p and not q) = ("False" and "True") = "False"$

//   Another example: $p and q$ is satisfiable only when both are `True`.

//   *4. Number of satisfying assignments for a valid formula:*

//   If $phi$ is valid over $p, q$ there are $2^2 = 4$ total assignments and all
//   4 satisfy $phi$. The answer is *4*.
// ]






// \begin{example}[Linear Constraints.]\label{ex:z3-linear-constraints}

// We now use Z3 as an SMT solver to check linear constraints.

//     \begin{lstlisting}
// from z3 import *
// x, y = Reals(`x y')

// # example 1
// s = Solver()
// s.add(x > 0, y > 0, 2*x + y <= 1)
// print(s.check())  # Output: unsat

// # example 2
// s = Solver()
// s.add(x + y <= 4, x >= 0, y >= 0)
// print(s.check()) # Output: sat
// print(s.model())  # Output: {x=0, y=0}


// # example 3
// x, y = Ints(`x y')
// s = Solver()
// s.add(Implies(x > 3, y > 2))
// print(s.check()) # Output: sat
// print(s.model()) # Output: {x=0, y=0}
// \end{lstlisting}
// \end{example}

// \begin{problem <prob:z3-1}
// Use Z3 to check whether the constraints
// \[
// x+y=5, quad x >= 0, quad y >= 0
// \]
// are satisfiable, and if so, ask Z3 for a model.
// \end{problem}

// \begin{problem <prob:z3-2}
// Use Z3 to check the formula given in~@ex:smt2. Do it for both the reals and integers.
// \end{problem}

// \begin{problem <prob:z3-3}
// Use Z3 to formulate and check the statement \texttt{``If $x>3$ then $y>2$ AND $x <=q 1$''}.
// Is it satisfiable? What model does Z3 return?
// \end{problem}



// \begin{example}[DNN-style checking]
// Consider a one-neuron ReLU: $y = \max(0, x - 1)$.
// We want to check if the property \texttt{``For all $x <=q 0$, we have $y=0$''} holds.


// \begin{lstlisting}
// x, y = Reals(`x y')
// s = Solver()

// # y = max(0, x-1)
// s.add(y >= x-1, y >= 0)
// s.add(Or(y = x-1, y = 0)) # ReLU
// s.add(x <= 0, y != 0) # Negation of property

// print(s.check()) # Output: unsat, property holds
// \end{lstlisting}
// \end{example}


// \begin{problem}
// Modify the above to check property:
// \texttt{``For all $x >= 2$, we have $y >= 1$.''}
// What does Z3 return?
// \end{problem}


// = SAT Solving Algorithms <chap:sat-solving-algorithms}
//  == DPLL <sec:dpll}

// \begin{figure}
//     \centering
//    in cludegraphics[width=0.7\linewidth]{figure/dpll.pdf}
//   \caption{\label{fig:dpll} The classicial DPLL Algorithm.}
// \end{figure}


// @fig:dpll gives an overview of \textbf{DPLL}, a SAT solving technique introduced in 1961 by Davis, Putnam, Logemann, and Loveland~\cite{davis1962machine}. DPLL is an iterative algorithm that takes as input a propositional formula and (i) decides an unassigned variable and assigns it a truth value, (ii) performs Boolean constraint propagation (BCP or also called Unit Propagation),  which detects single literal clauses that either force a literal to be true in a satisfying assignment or give rise to a conflict; (iii) analyzes the conflict to backtrack to a previous decision level \texttt{dl}; and (iv) erases assignments at levels greater than \texttt{dl} to try new  assignments.

// These steps repeat until DPLL finds  a satisfying assignment and returns \texttt{sat}, or decides that it cannot backtrack (\texttt{dl}=-1) and returns \texttt{unsat}.




// \subsection{Decide}


// The \emph{Decide} step selects an unassigned variable and assigns it a truth value.
// Decision is the main source for the state space explosion in DPLL because it uses random choices or heuristics (e.g., VSIDS~\cite{moskewicz2001chaff}) to select the variable and truth value.
// Thus, value assignments can be \emph{wrong} (e.g., $x$ should be False but is assigned True), leading to conflicts later on.

// In addition, value assignment creates a new \emph{decision level}. In the beginning, the decision level is 0 (no decisions made yet). Each time a new variable is assigned, the decision level increases by 1.  Decision level is used to manage backtracking and erasing assignments discussed later.

// \begin{example}[Simple Decision]
// Consider the CNF:
// \[
// \varphi = (x_1 \lor x_2) \ \land\ (\lnot x_1 \lor x_3).
// \]
// All variables are initially unassigned.
// DPLL may choose:
// \[
// \text{Decide: } x_1 = \text{True} \qquad (\text{Decision level } 1).
// \]
// \end{example}

// \begin{example}[Decision Using a Heuristic]
// Given:
// \[
// \varphi = (x_1 \lor x_3) \land (x_3 \lor x_4) \land (\lnot x_3 \lor x_2),
// \]
// a heuristic such as VSIDS may choose the most frequent variable:
// \[
// \text{Decide: } x_3 = \text{False}.
// \]
// \end{example}


// % \paragraph{Assignments} A partial assignment $sigma$ maps variables to truth values (\texttt{True} or \texttt{False}). For example, $sigma =  {x_1=\text{True}, x_2=\text{False} }$ assigns $x_1$ to True and $x_2$ to False, leaving other variables unassigned.
// % A complete assignment maps all variables to truth values.

// \subsection{Boolean Constraint Propagation (BCP) <sec:bcp}

// BCP detects \emph{unit clauses}, i.e., clauses with exactly one unassigned literal
// and all other literals set to False. Such clauses force the remaining literal to be
// assigned True.

// BCP is very useful because it can determine variable assignments directly without using Decide, which can guesses wrong. For example, if we have the clause $(\lnot x_1 \lor x_2)$ and we know $x_1$ is True, then we don't need to guess $x_2$; it must be True to satisfy the clause.

// BCP is often invoked after each decision to propagate the consequences of the assignment.

// \begin{example}[Single Propagation]
// \[
// \varphi = (x_1) \land (\lnot x_1 \lor x_2).
// \]
// The unit clause $(x_1)$ forces:
// \[
// x_1 = \text{True}.
// \]
// Now $(\lnot x_1 \lor x_2)$ becomes $(\text{False} \lor x_2)$, hence:
// \[
// x_2 = \text{True}.
// \]
// \end{example}

// \begin{example}[Propagation Leading to Conflict]
// \[
// \varphi = (x_1) \land (\lnot x_1).
// \]
// BCP assigns $x_1 = \text{True}$, immediately contradicting $(\lnot x_1)$.
// \end{example}

// \begin{example}[Cascade of Propagations]
// \[
// \varphi = (x_1) \land (\lnot x_1 \lor x_2) \land (\lnot x_2 \lor x_3).
// \]
// BCP yields:
// \[
// x_1=\mathrm{True} \Rightarrow x_2=\mathrm{True} \Rightarrow x_3=\mathrm{True}.
// \]
// \end{example}

// % =========================================================
// % TikZ diagram for BCP
// % =========================================================
// % \begin{figure}
// % \centering
// % \begin{tikzpicture}[node distance=2cm,auto,>=latex,thick]
// % \node (x1) [circle,draw] {$x_1=\text{T}$};
// % \node (x2) [circle,draw,right of=x1] {$x_2=\text{T}$};
// % \node (x3) [circle,draw,right of=x2] {$x_3=\text{T}$};

// % \draw[->] (x1) -- node[above]{from $(\lnot x_1 \lor x_2)$} (x2);
// % \draw[->] (x2) -- node[above]{from $(\lnot x_2 \lor x_3)$} (x3);

// % \caption{Implication chain created by BCP. <fig:bcp-chain}
// % \end{tikzpicture}
// % \end{figure}


// \subsection{Conflict Analysis and Backtracking <sec:conflict-analysis}


// A \emph{conflict} occurs the formula is False under the current assignment $sigma$. More specifically, since the formula is in CNF, a conflict arises when at least one clause is False (i.e., all its literals are False).

// \begin{example}
// \[
// \varphi = (\lnot x_1 \lor x_2)\ \land\ (\lnot x_2)\ \land\ (x_1).
// \]
// Assignments $x_1=\mathrm{True}$ and $x_2=\mathrm{False}$ make
// $(\lnot x_1 \lor x_2) = (\text{False} \lor \text{False})$, producing a conflict.
// \end{example}

// % TikZ conflict visualization
// % \begin{figure}[h]
// % \centering
// % \begin{tikzpicture}[>=latex,thick]
// % \node (x1) [circle,draw] {$x_1=\text{T}$};
// % \node (x2) [circle,draw,right=2cm of x1] {$x_2=\text{F}$};
// % \node (cl) [rectangle,draw,below=1cm of $(x1)!0.5!(x2)$,text width=3.5cm,align=center]
// % {Clause $(\lnot x_1 \lor x_2)$ becomes $(\text{F} \lor \text{F})$};

// % \draw[->] (x1) -- (cl);
// % \draw[->] (x2) -- (cl);

// % \node (boom) [below=1cm of cl] {\Large\textbf{Conflict!}};

// % \caption{Conflict arises when a clause becomes empty.}
// % \label{fig:conflict}
// % \end{tikzpicture}
// % \end{figure}

// % =========================================================
// \paragraph{Conflict Analysis}


// Conflict analysis explains why the conflict occurred and generates a \emph{learned
// clause} that prevents the solver from revisiting the same conflicting assignment.
// Most modern solvers use the 1st-UIP (Unique Implication Point) learning scheme.

// \begin{example}[Simple Learned Clause]
// \[
// (x_1) \land (\lnot x_1).
// \]
// The conflict directly yields the learned clause:
// \[
// \lnot x_1 \lor x_1.
// \]
// Because this is always false, the solver concludes the formula is unsatisfiable.
// \end{example}

// \begin{example}[UIP Conflict Analysis]
// Assume decision levels:
// \[
// x_1=\mathrm{True} \ (dl=1), \qquad x_2=\mathrm{False}\ (dl=2).
// \]
// Clauses:
// \[
// (\lnot x_1 \lor x_2 \lor x_3),\qquad (\lnot x_2 \lor x_3),\qquad (\lnot x_3).
// \]
// Propagation yields $x_3=\mathrm{False}$, causing a conflict with $(\lnot x_3)$.

// The implication graph is:

// % \begin{figure}[h]
// % \centering
// % \begin{tikzpicture}[>=latex,thick,node distance=1.8cm]

// % \node (x1) [circle,draw] {$x_1=\text{T}$\\ dl 1};
// % \node (x2) [circle,draw,right of=x1] {$x_2=\text{F}$\\ dl 2};
// % \node (x3) [circle,draw,below right=1cm and 1cm of x1] {$x_3=\text{F}$\\ bcp};
// % \node (conf) [rectangle,draw,below=1.1cm of x3,align=center] {Clause $(\lnot x_3)$\\Conflict};

// % \draw[->] (x1) -- node[sloped,above]{from $(\lnot x_1\lor x_2\lor x_3)$} (x3);
// % \draw[->] (x2) -- node[sloped,below]{from $(\lnot x_2 \lor x_3)$} (x3);
// % \draw[->] (x3) -- (conf);

// % \caption{Implication graph and conflict.}
// % \label{fig:uip}
// % \end{figure}

// The learned clause (1st-UIP) is:
// \[
// (\lnot x_2 \lor \lnot x_1).
// \]
// \end{example}

// % =========================================================
// \paragraph{Backtracking}


// Given a learned clause, DPLL backtracks to the decision level at which the clause
// becomes unit.

// \begin{example}[Non-Chronological Backtracking]
// Decision levels:
// \[
// dl=1: x_1=\mathrm{True}, \qquad dl=2: x_2=\mathrm{True}, \qquad dl=3: x_3=\mathrm{False}.
// \]
// A conflict analysis produces the learned clause $(\lnot x_1 \lor x_3)$.
// The highest decision level in the clause except the most recent UIP is 1, so the
// solver backtracks to level 1, undoing assignments to $x_2$ and $x_3$.
// \end{example}

// % Diagram for backtracking
// % \begin{figure}[h]
// % \centering
// % \begin{tikzpicture}[>=latex,thick,node distance=2cm]
// % \node (dl1) [circle,draw] {$dl_1:\\ x_1=\text{T}$};
// % \node (dl2) [circle,draw,below of=dl1] {$dl_2:\\ x_2=\text{T}$};
// % \node (dl3) [circle,draw,below of=dl2] {$dl_3:\\ x_3=\text{F}$};

// % \draw[->,red,thick] (dl3.west) .. controls +(-2,0) and +(-2,-1) .. node[left]{backtrack to $dl_1$} (dl1.west);

// % \caption{Non-chronological backtracking drops from decision level 3 to 1.}
// % \label{fig:backtrack}
// % \end{figure}

// % % =========================================================
// % \subsection{End-to-End Mini Example}
// % \label{subsec:dpll-mini-example}

// % Finally, we show an entire DPLL cycle:

// % \[
// % \varphi = (x_1 \lor x_2)
// % \land (\lnot x_1 \lor x_3)
// % \land (\lnot x_3).
// % \]

// % \begin{enumerate}
// % \item Decide $x_1=\mathrm{True}$ (dl=1).
// % \item BCP on $(\lnot x_1 \lor x_3)$ gives $x_3=\mathrm{True}$.
// % \item Conflict with $(\lnot x_3)$.
// % \item Learned clause: $(\lnot x_1)$.
// % \item Backtrack to level 0 and set $x_1=\mathrm{False}$.
// % \end{enumerate}

// % The solver continues until it finds a model or proves unsatisfiability.

// %DPLL is both sound (its results are correct) and complete (it can find a solution for any input in finite time). %Since its introduction, many heuristics have been introduced to make DPLL more efficient,
// %However, because SAT solving is NP-Complete and DPLL has a worst-case exponential time complexity. %However, many heuristics have been developed to help DPLL efficient in practice,  e.g., choosing variables to assign values and decision levels to backtrack to~\cite{TODO}.

//  == CDCL}

// Modern DPLL solving improves the original version with Conflict-Driven Clause Learning (\emph{CDCL}~\cite{bayardo1997using,marques1999grasp,569607}).
// DPLL with CDCL can \emph{learn new clauses} to avoid past conflicts and backtrack more intelligently (e.g., using non-chronologically backjumping).
// %Similar to DPLL, CDCL is sound and complete, but also incurs an exponential complexity.  However,
// Due to its ability to learn new clauses, CDCL can significantly  reduce the search space and allow SAT solvers to scale to large problems.
// In the following, whenever we refer to DPLL, we mean DPLL with CDCL.





// \subsection{DPLL(T)}

// DPLL(T)~\cite{nieuwenhuis2006solving} extends DPLL for propositional formulae to check SMT formulae involving non-Boolean variables, e.g., real numbers and data structures such as strings, arrays, lists.
// DPLL(T) combines DPLL with dedicated \emph{theory solvers} to analyze formulae in those theories\footnote{SMT is Satisfiability Modulo Theories and the T in DPLL(T) stands for Theories.}.
// For example, to check a formula involving linear arithmetic over the reals (LRA), DPLL(T) may use a theory solver that uses linear programming to check the  constraints in the formula.

// Modern DPLL(T)-based SMT solvers such as Z3~\cite{de2008z3} and CVC4~\cite{barrett2011cvc4}
// include solvers supporting a wide range of theories including linear arithmetic, nonlinear arithmetic, string, and arrays~\cite{kroening2016decision}.

// = Linear Programming (LP) <chap:lp}

// Linear Programming (LP) and its generalization Mixed-Integer Linear Programming (MILP)
// form the optimization backbone of many NNV techniques.
// This chapter provides an overview of LP and MILP in the context of NNV.


//  == Linear Constraints and Objectives <sec:lp}

// At a high level, LP is a method for optimizing an objective with respect to certain constraints. For example, we want to maximize profit while keeping production costs within budget. In LP, both the objective and constraints are \emph{linear}.


// \paragraph{Linear Constraints}

// Linear constraints are inequalities that involve linear combinations of variables.  A linear inequality has the general form
// \[
// c_1x_1 + c_2x_2 + dots + c_nx_n <=q b,
// \]

// where $c_i, b in \mathbb{R}$. These constraints limit the feasible values that the variables $x_i$ can take.
// The set of points satisfying all constraints is called the \emph{feasible region}.


// \begin{example <ex:lp-constraints}
// Consider the following linear constraints:
// \[
// x + y <=q 4, \qquad x >= 0, \qquad y >= 0.
// \]
// The feasible region is a triangle with vertices at $(0,0), (4,0), (0,4)$.

// \begin{center}
// \begin{tikzpicture}[scale=0.8]
// \draw[->] (0,0) -- (5,0) node[right] {$x$};
// \draw[->] (0,0) -- (0,5) node[above] {$y$};
// \draw[thick, fill=blue!10] (0,0) -- (4,0) -- (0,4) -- cycle;
// \node at (2,1) {Feasible region};
// \end{tikzpicture}
// \end{center}
// \end{example}

// \paragraph{Linear Objective Functions}
// A linear objective function $z$ has the general form
// \[
// z(x_1, x_2, \ldots, x_n) = c_1x_1 + c_2x_2 + dots + c_nx_n,
// \]

// where $c_i in \mathbb{R}$ are coefficients, and $x_i in \mathbb{R}$ are decision variables.


// \paragraph{Optimizing Goals}
// Our goal is to optimize (maximize or minimize) $z$ with respect to a set of linear constraints over the decision variables, e.g., 
// \[
// \begin{aligned}
// & \text{maximize } z \\
// & \text{subject to } \\
// &  {c_1x_1 + c_2x_2 + dots + c_nx_n <=q b, \ldots     }
// \end{aligned}
// \]

// \begin{example <ex:lp-example1}
// Maximize
// \[
// 1.5x+2y
// \] subject to:
// \[
//  {x+y <=q 4, x >= 0, y >= 0 }.
// \]

// First, we can solve for the intersection points of the constraints:

// \[
// \begin{aligned}
// & x+y = 4 \\
// & x = 0 \\
// & y = 0
// \end{aligned}
// \]
// Solving these equations gives us the corner points or vertices of the feasible region:
// \[
// \begin{aligned}
// & (0,0) \\
// & (4,0) \\
// & (0,4)
// \end{aligned}
// \]

// Now, we can evaluate the objective function $z = 1.5x+2y$ at each vertex:

// \begin{center}
// \begin{tabular}{ccc}
// \hline
// x & y & z \\
// \hline
// 0 & 0 & 0 \\
// 4 & 0 & 6 \\
// 0 & 4 & 8 \\
// \hline
// \end{tabular}
// \end{center}

// Thus, the maximum value of $z$ is 8, achieved at vertex $(0,4)$.


// \paragraph{Geometric interpretation} The constraints represent the feasible region as a triangle with vertices at $(0,0)$, $(4,0)$, and $(0,4)$:

// \begin{center}
// \begin{tikzpicture}[scale=0.7, transform shape]
//     \begin{axis}[
//         axis lines = middle,
//         xlabel = $x$,
//         ylabel = $y$,
//         xmin=0, xmax=5,
//         ymin=0, ymax=5,
//         xtick={0,1,2,3,4},
//         ytick={0,1,2,3,4},
//         grid=both,
//         width=8cm,
//         height=8cm,
//     ]
//     % Feasible region
//     \addplot [
//         domain=0:4,
//         samples=100,
//         fill=blue!20,
//         opacity=0.5
//     ] {4 - x} \closedcycle;

//     % Constraints
//     \addplot [thick] {4 - x};
//     \addplot [thick] {0};
//     \addplot [thick] coordinates {(0,0) (0,4)};

//     % Vertices
//     \filldraw[red] (axis cs:0,0) circle (2pt) node[anchor=north west] {$(0,0)$};
//     \filldraw[red] (axis cs:4,0) circle (2pt) node[anchor=north east] {$(4,0)$};
//     \filldraw[red] (axis cs:0,4) circle (2pt) node[anchor=south west] {$(0,4)$};

//     % Objective function line
//     \addplot [dashed, thick] {8 - 1.5*x} node[pos=0.85, above] {$1.5x + 2y = 8$};

//     \end{axis}
// \end{tikzpicture}
// \end{center}

// The objective function $z = 1.5x+2y$ is maximized at vertex $(0,4)$.

// \end{example}



// \begin{example <ex:lp-example2}
// Minimize
// \[
// z = x + y
// \]
// subject to:
// \[
//  {2x + y >= 3,\; x + 2y >= 4,\; x >= 0,\; y >= 0 }.
// \]

// First, we solve for the intersection points of the boundary lines of the constraints:

// \[
// \begin{aligned}
// & 2x + y = 3 \\
// & x + 2y = 4 \\
// & x = 0 \\
// & y = 0
// \end{aligned}
// \]

// Solving these equations gives the vertices of the feasible region:
// \[
// \begin{aligned}
// & (0,3) \\
// & (4, 0) \\
// & (\frac{2}{3}, \frac{5}{3})
// \end{aligned}
// \]

// Now, we evaluate the objective function $z = x + y$ at each vertex:

// \begin{center}
// \begin{tabular}{ccc}
// \hline
// x & y & z \\
// \hline
// 0 & 3 & 3 \\
// 4 & 0 & 4 \\
// $\frac{2}{3}$ & $\frac{5}{3}$ & $\frac{7}{3}$ \\
// \hline
// \end{tabular}
// \end{center}

// Thus, the minimum value of $z$ is $\frac{7}{3}$, achieved at vertex $<=ft(\frac{2}{3}, \frac{5}{3}\right)$.


// \end{example}


// \begin{problem <ex:lp-problem2}
//     Maximize $z=4x+5y$ subject to $ {x+y <= 20, \; 2x+4y <=q 72 }$.

//     \begin{enumerate}
//         \item Identify the corner points.
//         \item Evaluate the objective function at each corner point.
//     \end{enumerate}
// \end{problem}


//  == Mixed-Integer Linear Programming (MILP) <sec:milp-basics}

// LP (@sec:lp) assumes continuous variables over real numbers.
// A mixed-integer linear program---MILP---extends LP by requiring some variables to be integers (often binary 0 or 1).  This is useful because it allows for modeling discrete decisions and logical constraints, e.g., on/off decisions, yes/no choices, and active/inactive ReLU.

// \paragraph{Linear Constraints}
// In MILP, a linear constraint can involve both integer and continuous decision variables, and have the general form
// \[
// c_1x_1 + c_2x_2 + dots + c_nx_n + d_1y_1 + d_2y_2 + dots + d_my_m <=q b,
// \]
// where $x_i in \mathbb{R}$ are continuous variables, $y_j in \mathbb{Z}$ are integer variables, and $c_i, d_j, b in \mathbb{R}$.

// \paragraph{Objective Function}
// A linear objective function $z$ in MILP can be expressed as:
// \[
// z(x_1, \ldots, x_n, y_1, \ldots, y_m) = c_1x_1 + c_2x_2 + dots + c_nx_n + d_1y_1 + d_2y_2 + dots + d_my_m,
// \]
// where $x_i in \mathbb{R}$ are continuous variables, $y_j in \mathbb{Z}$ are integer variables, and $c_i, d_j in \mathbb{R}$.

// \paragraph{Optimizing Goals}
// In MILP, the goal is to find the optimal values of the decision variables $x$ and $y$ that maximize or minimize the objective function $z$, while satisfying all linear constraints.

// \[
// \begin{aligned}
// & \text{maximize } z(x_1, \ldots, x_n, y_1, \ldots, y_m) \\
// & \text{subject to } \\
// &  {c_1x_1 + c_2x_2 + dots + c_nx_n + d_1y_1 + d_2y_2 + dots + d_my_m <=q b }
// \end{aligned}
// \]


// \begin{example <ex:lp-example3}
// A company sells a chair for \$50 and a table for \$120. The production costs of the chair and the table are \$20 and \$70, respectively. It also takes 3 hours to produce a chair and 1 hour to produce a table.
// Moreover, it takes 5 units of wood to produce a chair and 20 units of wood to produce a table.

// How many chairs and tables should the company produce to \emph{maximize} profit within a week without exceeding its monthly budget of 200 units of woods, 80 hours of labor, and \$800 in production costs?

// First, the decision variables are defined as follows:
// \begin{itemize}
//     \item $x$: the number of chairs produced.
//     \item $y$: the number of tables produced.
// \end{itemize}

// The objective function to maximize profit $P$ is given by:
// \[
// P = 50x + 120y - 20x - 70y = 30x + 50y
// \]

// with subject to the constraints:
// \[
// \begin{aligned}
// & 5x + 20y <= 200 \implies x + 4y <= 40\\
// & 3x + y <= 80 \\
// & 20x + 70y <= 800 \implies 2x + 7y <= 80\\
// & x >= 0 \\
// & y >= 0.
// \end{aligned}
// \]

// \paragraph{Solving}

// First, we can find the corner points from the constraints
// \[
// \begin{aligned}
//     & x + 4y = 40 \\
//     & 3x + y = 80 \\
//     & 2x + 7y = 80 \\
//     & x = 0 \\
//     & y = 0
// \end{aligned}
// \]

// Solving these equations gives us the corner points or vertices of the feasible region:
// (0,0);
// (0, 10);
// $(\frac{80}{3} ,0)$; and
// $(\frac{280}{11},\frac{40}{11})$ (from x + 4 y = 40 ~\&~ 3x + y = 80).
// Note that all of these are feasible with $2x + 7y <= 800$.




// Now, we can evaluate the objective function $P$ at each vertex:

// \begin{center}
// \begin{tabular}{ccc}
// \hline
// x & y & P = 30x + 50y \\
// \hline
// 0 & 0 & 0 \\
// 0 & 10 & 500 \\
// $\frac{80}{3}$ & 0 & 800 \\
// $\frac{280}{11}$ & $\frac{40}{11}$ &945.45 \\
// \hline
// \end{tabular}
// \end{center}

// Thus, the maximum value of $P$ is 945.45, achieved at the vertex $(\frac{280}{11},\frac{40}{11})$.

// Of course, since we cannot produce fractional chairs or tables, we need to round these numbers to the nearest integers.
// This means the company should produce 24 chairs and 4 tables per week, and get a profit of \$920.00

// \end{example}


// \subsection{Encoding Binary Variables <sec:milp-binary}
// MILP problems often involve condition where the answer depends on some condition.  We can encode such condition using binary variables (0-1 integers), e.g., using  $z in  {0,1 }$ to indicate whether a certain condition is met.  Moreover, we can use a ``trick'' with a large constant $M$, e.g., $ in fty$, to encode logical implications.

// \begin{example}
// To encode ``if $z = 1$ then $x >= 5$'', use:
// \[
// x ~ >=~ 5 - M(1-z), quad z in  {0,1 }
// \]


// This works because
// \begin{itemize}
//  \item $z=1 \implies x ~>=~ 5 - M(0) \implies x >= 5$.
//  \item $z=0 \implies x ~>=~ 5 - M \implies x >= - in fty$ (when $M$ is large this is vacuously true and can be discarded).
// \end{itemize}

// \end{example}


// \begin{problem}
// Encode the disjunction $x >= 5 \lor x <=q 3$ in MILP.

// \begin{solution}
//     We use two constraints:
//     \begin{itemize}
//     \item $x >= 5 - M(1-z)$ (if $z=1$, this enforces $x >= 5$)
//     \item $x <=q 3 + Mz$ (if $z=0$, this enforces $x <=q 3$)
//     \end{itemize}
// \end{solution}
// \end{problem}


// \begin{example}[Encoding ReLU in MILP]\label{ex:relu_milp}

// To encode the ReLU (@sec:relu) activation function $y = \max(0, x)$, use
// \begin{equation <eq:relu-milp}
// \begin{aligned}
// & y >= x, \\
// & y >= 0, \\
// & y <=q x + M(1-z), \\
// & y <=q Mz,\\
// & z in  {0,1 }.\\
// \end{aligned}
// \end{equation}

// This works because

// \begin{itemize}
// \item $z=1 \implies y=x$.
// \item $z=0 \implies y=0$.
// \end{itemize}
// \end{example}

// \begin{problem <problem:relu-milp-bounds}
// Consider again the ReLU example in @ex:relu_milp but now $x$ has the bounds $L <=q x <=q U$. Modify the MILP encoding so that $L$ and $U$ are used \emph{directly} instead of a large constant $M$.

// \begin{solution}
// To modify the MILP encoding for the ReLU function with bounds $L <=q x <=q U$, we add the following constraints to those in~@eq:relu-milp:
// \[
// \begin{aligned}
// & y >= x, \\
// & y >= 0, \\
// & y <=q x + (U-x)(1-z), \\
// & y <=q Uz, quad z in  {0,1 }, \\
// & L <=q x <=q U.
// \end{aligned}
// \]
// \end{solution}
// \end{problem}


//  == Using Z3 to Solve LP and MILP}

// We can use Z3's optimization capabilities to solve both LP and MILP problems. Note that in practice, we often use dedicated solvers such as Gurobi or CPLEX for large problems, but Z3 is effective for demonstration purposes.

// \begin{example <ex:lp-z3}
//     We can model and solve~@ex:lp-example1 using Z3 as follows:

//     \begin{lstlisting}
// from z3 import *

// x, y = Reals("x y")
// opt = Optimize() # setUB the optimization problem
// opt.add(x + y <= 4, x >= 0, y >= 0)

// # Objective
// z = 1.5*x + 2*y
// h = opt.maximize(z)

// # Solve
// if (opt.check() = sat):
//     print("Optimal sol:", opt.model())  # output [x = 0, y = 4]
//     print("Max value:", opt.upper(h))   # output 8
//     \end{lstlisting}
// \end{example}


// \begin{problem}
// Do~@ex:lp-problem2 using Z3.
// \end{problem}

// \begin{problem}
// Do~@ex:lp-example3 using Z3.
// \end{problem}



// \begin{problem <ex:milp-online}
// For this problem, you will find some interesting MILP problem online, formulate it, and solve it using Z3. Specifically, do the following:
// \begin{itemize}
// \item Find \emph{two} interesting MILP problems online. These can be from textbooks, research papers, or online resources (Youtube, Google, online tutorials).

// Note: Interesting here means the problem has a non-trivial structure, resembles real-world applications (like the table and chair example in~@ex:lp-example3), or involves complex constraints.
// \item For each problem:
// \begin{itemize}
//     \item Write down the problem and \emph{cite} the source (e.g., exact URL or Author(s)/Title/Year if from a paper).
//     \item Formulate the problem as a MILP (clearly indicate the objective and constraints).
//     \item Solve them by hand (show all the steps, and if possible, draw the graph showing the feasible region).
//     \item Implement the formulation in Z3 and solve it (also document the steps as comments). Use~@ex:lp-z3 as example.
// \end{itemize}
// \end{itemize}

// \end{problem}


// \begin{problem <problem:milp-hand}
// Minimize $z = x + y$ subject to:
// \[
// \begin{aligned}
// & x + 2y >= 3, \\
// & 3x + y >= 3, \\
// & x, y >= 0, \\
// & x,y in \mathbb{R}.
// \end{aligned}
// \]

// \begin{enumerate}
//     \item The constraints and objective function.
//     \item The corner or candidate points (this problem is very simple that you do not need any complex algorithm to solve. You can simply ``guess'' these points, e.g., the intersection of the given constraints)
//     \item The objective value at each corner point.
//     \item The optimal solution.
// \end{enumerate}

// \begin{solution}
// \textbf{1. Constraints and Objective Function:}

// Minimize $z = x + y$ subject to:
// \[
// \begin{aligned}
// & x + 2y >= 3, \\
// & 3x + y >= 3, \\
// & x, y >= 0.
// \end{aligned}
// \]

// \textbf{2. Corner Points:}

// We find the corner points by solving the systems of equations formed by the constraint boundaries:

// \begin{itemize}
// \item If $x = 0$ and $x + 2y = 3$: $(0, 1.5)$. Check: $3(0) + 1.5 = 1.5 < 3$, not feasible.
// \item If $y = 0$ and $x + 2y = 3$: $(3, 0)$. Check: $3(3) + 0 = 9 >= 3$, feasible.
// \item If $x = 0$ and $3x + y = 3$: $(0, 3)$. Check: $0 + 2(3) = 6 >= 3$, feasible.
// \item If $y = 0$ and $3x + y = 3$: $(1, 0)$. Check: $1 + 0 = 1 < 3$, not feasible.
// \item Intersection of $x + 2y = 3$ and $3x + y = 3$: Solving gives $x = \frac{3}{5}$, $y = \frac{6}{5}$, so $<=ft(\frac{3}{5}, \frac{6}{5}\right)$, feasible.
// \end{itemize}

// Feasible corner points: $(3,0)$, $(0,3)$, and $<=ft(\frac{3}{5}, \frac{6}{5}\right)$.

// \textbf{3. Objective Values:}

// We evaluate the objective function $z$ at each corner point:

// \begin{center}
// \begin{tabular}{ccc}
// \hline
// x & y & z = x + y \\
// \hline
// 3 & 0 & 3 \\
// 0 & 3 & 3 \\
// $\frac{3}{5}$ & $\frac{6}{5}$ & 1.8 \\
// \hline
// \end{tabular}
// \end{center}

// \textbf{4. Optimal Solution:}

// The minimum value of $z$ is $\frac{9}{5}$ (or 1.8), achieved at $<=ft(\frac{3}{5}, \frac{6}{5}\right)$.

// Both constraints are binding (active) at this optimal point.
// \end{solution}
// \end{problem}





// % \subsubsection*{Examples (adapted from earlier LP sections)}

// \begin{example}

// For the constraints in~@ex:lp-constraints:
// \begin{align}
// x+y <= 4,quad x>= 0,quad y>= 0
// \end{align}

// Running an LP solver with objective $\min 0$ will return a point, e.g., (x=0,y=0), within the feasible region.
// \end{example}


// % = Software vs DNN Verification <app:software-vs-dnn}


// % \paragraph{General}
// % Software verification and DNN verification share the common goal of ensuring the correctness and reliability of their respective systems. Both fields aim to identify and eliminate potential errors or vulnerabilities before deployment, ultimately enhancing user trust and system robustness.

// % \begin{table}
// %     \caption{Comparison of Software Verification and DNN Verification}
// %     \footnotesize
// % \begin{tabular}{|c|c|c|}
// %     \hline
// %     \textbf{Aspect} & \textbf{Software Verification} & \textbf{DNN Verification} \\
// %     \hline
// %     \textbf{Input} & Source code, specifications & DNN model, input space \\
// %     \hline
// %     \textbf{Output} & Verification results, counterexamples & Verification results, adversarial examples \\
// %     \hline
// %     \textbf{Techniques} & Model checking, theorem proving & Formal methods, testing \\
// %     \hline
// %     \textbf{Challenges} & State explosion, incomplete specifications & High dimensionality, non-convexity \\
// %     \hline
// % \end{tabular}
// % \end{table}

// % \paragraph{Similarities}

// % \begin{table}
// % \caption{Similarities of Software Verification and DNN Verification}
// % \footnotesize
// % \begin{tabular}{|c|c|c|}
// %     \hline
// %     \textbf{Aspect} & \textbf{Software Verification} & \textbf{DNN Verification} \\
// %     \hline
// %     \textbf{Input} & Source code, specifications & DNN model, input space \\
// %     \hline
// %     \textbf{Output} & Verification results, counterexamples & Verification results, adversarial examples \\
// %     \hline
// %     \textbf{Techniques} & Model checking, theorem proving & Formal methods, testing \\
// %     \hline
// %     \textbf{Challenges} & State explosion, incomplete specifications & High dimensionality, non-convexity \\
// %     \hline
// % \end{tabular}
// % \end{table}

// % \paragraph{Differences}
// % Software verification typically deals with discrete systems and logical properties, while DNN verification focuses on continuous input spaces and the behavior of neural networks under various conditions. Additionally, the techniques used in each field differ significantly, with software verification relying on formal methods and testing, whereas DNN verification often employs specialized techniques such as adversarial training and robustness analysis.

// % \begin{table}
// % \caption{Differences of Software Verification and DNN Verification}
// % \begin{tabular}{|c|c|c|}
// %     \hline
// %     \textbf{Aspect} & \textbf{Software Verification} & \textbf{DNN Verification} \\
// %     \hline
// %     \textbf{Input} & Source code, specifications & DNN model, input space \\
// %     \hline
// %     \textbf{Output} & Verification results, counterexamples & Verification results, adversarial examples \\
// %     \hline
// %     \textbf{Techniques} & Model checking, theorem proving & Formal methods, testing \\
// %     \hline
// %     \textbf{Challenges} & State explosion, incomplete specifications & High dimensionality, non-convexity \\
// %     \hline
// % \end{tabular}
// % \end{table}
// % = Comparing neural networks with software <chap:nn-vs-software}

// % \begin{table}
// %     \caption{Similarities <tab:nn-software-similarities}
// %     \scriptsize
// %     \centering
// % \begin{tabular}{l|l}
// %     \toprule
// %     Aspect & Description\\
// %     \midrule
// %     Representation &	Represented using if-then-else statements\\
// %     Input-Output Mapping &	Take Inputs and produce outputs\\
// %     Determinism	& Can produce deterministic outputs\\
// %     Execution Path	& Paths from input to output\\
// %     Specifications & Can have specifications involving preconditions over inputs and postconditions over outputs\\
// %     Logical Constraints	& Can be represented as logical constraints\\
// %     Bugs and Errors & Can have bugs that violate specifications\\
// %     \bottomrule
// % \end{tabular}
// % \end{table}

// % \begin{table}
// %     \caption{Differences <tab:nn-software-differences}
// %     \scriptsize
// %     \centering
// % \begin{tabular}{l|l|l}
// %     \toprule
// %     Aspect	& Traditional Software	& Neural Networks \\
// %     \midrule
// %     % Control Flow	Complex flow with loops, recursion, and branching.	Feedforward execution; no explicit loops or recursion during inference.
// %     % State Representation	Uses variables, objects, and explicit state transitions.	Encodes state in weights and neuron activations.
// %     % Granularity	Operates at a higher abstraction level with fewer conditional branches.	Operates on thousands or millions of neurons, creating many implicit conditional branches.
// %     % Object-Oriented Features	Incorporates OOP principles like encapsulation, inheritance, and polymorphism.	Lacks explicit OOP features but can be modular (e.g., layers, sub-networks).
// %     % Execution Path	Determined by explicit logic and relatively few branches.	Implicit execution paths defined by piecewise-linear regions from activations.
// %     % Termination	Explicitly handles termination in loops and recursion.	Fixed-length inference process with no explicit termination conditions.
// %     % Semantics	Implements precise, deterministic logic for well-defined tasks.	Approximates functions based on training, often non-deterministic during learning.
// %     % Verification	Formal verification methods are established for correctness.	Verification is challenging due to non-linearity and high dimensionality.
// %     % Debugging	Tools like debuggers allow step-by-step inspection of logic.	Focuses on diagnosing data issues, architecture problems, or training convergence.
// %     Explainability & Can be explained through code inspection & Lacks explicit explainability mechanisms\\
// %     Designing &	Written by human & Created by machine through learning from training data\\
// %     Size & Small to medium-sized codebases & Large number of neurons and layers\\
// %     Error Causing & arise from bugs in logic or implementation & arise from insufficient training data, overfitting, etc\\
// %     Error Incurring & Can cause crashes, incorrect outputs, or unexpected behavior & Can cause incorrect predictions or unexpected behavior\\
// %     Error Handling & try-catch blocks for exception handling &	Lacks explicit error-handling mechanisms\\
// %     % Learning	Does not “learn”; behavior must be explicitly defined.	Learns to approximate functions through training.
// %     % Non-Linearity	Handles non-linearity explicitly through conditional logic or complex mathematical operations.	Uses activation functions like ReLU, Sigmoid, or Tanh to introduce non-linearity.
// %     % Parallelism	Often single-threaded or relies on explicit multi-threading for parallelism.	Intrinsic large-scale parallelism due to the structure of layers and neurons.
// %     % Adversarial Vulnerability	Less vulnerable to adversarial inputs, but bugs can lead to unexpected behavior.	Susceptible to small, imperceptible perturbations in input (adversarial examples).
// %     % Generalization	Executes pre-defined logic; does not generalize beyond explicit instructions.	Generalizes from training data, allowing predictions on unseen inputs.
// %     % Dynamic Resource Management	Explicitly handles memory, files, and resources during execution.	Resources are statically allocated during training and inference; no dynamic management.
// %     % Concurrency	Explicitly handles concurrent operations using threads or async programming.	No explicit concurrency; parallelism occurs naturally due to network architecture.
// %     \bottomrule
// % \end{tabular}
// % \end{table}


// % \paragraph{Representation (Source Code)} Both NNs and software have static representations that can be analyzed. Software is represented as source code, e.g., Pyhon or Java code, while NNs are represented by their architecture and weights, stored in files like ONNX or TensorFlow.

// % Compared to software, NNs are often much larger in size (e.g., billions of parameters), but have less expressive semantics and structure (e.g., no pointers, OOP features, or complex loops). In fact, we can treat NNs as large functions composed of many simple operations (e.g., matrix multiplications and activations). Note that activation functions such as ReLU can be represented as simple if-then-else statements, e.g., ReLU(x) = \code{if x > 0 then x else 0}.

// % \paragraph{Specifications} Both NNs and software can have specifications that describe their intended behavior. %For software, specifications are often written in formal languages or as assertions within the code. For NNs, specifications can be expressed as properties over input-output behavior, e.g., ``for all inputs within a certain range, the output should satisfy a certain condition.''

// % \paragraph{Constructions} Software is typically \emph{designed} and \emph{written} by humans using programming languages and code editors. In constrast, NNs are largely \emph{constructed} and \emph{trained} by machines using training data and optimization algorithms. This leads to different types of errors: software errors often arise from bugs in logic or implementation, while NN errors often arise from insufficient training data and overfitting.

// %\part{Appendices\label{part:appendices}}
// % \renewcommand{\appendixname}{Advanced Topics}
// % \appendix

// % = \neuralsat{} Algorithm <sec:neuralsat-alg}



// % \SetKwInOut{Input}{input}
// % \SetKwInOut{Output}{output}
// % \SetKw{Break}{break}
// % \SetKw{Continue}{continue}
// % \SetKwFunction{Backtrack}{Backtrack}
// % \SetKwFunction{Decide}{Decide}
// % \SetKwFunction{BCP}{BCP}
// % \SetKwFunction{Deduction}{Deduction}
// % \SetKwFunction{AnalyzeConflict}{AnalyzeConflict}
// % \SetKwFunction{BooleanAbstraction}{BooleanAbstraction}
// % \SetKwFunction{AddClause}{AddClause}
// % \SetKwFunction{isTotal}{isTotal}
// % \SetKwFunction{randomattack}{RandomAttack}
// % \SetKwFunction{pgd}{PGDAttack}

// % \SetKwFunction{DPLLT}{DPLLT}
// % \SetKwFunction{isValid}{isValid}
// % \SetKwFunction{LPSolver}{LPSolver}
// % \SetKwFunction{Solve}{Solve}
// % \SetKwFunction{FindLayerNodes}{FindLayerNodes}
// % \SetKwFunction{TightenInputBounds}{TightenInputBounds}
// % \SetKwFunction{Abstract}{Abstract}
// % \SetKwFunction{Check}{Check}
// % \SetKwFunction{Decide}{Decide}
// % \SetKwFunction{Imply}{Imply}
// % \SetKwFunction{Lower}{LowerBound}
// % \SetKwFunction{Upper}{UpperBound}
// % \SetKwFunction{GetInputBounds}{GetInputBounds}
// % \SetKwFunction{GetInputs}{GetInputs}
// % \SetKwFunction{GetNumInputs}{GetNumInputs}
// % \SetKwFunction{CurrentConflictClause}{CurrentConflictClause}
// % \SetKwFunction{StopCriterion}{StopCriterion}
// % \SetKwFunction{LastAssignedLiteral}{LastLiteral}
// % \SetKwFunction{LiteralToVariable}{LiteralToVariable}
// % \SetKwFunction{Antecedent}{Antecedent}
// % \SetKwFunction{BinRes}{BinRes}
// % \SetKwFunction{BacktrackLevel}{BacktrackLevel}
// % \SetKwFunction{AddClause}{AddClause}
// % \SetKwFunction{ActivationStatus}{ActivationStatus}

// % \SetKwData{implicationgraph}{igraph}
// % \SetKwData{literal}{lit}
// % \SetKwData{variable}{var}
// % \SetKwData{antecedent}{ante}
// % \SetKwData{conflict}{conflict}
// % \SetKwData{none}{none}
// % \SetKwData{layerid}{lid}
// % \SetKwData{hiddenbounds}{hidden\_bounds}
// % \SetKwData{layerbounds}{lbounds}
// % \SetKwData{inputs}{inputs}
// % \SetKwData{inputbounds}{input\_bounds}
// % \SetKwData{outputbounds}{output\_bounds}
// % \SetKwData{infeasible}{INFEASIBLE}
// % \SetKwData{unreachable}{UNREACHABLE}
// % \SetKwData{maxinputs}{MAX\_NUM\_INPUT}
// % \SetKwData{assignment}{$sigma$}
// % \SetKwData{network}{$alpha$}
// % \SetKwData{dl}{dl}
// % \SetKwData{lpmodel}{solver}
// % \SetKwData{clauses}{clauses}
// % \SetKwData{conflict}{conflict}
// % \SetKwData{clause}{clause}
// % \SetKwData{igraph}{igraph}
// % \SetKwData{cex}{cex}

// % \SetKwData{true}{true}
// % \SetKwData{false}{false}
// % \DontPrintSemicolon
// % \SetKwFunction{Restart}{Restart}

// % \SetKwData{issat}{is\_sat}
// % \SetKwData{conflictclause}{conflict\_clause}
// % \SetKwData{isconflict}{is\_conflict}

// % \begin{algorithm}
// %     \small


// %      in put{DNN $alpha$, property $phi_"in" \Rightarrow phi_"out"$}
// %     \Output{\texttt{unsat} if the property is valid and \texttt{sat} otherwise}
// %     \BlankLine

// %     $\clauses <=ftarrow \BooleanAbstraction(alpha)$\;\label{line:Booleanabstraction}

// %     \While{\true}{
// %         $sigma <=ftarrow \emptyset$ \tcp{initial assignment <line:varsa}
// %         $\dl <=ftarrow 0$ \tcp{initial decision level}
// %         $\igraph <=ftarrow \emptyset$ \tcp{initial implication graph <line:varsb}
// %         \While{\true}{\label{line:dpllstart}
// %             $\isconflict <=ftarrow \true$ \;

// %             \If{$\BCP(\clauses, sigma, \dl, \igraph)$}{\label{line:bcp}
// %                 \If{$\Deduction(sigma, \dl, alpha, phi_"in", phi_"out")$}{ \label{line:deduction}
// %                     $\issat, v_i <=ftarrow \Decide(alpha, phi_"in", phi_"out", \dl, sigma)$ \tcp{decision heuristic} \label{line:decide}
// %                     \lIf(\tcp*[h]{total assignment}){\issat}{
// %                         \Return{$\sat$} \label{line:returnsat}
// %                     }
// %                     $sigma <=ftarrow sigma \land v_i$\;% \tcp{decide new variable}
// %                     $\dl <=ftarrow \dl + 1$\;% \tcp{increase decision level by 1}
// %                     $\isconflict <=ftarrow \false$ \tcp{mark as no conflict}
// %                 }
// %             }
// %             \If{\isconflict}{
// %                 \lIf(\tcp*[h]{conflict at decision level 0}){$\dl \equiv 0$}{
// %                     \Return{\unsat}  \label{line:unsat}
// %                 }
// %                 $\clause <=ftarrow \AnalyzeConflict(\igraph)$\;
// %                 $\dl <=ftarrow \Backtrack(sigma, \clause)$ \;\label{line:backtrack}
// %                 $\clauses <=ftarrow \clauses \cup  {\clause }$ \tcp{learn conflict clauses} \label{line:learn}
// %             }

// %             \lIf(\tcp*[h]{restart heuristic}){$\Restart{}$}{\label{line:restart}
// %                 \Break
// %             }
// %          <line:dpllend}
// %     }
// %     \caption{The  \tool{}  DPLL(T) algorithm. <fig:alg}

// % \end{algorithm}


// % @fig:alg shows the \tool{} algorithm, which takes as input the formula $alpha$ representing the ReLU-based DNN $N$ and the formulae $phi_"in"\Rightarrow phi_"out"$ representing the property $phi$ to be proved.
// % Internally, \tool{} checks the satisfiability of the formula given in~@eq:nnv2
// % \begin{equation*}
// %   alpha \land phi_"in" \land \lnot{phi_"out"}.
// % \end{equation*}
// % \tool{} returns \texttt{unsat} if the formula unsatisfiable, indicating  that $phi$ is a valid property of $N$, and \texttt{sat} if it is satisfiable, indicating the $N$ is not a valid property.

// % \tool{} uses a  DPLL(T)-based algorithm to check unsatisfiability.
// % First, the input formula in~@eq:nnv2 is abstracted to a propositional formula
// % with variables encoding neuron activation status (\texttt{BooleanAbstraction}).
// % Next, \tool{} assign values to Boolean variables (\texttt{Decide}) and checks for conflicts the assignment has with the real-valued constraints of the DNN and the property of interest (\texttt{BCP} and \texttt{Deduction}).
// % If conflicts arise, \tool{} determines the assignment decisions causing the conflicts (\texttt{AnalyzeConflict}), backtracks to erase such decisions (\texttt{Backtrack}), and learns clauses to avoid those decisions in the future.
// % \tool{} repeats these decisions and checking steps until it finds a total or full assignment for all Boolean variables, in which it returns \texttt{sat}, or until it no longer can backtrack and returns \texttt{unsat}.

// % %Note that \tool{} also resets its search (if it thinks that it is stuck in a local optima) and tries different decision orderings to enable better clause learning and avoid similar ``bad'' decisions in the previous runs.



// %  == Boolean Abstraction}
// % \texttt{BooleanAbstraction} (@fig:alg~@line:Booleanabstraction) encodes the DNN verification problem into a Boolean constraint to be solved by DPLL.  This step creates Boolean variables to represent the \emph{activation status} of hidden neurons in the DNN. Observe that when evaluating the DNN on any concrete input, the value of each hidden neuron \emph{before} applying ReLU is either $>0$ (the neuron is \emph{active} and the input is passed through to the output) or $<= 0$ (the neuron is \emph{inactive} because the output is 0).
// % This allows partial assignments to these variables to represent neuron activation patterns within the DNN.

// % From the given network, \tool{} first creates Boolean variables representing the activation status of neurons. Next, \tool{} forms a set of initial clauses ensuring that each status variable is either \texttt{T} or \texttt{F}, indicating that each neuron is either active or inactive, respectively. A truth assignment over the variable $v_i$ creates a constraint on the pre-ReLU neuron $x_i$.


// % \begin{example}
// % For the DNN in~@fig:dnn, \tool{} creates two status variables $v_3,v_4$ for neurons $x_3,x_4$, respectively, and two initial clauses $v_3\lor \lnot{v_3}$ and $v_4 \lor \lnot{v_4}$. The assignment $ {x_3=T, x_4=F  }$ creates the constraint $0.5x_1-0.5x_2-1>0 \land x_1 + x_2 -2 <= 0$.
// % \end{example}


// % % neural network of verification task into set of clauses, then feed them to the solver.
// % % To do this, we encode each hidden node $h_i$ of the network correspond to one variable $v_i$ of the decidability problem.
// % % The number of variables for each hidden layer is equal to number of neurons that feed into the ReLU activation (because we want to decide the status of each ReLU node).
// % % In particular, in case of the linear layer, the number of hidden nodes is the hidden size $H$ of the layer itself.
// % % Therefore, $H$ hidden nodes are encoded as $ {v_i, v_{i+1}, ..., v_{i+H-1}  }$.
// % % In case of the 2-D convolution layer with input shape of $(N, C_{in}, H_{in}, W_{in})$, and output shape $(N, C_{out}, H_{out}, W_{out})$, where $N$ is the batch size, number of variables for this layer is:
// % % \begin{equation*}
// % %     H = C_{out} \times H_{out} \times W_{out}
// % % \end{equation*}
// % % After encoding all the hidden neurons into the corresponding variables, we construct a set of clauses (init\_clauses in Line 1 of Algo~\ref{fig:alg}):
// % % \begin{equation} \label{eq:clause}
// % %     (v_0 \lor \overline{v_0}) \land (v_1 \lor \overline{v_1}) \land ... \land (v_i \lor \overline{v_i}) \land (v_{i+1} \lor \overline{v_{i+1}}) \land ...
// % % \end{equation}
// % % With this form in Eq~\ref{eq:clause}, the \tool{} needs to decide all the variables to find a satisfiable solution if it exists, then returns SAT, or returns UNSAT if it could not find one.




// % %thus in the first step we exploit the structure of the network to create a Boolean abstraction for DPLL.

// % %and backtracks assignment decisions when conflicts arise.
// % %However, the variables in the SMT formula representing the FNN and property are real-valued, thus we exploit the structure of network to create a Boolean abstraction for DPLL.


// % %Thus, during preprocessing, \tool{} also creates Boolean variables representing the status values of hidden pre-ReLU neurons and an initial set of clause enforcing that each variable needs to be either $T$ (\texttt{on}) or $F$ (\texttt{off}).

// %  == DPLL <sec:ns-dpll}

// % After \texttt{BooleanAbstraction}, \tool{} iteratively searches for an assignment satisfying the status clauses (@fig:alg, lines~\ref{line:dpllstart}--~\ref{line:dpllend}).
// % % \tvn{something is wrong with the line ?? here} \hd{fixed}
// % \tool{} combines  DPLL components (e.g., \texttt{Decide}, \texttt{BCP}, \texttt{AnalyzeConflict}, \texttt{Backtrack} and \texttt{Restart}) to assign truth values with a theory solver (\S\ref{sec:deduction}), consisting of abstraction and linear programming solving, to check the feasibility of the constraints implied by the assignment with respect to the network and property of interest.

// % \tool{} maintains several variables (@fig:alg, lines~\ref{line:Booleanabstraction}--~\ref{line:varsb}). These include $\clauses$, a set of \emph{clauses} consisting of the initial activation clauses and learned clauses;   $sigma$, a \emph{truth assignment} mapping status variables to truth values; $igraph$, an \emph{implication graph} used for analyzing conflicts; and  $dl$, a non-zero \emph{decision level} used for assignment and backtracking.


// % %needs to analyze both \emph{Boolean constraints} (i.e., clauses involving status variables) and \emph{non-Boolean constraints} involving the nonlinear representation of the activation function and linear constraints encoding the network and status variables,  e.g., $v_3=\texttt{F}$ means $x_3'=\texttt{off}=0.5x_1-0.5x_2-1.0 <= 0$.
// % %To analyze both kinds of constraints,

// % %@fig:overview gives an overview of \tool{}, which takes as input a DNN $N$ and a property $P$ and returns \texttt{unsat} if $P$ is a valid property of $N$ and \texttt{sat} otherwise. In the case of \texttt{sat}, \tool{} can also return a satisfying assignment representing a counterexample input violating $P$.

// % \subsection{Decide <sec:decide}

// % From the current assignment, \texttt{Decide} (@fig:alg, line~\ref{line:decide}) uses a heuristic to choose an unassigned variable and assigns it a random truth value at the current decision level.
// % \tool{} applies the Filtered Smart Branching (FSB) heuristic~\cite{bunel2018unified,de2021improved}. For each unassigned variable, FSB assumes that it has been decided (i.e., the corresponding neuron has been split) and computes a fast approximation of the lower and upperbounds of the network output variables.  FSB then prioritizes unassigned variables with the best differences among the bounds that would help make the input formula unsatisfiable (which helps prove the property of interest).
// % Note that if the current assignment is full, i.e., all variables have assigned values, \texttt{Decide} returns \texttt{False} (from which \tool{} returns \texttt{sat}).

// % % In the current implementation of \tool{}, we use two heuristics to decide unassigned variables representing activation status of neurons.
// % % The first is based on the bounds computed for the neurons and the second is based objective improvement approach proposed in~\cite{bunel2018unified}.



// % % \subsection{DPLL - CDCL}
// % % Modern SAT solvers employ the CDCL (Conflict-Driven Clause Learning) algorithm \cite{cdcl}, which combines the classical DPLL \cite{dpll} (Davis-Putnam-Logemann-Loveland) algorithm with clause learning.

// % % \textbf{DPLL} DPLL has three main components: assigning truth values to variables, inferring additional assignments from current assignments, and analyzing conflicts and backtracking to a previous decision level to try new assignments.
// % % Viewing the process as a search on a binary tree, each decision is associated with a decision level, which is the depth in the binary decision tree at which it is made, starting from 1.
// % % The assignments implied by a decision are associated with its decision level at which it occurred.

// % % The process of BCP is best illustrated with an implication graph.
// % % An implication graph represents the current partial assignment and the reason for each of the implications.
// % % The root nodes of an implication graph correspond to decisions, and the internal nodes to implications through BCP.
// % % A conflict node with incoming edges labeled with $c$ represents the fact that the BCP process has reached a conflict, by assigning 0 (False) to all the literals in the clause $c$ (i.e., $c$ is conflicting).

// % % \textbf{CDCL} CDCL also has these DPLL components but extends conflict analysis to learn clauses, which help avoid conflicts and backtrack more effectively.

// % % \textbf{DPLL(T)} DPLL(T) combines DPLL/CDCL with theory solvers to analyze formulae in different theories (e.g., using an LP solver for linear constraints).
// % % State-of-the-art SMT solvers such as Z3 \cite{z3} and CVC \cite{cvc} employ the DPLL(T) algorithm \cite{dpllt} to check the satisfiability of an SMT formula involving non-Boolean variables, e.g., real numbers or strings.



// % %\tool{} follows the DPLL(T) architecture and consists of the several main components as follows.

// % \subsection{Boolean Constraint Propagation (BCP) <sec:bcp}

// % From the current assignment and clauses, \texttt{BCP} (@fig:alg, line~\ref{line:bcp}) detects \emph{unit clauses}\footnote{A unit clause is a clause that has a single unassigned literal.} and infers values for variables in these clauses.
// % For example, after the decision $a\mapsto F$, \texttt{BCP} determines that the clause $a\vee b$ becomes unit, and infers that $b \mapsto T$.
// % Moreover, each assignment due to \texttt{BCP} is associated with the current decision level because instead of being ``guessed'' by \texttt{Decide} the chosen value is logically implied by other assignments.
// % Moreover, because each {BCP} implication might cause other clauses to become unit, \texttt{BCP} is applied repeatedly until it can no longer find unit clauses.
// % \textsc{BCP} returns \texttt{False} if it obtains contradictory implications (e.g., one BCP application infers $a \mapsto F$ while another infers $a \mapsto T$), and returns \texttt{True} otherwise.

// % \paragraph{Implication Graph} \texttt{BCP} uses an \emph{implication graph}~\cite{barrett2013decision} to represent the current assignment and the reason for each BCP implication. In this graph, a node represents the assignment and an edge $i \xrightarrow{c} j$ means that \texttt{BCP} infers the assignment represented in node $j$ due to the unit clause $c$ caused by the assignment represented by node $i$.
// % The implication graph is used by both BCP, which iteratively constructs the graph on each BCP application and uses it to determine conflict, and \texttt{AnalyzeConflict} (@sec:analyze-conflicts), which analyzes the conflict in the graph to learn clauses.

// % \begin{figure}
// %     \begin{minipage}[c]{0.15\textwidth}
// %         \centering
// %         \small
// %         \begin{equation*}
// %             \begin{aligned}
// %                 c_1 &= (\overline{v_1} \lor v_2) \\
// %                 c_2 &= (\overline{v_1} \lor v_3 \lor v_5) \\
// %                 c_3 &= (\overline{v_2} \lor v_4) \\
// %                 c_4 &= (\overline{v_3} \lor \overline{v_4})
// %             \end{aligned}
// %         \end{equation*}
// %         \caption*{(a)}
// %     \end{minipage}
// %     \begin{minipage}[c]{0.40\textwidth}
// %         \centering
// %          in cludegraphics[width=1\linewidth]{figure/implication_graph.pdf}
// %         \caption*{(b)}
// %     \end{minipage}
// %     \begin{minipage}[c]{0.33\textwidth}
// %         \centering
// %         \footnotesize
// %         \begin{tabular}{ccccc}
// %             name & cl & lit & var & ante \\
// %             \midrule
// %             $c_4$ &$\overline{v_3} \lor \overline{v_4}$   & $\overline{v_3}$ &$v_3$   &     $c_2$\\
// %             & $\overline{v_4} \lor \overline{v_1} \lor v_5$  & $\overline{v_4}$   &     $v_4$  &      $c_3$\\
// %             &$\overline{v_1} \lor v_5 \lor \overline{v_2}$   & $\overline{v_2}$   &     $v_2$  &      $c_1$\\
// %             $c_5$      & $\overline{v_1} \lor v_5$
// %         \end{tabular}
// %         \caption*{(c)}
// %     \end{minipage}
// %     \caption{(a) A set of clauses, (b) an implication graph, and (c) learning a new clause.\label{fig:igraph}}
// % \end{figure}


// % \begin{example}
// %     Assume we have the clauses in~@fig:igraph(a), the assignments $\overline{v_5}@3$ and $v_1@6$ (represented in the graph in~@fig:igraph(b) by nodes  $\overline{v_5}@3$ and $v_1@6$, respectively), and are currently at decision level $dl$ 6.
// % Because of assignment $v_1@6$, \texttt{BCP} infers $v_2@6$ from the unit clause $c_1$ and captures that implication with edge $v_1@6 \xrightarrow{c_1} v_2@6$.
// % Next, because of assignment $v_2@6$, \texttt{BCP} infers $v_4@6$ from the unit clause $c_3$ as shown by edge $v_2@6 \xrightarrow{c_3} v_4@6$.

// % Similarly, \texttt{BCP} creates edges $v_1@6 \xrightarrow{c_2} v_3@6$ and $\overline{v_5}@ \xrightarrow{c_2} v_3@6$ to capture  the inference $v_3@6$ from the unit clause $c_2$ due to assignments $\overline{v_5}@3$ and $v_1@6$.
// % Now, \texttt{BCP} detects a conflict because clause $c_4=\overline{v_3} \lor \overline{v_4}$ cannot be satisfied with the assignments $v_4@6$ and $v_3@6$ (i.e., both $v_3$ and $v_4$ are $T$)  and creates two edges to the (red) node $\kappa$: $v_4@6 \xrightarrow{c_4} \kappa$ and $v_3@6 \xrightarrow{c_4} \kappa$ to capture this conflict.

// % Note that in this example \texttt{BCP} has the implication order $v_2,v_4,v_3$ (and then reaches a conflict). In the current implementation, \tool{} makes an arbitrary decision and thus could have a different order, e.g., $v_3, v_4,v_2$.
// % \end{example}

// % %While many SAT solvers use such arbitrary BCP implications, some use heuristics to make decisions to help reach a conflict faster~\cite{pipatsrisawat2007lightweight}.


// % %The implication graph is sensitive to the order in which the implications are propagated in BCP, which means that the graph is not unique for a given partial assignment. In most SAT solvers, this order is rather arbitrary (in particular, BCP progresses along a list of clauses that contain a given literal, and the order of clauses in this list can be sensitive to the order of clauses in the input CNF formula). In some other SAT solvers, this order is not arbitrary; rather, it is biased towards reaching a conflict faster. \tvn{what about in \tool{}, is the order arbitrary?}

// % % To illustrate the technique, we use some notations as in \cite{barrett2013decision}.
// % % If a variable $v_i$ is assigned 1 (owing to either a decision or an implication) at decision level \textit{dl}, we write $v_i@dl$. Similarly, $\overline{v_i}@dl$ reflects an assignment of False to this variable at decision level \textit{dl}.
// % % Where appropriate, we refer only to the truth assignment, omitting the decision level, in order to make the notation simpler.

// % % Consider, for example, a formula that contains the following set of conflict clauses, among others:
// % % \begin{equation}
// % %     \begin{aligned}
// % %         c_1 &= (\overline{v_1} \lor v_2) \\
// % %         c_2 &= (\overline{v_1} \lor v_3 \lor v_5) \\
// % %         c_3 &= (\overline{v_2} \lor v_4) \\
// % %         c_4 &= (\overline{v_3} \lor \overline{v_4}) \\
// % %         c_5 &= (v_1 \lor v_5 \lor \overline{v_2}) \\
// % %         c_6 &= (v_2 \lor v_3) \\
// % %         c_7 &= (v_2 \lor \overline{v_3}) \\
// % %         c_8 &= (v_6 \lor \overline{v_5})
// % %     \end{aligned}
// % % \end{equation}




// % \subsection{Conflict Analysis <sec:analyze-conflicts}

// % Given an implication graph with a conflict (e.g.,~@fig:igraphb), \texttt{AnalyzeConflict} learns a new \emph{clause} to avoid past decisions causing the conflict.
// % The algorithm traverses the implication graph backward, starting from the conflicting node $\kappa$, while constructing a new clause through a series of resolution steps.
// % \texttt{AnalyzeConflict} aims to obtain an \emph{asserting} clause, which is a clause that will force an immediate BCP implication after backtracking.


// % \begin{wrapfigure}{r}{0.50\textwidth}
// % \begin{minipage}{\linewidth}
// % \vspace{-0.2in}
// % \begin{algorithm}[H]
// %     \small
// %      in put{implication graph \implicationgraph}
// %     \Output{\clause}
// %     \BlankLine
// %     $\clause >=ts \CurrentConflictClause(\implicationgraph)$\;\label{line:conflict}
// %     \While{$not \StopCriterion(\clause)$}{\label{line:loopstart}
// %       $\literal >=ts \LastAssignedLiteral(\implicationgraph, \clause)$\;\label{line:lit}
// %       $\variable >=ts \LiteralToVariable(\literal)$\;\label{line:var}
// %       $\antecedent >=ts \Antecedent(\implicationgraph,\literal)$\;\label{line:ante}
// %       $\clause >=ts \BinRes(\clause, \antecedent, \variable)$\;\label{line:resolve}
// %      <line:loopend}
// %     \Return{$\clause$}
// %     \caption{\textsc{AnalyzeConflict} <alg:conflict}
// %   \end{algorithm}
// %   \end{minipage}
// % \end{wrapfigure}
// % \texttt{AnalyzeConflict}, shown in~@alg:conflict, first extracts the conflicting clause $cl$ (line~\ref{line:conflict}), represented by the edges connecting to the conflicting node $\kappa$ in the implication graph.
// % Next, the algorithm refines this clause to achieve an asserting clause (lines~\ref{line:loopstart}--~\ref{line:loopend}).
// % It obtains the literal $lit$ that was assigned last in $cl$ (line~\ref{line:lit}), the variable $var$ associated with $lit$ (line~\ref{line:var}), and the antecedent clause $ante$ of that $var$ (line~\ref{line:ante}), which contains $\overline{lit}$ as the only satisfied literal in the clause. Now, \texttt{AnalyzeConflict} resolves $cl$ and $ante$ to eliminate literals involving $var$ (line~\ref{line:resolve}). The result of the resolution is a clause, which is then refined in the next iteration.

// % \paragraph{Resolution.} We use the standard \emph{binary resolution rule} to learn a new clause implied by two (\emph{resolving}) clauses $a_1 \lor ... \lor a_n \lor \beta$ and $b_1 \lor ... \lor b_m \lor \overline{\beta}$ containing complementary literals involving the (\emph{resolution}) variable $\beta$:
// % \begin{equation} \label{eq:binary-resolution}
// %     \frac{(a_1 \lor ... \lor a_n \lor \beta) quad quad (b_1 \lor ... \lor b_m \lor \overline{\beta})}{(a_1 \lor ... \lor a_n \lor b_1 \lor ... \lor b_m)} quad  (\textsc{Binary-Resolution})
// % \end{equation}
// % The resulting (\emph{resolvant}) clause $a_1 \lor ... \lor a_n \lor b_1 \lor ... \lor b_m$ contains all the literals that do not have complements $\beta$ and $not{\beta}$.
// % %A well-known result obtained by Robinson \cite{robinson1965machine} shows that a deductive system based on the \textbf{binary resolution} rule as its single inference rule is \textbf{sound} and \textbf{complete}.
// % %In other words, a CNF formula is unsatisfiable if and only if there exists a finite series of binary resolution steps ending with the empty clause.

// % %The function \textsc{Binary-Resolution}($c_1, c_2, v$) used in line 10 of Algorithm~\ref{alg:conflict} returns the resolvent of clauses $c_1, c_2$, where the \textbf{resolution variable} is $v$ ($\beta$ in the Equation~\ref{eq:binary-resolution}).

// % %\textbf{Stopping Criteria} \hd{Learned conflict clause is a special kind of conflict clause, called an \textbf{asserting} clause: it forces an immediate implication after backtracking. Empirical studies show that a good strategy for stopping criteria is to  return \textbf{true} if and only if the learned conflict clause $cl$ contains the negation of the first UIP as its single literal at the current decision level. This negated literal becomes asserted immediately after backtracking. In short, the learned conflict clause $cl$ should be an \textbf{asserting} clause.}
// % %(to obtain an asserting clause

// % % using the clauses in~@fig:igrapha and implication graph in~@fig:igraphb developed in
// % \begin{example}

// %    ~@fig:igraph(c) demonstrates \texttt{AnalyzeConflict} using the example in \S\ref{sec:bcp} with the BCP implication order $v_2,v_4,v_3$ and the conflicting clause $cl$ (connecting to node $\kappa$ in the graph in~@fig:igraph(b)) $c_4=\overline{v_3} \lor \overline{v_4}$. From $c_4$, we determine the last assigned literal is $lit=\overline{v_3}$, which contains the variable $var=v_3$, and the antecedent clause containing $v_3$ is $c_2=\overline{v_1} \lor v_3 \lor v_5$ (from the implication graph in~@fig:igraph(b), we determine that assignments $v_1@6$ and $\overline{v_5}@3$ cause the BCP implication $v_3@6$ due to clause $c_2$). Now we resolve the two clauses $cl$ and $c_2$ using the resolution variable $v_3$ to obtain the clause $\overline{v_4} \lor \overline{v_1} \lor v_5$.
// % Next, from the new clause, we obtain $lit=\overline{v_4}, var=v_4, ante=c_3$ and apply resolution to get the clause $\overline{v_1} \vee v_5 \lor \overline{v_2}$.
// % Similarly, from this clause, we obtain $lit=\overline{v_2}, var=v_2, ante=c_1$ and apply resolution to obtain the clause $v_1 \lor v_5$.
// % % \begin{figure}
// % %   \centering
// % %   \begin{tabular}{ccccc}
// % %     name & cl & lit & var & ante \\
// % %     \midrule
// % %     $c_4$ &$\overline{v_3} \lor \overline{v_4}$   & $\overline{v_3}$ &$v_3$   &     $c_2$\\
// % %          & $\overline{v_4} \lor \overline{v_1} \lor v_5$  & $\overline{v_4}$   &     $v_4$  &      $c_3$\\
// % %          &$\overline{v_1} \lor v_5 \lor \overline{v_2}$   & $\overline{v_2}$   &     $v_2$  &      $c_1$\\
// % %     $c_5$      & $\overline{v_1} \lor v_5$

// % %   \end{tabular}
// % %   \caption{Learning a new clause. <fig:igraphc}
// % % \end{figure}

// % At this point, \texttt{AnalyzeConflict} determines that this is an asserting clause, which would force an immediate BCP implication after backtracking. As will be shown in \S\ref{sec:backtrack}, \tool{} will backtrack to level 3 and erases all assignments after this level (so the assignment $\overline{v_5}@3$ is not erased, but assignments after level 3 are erased).  Then, \texttt{BCP} will find that $c_5$ is a unit clause because $\overline{v_5}@3$ and infers $\overline{v_1}$.
// % Once obtaining the asserting clause, \texttt{AnalyzeConflict} stops the search, and \tool{} adds  $v_1\lor v_5$ as the new clause $c_5$ to the set of existing four clauses.

// % \end{example}

// % %is a main benefit of CDCL and
// % The process of learning clauses allows \tool{} to learn from its past mistakes.
// % While such clauses are logically implied by the formula in ~@eq:nnv2 and therefore do not change the result, they help prune the search space and allow DPLL and therefore \tool{} to scale. For example, after learning the clause $c_5$, together with assignment $v_5@3$, we immediately infer $v_1 \mapsto F$ through BCP instead of having to guess through \texttt{Decide}.

// % %The literal lit is the literal in cl assigned last, and var denotes its associated variable. The antecedent clause of var, denoted by ante, contains ¬lit as the only satisfied literal, and other literals, all of which are currently unsatisfied. The clauses cl and ante thus contain lit and ¬lit, respectively, and can therefore be resolved with the resolution variable var. The resolvent clause is again a conflicting clause, which is the basis for the next resolution step.


// % %% After detecting the conflict, the solver determines which decision level to backtrack to according to the \textbf{conflict-driven backtracking} strategy.
// % %% According to this strategy, the backtracking level is set to the second most recent decision level in the conflict clause, while erasing all decisions and implications made after that level.

// % %% There are two special cases: when learning a \textit{unary} clause, the solver backtracks to the ground level; when the conflict is at the ground level, the backtracking level is set to –1 and the solver exits and declares the formula to be \textbf{unsatisfiable}.

// % %In the case of $c_9$, the solver backtracks to decision level 3 (the decision level of $v_5$), and erases all assignments from decision level 4 onwards, including the assignments to $v_1@6, v_2@6, v_3@6$, and $v_4@6$.
// % %The newly added conflict clause $c_9$ becomes a unit clause since $\overline{v_5}@3$, and therefore the assignment $\overline{v_1}@3$ is implied.
// % %This new implication restarts the BCP process at level 3.


// % %% Formally, the process of the analyze conflict is described in Algorithm~\ref{alg:conflict}.
// % %% For a given unit clause $C$ with an unassigned literal $l$, we say that $l$ is implied by $C$ and that $C$ is the \textbf{antecedent clause} of $l$, denoted by \textsc{Antecedent}($l$).
// % %% For example, in the example in Sec \ref{sec:bcp}, at decision level 3 the decision was $\overline{v_6}@3$, which implied $\overline{v_5}@3$ owing to clause $c_8$, hence \textsc{Antecedent}($\overline{v_5}$) = $c_8$.


// % %% The other functions and variables are self-explanatory.


// % %% The implication graph on the~@fig:igraphb demonstrates the BCP process at the current decision level 6 until, in this case, a conflict is detected.
// % %% The roots of this graph, namely $\overline{v_5}@3$ and $v_1@6$, constitute a sufficient condition for creating this conflict.
// % %% Therefore, we can safely add to our formula the \textbf{conflict clause}:
// % %% \begin{equation}
// % %%     c_9 = (v_5 \lor \overline{v_1})
// % %% \end{equation}


// % \subsection{Backtrack} \label{sec:backtrack}
// % From the clause returned by \texttt{AnalyzeConflict}, \texttt{Backtrack}  (@fig:alg, line~\ref{line:backtrack}) computes a backtracking level and erases all decisions and implications made after that level.
// % If the clause is \emph{unary} (containing just a single literal), then we backtrack to level 0. % (and if we obtain further conflict with this clause, then the formula is unsatisfiable).

// % Currently, \tool{} uses the standard \emph{conflict-drive backtracking} strategy~\cite{barrett2013decision}, which sets the backtracking level to the \emph{second most recent} decision level in the clause.
// % Intuitively, by backtracking to the second most recent level, which means erasing assignments made \emph{after} that level, this strategy encourages trying new assignments for more recently decided variables.
// % %\hd{Other backtracking scheme in Chaff~\cite{moskewicz2001chaff}: always stop clause learning at the first UIP --- This form of clause learning, and associated backtracking procedure, is referred to as first UIP clause learning. Existing results indicate that the first UIP clause learning procedure may end up doing more backtracking than the original clause learning of GRASP~\cite{zhang2001efficient}. However, Chaff creates significantly fewer clauses and is significantly more effective at backtracking. As a result, the first UIP learning scheme is now commonly used by the majority of CDCL SAT solvers.}

// % %\tvn{Intuitively this is because} \hd{Intuitively, backtracking to 2nd most recent $dl$ in $cl$ to flip the assignment of the most recent decided literal (True to False or False to True). For example,  {$not x_5@3, x_1@6$ } causes the conflict, the most recent decided literal is $x_1$, then we need to flip $x_1$ from True to False. But now $x_1$ is associated with decision level 3 (dl 3 is decision level of $x_5$ --- the literal which has 2nd most recent decision level in the learned conflict clause.)}.



// % \begin{example}

// %     From the clause $c_5=\overline{v_1} \lor v_5$ learned in \texttt{AnalyzeConflict}, we backtrack to decision level 3, the second most recent decision level in the clause (because assignments $v_1@6$  and $\overline{v_5}@3$ were decided at levels 6 and 3, respectively). Next, we erase all assignments from decision level 4 onward (i.e., the assignments to $v_1,v_2,v_3,v_4$ as shown in the implication graph in~@fig:igraph). This thus makes these more recently assigned variables (after decision level 3) available for new assignments (in fact, as shown by the example in~@sec:bcp, \texttt{BCP} will immediately infer $v_1=T$ by noticing that $c_5$ is now a unit clause).
// % \end{example}

// % %\tvn{Discussion: waste of time for erasing everything from dl?} \hd{If we don't erase information from $dl$ when backtrack occurs, it will require a lot of memories to save the redundant information of implication graph from decision level $dl$ onwards.}
// % % \subsection{Clause Learning}
// % % \tvn{write pseudo code if it is complicated enough}
// % % \tvn{Describe }

// % % \tvn{Give small illustration using example in SEct 3}

// % % \subsection{Backtracking}
// % % \tvn{write pseudo code if it is complicated enough}
// % % \tvn{Describe }

// % % \tvn{Give small illustration using example in SEct 3}



// % %% \subsubsection{Backtrack} Given a conflict clause, \textbf{Backtrack}  (@fig:alg, line~\ref{line:backtrack}) compute a decision level to backtrack to. Currently, we use the \emph{conflict-drive backtracking}~\cite{barrett2013decision}, which sets the backtracking level to the \emph{second most recent} decision level in the conflict clause \tvn{Intuitively this is because}.
// % %% Next, Backtrack erases decisions by Decide and implications by BCP and Deduce made after that level.
// % %% Note that if we learn a \emph{unary} clause, which contain just a single literal, then we backtrack to level 0 (and if we obtain further conflict with this clause (a conflict at level $dl=0$, line~\ref{line:unsat}), i.e., the formula is unsatisfiable).

// % \subsection{Restart <sec:restart}


// % As with any stochastic algorithm, \tool{} can perform poorly if it gets into a subspace of the search that does not quickly lead to a solution, e.g., due to choosing a bad sequence of neurons to split~\cite{bunel2018unified,de2021improved}.
// % % In the development of modern SAT solver (e.g.PicoSAT~\cite{biere2008picosat}), researchers has realized most practical problems, even very large or complex, can be easily solved if they follow
// % This problem, which has been recognized in early SAT solving, motivates the introduction of restarting the search~\cite{gomes1998boosting} to avoid being stuck in such a \emph{local optima}.




// % %because the initial clause is too simple (e.g., $v_i \lor \overline{v_i}$) to make clause learning effective.

// % %\tvn{some more explanation on why this make clause learning ineffective}
// % %\hd{simple and trivial clauses lead to simple chronological backtracks by the binary resolution during conflict analysis step}
// % %Having said that without using restart, the non-chronological backtracks would never get used by \tool{} since these backtracks need more complex implication graph to be jumped into.

// % \tool{} uses a simple restart heuristic (@fig:alg, line~\ref{line:restart}) that triggers a restart when either the number of processed assignments (nodes) exceeds a pre-defined number (e.g., 300 nodes) or the current runtime exceeds a pre-defined threshold (e.g., 50 seconds).
// % % \tvn{what are these number and threshold?}\hd{added}
// % After a restart, \tool{} avoids using the same decision order of previous runs (i.e., it would use a different sequence of neuron splittings). It also resets all internal information (e.g., decisions and implication graph) except the learned conflict clauses, which are kept and reused as these are \textit{facts} about the given constraint system.
// % This allows a restarted search to quickly prune parts of the  space of assignments.


// % %For \tool{} and DNN verification problem, we found that restart is especially important for solving difficult problem.
// % %Restart, which is only triggered for expensive searches, allows for a different decision ordering and assignments that might solve the problem quicker. Moreover,

// % We found the combination of clause learning and restarts effective for DNN verification. In particular, while restart resets information  it keeps learned clauses, which  are \emph{facts} implied by the problem, and therefore enables quicker BCP applications and non-chronological backtracking (e.g., as illustrated in~@fig:tree).

// % %It is worth noting that while it is possible to add a restart to existing DNN verification approaches. This is unlikely to help, because these techniques do not learn conflict clauses and therefore restart will just randomize order but carry no information forward to prune the search space.

// % %... \mbd{discuss possibility of restart for other tools, but it will just randomize order but carry no information forward to prune search.}

// % % \tvn{these are standard arguments for restart.  For \tool{} and DNN verifcation problem,  restart is even more important because the inital clause is too simple to make clause learning effective.  You should say something here about that issue.  Just write all of them here and we can clean it up}



// %  == Deduction (Theory Solving) <sec:deduction}

// % \begin{algorithm}[t]
// %     \small

// %      in put{ DNN $\network$, input property $phi_"in"$, output property $phi_"out"$, decision level $dl$ and current assignment $\assignment$}
// %     \Output{{\false} if infeasibility occurs, {\true} otherwise}

// %     \BlankLine

// %     $\lpmodel <=ftarrow \LPSolver(\assignment, \network \land phi_"in" \land \overline{phi_"out"})$\;\label{line:lpsolver}
// %     \lIf{$\Solve(\lpmodel) \equiv  in feasible$}{\Return {\false} <line:solve}
// %     \lIf(\tcp*[h]{orig prob (~@eq:nnv2) is satisfiable}){$\isTotal(\assignment)$}{\Return {\true}  <line:full}
// %     %$ in puts = >=tInputs(phi_"in")$
// %     % $\ninputs <=ftarrow >=tNumInputs(\network)$
// %     % $\layernodes = \FindLayerNodes(\assignment)$\;

// %     % \If{$| in puts| <= \maxinputs$}{
// %     %     $ in putbounds = \TightenBounds(\lpmodel,  in puts)$\;\label{line:tighteninpsb}
// %     % }
// %     % \Else{$ in putbounds = >=tInputBounds(phi_"in")$\;\label{line:inputbounds}
// %     % }

// %     $ in putbounds <=ftarrow \TightenInputBounds(\lpmodel, phi_"in")$\;\label{line:absstart}
// %     $\outputbounds, \hiddenbounds <=ftarrow \Abstract(\network, \assignment,  in putbounds$)\;\label{line:abstraction}

// %     \lIf{$\Check(\outputbounds, \overline{phi_"out"}) \equiv  in feasible$}{\Return {\false} <line:checkfeasibility}

// %     \For{$v in \hiddenbounds$} {\label{line:infera}
// %       $x <=ftarrow \ActivationStatus(v)$\;
// %       \lIf{$x in sigma \lor not{x} in sigma$}{\Continue}
// %       \lIf{$\Lower(v) > 0$}{$\assignment <=ftarrow \assignment \cup x@dl$}
// %         <=lseIf{$\Upper(v) <= 0$}{$\assignment <=ftarrow \assignment \cup \overline{x}@dl$ <line:inferb}
// %     }

// %     \Return {\true}\;\label{line:absend}

// %     \caption{\textsc{Deduction} <alg:deduction}
// % \end{algorithm}

// % \texttt{Deduction} (@fig:alg, line~\ref{line:deduction}) is the theory or T-solver, i.e., the T in DPLL(T). The main purpose of the T-solver is to check the feasibility of the constraints represented by the current propositional variable assignment; as shown in the formalization in \S\ref{sec:formalization} this amounts to just \emph{linear equation} solving for verifying piecewise linear DNNs. However, \tool{} is able to leverage specific information from the DNN problem, including input and output properties, for more aggressive feasibility checking.  Specifically, \texttt{Deduction} has three tasks: (i) checking feasibility using linear programming (LP) solving, (i) further checking feasibility with input tightening and abstraction, and (iii) inferring literals that are unassigned and are implied by the abstracted constraint.

// % %The algorithm returns conflict if the current assignment does not satisfy the constraints of the network and property.
// % %Similar to \textsc{BCP}, Deduce also perform assignment inferencing.


// % @alg:deduction describes \texttt{Deduction}, which returns \texttt{False} if infeasibility occurs and  \texttt{True} otherwise.
// % %\textsc{Deduce} is a theory solver that takes the arguments including: the current assignment $sigma$, neural network $alpha$, precondition $phi_"in"$ over inputs and postcondition $phi_"out"$ over outputs.
// % First, it creates a linear constraint system from the input assignment $sigma$ and $alpha \land phi_"in" \land \overline{phi_"out"}$, i.e., the formula in ~@eq:nnv2 representing the original problem  (line~\ref{line:lpsolver}).
// % The key idea is that we can remove ReLU activation for hidden neurons whose activation status have been decided.
// % For constraints in $alpha$ associated with variables that are not in the $sigma$,  we ignore them and just consider the cutting planes introduced by the partial assignment.
// % %FixUB preceding sentence based on answer.}
// % %\hd{Yes, you're correct. We ignore constraints generated by unassigned variables and only consider the cutting planes introduced by the partial assignment}
// % For example, for the assignment $v_3\mapsto T, v_4 \mapsto F$, the non-linear ReLU constraints $x_3=ReLU(-0.5x_1+0.5x_2+1)$ and  $x_4=ReLU(x_1+x_2-1)$ for the DNN in~@fig:dnn become linear constraints $x_3=-0.5x_1+0.5x_2$ and $x_4=0$, respectively.

// % Next, an LP solver checks the feasibility of the linear constraints (line~\ref{line:solve}).
// % If the solver returns infeasible,  \texttt{Deduction} returns \texttt{False} so that \tool{} can analyze the assignment and backtrack.
// % If the constraints are feasible, then there are two cases to handle. First, if the assignment is total (i.e., all variables are assigned), then that means that the original problem is satisfiable (line~\ref{line:full}) and \tool{} returns \texttt{sat}.

// % \paragraph{ReLU Abstraction.} Second, if the assignment is not total then \texttt{Deduction} applies abstraction to check satisfiability (lines~\ref{line:absstart}--\ref{line:checkfeasibility}).
// % Specifically, we over-approximate  ReLU computations to obtain the upper and lower bounds of the output values and check if the output properties are feasible with respect to these bounds. For example, the output $x_5 > 0$ is \emph{not} feasible if the upperbound is $x_5 <= 0$ and \emph{might be} feasible if the upperbound is $x_5 <= 0.5$ (``might be'' because this is an upper-bound). If abstraction results in infeasibility, then \texttt{Deduction} returns \texttt{False} for \tool{} to analyze the current assignment (line~\ref{line:checkfeasibility}).

// % \begin{figure}
// %     \begin{minipage}[b]{1\linewidth}
// %         \centering
// %         \begin{minipage}[c]{0.24\linewidth}
// %              in cludegraphics[width=\linewidth]{figure/interval-3.pdf}
// %             \vspace*{-10mm}
// %             \caption*{(a) interval}
// %         \end{minipage}
// %         % \hspace{0.05\textwidth}%
// %         \begin{minipage}[c]{0.24\linewidth}
// %              in cludegraphics[width=\linewidth]{figure/zonotope-3.pdf}
// %             \vspace*{-10mm}
// %             \caption*{(b) zonotope}
// %         \end{minipage}
// %         % \hspace{0.05\textwidth}%
// %         \begin{minipage}[c]{0.24\linewidth}
// %              in cludegraphics[width=\linewidth]{figure/polytope-3.pdf}
// %             \vspace*{-10mm}
// %             \caption*{(c) DeepPoly}
// %         \end{minipage}
// %         \begin{minipage}[c]{0.24\linewidth}
// %              in cludegraphics[width=\linewidth]{figure/lirpa-3.pdf}
// %             \vspace*{-10mm}
// %             \caption*{(d) LiRPA}
// %         \end{minipage}
// %         \vspace*{-3mm}
// %         \caption{Abstractions for ReLU: (a) interval, (b) zonotope, and (c-d) polytopes. Notice that ReLU is a non-convex region (red line) while all abstractions are convex regions. Note that (c) and (d) are both polytopes. <fig:abs}
// %     \end{minipage}
// % \end{figure}

// % \tool{} uses abstraction to approximate the lower and upper bounds of hidden and output neurons.
// % @fig:abs compares the (a) interval~\cite{wang2018formal}, (b) zonotope~\cite{singh2018fast}, and (c, d) polytope~\cite{xu2020fast,singh2019abstract,wang2021beta} abstraction domains to compute the lower $l_y(x)$ and upper $u_y(x)$ bounds of a ReLU computation $y=\texttt{ReLU(x)}$ (non-convex red line).
// % \tool{} can employ any existing abstract domains, though currently it adopts the \emph{LiRPA} polytope (@fig:absd)~\cite{xu2020fast,xu2020automatic,wang2021beta} because it has a good trade-off between precision and efficiency.

// % %\hd{remove this sentence?}

// % \paragraph{Inference} If abstraction results in feasible constraints, \texttt{Deduction} next attempts to infer implied literals (lines~\ref{line:infera}--~\ref{line:inferb}). To obtain the bounds of the output neurons, abstraction also needs to compute the bounds of hidden neurons, including those with undecided activation status (i.e., not yet in $sigma$).
// % This allows us to assign the activation variable of a hidden neuron the value
// % \texttt{True} if the lowerbound of that neuron is greater than 0 (the neuron is active) and
// % \texttt{False} otherwise.
// % Since each literal is considered, this would be considered exhaustive theory propagation.  Whereas the literature~\cite{nieuwenhuis2006solving,kroening2016decision} suggests that this is an inefficient strategy, we find that it does not incur significant overhead (average overhead is about 4\% and median is 2\%).

// % %\mbd{forward pointer to data on this in evaluation section.}
// % %\hd{Maximum overhead is about 39\% of runtime, all cases which have overhead > 30\% belong to CIFAR networks from CIFAR2020 benchmark which are large (cifar10\_2\_255, convBigRELU\_PGD), average overhead is about 4\%, apply median filter and average will be 2\%}

// % \begin{example} For the illustrative example in~@ex:neuralsat, in iteration 3, the current assignment $sigma$ is  $ {v_4=1 }$, corresponding to a constraint $x_1 + x_2 - 1 > 0$. With the new constraint, we optimize the input bounds and compute the new bounds for hidden neurons $0.5 <= x_3 <= 2.5$, $0 < x_4 <= 2.0$ and output neuron  $x_5 <= 0.5$ (and use this to determine that the postcondition $x_5 > 0$ might be feasible). We also infer $v_3=1$ because of the positive lower bound $0.5 <= x_3$.
// % \end{example}



// %  == \tool{}'s Optimizations <sec:optimizations}

// % \tool{} implements several optimizations to improve the performance of the search. First are the common optimizations used by other DNN verifiers, such as input splittings (@chap:common-engineering) and adversarial attacks (@chap:adversarial-attacks). In addition, \neuralsat{} implements several unique optimizations~\cite{duong2024harnessing} to improve the performance of the search. These are neuron stability, restart tree, and restart.


// % \subsection{Neuron Stability <sec:stabilization}
// % A neuron is \emph{stable} if its activation status does not change regardless of the input values. In contrast, a neuron is \emph{unstable} if its activation status can change depending on the input values. For example, in the DNN in~@fig:dnn, \tvn{any neuron stable? or they are all unstable?}


// % The key idea in using neuron stability is that if we can determine that a neuron is stable,  we can assign the exact truth value for the corresponding Boolean variable instead of having to guess. This has a similar effect as \mycode{BCP}---reducing mistaken assignments by \Decide---but it operates at the theory level instead of the propositional Boolean level.

// % %First, the T-solver creates a linear constraint system from the input assignment $sigma$ and $alpha \land phi_"in" \land \overline{phi_"out"}$, i.e., the formula in ~@eq:nnv2 representing the original problem  (line~\ref{line:lpsolver}).
// % %First, the T-solver creates a set of linear constraints representing ReLU activation for hidden neurons whose activation status have been decided.
// % %Next, those constraints are used in \textsc{Stabilize} for inferring status of neurons that are unassigned, \textsc{Deduce} then applies the polytope abstraction to check satisfiability.
// % %If the abstraction confirms the infeasibility, \textsc{Deduce} returns \texttt{False} so that \textsc{AnalyzeConflict} can analyze the assignment and and learn the conflict clause.
// % %Otherwise, the current assignment might be feasible and \textsc{Decide} continues to split more hidden neurons.


// % %\texttt{Stabilize} (@fig:alg line~\ref{line:stabilize}) first creates linear constraints consisting of the DNN $alpha$, the input \tvn{fillin} and output \tvn{fillin} conditions, and the current assignment $sigma$. Next, it uses these constraints to generate a Mixed Integer Linear Programming (MILP) problem (~@eq:mip), whose objective is compute a tighter lower and upper bounds for unstable neurons based on the current search state (i.e., the current assignment $sigma$).

// % %the considered property into a set of constraints for
// % %The main goal of this process is to


// % %the boolean values activation status instead of
// % %that we can remove ReLU activation for hidden neurons whose activation status have been decided, each propositional variable in current assignment concretizes (removes) its corresponding constraints in MILP problem (~@eq:mip) that helps solver reduce numbers of constraints and be able to tighten bounds further.



// % % \hd{Should mention about StabilizeCondition: \tool{} invokes Stabilize() after a number of iterations without improvement in Deduce step (abstraction), e.g, 10 iterations.}

// % %\tvn{candidate to remove}
// % %The complexity of this problem can increase exponentially with the number of ReLU neurons, so it would take long time to run even on a small network.
// % %In the previous work, \mipverify{}~\cite{tjeng2019evaluating} encoded the adversarial attack and verification of ReLU-based networks MIP problem, directly solved by existing MILP solvers (e.g., Gurobi).
// % %In this work, we do not use MILP for solving instances directly, instead we leverage the progressive bound tightening for determining tighter bounds for hidden neurons which is crucial for problem tractability: tight bounds strengthen the problem formulation and thus improve solve times~\cite{vielma2015mixed}.
// % %Furthermore, if we can prove that a neuron is stable, we can avoid splitting in the DPLL(T)-based search process.

// % %Theoretically, for ReLU-based networks, each neuron can either be \textit{active} (its input is positive) or \textit{inactive} (its input is negative so the output is 0), which can be encoded by discrete 0-1 variables.
// % %Those networks can be generally formulated into a MILP problem which has binary variables $a_j^{(i)}$ for an $j^{th}$ ReLU at layer $i$:

// % Stabilization involves the solution of a mixed integer linear program (MILP) system~\cite{tjeng2019evaluating}:
// % \begin{equation}
// %     \begin{aligned}
// %         &\mbox{(a)}quad z^{(i)} = W^{(i)}  hat(z)^{(i-i)} + b^{(i)}; \\
// %         &\mbox{(b)}quad y = z^{(L)};  x =  hat(z)^{(0)}; \\
// %         &\mbox{(c)}quad  hat(z)_j^{(i)} >= {z}_j^{(i)};  hat(z)_j^{(i)} >= 0; \\
// %         &\mbox{(d)}quad a_j^{(i)} in  { 0, 1 } ;\\
// %         &\mbox{(e)}quad  hat(z)_j^{(i)} <= {a}_j^{(i)} {u}_j^{(i)};  hat(z)_j^{(i)} <= {z}_j^{(i)} - {l}_j^{(i)}(1 - {a}_j^{(i)}); \\
// %     \end{aligned}
// %     \label{eq:mip1}
// % \end{equation}
// % where $x$ is input, $y$ is output, and $z^{(i)}$, $ hat(z)^{(i)}$, $W^{(i)}$, and $b^{(i)}$ are the pre-activation, post-activation, weight, and bias vectors for layer $i$.
// % The equations encode the semantics of a DNN as follows:
// % (a) defines the affine transformation computing the pre-activation value for a neuron in terms of outputs in the preceding layer;
// % (b) defines the inputs and outputs in terms of the adjacent hidden layers;
// % (c) asserts that post-activation values are non-negative and no less than pre-activation values;
// % (d) defines that the neuron activation status indicator variables that are either 0 or 1; and
// % (e) defines constraints on the upper, $u_j^{(i)}$, and lower, $l_j^{(i)}$, bounds of the pre-activation value of the $j$th neuron in the $i$th layer.
// % Deactivating a neuron, $a_j^{(i)} = 0$, simplifies the first of the (e) constraints to $ hat(z)_j^{(i)} <= 0$, and activating a neuron simplifies the second to $ hat(z)_j^{(i)} <= z_j^{(i)}$, which is consistent with the semantics of $ hat(z)_j^{(i)} = max(z_j^{(i)},0)$.

// % %Even if \mycode{Stabilize} fails to stabilize, \tool{} still can solve problem by other components, e.g., parallel DPLL(T) search.



// % \SetKwFunction{GetUnassignedVariable}{GetUnassignedVariable}
// % \SetKwFunction{Sort}{Sort}

// % \begin{algorithm}
// %     \small

// %      in put{DNN $alpha$, property $phi_"in" \Rightarrow phi_"out"$, current assignment $sigma$, number of neurons for stabilization $k$}
// %     \Output{Tighten bounds for variables \textbf{not} in $sigma$ (unassigned variables)}
// %     \BlankLine

// %     % \tcp{create an MILP solver based on ~@eq:mip}
// %     $\model <=ftarrow \MIP(alpha, phi_"in", phi_"out", sigma)$ \tcp{create model (~@eq:mip1) with  current assignment}

// %     $[v_1, ..., v_m] <=ftarrow >=tUnassignedVariable(sigma)$ \tcp{get all $m$ current unassigned variables} \label{line:find}


// %     $[v_1', ..., v_m'] <=ftarrow \Sort([v_1, ..., v_m])$ \tcp{prioritize tightening order} \label{line:sort}
// %     $[v_1', ..., v_k'] <=ftarrow \Select([v_1', ..., v_m'], k)$ \tcp{select top-$k$ unassigned variables, $k <= m$} \label{line:topk}

// %     \tcp{stabilize $k$ neurons in parallel}
// %     \Parfor{$v_i$ \textbf{in} $[v_1', ..., v_k']$}{
// %         \If(\tcp*[h]{lower is closer to 0 than upper, optimize lower first}){$(v_i.lower + v_i.upper) >= 0$}{
// %             % \tcp{lower is closer to 0 than upper, optimize lower first}
// %             $\Maximize(\model, v_i.lower)$ \tcp{tighten lower bound of $v_i$} \label{line:maximize1}
// %             \If(\tcp*[h]{still unstable}){$v_i.lower < 0$}{
// %                 $\Minimize(\model, v_i.upper)$ \tcp{tighten upper bound of $v_i$} \label{line:minimize1}
// %             }
// %         }
// %         \Else(\tcp*[h]{upper is closer to 0 than lower, optimize upper first}){
// %             % \tcp{upper is closer to 0 than lower, optimize upper first}
// %             $\Minimize(\model, v_i.upper)$ \tcp{tighten upper bound of $v_i$} \label{line:minimize2}
// %             \If(\tcp*[h]{still unstable}){$v_i.upper > 0$}{
// %                 $\Maximize(\model, v_i.lower)$ \tcp{tighten lower bound of $v_i$} \label{line:maximize2}
// %             }
// %         }
// %     }
// %     \vspace*{-0.2in}
// %     \caption{\texttt{Stabilize}}
// %     \label{fig:stabilize}
// % \end{algorithm}



// % @fig:stabilize describes Stabilize solves this equation system.
// % First,  a MILP problem is created from the current assignment, the DNN, and the property of interest using formulation in ~@eq:mip1.
// % Note that the neuron lower (${l}_j^{(i)}$) and upper bounds (${u}_j^{(i)}$) can be quickly computed by polytope abstraction.

// % Next, it collects a list of all unassigned variables which are candidates being stabilized (line~\ref{line:find}).
// % In general, there are too many unassigned neurons, so
// % \mycode{Stabilize} restricts consideration to $k$ candidates.
// % Because each neuron has a different impact on abstraction precision we prioritize the candidates.
// % In \mycode{Stabilize}, neurons are prioritized based on their interval boundaries (line~\ref{line:sort}) with a preference for neurons with either lower or upper bounds that are closer to zero.
// % The intuition is that neurons with bounds close to zero are more likely to become stable after tightening.

// % We then select the top-$k$ (line~\ref{line:topk}) candidates and seek to further tighten their interval bounds.
// % The order of optimizing bounds of select neurons is decided by its boundaries, e.g., if the lower bound is closer to zero than the upper bound then the lower bound would be optimized first.
// % These optimization processes, i.e., \mycode{Maximize} (line~\ref{line:maximize1} or line~\ref{line:maximize2}) and \mycode{Minimize} (line~\ref{line:minimize1} or line~\ref{line:minimize2}), are performed by an external LP solver (e.g., Gurobi~\cite{gurobi}).

// % %Note that the work in~\cite{tjeng2019evaluating} uses the MILP system in ~@eq:mip to encode the entire verification problem and thus is limited to the encodings of small networks that can be handled by an LP solver.
// % %This MILP system is used by~\cite{tjeng2019evaluating} to encode the entire verification problem. It is passed to an LP solver to optimize the output of the network with respect to the the property of interest.
// % %This approach only works small networks whose constraints can be handled by LP solving.
// % %In contrast, \tool{} creates this system based on the current assignment, which has significantly fewer constraints.
// % %Moreover, we only use the computed bounds of hidden neurons from this system, and thus even if it cannot be solved, \tool{} will still continue.



// % \begin{example}
// %   \tvn{Need a concrete example here.  Use the DNN in~@fig:dnn and create the MILP system in ~@eq:mip1.}
// % \end{example}

// % \subsubsection{Parallel Search <sec:parallel-search}
// % % Things need to write about
// % % \begin{itemize}
// % %     \item [+] how to parallelize DPLL: remove backtrack, compute both branches
// % %     \item [+] how to use learned clauses: run several times until problem is solved or reaches timeout, save conflict clauses before restarting and use them as initial clauses for next runs
// % %     \item [!] non-chronological backtracking isn't supported yet, need more engineering to handle this sort of backtracks
// % % \end{itemize}


// % %\tvn{this section is short. Add some more, may be some small examples (recall in the POPL paper we have various examples describing various DPLL components).  Does the tree in Fig1. applicable here?  If so you can refer to it. }
// % %\hd{it appears that's purely engineering to me, shouldn't be focused too much}\tvn{just write what engineerings were used here to help people understand how it works.  Also describe how this removes the need for Backtracking}
// % % We adopt the idea of Distributed tree search (DTS) algorithm which is a class of algorithms for searching values in an efficient and distributed manner~\cite{ferguson1988distributed}.
// % % \matt{I woud cite DTS.}
// % % Their purpose is to iterate through a tree by working along multiple branches in parallel and merging the results of each branch into one common solution, in order to minimize time spent searching for a value in a tree-like data structure.
// % % DPLL(T) is tree-search problem in each internal nodes is actually an activation pattern containing conditions values along the path from root to such node.
// % % \matt{replace path condition with activation pattern throughout the paper}
// % % The arrival of many-core machines leads to new possibilities for SAT solving.
// % % \matt{What techniques do the parallel SAT people use, i.e., \cite{le2017painless}, we should relate our solution to theirs.}
// % % Parallel SAT solving rely on two concepts: parallelization strategy and learnt clause exchanges.
// % % Two main parallelization methods have been developed: Portfolio~\cite{hamadi2010manysat} and Divide-and-Conquer~\cite{le2017painless}.
// % % The main idea of Portfolio is to run sequential solvers working in parallel on the entire formula, in a competitive way, aiming at increasing the probability of finding a solution using the diversification.
// % % The Divide-and-Conquer (DnC) approach is based on splitting the search space in disjoint subspaces that are solved independently in parallel by different workers.
// % % If a subspace is proven sat then the initial formula is sat.
// % % The formula is unsat if all the subspaces are unsat.
// % % The challenging points of the divide-and-conquer mechanism are:
// % % dividing the search space, balancing jobs between workers, and exchanging learnt clauses.


// % The DPLL(T) process in \tool{} is designed as a tree-search problem where each internal node encodes an \textit{activation pattern} defined by the variable assignments from the root.
// % To parallelize DPLL(T), we adopt a beam search-like strategy which combines distributed search from Distributed Tree Search (DTS) algorithm~\cite{ferguson1988distributed} and Divide and Conquer (DNC)~\cite{le2017painless} paradigms for splitting the search space into disjoint subspaces that can be solved independently.
// % At every step of the search algorithm, we select up to $n$ nodes  of the DPLL(T) search tree to create a beam of width $n$.
// % This splits (like DNC) the search into $n$ subproblems that are independently processed.  Each subproblem extends the tree by a depth of 1.

// % Our approach simplifies the more general DNC scheme since the $n$ bodies of the \textbf{parfor} on line~\ref{line:parfor} of~@fig:alg are roughly load balanced.
// % While this is a limited form of parallelism, it sidesteps one of the major roadblocks to DPLL parallelism -- the need to efficiently synchronize across load-imbalanced subproblems~\cite{le2017painless,le2019modular}.

// % In addition to raw speedUB due to multiprocessing, parallelism accelerates the sharing of information across search subspaces, in particular learned clause information for DPLL. In \tool{}, we only generate independent subproblems which eliminates the need to coordinate their solution. When all subproblems are complete, their conflicts are accumulated,~@fig:alg line~\ref{line:analyze_conflict},  to inform the next round of search.


// % \subsection{Restart}

// % \SetKwFunction{threshold}{threshold}
// % \SetKwFunction{maxvisited}{max\_visited}
// % \SetKwFunction{maxremaining}{max\_remaining}
// % \SetKwData{implicationgraph}{igraph}


// % % \begin{algorithm}
// % %     \small

// % %      in put{TBD}
// % %     \Output{TBD}
// % %     \BlankLine

// % %     $\threshold <=ftarrow 3$ \tcp{predefined maximum number of restarts}
// % %     $\maxvisited <=ftarrow 200000$ \tcp{predefined maximum number of visited nodes}
// % %     $\maxremaining <=ftarrow 30000$ \tcp{predefined maximum number of remaining nodes}

// %     % \tcp{create an MILP solver based on ~@eq:mip}
// %     % $\model <=ftarrow \MIP(alpha, phi_"in", phi_"out", sigma)$ \tcp{create model (~@eq:mip) with  current assignment}

// %     % $[v_1, ..., v_m] <=ftarrow >=tUnassignedVariable(sigma)$ \tcp{get all $m$ current unassigned variables} \label{line:find}


// %     % $[v_1', ..., v_m'] <=ftarrow \Sort([v_1, ..., v_m])$ \tcp{prioritize tightening order} \label{line:sort}
// %     % $[v_1', ..., v_k'] <=ftarrow \Select([v_1', ..., v_m'], k)$ \tcp{select top-$k$ unassigned variables, $k <= m$} \label{line:topk}

// %     % \tcp{stabilize $k$ neurons in parallel}
// %     % \For{$v_i$ \textbf{in} $[v_1', ..., v_k']$}{
// %     %     \If(){$(v_i.lower + v_i.upper) >= 0$}{
// %     %         \tcp{lower is closer to 0 than upper, optimize lower first}
// %     %         $\Maximize(\model, v_i.lower)$ \tcp{tighten lower bound of $v_i$}
// %     %         \If(){$v_i.lower < 0$}{
// %     %             \tcp{still unstable}
// %     %             $\Minimize(\model, v_i.upper)$ \tcp{tighten upper bound of $v_i$}
// %     %         }
// %     %     }
// %     %     \Else{
// %     %         \tcp{upper is closer to 0 than lower, optimize upper first}
// %     %         $\Minimize(\model, v_i.upper)$ \tcp{tighten upper bound of $v_i$}
// %     %         \If(){$v_i.upper > 0$}{
// %     %             \tcp{still unstable}
// %     %             $\Maximize(\model, v_i.lower)$ \tcp{tighten lower bound of $v_i$}
// %     %         }
// %     %     }
// %     % }
// % %     \caption{\texttt{Reset}}
// % %     \label{fig:restart}
// % % \end{algorithm}

// % As with any stochastic algorithm, \tool{} would perform poorly if it gets into a subspace of the search that does not quickly lead to a solution, e.g., due to choosing a bad sequence of neurons to split~\cite{ferrari2022complete,wang2021beta,de2021improved}.
// % %In the development of modern SAT solver (e.g.PicoSAT~\cite{biere2008picosat}), researchers has realized most practical problems, even very large or complex, can be easily solved if they follow
// % This problem, which has been recognized in early SAT solving, motivates the introduction of restarting the search~\cite{gomes1998boosting} to avoid being stuck in such a \emph{local optima}. %This kind of heavy-tail behavior was also the motivation in the original publication on restarts \cite{}.


// % %In our context where easy SAT instances are usually falsified by external adversarial attack (e.g., PGD~\cite{madry2017towards}), or easy UNSAT instances are often verified within few iterations (e.g., a single iteration), we adopt restart schedule to avoid local optima during search process for ``hard'' problems (at certain points, the abstraction would not be improved or rarely improved).
// % %Moreover, previous related work showed that the order of making decisions had a great impact to their performance, hence, we hope that after restarting and decision heuristic is changed, \tool{} can follow other search directions toward the goal.

// % %\tvn{I am not so sure about listing all these numbers. Do we have to write about them here?}\hd{I think so, we can neglect those number too, those are heuristically selected and we didn't change them, different numbers might have different performances.}
// % \tool{} uses a simple restart heuristic that triggers a restart when either the number of processed assignments (nodes) exceeds a pre-defined number or the number of remaining assignments that need be checked exceeds a pre-defined threshold. % (e.g, 5000). (e.g, 20000)
// % % It also has a fast restart on the \textit{first} run when it detects a number of consecutive iterations (e.g., 10) without any improvement in abstraction steps.
// % %The period of restart is repeated until exceed a predefined maximum number of restarts (e.g., 3).
// % %These thresholds are chosen heuristically based on our experience. %and subject to change and performance of \tool{} might vary depending on those numbers.
// % After a restart, \tool{} avoids using the same decision order of previous runs (i.e., it would use a different sequence of neuron splittings). It also resets all internal information except the learned conflict clauses, which are kept and reused as these are \textit{facts} about the given constraint system.
// % This allows a restarted search to quickly prune parts of the space of assignments.
// % Although restarting may seem like an engineering aspect, it plays a crucial role in stochastic algorithms, and helps \neuralsat{} reduce verification time for challenging problemsk.




// % %reason
// % %with trade-offs between computational complexity and precision.

// % %\tvn{Describe how ABstractDomain works, e.g., are hidden\_bounds the bounds of values of hidden neurons? Also, how does CheckReachability work? why does it require $phi_"in"$?}

// % %in which we know that the original problem is satisfiable and return (and \tool{} will return \texttt{sat}).
// % %The second case is when the assignment was not full, i.e., we

// % %% For every assignment $x\mapsto $
// % %% Base on the current assignment $alpha$, first step is to build linear equations for each status variable over the input variables using back substitution.
// % %% The key idea here is that we could be able to remove the ReLU activation at layer $i$ if the pre-activation variables in the layer $i$ are fully assigned.
// % %% The ReLU function originally is non-linear (e.g., $y = max(0, x)$), but it becomes a linear function when we know about the value of its input (base on the value of assigned nodes, we could have the pre-activation values either greater or less than 0).

// % %% For example, the network in Figure~\ref{fig:dnn} is represented as the formula:
// % %% \begin{gather}
// % %%         x_3 = -0.5x_1 + 0.5x_2 + 1 \;\land\; x_3' = ReLU(x_3) \;\land\; \nonumber\\
// % %%         x_4 = x_1 + x_2 - 1 \;\land\; x_4' = ReLU(x_4)  \;\land\; \\
// % %%         x_5 = -x_3 + x_4' - 1 \;\nonumber
// % %% \end{gather}
// % %% If \tool{} decides $v_3 = True$ ($v_3$ is status variable of neuron $x_3$) and $v_4$ is undecided, we cannot have the linear relationship between $x_5$ and the inputs $x_1, x_2$, because the first layer is not fully decided, then we cannot remove the ReLU layer.
// % %% Otherwise, \tool{} decides $v_3 = True$ and $v_4 = False$, then $x_3 = -0.5x_1 + 0.5x_2 + 1$ and $x_4' = 0$, also $x_5 = 0.5x_1 - 0.5x_2 - 2$.
// % %% The first layer now is fully assigned, then the ReLU layer no longer exists, that makes we could build linear relationship of $x_5$ over $x_1, x_2$.

// % %When all the neurons of the network are decided, the network becomes a linear one, then we could build a linear solver to check the feasibility of the model w.r.t the specification, with the constraints as linear equations of outputs over inputs.
// % %Branch-and-Bound based methods without the step of checking feasibility when all split neurons are also considered as \textbf{incomplete}.

// % %Next, these equations is added to a LP solver that follow the rule of ReLU activation: if a status variable is decided to be True, which means that neuron is in active region, its equation will be greater than 0, and constraint $eq(x) > 0$ is added to the solver; otherwise constraint $eq(x) <= 0$ is added to the solver (Line 2 in Algorithm~\ref{alg:deduction}).
// % %For example, $v_3 = True$ then $x_3 > 0$ and a constraint $-0.5x_1 + 0.5x_2 + 1 > 0$ is added into the LP solver.

// % %Then, solver runs optimization step without objective function to check the feasibility of model  (Line 3).
// % %If the model is infeasible, the current assignment will lead to UNSAT state, the Theory Deduce will raise ``conflict'' status so that the core DPLL could make a conflict analysis to handle it.

// % %Otherwise, the process continues with checking the reachability of the current assignment bases on the abstraction, described in Sec~\ref{sec:theory_abstraction}.
// % %Without this step, the Theory Deduce is unable to quickly decide an assignment is unreachable.
// % %Thus, this step uses an over-approximation technique to estimate the possible output ranges w.r.t the given input ranges and the current assignment.
// % %Two well-known abstraction techniques are adapted/adopted in our \tool{}, which are \textbf{DeepPoly} in ERAN verifier \cite{singh2019abstract} and \textbf{LiRPA} in $alpha$-$\beta$-CROWN verifier\cite{wang2021beta} (Line 7).
// % %\hd{when does \tool{} use DeepPoly/LiRPA? Small number of inputs (<50), use LP to tighten input ranges then apply DeepPoly. Otherwise, jointly optimize hidden bounds and output bounds using LiRPA (same as ab-crown) --- Actually, in small number of inputs cases, it's reimplementation of DeepPoly with adaptation of learnable \textit{slopes} as in ab-crown. Depend on the input ranges, the abstraction will compute output ranges directly use original version or use optimized slopes version of DeepPoly to get better bounds.}
// % %The estimated output ranges could be used to check the reachability, as shown in Sec~\ref{sec:unsat}.
// % %If the output property is unreachable, the Theory Deduce will raise ``conflict'' status, otherwise, the output property might be reachable, we could not decide the reachability status of the current assignment.


// \part{Programming Assignments and Schedule <part:pas-schedule}
// \renewcommand{\appendixname}{Assignments}
// \appendix

= Programming Assignments <chap:pa>

== PA1 <sec:pa1>

In this PA you will implement NNV using symbolic execution (SE) as described in @sec:se-smt. You can consider neural networks as a specific type of programs and thus can "execute" it. SE runs the network on symbolic inputs and returns symbolic outputs, i.e., a constraint representation. You will represent the symbolic outputs as a logical formula and use a constraint solver to check _assertions_, i.e., properties about the network. This PA has two parts: (1) implement SE on a given a network, and (2) evaluate the scalability of your SE on various networks.

You will use Python and the Z3 SMT solver (@sec:z3) for this assignment. *Do not* use external libraries or any extra tools. *Do not* use AI tools (e.g., ChatGPT, GitHub Copilot, etc.) to generate code for this assignment, the purpose of this PA is for you to understand and implement symbolic execution yourself.

Finally, you will need to answer some questions about your implementation and findings in the provided `README` template. #link("https://github.com/dynaroars/book_nnv/blob/main/pa/templates/README_PA1.md")

=== Part 1: Symbolic Execution

Consider the following fully-connected network with 2 inputs, 2 hidden layers, and 2 outputs.

#figure(image("figure/dnn1.png", width: 80%))

#enum(
  [*DNN Encoding*: We can encode this DNN using Python:

  ```python
  # (weights, bias, use activation function relu or not)
  n00 = ([1.0, -1.0], 0.0, True)
  n01 = ([1.0, 1.0], 0.0, True)
  hidden_layer0 = [n00, n01]

  n10 = ([0.5, -0.2], 0.0, True)
  n11 = ([-0.5, 0.1], 0.0, True)
  hidden_layer1 = [n10, n11]

  # don't use relu for outputs
  o0 = ([1.0, -1.0], 0.0, False)
  o1 = ([-1.0, 1.0], 0.0, False)
  output_layer = [o0, o1]

  dnn = [hidden_layer0, hidden_layer1, output_layer]
  ```

  In this network, the outputs of the neurons in the hidden layers (prefixed with `n`) are applied with the ReLU activation function, but the outputs of the network (prefixed with `o`) are not. These settings are controlled by the `True`, `False` parameters as shown above. Also, this example does not use `bias`, i.e., bias values are all 0.0's as shown.

  Note that all of these settings are parameterized and I deliberately use this example to show how these parameters are used (e.g., ReLU only applies to hidden neurons, but not outputs).
  ],

  [*Symbolic States*: After performing symbolic execution on the network, we obtain _symbolic states_, represented by a logical formula relating input and output variables.

  ```python
  # my_symbolic_execution is something you implement,
  # it returns a single (but large) formula representing the symbolic states.
  symbolic_states = my_symbolic_execution(dnn)
  ...
  "done, obtained symbolic states for DNN in 0.1s"
  assert z3.is_expr(symbolic_states)  # symbolic_states is a Z3 expression

  # your symbolic states should look something like this
  print(symbolic_states)
  # And(n0_0 == If(i0 + -1*i1 <= 0, 0, i0 + -1*i1),
  #     n0_1 == If(i0 + i1 <= 0, 0, i0 + i1),
  #     n1_0 ==
  #     If(1/2*n0_0 + -1/5*n0_1 <= 0, 0, 1/2*n0_0 + -1/5*n0_1),
  #     n1_1 ==
  #     If(-1/2*n0_0 + 1/10*n0_1 <= 0, 0, -1/2*n0_0 + 1/10*n0_1),
  #     o0 == n1_0 + -1*n1_1,
  #     o1 == -1*n1_0 + n1_1)
  ```
  ],

  [*Constraint Solving*: We will use Z3 to query various things about this network from the obtained symbolic states. Examples include:

  #enum(numbering: "(a)")[
    Generating random inputs and obtain outputs. Note that these are random values (that satisfy the symbolic states), so your results might look different.

    ```python
    z3.solve(symbolic_states)
    [n0_1 = 15/2,
        o1 = 1/2,
        o0 = -1/2,
        i1 = 7/2,
        n1_1 = 1/2,
        n1_0 = 0,
        i0 = 4,
        n0_0 = 1/2]
    ```
  ][
    Simulating a concrete execution.

    ```python
    i0, i1, n0_0, n0_1, o0, o1 = z3.Reals("i0 i1 n0_0 n0_1 o0 o1")

    # finding outputs when inputs are fixed [i0 == 1, i1 == -1]
    g = z3.And([i0 == 1.0, i1 == -1.0])
    z3.solve(z3.And(symbolic_states, g))  # you should get o0, o1 = 1, -1
    [n0_1 = 0,
    o1 = -1,
    o0 = 1,
    i1 = -1,
    n1_1 = 0,
    n1_0 = 1,
    i0 = 1,
    n0_0 = 2]
    ```
  ][
    Checking assertions, i.e., verifying/proving properties about the network or disproving/finding counterexamples.

    ```python
    print("Prove that if (n0_0 > 0.0 and n0_1 <= 0.0) then o0 > o1")
    g = z3.Implies(z3.And([n0_0 > 0.0, n0_1 <= 0.0]), o0 > o1)
    print(g)  #  Implies(And(n0_0 > 0, n0_1 <= 0), o0 > o1)
    z3.prove(z3.Implies(symbolic_states, g))  # proved

    print("Prove that when (i0 - i1 > 0 and i0 + i1 <= 0), then o0 > o1")
    g = z3.Implies(z3.And([i0 - i1 > 0.0, i0 + i1 <= 0.0]), o0 > o1)
    print(g)  # Implies(And(i0 - i1 > 0, i0 + i1 <= 0), o0 > o1)
    z3.prove(z3.Implies(symbolic_states, g))
    # proved

    print("Disprove that when i0 - i1 > 0, then o0 > o1")
    g = z3.Implies(i0 - i1 > 0.0, o0 > o1)
    z3.prove(z3.Implies(symbolic_states, g))
    # counterexample (you might get different counterexamples)
    # [n0_1 = 15/2,
    # i1 = 7/2,
    # o0 = -1/2,
    # o1 = 1/2,
    # n1_0 = 0,
    # i0 = 4,
    # n1_1 = 1/2,
    # n0_0 = 1/2]
    ```
  ]
  ],
)

=== Tips

+ You should apply symbolic execution on this example *by hand* first before attempting any coding. This example is small enough that you can work out step by step. For example, you can do these steps:
  + First, obtain the symbolic states by hand (e.g., on paper) for the given network.
  + Then, put what you have in code but also for the given network. Use Z3 format (e.g., declare the inputs as symbolic values `i0 = z3.Real("i0")`, then compute the neurons and outputs, etc.).
  + Finally, convert what you have into a general program that would work for any network input.

+ You can use the method below to construct a Z3 formula for ReLU:

  ```python
  @classmethod
  def relu(cls, v):
      return z3.If(0.0 >= v, 0.0, v)
  ```

+ Two ways of doing symbolic execution to obtain symbolic states:
  + You can follow the traditional SE method which produces symbolic execution trees in which each condition representing ReLU forks into two paths. You can decide whether to do a depth-first or breadth-first search (they will have the same results). At the end, the symbolic states are a disjunction of the path conditions (i.e., `z3.And[path_conds]`).
  + But since we are using Z3, a much simpler way is to encode all those forked paths directly as a formula. For example:

    ```python
    if (x + y > 0):
        r = 3
    else:
        r = 4
    ```

    Using traditional SE, you would have 2 paths: path 1: `x+y > 0 && r = 3` and path 2: `x+y <= 0 && r == 4`, from which you take the disjunction to get `(x+y > 0 && r == 3) || (x+y <= 0 && r == 4)`. But for this assignment, instead of forking into two paths, you can use Z3 to encode both branches using the `If` function, e.g., `If(x+y>0, r==3, r==4)` or `r==If(x+y>0,3,4)`. The results of these two methods are exactly the same; the latter requires less work. It is up to you.

+ When `bias` is non-zero, it will simply be added to the neuron computation, i.e., `neuron = relu(sum(value_i * weight_i) + bias)`. For example, if `bias` is `0.123` then for neuron `n0_0` we would obtain `n0_0 == If(i0 + -1*i1 + 0.123 <= 0, 0, i0 + -1*i1 + 0.123)`.

=== Part 2: Evaluation

In this part you will show that symbolic execution _does not_ scale on large networks.

+ You will create a function `create_random` that takes as input a list of positive integers representing the shape of the network `[#inputs, #neurons, ..., #outputs]`, and creates a neural network of that size with _random_ weights and biases (e.g., between $-5$ and $5$).
+ You will run symbolic execution on this network as you did in Part 1, get its results, and time the solving process.
+ You will do this for various sizes of networks *until your computer cannot handle it anymore* (e.g., until it takes more than a minute or two).
+ You will *save these networks* because you will reuse them to measure and compare execution time using abstraction in Part 2.
+ Finally, you will plot the results: the $x$-axis will show the size of the networks (for simplicity, the product of all numbers in the input list) and the $y$-axis shows the time.

Feel free to be creative in this process (e.g., play around with different sizes/layers), and discuss your findings in the `README` file. Below gives some code example:

```python
# Create a random network from a given
# number of inputs, hidden neurons, and outputs
l = [2, 3, 4, 3, 3]  # 2 inputs, 3 hidden layers (with 3, 4, 3 hidden neurons
                      # for respective hidden layer 1, 2, 3), and 3 outputs.
dnn = create_random_nn(l)

symbolic_state = my_symbolic_execution(dnn)

# time the execution
import time
st = time.time()
_ = z3.solve(symbolic_state)
print('time to solve: ', time.time() - st)
```

=== Conventions and Requirements

Your program must have the following:

*Part 1*

+ A function `my_symbolic_execution(dnn)` that:
  - takes as input the network, whose specifications are given as example above.
    - *Do NOT hard-code* the network in your program (e.g., do not hardcode the example given above in your code or hard-code the weight values). This function should work with any network input.
  - returns _symbolic states_ of the network represented as a Z3 expression (a formula) as shown above.
+ In your resulting formula, you must name:
  - the $n$th input as $i_n$ (e.g., the first input is $i_0$)
  - the $n$th output as $o_n$ (e.g., the second output is $o_1$)
  - the $j$th neuron at the $i$th layer as $n_{i\_j}$ (note that the first layer is the $0$th layer)
+ A testing function `test()` where you copy and paste pretty much the complete examples given above to demonstrate that your SE works for the given example. In summary, your `test` will include:
  - the specification of the 2×2×2×2 network in the Figure
  - run the symbolic execution on the network (as shown above, it should output the dimension of the network and runtime)
  - output the symbolic states results
  - apply Z3 to the symbolic states to obtain:
    - random inputs and associated outputs
    - simulate concrete execution
    - checking the 3 assertions as shown
+ Another testing function `test2()` where you create another network:
  - The network will have:
    - the same number of 2 inputs and 2 outputs, but 3 hidden layers where each layer has 4 neurons, i.e., a 2×4×4×4×2 network.
    - non-zero bias values.
  - Then on this network, do every single task you did in `test()` (run SE on it, output results, apply Z3, etc.). You will need to have 2 assertions that are true and 1 assertion that is false (just like above).
    - Initially you might randomly generate weights and bias values, but you will likely need to manually adjust them so that you can prove some correct assertions (randomly generated values probably will not give you a meaningful network with any asserted properties).

You can be as creative as you want, but your SE must not run for too long and must not take up too much space (e.g., do not generate over 50MB of files). Use the `README` to tell me exactly how to compile/run your program, e.g., `python3 se.py`.

*Part 2*

+ A function `create_random(sizes: int)` that:
  - takes as input the list `sizes` and returns a network of that size as described above.
+ A testing function `test3()` that runs `create_random` on various sizes of networks, runs `my_symbolic_execution` on them as you did with `test()` and `test2()` above, and times the execution.
+ A plot (in pdf, png, or jpeg) showing the scalability of `my_symbolic_execution` on various networks. You need to use *at least 25 networks of different sizes* to generate the plot. Use incrementally sized networks (e.g., gradually increasing the number of neurons/layers) or a good random distribution of sizes. A plot with very few datapoints will not be sufficient to show the scalability trend.

=== What to Turn In

You must submit a *zip file* containing the following files. Use the following names:

+ The zip file must be named `pa1-[yourname].zip`.
+ One single main source file `se.py`. Indicate in the `README` file how I can run it.
  - Your file should include at least a `my_symbolic_execution` function and the test functions `test()`, `test2()`, and `test3()` as indicated above.
+ The completed `README.md` file. You _must_ use the provided template and answer all questions in it.
+ Nothing else; do not include any binary files or other directories like `__pycache__`, `.venv`.

=== Grading Rubric (out of 30 points)

- 12 points --- for complete SE implementation.
  - 4 points for `my_symbolic_execution`
  - 2 points for `test`
  - 2 points for `test2`
  - 4 points for `create_random` and `test3`
- 2 points --- for code quality and submission format.
- 16 points --- for completing the `README` file.
  - 4 points for Part 1
  - 10 points for Part 2 (plot and discussion)
  - 2 points for the running instructions and screenshots

== PA2 <sec:pa2>

In this PA you will implement neural network (NN) verification using (1) _interval abstraction_ as described in @sec:interval-abstraction and (2) _zonotope abstraction_ as described in @sec:zonotope-abstraction.
While symbolic execution (PA1 @sec:pa1) computes exact symbolic representations, abstract interpretation uses over-approximations to make verification more scalable at the cost of some precision. You will implement interval and zonotope abstract transformers and compare their precision-scalability trade-offs with symbolic execution.

You will use Python and PyTorch for this assignment. *Do not* use external verification libraries (other than standard numerical libraries like `torch`, `numpy`).

This PA has three main parts:

+ implement interval abstraction for linear layers and ReLU activations.
+ implement zonotope abstraction for linear layers and ReLU activations.
+ evaluate the precision/scalability compared to symbolic execution from PA1.

A README template is provided. Please answer the questions in the template and include it in your submission. #link("https://github.com/dynaroars/book_nnv/blob/main/pa/templates/README_PA2.md")

=== Interval Abstraction

Interval abstraction is the simplest form of abstract interpretation for neural networks. Each variable is represented by an interval $[l, u]$ indicating its lower and upper bounds.

==== Part 1: Interval for Linear Layers

Linear transformations on intervals can be computed exactly using interval arithmetic.

```python
class LinearTransformer:
    def __init__(self, W, b):
        # TODO: store weight matrix and bias vector

    def forward(self, input_lower, input_upper):
        """
        Apply affine transformation f(x) = Wx + b to intervals [l, u]

        Mathematical formulation:
        - W+: positive part of weights
        - W-: negative part of weights
        - output_lower = W+ @ input_lower + W- @ input_upper + bias
        - output_upper = W+ @ input_upper + W- @ input_lower + bias

        Args:
            input_lower: lower bounds of input intervals
            input_upper: upper bounds of input intervals

        Returns:
            (output_lower, output_upper): transformed interval bounds
        """
        # TODO:
        # 1. Split weights into positive and negative parts
        # 2. Compute output bounds using interval arithmetic
        # 3. Add bias to both bounds
        # 4. Return (output_lower, output_upper)

        return output_lower, output_upper
```

==== Part 2: Interval for ReLU Activations

ReLU transformation on intervals is straightforward: clamp lower bounds to 0.

```python
class ReluTransformer:

    def forward(self, input_lower, input_upper):
        """
        Apply ReLU transformation to intervals: ReLU(x) = max(0, x)
        Args:
            input_lower: lower bounds of input intervals
            input_upper: upper bounds of input intervals

        Returns:
            (output_lower, output_upper): intervals after ReLU
        """
        # TODO: For each dimension:
        # 1. Clamp lower bounds to be >= 0
        # 2. Clamp upper bounds to be >= 0
        # 3. Return transformed bounds

        return output_lower, output_upper
```

==== Part 3: Putting It All Together

```python
class IntervalAbstraction:

    def __init__(self, DNN):
        # TODO: convert DNN to corresponding interval abstraction transformers
        self.transformers = ...

    def forward(self, lb, ub):
        # propagate through layers
        for transformer in self.transformers:
            lb, ub = ...

        return (lb, ub)
```

==== Part 4: Test Your Implementation

In this DNN, the outputs of the neurons in the hidden layers (prefixed with `n`) are applied with the `relu` activation function, but the outputs of the DNN (prefixed with `o`) are not. These settings are controlled by the `True`, `False` parameters. Also, this example does not use `bias`, i.e., bias values are all 0.0's as shown.

```python
# DNN specification
n00 = ([1.0, 1.0], 2.0, True)
n01 = ([1.0, -1.0], 2.0, True)
hidden_layer0 = [n00, n01]

n10 = ([1.0, 1.0], -0.5, True)
n11 = ([1.0, -1.0], -1.0, True)
hidden_layer1 = [n10, n11]

n20 = ([-1.0, 1.0], 7.0, False)
n21 = ([0.0, 1.0], 0.0, False)
hidden_layer2 = [n20, n21]

o0 = ([1.0, -1.0], 0.0, False)
output_layer = [o0]

dnn = [hidden_layer0, hidden_layer1, hidden_layer2, output_layer]
```

Note that all of these settings are parameterized and I deliberately use this example to show how these parameters are used (e.g., `relu` only applies to hidden neurons, but not outputs).

```python
net = IntervalAbstraction(dnn)
input_lower = torch.tensor([-1, -1], dtype=torch.float)
input_upper = torch.tensor([1, 3], dtype=torch.float)
output_lower, output_upper = net(input_lower, input_upper)
print(f'{output_lower=}')
print(f'{output_upper=}')
# output_lower=tensor([-7.5000])
# output_upper=tensor([12.])
```

=== Zonotope Abstraction

==== Part 1: Zonotope Representation

*From Bounds to Zonotope*

A zonotope is represented by a tuple of a center vector and a generator matrix. Given the bounds of a zonotope, we can convert it to a zonotope.

```python
def zonotope(lb, ub):
    """
    Computes zonotope from interval bounds [l, u].
    TODO:
    - compute center from bounds
    - generator from bounds
    """
    return center, generator
```

*From Zonotope to Bounds*

Given the center and generators of a zonotope, we can concretize the bounds of the zonotope.

```python
def concrete(center, generator):
    """
    Computes interval bounds [l, u] from zonotope (center, generator).

    A zonotope Z = {c + sum_i eps_i * g_i | eps_i in [-1,1]} can be
    converted to interval bounds:
      Lower bound: l = c - sum_i |g_i|  (eps_i = -sign(g_i))
      Upper bound: u = c + sum_i |g_i|  (eps_i = +sign(g_i))

    Args:
        center: Center vector c of the zonotope
        generator: Generator matrix G

    Returns:
        (lb, ub): Interval bounds for each dimension
    """
    # TODO: compute interval bounds from zonotope
    # 1. compute lower bound
    # 2. compute upper bound
    return lb, ub
```

==== Part 2: Zonotope for Linear Layers

Linear (affine) transformations can be handled exactly in zonotope abstraction.

```python
class LinearTransformer(nn.Module):
    def __init__(self, W, b):
        # TODO: store weights and bias

    def forward(self, center, generator):
        """
        Apply affine transformation f(x) = Wx + b to zonotope Z = (c, G)
        Result: f^a(Z) = (Wc + b, WG)

        Args:
            center: center vector c of input zonotope
            generator: generator matrix G of input zonotope

        Returns:
            (new_center, new_generator): transformed zonotope
        """
        # TODO:
        # 1. Transform center using weight matrix and bias
        # 2. Transform generator matrix using weight matrix
        # 3. Return transformed (center, generator)

        return new_center, new_generator
```

==== Part 3: Zonotope for ReLU Activations

ReLU activations are non-linear and require over-approximation in zonotope abstraction. For each neuron with bounds $[l, u]$, there are three cases to handle.

```python
class ReluTransformer(nn.Module):

    def forward(self, center, generator):
        """
        Apply ReLU abstraction to zonotope: ReLU(x) = max(0, x)

        Three cases for each neuron i with bounds [l_i, u_i]:
        1. Active case (l_i >= 0): ReLU is identity, Z' = Z
        2. Inactive case (u_i <= 0): ReLU outputs 0, Z' = {0}
        3. Unstable case (l_i < 0 < u_i): requires over-approximation

        Args:
            center: center vector of input zonotope
            generator: generator matrix of input zonotope

        Returns:
            (new_center, new_generator): over-approximated zonotope after ReLU
        """
        # TODO:
        # 1. Compute current bounds using concrete(center, generator)
        # 2. Create new generator matrix with extra row for ReLU error
        # 3. For each neuron, handle based on bounds [l, u]:
        #    - Active (l >= 0): keep unchanged
        #    - Inactive (u <= 0): set to zero
        #    - Unstable (l < 0 < u): apply slope approximation
        # 4. Return transformed (center, generator)

        return new_center, new_generator
```

==== Part 4: Putting It All Together

```python
class ZonotopeAbstraction(nn.Module):

    def __init__(self, DNN):
        # TODO: convert DNN to corresponding zonotope abstraction transformers
        self.transformers = ...

    def forward(self, lb, ub):
        # 1. convert bounds to zonotope
        center, generator = ...
        # 2. propagate zonotope through layers
        for transformer in self.transformers:
            center, generator = ...

        # 3. convert zonotope to bounds
        lb, ub = ...
        return (lb, ub)
```

==== Part 5: Test Your Implementation

```python
net = ZonotopeAbstraction(dnn)  # same DNN specification as interval
input_lower = torch.tensor([-1, -1], dtype=torch.float)
input_upper = torch.tensor([1, 3], dtype=torch.float)
output_lower, output_upper = net(input_lower, input_upper)
print(f'{output_lower=}')
print(f'{output_upper=}')
# output_lower=tensor([0.1667])
# output_upper=tensor([6.1667])
```

=== Evaluation

- Make sure you use the same set of DNNs for the evaluation of both abstraction methods and the symbolic execution for fair comparison.
- Same requirement as PA1: use at least 25 DNNs of varying sizes (number of layers, number of neurons per layer, etc.) in your evaluation.
- A good proxy of precision is the width of the output bounds (i.e., upper $-$ lower), but you can be creative with other metrics as well.
- All text in your plots must be legible.
- If the DNNs you use are too small or too few to show the trend, you will receive a low score.
- Answer the questions in the README template.

=== What to Turn In

You must submit a *zip file* containing the following files. Use the following names:

+ The zip file must be named `pa2-[yourname/groupname].zip` (1 submission per group).
+ One single main source file `pa2.py`. Indicate in the `README` file how I can run it.
  - Your code should use the provided class/function signatures as indicated above. E.g., `LinearTransformer`, `ReluTransformer`, `IntervalAbstraction`, `ZonotopeAbstraction`, `zonotope`, `concrete`.
+ If you imported anything from your previous PAs, please include those files as well (e.g., `p1.py`). We will not run your code if they are missing and you will lose points.
+ A completed `README.md` file. You _must_ use the provided template and answer all questions in it.
+ Nothing else; do not include any binary files or other directories like `__pycache__`, `.venv`.

=== Grading Rubric (out of 30 points)

- 12 points --- for complete interval and zonotope abstraction implementation.
  - 2 points for `LinearTransformer` for Interval Abstraction
  - 2 points for `ReluTransformer` for Interval Abstraction
  - 2 points for zonotope representation functions (`zonotope` and `concrete`)
  - 3 points for `LinearTransformer` for Zonotope Abstraction
  - 3 points for `ReluTransformer` for Zonotope Abstraction
- 16 points --- for completed README with evaluation and analysis.
- 2 points --- for code quality and submission format.

== PA3 <sec:pa3>

In this PA you will implement the branch and bound (BaB) algorithm as described in @sec:bab-alg with abstract interpretation from PA2 @sec:pa2 (using either interval @sec:interval-abstraction or zonotope @sec:zonotope-abstraction).

While symbolic execution (PA1 @sec:pa1) provides exact analysis but does not scale, and abstract interpretation (PA2 @sec:pa2) scales well but may lose precision, Branch and Bound provides a framework that can _refine_ abstract domains when needed, achieving a balance between precision and scalability.

You will use Python and PyTorch for this assignment, building upon your implementations from PA2. *Do not* use external verification libraries.

This PA has three main parts:

+ implement the core BaB algorithm with a priority _queue_-based approach.
+ implement utility functions: `deduce`, `decide`, `bound`, and `prune`.
+ evaluate the precision and scalability of BaB compared to pure abstract interpretation and symbolic execution.

A README template is provided. Please answer the questions in the template and include it in your submission. #link("https://github.com/dynaroars/book_nnv/blob/main/pa/templates/README_PA3.md")

=== Part 1: Branch and Bound Algorithm Framework

BaB systematically explores the space by maintaining a queue of subproblems and iteratively refining them until verification is complete or a counterexample is found. You will implement four core utility functions that form the building blocks of the BaB algorithm: `deduce`, `decide`, `bound`, and `prune`.

==== Algorithm Skeleton

```python
class BranchAndBound:
    def __init__(self, network, abstraction_type):
        """
        Initialize BaB verifier
        Args:
            network: DNN to verify (same format as PA2)
            abstraction_type: Interval or Zonotope from PA2
        """
        # TODO: Initialize your abstraction from PA2
        self.abstraction = ...
        self.network = network

    def verify(self, input_lower, input_upper, property_fn, timeout=60):
        """
        Main BaB verification algorithm following Algorithm 1 from the book

        Args:
            input_lower: lower bounds of input domain
            input_upper: upper bounds of input domain
            property_fn: function that takes (output_lower, output_upper)
                         and returns VERIFIED, FALSIFIED, or UNKNOWN
            timeout: maximum time in seconds

        Returns:
            result: VERIFIED, FALSIFIED, or TIMEOUT
            counterexample: input that violates property (if FALSIFIED)
        """
        start_time = time.time()

        # Initialize verification problems (Line 5 in Algorithm 1)
        problems = Queue()
        initial_problem = (input_lower, input_upper)
        problems.put(initial_problem)

        # Main loop
        while not problems.empty():
            if time.time() - start_time > timeout:
                return TIMEOUT, None

            # Select a subproblem
            lb, ub = ...  # Hint: use problems.get()

            # TODO: Use self.deduce() to determine if the problem is feasible
            if self.deduce(lb, ub, property_fn):
                # Check satisfiability using adversarial attack
                cex = ...  # Hint: use self.attack()

                if cex is not None:  # Found valid counterexample
                    return FALSIFIED, cex

                # Decide: pick an input dimension to split on
                subproblems = ...  # Hint: use self.decide()

                # Add new subproblems to queue
                for sub_lb, sub_ub in subproblems:
                    ...  # Hint: use problems.put()

        # All subproblems are verified
        return VERIFIED, None
```

==== Deduce Function

The `deduce` function checks if the current problem is feasible by combining the abstract interpretation (bound).

```python
def deduce(self, input_lower, input_upper, property_fn):
    """
    Deduce: combine bound + prune to check if we can make progress

    Args:
        input_lower: lower bounds of input domain
        input_upper: upper bounds of input domain
        property_fn: property function to check

    Returns:
        bool: False if verified, True otherwise (need to branch)
    """
    # TODO:
    # 1. Compute abstract bounds using self.bound() (PA2)
    # 2. Check pruning using self.prune()
    # 3. Return True if prune_result == UNKNOWN (need to branch)
    # 4. Return False if prune_result == VERIFIED (can prune)
    # 5. This function should NOT handle FALSIFIED case directly

    return prune_result == UNKNOWN
```

==== Attack Function

The `attack` function finds a counterexample using an adversarial attack. You can use a simpler approach like random sampling, or a more advanced approach like PGD, FGSM, etc.

```python
def attack(self, input_lower, input_upper, property_fn):
    """
    Find counterexample using adversarial attack

    Uses random sampling or adversarial attacks instead of LP solving

    Args:
        input_lower: lower bounds of input domain
        input_upper: upper bounds of input domain
        property_fn: property function to check

    Returns:
        counterexample: cex that violates property, or None if not found

    Example approaches:
        # Random sampling
        for _ in range(100):
            random_input = ...
            output = self.network(random_input)
            if violates_property(output):
                return random_input

        # Or use PGD attack, FGSM, etc.
    """
    # TODO: Implement adversarial attack to find counterexample
    # 1. Generate candidate inputs within [input_lower, input_upper]
    # 2. Run network on candidates
    # 3. Check if any output violates the property
    # 4. Return first violating input, or None if none found

    return counterexample
```

==== Branch (Decide) Function

The `decide` function splits a domain into smaller subdomains. For this PA, we use input splitting where we divide one dimension at a time.

```python
def decide(self, input_lower, input_upper):
    """
    Split input domain into 2 subproblems by splitting one dimension

    Args:
        input_lower: lower bounds of input domain
        input_upper: upper bounds of input domain

    Returns:
        list of (sub_lower, sub_upper) tuples representing subproblems

    Example:
        # Input domain: [-1, 1] x [-2, 2]
        input_lower = torch.tensor([-1.0, -2.0])
        input_upper = torch.tensor([1.0, 2.0])

        # Splitting the 1st dimension at 0:
        # Subproblem 1: [-1, 0] x [-2, 2]
        # Subproblem 2:  [0, 1] x [-2, 2]

        subproblems = decide(input_lower, input_upper)
        # subproblems = [
        #     (torch.tensor([-1.0, -2.0]), torch.tensor([0.0, 2.0])),
        #     (torch.tensor([0.0, -2.0]), torch.tensor([1.0, 2.0]))
        # ]
    """
    # TODO:
    # 1. Find desired dimension to split on
    #       (e.g., first dimension, max width, random, etc.)
    # 2. Compute split point for that dimension
    #       (e.g., midpoint, random, etc.)
    # 3. Create two subproblems by splitting at the computed point
    # 4. Return list of subproblems

    return subproblems
```

==== Bound Function

The `bound` function computes abstract output bounds using your abstraction from PA2 (@sec:pa2).

```python
def bound(self, input_lower, input_upper):
    """
    Compute output bounds using abstract interpretation

    Args:
        input_lower: lower bounds of input domain
        input_upper: upper bounds of input domain

    Returns:
        (output_lower, output_upper): abstract bounds on network outputs

    Example:
        input_lower = torch.tensor([-1.0, -2.0])
        input_upper = torch.tensor([1.0, 2.0])

        output_lower, output_upper = bound(input_lower, input_upper)
        # output_lower = tensor([-10.0])
        # output_upper = tensor([10.0])
    """
    # TODO: Use your abstraction from PA2 (interval or zonotope)
    # to compute output bounds

    return output_lower, output_upper
```

==== Prune Function

The `prune` function determines whether a subproblem can be eliminated based on the property being verified.

```python
def prune(self, output_lower, output_upper, property_fn):
    """
    Determine if subproblem can be pruned based on abstract bounds

    Args:
        output_lower: lower bounds on network outputs
        output_upper: upper bounds on network outputs
        property_fn: function that checks if bounds satisfy property

    Returns:
        VERIFIED: property holds for all points in this subproblem
        FALSIFIED: property violated for all points in this subproblem
        UNKNOWN: cannot determine, need to branch further

    Example:
        def safety_property(out_lb, out_ub, threshold):
            if torch.all(out_ub < threshold):
                return VERIFIED
            elif torch.all(out_lb >= threshold):
                return FALSIFIED
            else:
                return UNKNOWN

        prop_1 = lambda out_lb, out_ub: safety_property(out_lb, out_ub, 5)

        # Example 1: Can be pruned as VERIFIED
        output_lower = torch.tensor([-10.0])
        output_upper = torch.tensor([3.0])  # All outputs < 5
        result = prune(output_lower, output_upper, prop_1)
        # result = VERIFIED -> prune this subproblem

        # Example 2: Cannot be pruned
        output_lower = torch.tensor([-2.0])
        output_upper = torch.tensor([8.0])  # Outputs span threshold
        result = prune(output_lower, output_upper, prop_1)
        # result = UNKNOWN -> need to branch further
    """
    # TODO:
    # 1. Check if property_fn gives definitive answer
    # 2. Return appropriate result based on property satisfaction

    return result
```

=== Part 2: Evaluation

- Make sure you use the same set of DNNs and properties for the evaluation of all methods for fair comparison.
- Use at least 30 diverse DNN and property pairs in your evaluation.
- All text in your plots must be legible.
- If the DNNs you use are too small or too few to show the trend, you will receive a low score.
- Answer the questions in the README template.

==== Test Your Implementation

This function is used to test whether your BaB implementation is correct. Make sure there is _at least one perturbed dimension_, e.g., `input_lower` should not equal `input_upper`, or otherwise the input space is just a single point and no need to use abstraction.

```python
def test_bab():
    """Test BaB on a DNN"""
    dnn = ...

    # Test with interval abstraction
    bab = BranchAndBound(dnn, 'interval')

    # Input domain
    input_lower = ...
    input_upper = ...

    # Property:
    property_fn = ...

    result, counterexample, stats = bab.verify(
        input_lower, input_upper, property_fn, timeout=30
    )

    print(f"Result: {result}")
```

==== Analysis

Create two additional test functions:

+ `bab_vs_z3`: Compare BaB with Z3 on a local robustness property.
+ `bab_vs_abstraction`: Compare BaB with pure abstraction from PA2.

Note that `property_fn` can be an arbitrary function; make up your own property function (e.g., $y_0 > 0$ or $y_0 > y_1$, etc.), just make sure to use the _same property function_ for different methods so that the comparison is fair.

For each testcase, you should:

+ Create networks of varying sizes.
+ Use BaB with different configurations (e.g., abstraction types, branching strategies, etc.).
+ For each network, measure:
  - Symbolic execution time/result (PA1 @sec:pa1)
  - Pure abstraction time/result (PA2 @sec:pa2)
  - BaB verification time/result
  - Use appropriate timeouts (e.g., 30s)
+ Plot results showing precision vs. scalability trade-offs.
+ Analyze when BaB is most beneficial.

=== What to Turn In

You must submit a *zip file* containing the following files. Use the following names:

+ The zip file must be named `pa3-[yourname/groupname].zip` (1 submission per group).
+ One single main source file `pa3.py`. Indicate in the `README` file how I can run it.
  - Your code should use the provided class/function signatures as indicated above. E.g., `BranchAndBound`, `deduce`, `decide`, `bound`, `prune`.
+ If you imported anything from your previous PAs, please include those files as well (e.g., `p1.py`). We will not run your code if they are missing and you will lose points.
+ A completed `README.md` file. You _must_ use the provided template and answer all questions in it.
+ Nothing else; do not include any binary files or other directories like `__pycache__`, `.venv`.

=== Grading Rubric (out of 30 points)

- 12 points --- Core BaB implementation.
  - 3 points for correct `verify` algorithm implementation
  - 3 points for `branch` function with proper input splitting
  - 3 points for `bound` function integration with PA2 abstractions
  - 3 points for `prune` function with correct pruning logic
- 16 points --- for completed README with evaluation and analysis.
- 2 points --- for code quality and submission format.

== PA4 <sec:pa4>

In this PA, you will use your existing implementations from previous PAs to verify properties of a real benchmark using the standard format (ONNX for networks, and VNNLIB for properties).

=== Part 1: Handling ONNX Networks

In order to handle ONNX networks, the simplest way is to use the ONNX library to load the network and convert it to a PyTorch model. You can install the conversion library `onnx2pytorch` using pip:

```sh
pip install onnx2pytorch
```

Then you can use the library to load the network and convert to a PyTorch model as follows:

```python
import onnx
import onnx2pytorch

# load the ONNX network
model = onnx.load("path/to/your/network.onnx")

# convert to Pytorch model
# experimental=True is optional to use batch processing
model = onnx2pytorch.convert(model, experimental=True)

# since ACAS XU benchmarks contain simple feed-forward networks,
# we can simply enumerate each layer of a network
for layer_name, layer in enumerate(layers):
    if isinstance(layer, nn.Linear):
        # TODO handle linear layer
        pass
    elif isinstance(layer, nn.ReLU):
        # TODO handle ReLU layer
        pass
    elif isinstance(layer, sub):
        # handle subtraction layer
        continue  # this layer is y = x - 0, which is identity, so skip it
    else:
        # TODO handle other layers
        pass
```

=== Part 2: Handling VNNLIB Properties

==== Parsing VNNLIB Properties

VNNLIB properties are designed to represent properties of neural networks in a formal language. It specifies the precondition and postcondition of the network. To extract the preconditions and postconditions from a VNNLIB property, you can follow the provided code at #link("https://github.com/dynaroars/book_nnv/blob/main/code/pa4/test.py"):

```python
# input shape is (1, 5) for ACAS XU benchmarks
input_shape = (1, 5)

# parse the VNNLIB property
properties = parse_vnnlib("path/to/your/property.vnnlib", input_shape)
```

==== VNNLIB Disjunctive Properties

Note that one VNNLIB file can contain disjunctive properties. Let's take a look at an example VNNLIB property 7 of ACAS XU benchmarks:

```
; ACAS Xu property 7

(declare-const X_0 Real)
(declare-const X_1 Real)
(declare-const X_2 Real)
(declare-const X_3 Real)
(declare-const X_4 Real)

(declare-const Y_0 Real)
(declare-const Y_1 Real)
(declare-const Y_2 Real)
(declare-const Y_3 Real)
(declare-const Y_4 Real)

; Unscaled Input 0: (0, 60760)
(assert (<= X_0 0.679857769))
(assert (>= X_0 -0.328422877))

; Unscaled Input 1: (-3.141592, 3.141592)
(assert (<= X_1 0.499999896))
(assert (>= X_1 -0.499999896))

; Unscaled Input 2: (-3.141592, 3.141592)
(assert (<= X_2 0.499999896))
(assert (>= X_2 -0.499999896))

; Unscaled Input 3: (100, 1200)
(assert (<= X_3 0.5))
(assert (>= X_3 -0.5))

; Unscaled Input 4: (0, 1200)
(assert (<= X_4 0.5))
(assert (>= X_4 -0.5))

; unsafe if strong left is minimal or strong right is minimal
(assert (or
    (and (<= Y_3 Y_0) (<= Y_3 Y_1) (<= Y_3 Y_2))
    (and (<= Y_4 Y_0) (<= Y_4 Y_1) (<= Y_4 Y_2))
))
```

This file specifies the properties in the form of $X and (P_0 or P_1)$, where $X$ is the precondition on input variables ($X_0$, $X_1$, $X_2$, $X_3$, $X_4$) and $P_0$ and $P_1$ are the postconditions in _negation form_ (do not negate them!) on output variables ($Y_0$, $Y_1$, $Y_2$, $Y_3$, $Y_4$).

Specifically,

$
X equiv (-0.328422877 <= X_0 <= 0.679857769) \
  and (-0.499999896 <= X_1 <= 0.499999896) \
  and (-0.499999896 <= X_2 <= 0.499999896) \
  and (-0.5 <= X_3 <= 0.5) \
  and (-0.5 <= X_4 <= 0.5)
$

$
P_0 equiv (Y_3 <= Y_0) and (Y_3 <= Y_1) and (Y_3 <= Y_2) \
P_1 equiv (Y_4 <= Y_0) and (Y_4 <= Y_1) and (Y_4 <= Y_2)
$

To deal with disjunctive postconditions ($P_0 or P_1$), the code from NeuralSAT simply converts $X and (P_0 or P_1)$ to a list of conjunctive sub-properties:

$
underbrace(X and P_0, "property 1") or underbrace(X and P_1, "property 2")
$

Now each sub-property has the same form as PA3. To verify a sub-property, you can use the code from PA3.

==== Output Constraints in VNNLIB

VNNLIB always represents the output constraints in the form of $c s dot Y <= "rhs"$ where $Y$ is the output vector.

For example, $Y_3 <= Y_0$ is equivalent to $-Y_0 + Y_3 <= 0$, which is represented as:

$
underbrace(mat(-1, 0, 0, 1, 0), c s) dot underbrace(mat(Y_0; Y_1; Y_2; Y_3; Y_4), Y) <= underbrace(mat(0), "rhs")
$

If you are using the VNNLIB extraction code from NeuralSAT, each sub-property is an object with the following attributes:

- `lower_bounds`: input lower bounds (e.g., lower bounds of all input variables)
- `upper_bounds`: input upper bounds (e.g., upper bounds of all input variables)
- `cs`: coefficient matrix for output constraints
- `rhs`: constant vector for output constraints

```python
# number in pop(), e.g., pop(1), means number of sub-properties
# we want to verify simultaneously, not the index of the sub-property
sub_property = properties.pop(1)  # get one sub-property

print(sub_property.lower_bounds)
# tensor([[-0.3284, -0.5000, -0.5000, -0.5000, -0.5000]])

print(sub_property.upper_bounds)
# tensor([[0.6799, 0.5000, 0.5000, 0.5000, 0.5000]])

print(sub_property.cs)
# tensor([[[-1.,  0.,  0.,  1.,  0.],   # Y_3 <= Y_0
#         [ 0., -1.,  0.,  1.,  0.],    # Y_3 <= Y_1
#         [ 0.,  0., -1.,  1.,  0.]]])  # Y_3 <= Y_2

print(sub_property.rhs)
# tensor([[0., 0., 0.]])
```

==== Verifying VNNLIB Properties

Remember that we have a list of disjunctive sub-properties (e.g., property 1 and property 2 for property 7). To verify the original property is UNSAT, we need to verify all sub-properties are UNSAT. But to show the original property is SAT, disproving one sub-property is enough. The high-level idea:

```python
while len(properties):  # make sure to verify all sub-properties
    sub_property = properties.pop(1)  # get one sub-property
    # disprove one sub-property, return counterexample immediately
    if verify(network, sub_property) == SAT:
        return SAT, cex

    # run out of time
    if verify(network, sub_property) == TIMEOUT:
        return TIMEOUT

    # prove one sub-property
    if verify(network, sub_property) == UNSAT:
        continue  # move to next sub-property

# all sub-properties are verified, the original property is UNSAT
return UNSAT
```

=== Part 3: Putting Everything Together

Now you have all the components to build the verifier. Follow the naming conventions below:

#enum(
  [A single Python file `verify.py` that accepts three command line arguments and runs the verification. This provides a unified interface for testing your implementation.

  ```sh
  python verify.py [path/to/network.onnx] [path/to/property.vnnlib] \
      [timeout_in_seconds]

  # E.g.
  python verify.py acasxu/Network1_1.onnx acasxu/Property7.vnnlib 116
  ```

  Your output should be either `UNSAT`, `SAT`, or `TIMEOUT`. If the output is `SAT`, you should also print the counterexample found.
  ],
  [Your actual implementation should be in `p4.py`.]
)

=== Part 4: Verifying ACAS XU Benchmarks

Download the ACAS XU benchmarks from #link("https://github.com/dynaroars/neuralbench/tree/main/instances/acasxu"). In this folder, you will find:

- Folder `onnx`: contains the ONNX networks.
- Folder `vnnlib`: contains the VNNLIB properties.
- File `instances.csv`: contains list of instances of the ACAS XU benchmarks, where each line is a tuple of (network path, property path, timeout in seconds).

You can use `acasxu_instances_w_ground_truth.csv` instead of `instances.csv` in the repo. It contains the same instances as `instances.csv`, but also includes the ground truth results for each instance. It is available from #link("https://github.com/dynaroars/book_nnv/blob/main/code/pa4/acasxu_instances_w_ground_truth.csv").

Your task is to:

+ Enumerate the first 90 instances in `instances.csv` and verify the properties; the rest are optional.
+ Report the result for each instance: either UNSAT, SAT, or TIMEOUT.
+ Some timeouts are expected; we do not expect your verifier to verify all instances.
+ Check the results with the ground truth at #link("https://github.com/dynaroars/book_nnv/blob/main/code/pa4/acasxu_instances_w_ground_truth.csv").

You should debug your implementation using a few instances first before running all 90, as the complete run may take a long time.

=== What to Turn In

You must submit a *zip file* containing the following files. Use the following names:

+ The zip file must be named `pa4-[yourname/groupname].zip` (1 submission per group).
+ If you imported anything from your previous PAs, please include those files as well (e.g., `p1.py`). We will not run your code if they are missing and you will lose points.
+ One `verify.py` file as described above.
+ A completed `README.md` file. You _must_ use the provided template and answer all questions in it.
+ It is recommended to include any logs or results your verifier generated in a separate folder. You can name the folder as you like, e.g., `results/`.
  - This is not mandatory, but it will show that you have done the experiments and help us grade your PA.
+ If you used any additional scripts/files to help with Part 4, include those as well and add instructions to the `README.md` file.
+ Nothing else; do not include any binary files or other directories like `__pycache__`, `.venv`.

=== Grading Rubric (out of 30 points)

- 20 points --- Verifier implementation.
  - 4 points --- for parsing ONNX networks correctly
  - 4 points --- for parsing VNNLIB properties correctly
  - 6 points --- for implementing the verifier (`verify.py`)
  - 6 points --- for running your verifier on ACAS XU benchmarks (first 90 instances)
- 10 points --- for completed README with analysis.

= Schedule <chap:schedule>

#tvn[DRAFT --- ported from `../nnv/book.tex` (Schedule chapter) on 2026-07-30; needs review.]

- Week 1 (1/20):
  - Introduction / Syllabus Overview
  - Formal Methods and Specifications Overview (@chap:formal-methods)
  - HW: Post a short introduction about yourself on Canvas

- Week 2 (2/3):
  - Topics: Background on Logic and Satisfiability @chap:logics
  - Quiz: @prob:remove_duplicates
  - HW: Using Z3 SMT Solver to check satisfiability.
    - Familiarize yourself with Z3 and install it on your machine (@sec:z3). Try a few examples as given in @ex:z3-propositional and @ex:z3-linear-constraints.
    - Do @prob:z3-0, @prob:z3-1, @prob:z3-2, @prob:z3-3

- Week 3 (2/10):
  - Backgrounds on Linear Programming (@chap:lp)
  - Topics: NNV and Properties and their formal representation (@chap:nn-basics and @chap:properties)
  - Short Videos
    - But what is a neural network? @3blue1brown2017neuralnetworks
  - Quiz: @problem:short-questions
  - HW: MILP problem @ex:milp-online

- Week 4 (2/17):
  - Topics: NN Properties @chap:properties
  - In class exercise: Using Z3 to check satisfiability of networks and properties @prob:z3-dnn
  - Quiz: @problem:milp-hand
  - HW: Neural Networks and Properties @problem:z3-properties

- Week 4 (2/24):
  - Topics: Neural Network Verification (NNV) (@sec:nnv-problem) and Symbolic Execution @sec:se-smt
  - In class exercise: @ex:dnn-b and @problem-z3-dnn
  - Quiz: @problem:drone
  - HW: @ex-negation-trick

- Programming Assignment 1 (PA1)
  - Topics: Symbolic Execution of Neural Networks @sec:pa1
  - Due date #alert[Monday March 17, 2026 11:59 PM]

- Week 5 (3/3):
  - Topics: MILP Encoding of NNVs (@sec:using-milp)
  - Quiz: @problem:mydnntwo. You don't need to do question 4 (Z3) for the quiz.
  - HW: Do @problem:relu-milp-bounds and @prob:milp-dnn

- Week 6 (3/17):
  - Topics: Abstraction (@chap:abstractions), Interval Abstraction (@sec:interval-abstraction)
  - Quiz: (Re)Do @ex:milp-dnn by hand
  - HW: No HW because we didn't get a chance to cover the material in class.

- Week 7 (3/24):
  - Topics: Abstraction (@chap:abstractions), Interval and Zonotope (@sec:interval-abstraction, @sec:zonotope-abstraction)
  - Quiz: No Quiz because no HW due this week.
  - HW: Do @prob:int-abs and @ex:zonotope_linear_example (this is a complete example so just rewrite it by hand and submit it as HW)

- Programming Assignment 2 (PA2)
  - Abstraction @sec:pa2
  - Due date #alert[Monday April 13, 2026 11:59 PM]

- Week 8 (3/31):
  - Topics: Branch and Bound (@chap:bab), Activation Pattern Search (@sec:activation-patterns)
  - Quiz: @prob:zonotope_linear_example_x4
  - HW: @problem:pattern-enumeration and @problem:nnv-pattern

- Week 9 (April 7):
  - Topics: Adversarial Attacks @chap:adversarial-attacks
  - Quiz: @problem:counting-patterns
  - HW: Do @prob:bab-detailed, @prob:compute-gradients, @prob:pgd-iterations (due date extended to Friday April 17, 2026 11:59pm)

- Programming Assignment 3 (PA3)
  - Branch and Bound @sec:pa3
  - Due date #alert[Friday May 1, 2026 11:59pm]

- Week 10 (April 14):
  - Topics: Branch and Bound (@chap:bab), Activation Pattern Search (@sec:activation-patterns)
  - Quiz: No quiz due to homework extension
  - HW: no new HW

- Week 11 (April 21):
  - Short Clip: #link("https://www.youtube.com/watch?v=YYgepDY3rHw")[Mathematical Proofs]
  - Topics: Proof Generation for NNV @chap:proof-gen-check, Engineering and Optimization Tricks @chap:common-engineering, #tool algorithm @chap:neuralsat
  - Quiz: @prob:pgd-iterations (part 2 only)
  - HW: Do @prob:proof-tree and @problem:reluplex-hand

#pagebreak()
#bibliography("nnv.bib", style:"ieee")
//.#set page(numbering: "1")









