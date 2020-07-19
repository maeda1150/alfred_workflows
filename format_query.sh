# https://github.com/jdorn/sql-formatter
# SQLスタイルガイド https://qiita.com/taise/items/18c14d9b01a5dfd6d35e
q="{query}"
formatted=`~/.ghq/github.com/jdorn/sql-formatter/bin/sql-formatter "$q"`
# jdorn/sql-formatter は予約後を大文字に変換してくれない
# https://github.com/jdorn/sql-formatter/issues/84
# https://github.com/jdorn/sql-formatter/issues/97
~/.ghq/github.com/maeda1150/alfred_workflows/converting_sql_reserved_words_to_upper_case.rb "$formatted"

# JOIN 句などで動作しない
# use https://github.com/jackc/sqlfmt
# echo "$q" | ~/.bin/sqlfmt -u