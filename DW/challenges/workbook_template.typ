#import "@preview/codly-languages:0.1.10"
#import "@preview/codly:1.3.0"

#let horizontalrule = line()

#show: it => {
  set page(width: 30cm, height: auto, numbering: none, margin: 1cm)
  set heading(numbering: "1.1")
  set text(font: "Liberation Serif")
  show par: it => block(width: 15cm, it)
  show raw.where(block: true): set block(breakable: false)
  show: codly.codly-init
  show link: set text(blue)
  set par(justify: true)

  show raw: set text(
    font: "JetBrainsMono NF",
  )

  codly.codly(
    number-format: none,
    languages: codly-languages.codly-languages,
    header-transform: it => align(start, text(
      weight: "bold",
      it,
    )),
    header-cell-args: (
      stroke: 1pt + black.transparentize(85%),
    ),
    stroke: 1pt + black.transparentize(85%),
    zebra-fill: black.transparentize(95%),
    lang-stroke: none,
    lang-fill: it => rgb(0, 0, 0, 0),
  )
  it
}

$body$
