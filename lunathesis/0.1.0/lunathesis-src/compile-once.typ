#let compile-root-tag-place(main-file) = {
  if main-file {
    [
      #figure("") <compile-root-pseudo-tag>
    ]
  }
}

#let is-compile-root(main-file) = {
  if main-file {
    return true
  } else {
    let has-main-file = query(<compile-root-pseudo-tag>)
    if has-main-file.len() > 0 {
      return false
    } else {
      return true
    }
  }
}
