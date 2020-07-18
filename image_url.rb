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

inputs = ARGV[0].split
image_width = 500
image_uri = ''

if inputs.size == 1
  image_uri = inputs.first
else
  image_width = inputs.first.to_i if inputs.first.to_i != 0
  image_uri = inputs.last
end

result =
  if image_uri[0] == '!'
    image_uri.gsub(/!\[image\]\((.+)\)/, "<img alt=\"\" src=\"\\1\" width=\"#{image_width}\">")
  else
    image_uri.gsub(/<img width="\d+" alt="(.+)" src="(https\:\/\/.+)">/, "<img alt=\"\\1\" src=\"\\2\" width=\"#{image_width}\">")
  end

print alfred_output(
  title: result,
  subtitle: 'Success',
  arg: result
)
