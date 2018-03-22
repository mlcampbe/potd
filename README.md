# potd
This widget will retrieve a picture-of-the-day from a couple of pre-defined internet sources and
display it as the desktop wallpaper. Currently it supports retrieving pictures from:
* Bing - picture of the day
* Flickr - intersting images
* Matt Cooper - Just because I like Disney and he does great shots
* Reddit - currently configured to fetch from EarthPorn and unitedstatesofamerica subreddits
* National Geographic - Photo of the day

The bottom right corner of the screen shows the title (if any) of the image as well as the last refresh
time.

A gradient shadow will be added to the bottom of the screen to allow the title/refresh date to show up as
well as any other widgets placed on the bottom of the screen will show up better with a darker area. This 
can be disabled by commenting out the "$div.append $shadow" if desired.

# Install
Edit the index.coffee script and make the following changes:
1. If you are going to use images from Flickr or Matt Cooper (because his images are stored at Flickr)
then you need a Flickr API key. See https://www.flickr.com/services/api/misc.api_keys.html for more info
and once the key is generated enter it into the flickrApiKey line.
2. Change the srcUrl parameter to be one of: flickr, bing, mattcooper, reddit, natgeo depending on where
you wish to retrieve the picture from.
3. Optionally change the refresh interval from 1 hour to your desired setting.

###
Note that each source randomly selects and image from a pre-defined max number of images that the
source provides. For example:
* flickr and mattcooper retrieve only the last 20 images
* bing only provides the last 7 images in json format
* reddit selects from the last 50 images
* natgeo picks an image that was posted during the current month so early in the month there are fewer images available to select from than later in the month

# Screenshot
![](/screenshot.png?raw=true)

