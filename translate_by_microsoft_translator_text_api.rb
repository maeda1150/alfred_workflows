require 'json'
require 'net/https'
require 'uri'
require 'cgi'
require 'securerandom'

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

def error_no_key
  print alfred_output(
    title: 'Error',
    subtitle: 'No key error. Please set "SUBSCRIPTIOM_KEY".',
    arg: ''
  )
end

def error_lang
  print alfred_output(
    title: 'Error',
    subtitle: 'Language error. Please set correct language like this. "trs en ja target_text".',
    arg: ''
  )
end

def error_few_length
  print alfred_output(
    title: 'Error',
    subtitle: 'Few length error. Please input target text.',
    arg: ''
  )
end

def error_with_message(message)
  print alfred_output(
    title: 'Error',
    subtitle: message,
    arg: ''
  )
end

langs = [
  "en", "af", "ar", "bg", "bn", "bs", "ca", "zh-Hans", "cs", "cy", "da", "de", "el", "es", "et", "fa", "fi", "ht", "fr", "he", "hi", "hr",
  "hu", "id", "is", "it", "ja", "ko", "lt", "lv", "mt", "ms", "mww", "nl", "nb", "pl", "pt", "ro", "ru", "sk", "sl", "sr-Latn", "sv", "sw",
  "ta", "th", "tlh", "tr", "uk", "ur", "vi"
]
key = ENV['SUBSCRIPTIOM_KEY']

words = ARGV[0].split(' ')

from = words[0]
to   = words[1]

unless key
  error_no_key
  return
end

unless langs.include?(from)
  error_lang
  return
end

unless langs.include?(to)
  error_lang
  return
end

if words.size < 3
  error_few_length
  return
end


text = words[2..-1].join(' ')

host = 'https://api.cognitive.microsofttranslator.com'
path = '/translate?api-version=3.0'

params = "&from=#{from}&to=#{to}"

uri = URI (host + path + params)

content = '[{"Text" : "' + text + '"}]'

request = Net::HTTP::Post.new(uri)
request['Content-type'] = 'application/json'
request['Content-length'] = content.length
request['Ocp-Apim-Subscription-Key'] = key
request['X-ClientTraceId'] = SecureRandom.uuid
request.body = content

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  http.request (request)
end

result = response.body.force_encoding("utf-8")
trans = JSON.parse(result)

if trans.is_a?(Hash)
  if trans.has_key?('error')
    error_with_message(trans['error']['message'])
  else
    error_with_message('Unfortunately something wrong.')
  end
  return
end

print alfred_output(
  title: trans[0]['translations'][0]['text'],
  subtitle: 'Success translate.',
  arg: trans[0]['translations'][0]['text']
)
