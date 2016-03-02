# AbercrombieCodeTest
####About
This app was created in about two days.  The project is an iOS app written for iPhone in Swift 2.0. It requires iOS 9.2 to run properly. 
<br />

####Libraries and Tools Used
To make reading the RSS Feeds easier, I used the Swift Feed Reader (https://github.com/DigitalLeaves/SwiftFeedParser) to read/parse the RSS Feed.

####How It Works
+ AbercrombieCodeTest uses a TableViewController to display the rss feed.
+ FeedItems are created through the parsed XML payloads.
+ Each feedItem is then broken down by the title and content to create the title, little description, and image for the article.
+ Offline use is managed by saving the XML payload after it is received. There is a default rss image that appears when the user is not connected to a source since the images are created by a url call.
<br />

####Use Instructions
+ Stories are presented to the user in a table view format and allows the user to select them so that it can take them to a webview of the article. 
+ The user can access the last list of stories from when they were connected, as well as accessing a quick blurb from the story.
+ A message appears notifying the user that they are in offline mode when they access with no connection.
