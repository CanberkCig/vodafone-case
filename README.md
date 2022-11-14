# Vodafone-Case

Vodafone case study

To put it simply, I tried to create an application where the user searches for the desired movie, music, ebook and application. In addition, the user can go to the detail page of the desired category. On the detail page, he can read the description of the category he selected. In the movie category, you can watch the trailer of the movie, see the imdb score, see when the movie was released, and also visit the movie's own website or the movie's director's website. In the music category, you can see the clip of the music, the genre it is, and the details of the date it was broadcast. On the application detail page, I created a section with screenshots of the application, application icon and details. You can examine it more closely by clicking the screenshots of the application you want to examine. For the e-book tab, I also created an area with the author and the description of the book.

There is a filtering feature in the application and you can filter according to the type of category you want.

Required Third Party Libraries • Alamofire • SDWebImage • TrailerPlayer • DKPhotoGallery • CRRefresh All libraries must be included to the project with CocoaPods

• MVVM architecture is used

 Search data should getted from “https://itunes.apple.com/search?term=\(keyword)&limit=\(limit)&entity=\(mediaType)".
 
•    Search starts 0.5 seconds after you take your hand off the keyboard.

•    User can go to the detail of the categories.
