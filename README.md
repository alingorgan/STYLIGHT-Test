STYLIGHT-Test
===========

<p>A simple rest client demo for STYLIGHT's web api</p>

![screenshot](https://raw.github.com/alingorgan/STYLIGHT-Test/master/SLAPITest/screenshot.png)

# Description

<p>This project is a demo and it's communicating with the STYLIGHT web api to deliver content, optimized for iOS devices.</p>

<p>This project uses an updated version of the RequestCacher, now known as NetworkHelper. NetworkHelper is still under development and will replace RequestCacher as soon as it's ready.</p>

#Benefits of NetworkHelper

<p>Here is a brief list of benefits of using NetworkHelper in this project:
- Requests and their data are cached with the help of CoreData
- Data fetching and networking operations are performed on background threads
- Greater control on how long to cache data, therefore minimizing the number of API calls</p>
- Check for expired data and refetch
- Ability to display old data, as new data is still being refetched, therefore preventing blank screens.
