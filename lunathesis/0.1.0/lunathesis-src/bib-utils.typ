#let all-bib-entries() = {
  let bib-sources = {
    let all-bib = query(bibliography)
    if all-bib.len() > 0 {
      all-bib.at(0).sources
    } else {
      none
    }
  }
  if bib-sources == none {
    (:)
  } else {
    for bib in bib-sources {
      import "@preview/citegeist:0.2.0": load-bibliography
      load-bibliography(str(bib))
    }
  }
}

#let bib-normalize-to-bytes(bib) = {
  let convert_one(p) = {
    if type(p) == str {
      bytes(p)
    } else if type(p) == bytes {
      p
    } else {
      panic("Unsupported bibliography file content type: " + str(type(p)) + ".")
    }
  }
  if bib == none {
    none
  } else if type(bib) == array {
    bib.map(convert_one)
  } else {
    convert_one(bib)
  }
}
