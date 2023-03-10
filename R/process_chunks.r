process_chunk_pdf <- function(options) {
  code <- paste(options$code, collapse = "\n")

  if (options$escape) code <- escape_latex(code)

  # if the format is PDF
  start <- paste0("\\reviewerid{", options$label, "}{")

  paste(start, "\n", code, "}", sep = "\n")
}

process_chunk_txt <- function(options) {
  code <- paste(options$code, collapse = " ")

  comment_label <- options$label

  if (grepl("unnamed-chunk", comment_label)) {
    comment_label <-
      as.numeric(paste(unlist(
        stringr::str_extract_all(comment_label, "[0-9]")
      ), collapse = ""))
  }

  glue::glue("____\nCOMMENT {comment_label}\n\n -\nRC:\n{code}\n\n")
}

process_chunk_docx <- function(options) {
  code <- options$code
  code[nchar(code) > 0] <- paste0("**", code[nchar(code) > 0], "**")

  code <- paste(code, collapse = "\n")

  comment_label <- options$label

  if (grepl("unnamed-chunk", comment_label)) {
    comment_label <-
      as.numeric(paste(unlist(
        stringr::str_extract_all(comment_label, "[0-9]")
      ), collapse = ""))
  }

  glue::glue("____\n<span class='underline'>**COMMENT {comment_label}**</span>\n\n \n**RC:**\n{code}</br>\n\n")
}
