# PersonalCapitalChallenge

###### Task List
- Parse the RSS feed https://www.personalcapital.com/blog/feed/
    * The RSS feed is parsed using NSXMLParser class and loads all the feed items asynchronously.
    * A loading indicator is used within the cells until the image is populated.
- The main screen should display the title of the feed represented in the feed’s html
encoded title node and display each article in a scrolling list that correctly utilizes the
space of the device screen.
    * I use the CollectionView with flowLayout to properly format the articles that are displayed
    * The first article takes prominence taking up the first row of the CollectionView.  the title is set to display a single line max where the complete summary will take up 2 lines max and both will show ellipsis if necessary.
    * Each article under the main article will display the media:content image first and the title beneath it with at most 2 lines displayed and will show ellipsis if necessary.
- For handset, the articles should be in rows of 2.
- For tablet, the articles should be in rows of 3.
- HTML encoded content should be rendered correctly.
- The screen should contain a “refresh” button
    * The button has been added to the navigation bar in the upper right corner and queries the RSS feed and refreshes the collection view.
- Selecting an article will render the article’s link in an embedded webview
    * When an article is selected a new view controller is created and presented on screen. I tried to make it look very similar to the Daily Capital Blog section on the Personal Capital iOS application.
    * The title of the article is set to the navigation bar.
    * I appended “?displayMobileNavigation=0” to each article’s link.

###### Requirements
- Use Objective-C without using Interface Builder or Storyboards. 
    * I did not use Interface Builder or Storyboards while completing this challenge, I did play around a bit initially in Main.storyboard and when I started to do constraints to help me visualize a bit until I got the hang of it.
    * Project was done in Objective-C;
- No third party libraries were used.

###### Would Have Done With More Time
- I would have cached the data.
    * The user currently will read the RSS feed in full load up fro mscratch.  I could have cached the images and data the first time it loaded to improve future run time.
- Improved everything
    * I believe I came a long way this week in learning about Objective-C. I think if I had more time I would read up a lot more on the smartest way to do all aspects of this app. Variable declaration and implementation, async calls and constraints. I think there was probably a better way to do this project than I did, but I figured it out and the next project I do I know will be even better. I'm looking forward to it.

