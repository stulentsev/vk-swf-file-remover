require "uri"
require "net/http"

APP_ID = YOUR_APP_ID
COOKIE = YOUR_AUTH_COOKIE

USE_PROXY = false


proxy_addr = 'localhost'
proxy_port = 8888


url = URI.parse('http://vkontakte.ru/editapp')


common_headers = {
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1',
    'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Encoding' => '',
    'Accept-Language' => 'en-US,en;q=0.8',
    'Accept-Charset' => 'utf-8;q=0.7,*;q=0.3',
    'Cookie' => COOKIE
}

http = USE_PROXY ? Net::HTTP::Proxy(proxy_addr, proxy_port) : Net::HTTP

lines = http.start(url.host) do |http|
  headers = common_headers.merge({
                                     'Cache-Control' => 'max-age=0'
                                 })

  resp = http.request_get("/editapp?id=#{APP_ID}", headers)
  resp.body.split("\n")
end

lines.each do |line|
  res = line.scan /AppsEdit.deleteSWF\((\d+), '(\w+)', this\);/

  if res.length > 0


    http.start(url.host) do |http|
      data = {
          :act => :a_delete_swf,
          :aid => APP_ID,
          :al => 1,
          :swf_id => res[0][0],
          :hash => res[0][1]
      }

      headers = common_headers.merge({
                                         'Content-Type' => 'application/x-www-form-urlencoded',
                                         'X-Requested-With' => 'XMLHttpRequest',
                                     })

      data_str = data.map { |k, v| "#{k}=#{v}" }.join('&')

      puts http.post(url.path, data_str, headers).body
    end

  end
end



