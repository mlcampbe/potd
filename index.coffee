bing = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=7&mkt=en-US"
flickrApiKey = "your-flickr-api-key"
flickr = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key="+flickrApiKey+"&per_page=20&format=json&extras=url_o"
mattcooper = "https://api.flickr.com/services/rest/?method=flickr.people.getPhotos&api_key="+flickrApiKey+"&user_id=thetimethespace&per_page=20&format=json&extras=url_o"
reddit = "https://www.reddit.com/r/EarthPorn+unitedstatesofamerica/.json?limit=50"
natgeo = "https://www.nationalgeographic.com/photography/photo-of-the-day/_jcr_content/.gallery.json"

srcUrl = reddit
userAgent = "User-AgentMozilla/5.0 Gecko/20100101 Firefox/29.0"
debug = 0

command: "curl -s -A '#{userAgent}' '#{srcUrl}'"

refreshFrequency: '1h'

style: """
  position: absolute
  z-index: -10000
  left: 0px
  top: 0px
  width: 100%
  height: 100%
  color: white

  .container
    position: absolute
    top: 0px
    left: 0px
    width: 100%
    height: 100%
    background-size: cover

  .shadow
    position: absolute
    bottom: 0px
    left: 0px
    width: 100%
    height: 25%
    background: linear-gradient( 0deg, black, rgba(192, 192, 192, 0) )

  .descr
    position: absolute
    right: 3px
    bottom:2px
    font-size: 11px
    color: white
    font-family: Helvetica Neue
    font-weight: bold
"""

render: -> """
  <div class="wallpaper" />
"""

update: (output, domEl) ->
  if srcUrl.match(/flickr/i)
    output = output.replace(/^jsonFlickrApi\((.*)\)$/i, '$1')
  jsonData = JSON.parse(output)
  if debug
    console.log(jsonData)

  if srcUrl.match(/flickr/i)
    index = Math.floor(Math.random() * 20)
    photoid = jsonData.photos.photo[index].id
    farmid = jsonData.photos.photo[index].farm
    serverid = jsonData.photos.photo[index].server
    secretid = jsonData.photos.photo[index].secret
    title = jsonData.photos.photo[index].title
    url = "https://farm" + farmid + ".staticflickr.com/" + serverid + "/" + photoid + "_" + secretid + "_h.jpg"

  if srcUrl.match(/bing/i)
    index = Math.floor(Math.random() * 7)
    title = jsonData.images[index].copyright
    url = "http://www.bing.com" + jsonData.images[index].url

  if srcUrl.match(/reddit/i)
    index = Math.floor(Math.random() * 50)
    hres = jsonData.data.children[index].data.preview.images[0].source.width
    title = jsonData.data.children[index].data.title
    console.log(jsonData.data.children[index].data.title)
    title = title.substr(0,title.indexOf("["))
    url = jsonData.data.children[index].data.url

  if srcUrl.match(/nationalgeographic/i)
    now = new Date
    day = now.getDate() - 2
    index = Math.floor(Math.random() * day)
    title = jsonData.items[index].title
    url = jsonData.items[index].url + jsonData.items[index].originalUrl

  if debug
    console.log(title + " - " + url)

  $domEl = $(domEl)
  img = new Image
  img.onload = ->
    $domEl.find('div').addClass 'old'
    $div = $('<div class="container" />')
    $div.css 'background-image', 'url("' + img.src + '")'
    $div.css 'display', 'none'
    $div.fadeIn 'slow', ->
      $domEl.find('div.old').remove()
      return
    $shadow = $('<div class="shadow" />')
    $div.append $shadow
    $descr = $('<div class="descr" />')
    now = new Date
    ampm = if now.getHours() < 12 then 'a' else 'p'
    hours = if now.getHours() > 12 then now.getHours()-12 else now.getHours()
    minutes = if now.getMinutes() < 10 then '0'+now.getMinutes() else now.getMinutes()
    if title
      $descr.html title + " | " + hours + ":" + minutes + ampm
    else
      $descr.html hours + ":" + minutes + ampm
    $div.append $descr
    $domEl.append $div
  img.src = url
