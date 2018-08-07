# Photo Gallery App


[Photo Gallery](https://github.com/ReemHesham/photo-gallery-app) is a photo app, which fetch and display photos from Unsplsh public API.

![](https://github.com/ReemHesham/photo-gallery-app/blob/master/GalleryDemo.gif)

  - I used Unsplash public API to fetch list of photos
  - API URL: [https://api.unsplash.com/photos](https://api.unsplash.com/photos)
  - Access Key: Included in the task email
  - App has a pagination of 30 per page

_GET /photos_

| Param | Description |
| ------ | ------ |
| page | Page number to retrieve (Optional; default: 1) |
| per_page | Number of items per page (Optional; default: 10) |
| order_by | How to sort the photos (Optional, Valid values: latest, oldest, popular; default: latest) |

# App Features

  - The app displays list of photos in grid with infinite scrolling
  - When you tap on any photo, it will be displayed on a full view

**You can also:**

- Scroll between photos smoothly
- Zoom in/out on photo with double click or using pinch to zoom for full photo view
- Drag photo to dismiss the full photo view and return back to the grid view with fancy transition and fading animation (Use Pan Gesture)
- Share your photo URL with default share action.
- Hide and show the navigation bar and the bottom view on single tap on full photo view
- Showing the owner name on the grid photos and full photo view
- App supports localization for English and German

# Technical Part

**I used:**

- CocaPods dependency manager
- SwiftLint for linting
- Alamofire for networking
- Fabric and Crashlytics for bug reporting

### Testing

- I added Unit testing and UI testing

**I created 3 pull requests:**

- [Photo gallery using Unsplash APIs](https://github.com/ReemHesham/photo-gallery-app/pull/1) Which contains the main app features only fetch photos from the Unsplash API and displaying then on grid and on tap open single photo in full view

- [Gallery bonus features](https://github.com/ReemHesham/photo-gallery-app/pull/2) In this pull request I implemented extra features like I explained before in the app features part

- [Code refactoring](https://github.com/ReemHesham/photo-gallery-app/pull/3) In this pull request I do some code refactoring and enhancements like adding localization.
