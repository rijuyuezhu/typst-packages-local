#let underline-heading-style(it, extra-space: 0pt) = {
  show: block
  let numbering_str = counter(heading).display(it.numbering)
  if numbering_str != none and numbering_str != "" {
    numbering_str
    " "
  }
  it.body
  v(-1em + extra-space)
  line(length: 100%)
}
