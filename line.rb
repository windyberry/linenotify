require "uri"
require "net/http"
#https://notify-bot.line.me/my/

ACCESS_TOKEN  = "Wx0fVNalVul2YrGrCLiONy9eRGXXxQWPw0XF6yXSBmp"

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
# form_data                 = [['message', 'Hello'],['stickerPackageId','789'],['stickerId','10856']]
# form_data                 = [['message', 'Hello'],['imageThumbnail','https://scontent.fbkk8-2.fna.fbcdn.net/v/t39.30808-1/294548411_10160119384627710_97583482407957484_n.jpg?stp=c136.0.466.466a_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeFxTe-u92IBXa0EW7gJDC9CEruYhppOVqUSu5iGmk5WpRAHKAOCUF6owY3ZNhJ5qmA&_nc_ohc=hdzFLJLVjnkAX_Pyk89&_nc_ht=scontent.fbkk8-2.fna&oh=00_AT9H3RohAsr2ga1QmSXyV1XKF2bBd3LaAGS_XQL_qaoqVw&oe=631BEE32'],['imageFullsize','https://scontent.fbkk8-2.fna.fbcdn.net/v/t39.30808-1/294548411_10160119384627710_97583482407957484_n.jpg?stp=c136.0.466.466a_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeFxTe-u92IBXa0EW7gJDC9CEruYhppOVqUSu5iGmk5WpRAHKAOCUF6owY3ZNhJ5qmA&_nc_ohc=hdzFLJLVjnkAX_Pyk89&_nc_ht=scontent.fbkk8-2.fna&oh=00_AT9H3RohAsr2ga1QmSXyV1XKF2bBd3LaAGS_XQL_qaoqVw&oe=631BEE32']]
# form_data                 = [['message', 'Hello'],['imageThumbnail','https://scontent.fbkk9-2.fna.fbcdn.net/v/t1.6435-9/49704137_10156969471757710_6009838383130476544_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=84a396&_nc_eui2=AeFKD7nyETAbGdH7-M3XuURZ-75CHGoz29f7vkIcajPb16YWB5QPHKGIAuw4iYD1CWI&_nc_ohc=SpPfIIDd_m8AX_c6xns&_nc_ht=scontent.fbkk9-2.fna&oh=00_AT9G4m3TJ2nURmmczbJMsFRlwgvGw4CGg8ymB-d_5e4zRg&oe=633BBFF2'],['imageFullsize','https://scontent.fbkk9-2.fna.fbcdn.net/v/t1.6435-9/49704137_10156969471757710_6009838383130476544_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=84a396&_nc_eui2=AeFKD7nyETAbGdH7-M3XuURZ-75CHGoz29f7vkIcajPb16YWB5QPHKGIAuw4iYD1CWI&_nc_ohc=SpPfIIDd_m8AX_c6xns&_nc_ht=scontent.fbkk9-2.fna&oh=00_AT9G4m3TJ2nURmmczbJMsFRlwgvGw4CGg8ymB-d_5e4zRg&oe=633BBFF2']]
# form_data                 = [['message', 'Hello'],['imageThumbnail',''],['imageFullsize','']]
# form_data                 = [['message', 'Hello'],['imageThumbnail','https://stickershop.line-scdn.net/stickershop/v1/sticker/325468409/android/sticker.png'],['imageFullsize','https://stickershop.line-scdn.net/stickershop/v1/sticker/325468409/android/sticker.png']]
# request.set_form form_data, 'multipart/form-data'


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

# 789 10856
