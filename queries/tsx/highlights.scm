;; Match the TypeScript punctuation split in TSX buffers so JSX-heavy code keeps
;; the same delimiter hierarchy as plain TypeScript.

("," @punctuation.comma)
("." @punctuation.dot)
(":" @punctuation.colon)
(";" @punctuation.semicolon)
("?" @punctuation.special)
("..." @punctuation.special)
("=>" @operator)
