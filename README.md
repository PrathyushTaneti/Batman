# Youtube Clone Application

This Flutter application is a clone of the popular video-sharing platform YouTube. It leverages the Google Developer API to fetch video data, enabling users to browse, search, and watch YouTube videos directly within the app. 

## Features

### Google Developer API Integration

 * Utilizes the YouTube Data API v3 provided by Google to fetch video data such as titles, descriptions, thumbnails, and metadata.
 * Enables seamless communication with YouTube's backend infrastructure to ensure up-to-date and accurate video content retrieval.

### Caching API Data
 * Implements caching mechanisms to store fetched video data locally on the device.
 * Enhances performance and reduces the number of API calls by utilizing cached data when accessing content offline or in low-connectivity environments.

### Infinite Scrolling
  * Provides users with an endless scrolling experience through a dynamic list of videos.
  * Fetches additional video data from the API as the user scrolls, ensuring a continuous flow of content without interruption.

### Video Playback
  * Enables users to watch videos directly within the app using a built-in video player widget.
  * Supports essential video playback controls such as play/pause, seeking, volume adjustment, fullscreen mode, and playback controls.
