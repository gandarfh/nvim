;; ~/.config/nvim/after/queries/markdown/highlights.scm
;; extends

(list_item
  (paragraph
    (inline) @spell.in.list
  )
)

;; texto dentro de tarefa marcada (checked)
(list_item
  (task_list_marker_checked)
  (paragraph
    (inline) @spell.in.checked
  )
)

;; texto dentro de tarefa não marcada (unchecked)
(list_item
  (task_list_marker_unchecked)
  (paragraph
    (inline) @spell.in.unchecked
  )
)

;; blocos de comentário HTML (<!-- … -->)
(html_block)  @comment.markdown
;; comentários inline (em linha)
; (html_inline) @comment.markdown

;; Pipes em todas as partes da tabela
(pipe_table_header "|" @markup.table.delimiter.markdown)
(pipe_table_row "|" @markup.table.delimiter.markdown)
(pipe_table_delimiter_row "|" @markup.table.delimiter.markdown)

;; Células da tabela
(pipe_table_header (pipe_table_cell) @markup.table.header.markdown)
(pipe_table_row (pipe_table_cell) @markup.table.cell.markdown)
(pipe_table_delimiter_row (pipe_table_delimiter_cell) @markup.table.delimiter.markdown)

;; Headings com grupos adicionais específicos para markdown
(atx_heading) @markup.heading.markdown
