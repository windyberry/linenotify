require "uri"
require "net/http"

#https://notify-bot.line.me/my/

ACCESS_TOKEN  = "Wx0fVNalVul2YrGrCLiONy9eRGXXxQWPw0XF6yXSBm"

def send_line(data)
  url           = URI("https://notify-api.line.me/api/notify")
  https         = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request       = Net::HTTP::Post.new(url)
  request["Content-Type"]   = "application/x-www-form-urlencoded"
  request["Authorization"]  = "Bearer "+ACCESS_TOKEN
  request.set_form data, 'multipart/form-data'
  response = https.request(request)
  return response.read_body
end

def gen_message(text, urlImage, stickerPackageId, stickerId)
  data = []
  if (!text.nil?)
    message = ['message', text.to_s]
    data.append(message)
  end
  if (!urlImage.nil?)
    url1 = ['imageThumbnail', urlImage.to_s]
    data.append(url1)
    url2 = ['imageFullsize', urlImage.to_s]
    data.append(url2)
  end

  if (!stickerPackageId.nil? && !stickerId.nil?)
    url1 = ['stickerPackageId', stickerPackageId.to_s]
    data.append(url1)
    url2 = ['stickerId', stickerId.to_s]
    data.append(url2)
  end
  return data
end

if (ARGV.length > 0)
  if (ARGV.length == 2 && ARGV[0]=~/\d+/ && ARGV[1]=~/\d+/)
    msg = gen_message(" ", nil, ARGV[0].to_i.to_s, ARGV[1].to_i.to_s)
    puts send_line(msg)
  else
    data = ARGV.join(" ").to_s
    if (data =~ /^http/)
      msg = gen_message(" ", data, nil, nil)
      puts send_line(msg)
    else
      msg = gen_message(data, nil, nil, nil)
      puts send_line(msg)
    end
  end
else
  puts "How to run line.rb"
  puts "$ruby line.rb Hello windygallery !"
  puts "$ruby line.rb 789 10856"
  puts "$ruby line.rb https://stickershop.line-scdn.net/stickershop/v1/sticker/325468409/android/sticker.png"
end
