#import "/lunathesis-src/compile-once.typ": compile-root-tag-place, is-compile-root
#import "/lunathesis-src/style/heading-style.typ": underline-heading-style
#import "/lunathesis-src/style/combine-style.typ": combine-style
#import "/lunathesis-src/bib-utils.typ": all-bib-entries, bib-normalize-to-bytes


#let possible-missing-ref(it) = {
  if str(it.target) in all-bib-entries() or it.element != none {
    it
  } else {
    text(fill: red)[\<Target not found: #emph(str(it.target))\>]
  }
}

#let apply-heading-style(content, heading-style: (:)) = {
  for (level_str, style-func) in heading-style {
    let level = int(level_str)
    if style-func == none {
      continue
    }
    content = {
      show heading.where(level: level): style-func
      content
    }
  }
  content
}

#let numbering-default = (
  heading: "1.",
)

#let heading-style-default = (
  "1": combine-style(underline-heading-style, smallcaps),
)

#let textfill-default = (
  footnote: maroon,
  link: blue,
  cite: blue,
)

#let lunathesis-style-content(
  content,
  numbering: numbering-default,
  heading-style: heading-style-default,
  textfill: textfill-default,
) = {
  set par(linebreaks: "optimized", justify: true)
  set heading(numbering: numbering.heading) if numbering.at("heading", default: none) != none
  set enum(numbering: numbering.enum) if numbering.at("enum", default: none) != none
  set enum(full: numbering.enum-full) if numbering.at("enum-full", default: none) != none

  show: apply-heading-style.with(heading-style: heading-style)
  show footnote: set text(fill: textfill.footnote) if textfill.at("footnote", default: none) != none
  show link: set text(fill: textfill.link) if textfill.at("link", default: none) != none
  show cite: set text(fill: textfill.cite) if textfill.at("cite", default: none) != none
  show link: underline
  show ref: possible-missing-ref

  content
}

#let lunathesis-style-page(
  content,
  bib-file-content: none,
  bib-style: "apa",
  bib-title: "References",
  page-paper: "us-letter",
  page-numbering: "1",
) = {
  page(
    paper: page-paper,
    numbering: page-numbering,
    {
      content
      if bib-file-content != none {
        pagebreak()
        show heading.where(level: 1): set align(center)
        bibliography(bib-normalize-to-bytes(bib-file-content), style: bib-style, title: bib-title)
      }
    },
  )
}

#let lunathesis-style(
  content,
  style-content-func: lunathesis-style-content,
  style-page-func: lunathesis-style-page,
  main-file: false,
) = {
  content = style-content-func(content) + compile-root-tag-place(main-file)
  context {
    if is-compile-root(main-file) {
      style-page-func(content)
    } else {
      content
    }
  }
}
