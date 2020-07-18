# https://github.com/jdorn/sql-formatter
# SQLスタイルガイド https://qiita.com/taise/items/18c14d9b01a5dfd6d35e
q="{query}"
# echo "$q" | ~/.ghq/github.com/jdorn/sql-formatter/bin/sql-formatter

# use https://github.com/jackc/sqlfmt
echo "$q" | ~/.bin/sqlfmt -u
