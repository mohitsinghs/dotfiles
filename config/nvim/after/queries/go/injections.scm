; extends

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
  ] @injection.content
  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
  (#offset! @injection.content 0 0 0 0)
  (#set! injection.language "sql")
)
