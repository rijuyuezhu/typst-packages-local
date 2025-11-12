#let maybe_bool_to_sym(b) = {
  if type(b) != bool {
    b
  } else {
    if b {
      sym.checkmark
    } else {
      sym.crossmark
    }
  }
}

#let noteb(it) = block(
  fill: luma(230),
  inset: 8pt,
  radius: 2pt,
  width: 100%,
  it,
)

#let todo(..args) = {
  set text(fill: purple)
  show: emph
  let narg = args.pos().len()
  if narg == 0 {
    strong("<TODO>")
  } else {
    strong("<TODO: ") + args.pos().join(", ") + strong(">")
  }
}
