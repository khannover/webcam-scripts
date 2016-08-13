# webcam-scripts

## Prerequisites

To create videos you need to install avconv:

``` bash
sudo apt-get -y install libav-tools
```

To create gifs you need imagemagick:

``` bash
sudo apt-get -y install imagemagick
```

If you want to make a gif out of many images it can be that there is not enough ram to complete the convert job. That's why i changed to creating videos.

## Installation

Create a cronjob for webcams.sh which runs every minute. For creating the timelapse videos you need to create a second cronjob, which may run once per day, e.g.:

```bash
crontab -e
*/1 * * * * /bin/bash /home/pi/scripts/webcams/webcams.sh
10 0 * * * /bin/bash /home/pi/scripts/webcams/makevideo.sh

```

Inside the cams.cfg you can define the webcams you want to grab, e.g.:

```bash
http://www2.braunschweig.de/webcam/burgplatz1.jpg 1,16,31,46 /var/www/webcams/burgplatz
http://www2.braunschweig.de/webcam/turm1.jpg 1,6,11,16,21,26,31,36,41,46,51,56 /var/www/webcams/rufaeutchenplatz
http://www2.braunschweig.de/webcam/schloss.jpg 0,10,20,30,40,50 /var/www/webcams/schloss
```

The first column is the path to the image you want to grab periodically.
The second are the minutes of each hour you want to execute the download, seperated by comma.
The third one is the path where you want the images to be stored.

## Example Video

![preview](https://photos-6.dropbox.com/t/2/AAB7yCxvLLJiRf5aSkkkKaCJ_AeUOI3J4be8mhBKo7mz7Q/12/3059639/jpeg/32x32/1/_/1/2/schloss-timelapse-160812.mp4/ELKCqgIYxxwgBygH/f5OSD6azPQwXtxIjfLvRogGPDb1B3DgEM5p1ZJZmfnc%2CIQOGfWs1KlFVWU96SXMNGwnGOU9hWHHHLAS8aqC6yWI%2CXpubZMljAhtcLKC-o4MkpWm32v_1FCc8BDdCpAdSmYo%2CLYwPMnL9XknDxt44BK_pVZybDUHnjpfnatP0GGbAFg8%2CefsZEKagYbS21mv1_l7NYUtUGAzEmMkqDgMTQCPfpXU?size=1024x768&size_mode=2)
[Video](https://dl.dropboxusercontent.com/u/3059639/github/webcam-scripts/schloss-timelapse-160812.mp4)
