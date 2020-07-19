#! /usr/bin/env ruby

input = ARGV[0]

reserved_words = %w[
  select
  from
  where
  join
  inner
  left
  outer
  on
  order
  by
  asc
  desc
  limit
  as
  and
  in
]

reserved_words.each do |word|
  input = input.gsub(/^(#{word})/) { $1.upcase }
  input = input.gsub(/\s(#{word})\s/) { " #{$1.upcase} " }
end

puts input