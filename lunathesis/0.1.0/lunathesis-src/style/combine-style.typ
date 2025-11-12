#let combine-style(..styles) = {
  content => {
    for style-func in styles.pos() {
      if style-func == none {
        continue
      }
      content = style-func(content)
    }
    content
  }
}
