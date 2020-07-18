require 'json'

def alfred_output(title:, subtitle:, arg:)
  {
    items: [
      {
        title: title,
        subtitle: subtitle,
        arg: arg,
        icon: 'some_icon.png'
      }
    ]
  }.to_json
end

input = ARGV[0]
result =
  if input.start_with?('https://www.amazon.co.jp/dp/')
    input.gsub(/\Ahttps:\/\/www.amazon.co.jp\/dp\/(.+?)\/ref.+\z/, 'https://www.amazon.co.jp/dp/\1')
  elsif input.start_with?('https://www.amazon.co.jp/gp/product/')
    input.gsub(/\Ahttps:\/\/www.amazon.co.jp\/gp\/product\/(.+?)\?.+\z/, 'https://www.amazon.co.jp/dp/\1')
  else
    input.gsub(/\Ahttps:\/\/www.amazon.co.jp\/.+?\/dp\/(.+?)\/ref.+\z/, 'https://www.amazon.co.jp/dp/\1')
  end


print alfred_output(
  title: result,
  subtitle: 'Success',
  arg: result
)
