#set text(
  //font: "Noto Serif",
  
  //font: "TeX Gyre Pagella",
  size: 12pt
)

#set page(numbering: "1", number-align: center)
#set heading(numbering: "1.")
#set par(justify: true)

#set list(indent: 1em)
#set enum(indent: 1em)
#show heading: set block(below: 1.5em, above: 1.5em)

#show ref: set text(fill:blue)
#show link: set text(fill:blue)
#show link: underline
#show figure.caption: set text(size: 10pt)

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


//#set par(first-line-indent: (amount: 1.5em, all: false))

#let mytitle = "Two Clocks"
#let mysubtitle = "The Real Tenure Grind Across Two Institutions"
#let me = "ThanhVu (Vu) Nguyen"
#let institute = "George Mason University"
#let mybookgithub = "https://code.roars.dev/phd-cs-us"



#let alert(txt) = {highlight(fill:red.lighten(30%))[#txt]}
#let paragraph(title, body) = {
  v(0.5em)
  text(weight: "bold", style: "italic")[#highlight(fill:gray.lighten(80%))[#title] ]
  body
}

#let simpsons(s) = quote(
    attribution: [#text(size:0.85em)[*The Simpsons* 😱]],
    block:true
  )[
      #text(style:"italic", size:0.85em)[#s]
  ]

#import "@preview/theorion:0.6.0": *
//#import cosmos.simple: *
#import cosmos.fancy: *
//#import cosmos.rainbow: *
//#import cosmos.clouds: *
#show: show-theorion

#let redact(text, fill: black, height: 1em) = {
  box(rect(fill: fill, height: height)[#hide(text)])
}

#show figure.where(kind: image): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure(supplement: [Tab.])
//#show math.equation: set math.equation(supplement: [Eq.])
#show heading: set heading(supplement: [Sec.])


#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl, gls-long
#show: make-glossary

#let entry-list = (
  
)

#register-glossary(entry-list)
#set page(numbering: none)

// Title Page
#align(center)[
  #box(
    stroke: (x: 3pt + olive, y: 3pt + olive),
    inset: 1in
  )[
    #v(0.5fr)
    #text(size: 24pt, weight: "bold")[#mytitle]
    #v(1em)
    #text(size: 16pt, weight: "bold")[#mysubtitle]
    #v(1fr)
    #image("files/usamap.png", width: 100%)
    #v(1fr)
    #text(size: 18pt, weight: "bold")[#me]
    #v(0.2fr)
    #text(size: 14pt)[#institute]
  ]
]

#pagebreak()

#set page(numbering: "1")
#counter(page).update(2)

#v(1fr)
#emph-block[
    This #link(mybookgithub)[work] © #datetime.today().year() by #me is licensed under CC BY-NC-ND 4.0. To view a copy of this license, visit #link("https://creativecommons.org/licenses/by-nc-nd/4.0/")[creativecommons.org].
]


#pagebreak()
#outline(title: "Contents and Summary")
#pagebreak()


#heading(numbering: none)[Preface]


#pagebreak()
= Year 1 (2016--2017): Honeymoon Year at Nebraska

== New Research Direction: From Invariant Generation to Configurable Software

#pagebreak()
= Year 2 (2017--2018): The Real Grind Begins

== First NSF CAREER Rejection

#pagebreak()
= Year 3 (2018--2019): Multiple Grant Rejections

#pagebreak()
= Year 4 (2019--2020): Institutional Restructuring

#pagebreak()  
= Year 5 (2020--2021): COVID and Feeling Betrayed by the Institution

#pagebreak()
= Year 6 (2021--2022): Moving to GMU, New Research Direction

== From Software Analysis to Neural Network Verification

#pagebreak()
= Year 7 (2022--2023): Grants and Awards Year


== NSF CAREER Award

== Amazon Research Award

== FMiT Award

#pagebreak()
= Year 8 (2023--2024): Tenure

#pagebreak()
// = Glossary <chap:glossary>
// #print-glossary(entry-list, show-all: false)

#pagebreak()
#emph-block[#align(right)[_Last Updated: *#datetime.today().display("[year]-[month]-[day]")*_]]
