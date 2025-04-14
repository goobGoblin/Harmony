# Harmony
Application that unifies all of your music streaming services with one interface and application
## ~~[Backend Repo](https://github.com/hreed88/Harmony-Backend)~~ - Backend is deprecated

# Sprint 5

- Figma updates
<br><img src="https://drive.google.com/uc?id=1dEP2syLzEQbLPKcmAHpYVwJZtI_JDrzp" width=270><img src="https://drive.google.com/uc?id=1DmbynJroiMuZuJAj8lOorhTHcrIbOOy7" width=270><img src="https://drive.google.com/uc?id=1xrMSWCiV4oeHrLXPaxrK17kZ6t3v2Kc-" width=270><img src="https://drive.google.com/uc?id=12eaGnr4itkfGAKe8OVzICIjxWXNBNX2z" width=270><img src="https://drive.google.com/uc?id=1-kwq1x8n2kJPBF9zaNE7fkwxHvsxuVQd" width=270>


- Added images to each song that displays where the song was linked from
- <img src="https://drive.google.com/uc?id=1o1Xz-Lh3FlEI630dax45pq28Y4iq9ECs" width=270>
- Added preferences for what the user wants to import on account connection
- <img src="https://drive.google.com/uc?id=1o1vy6i_BxwpkutUKtS0eR3p4jjzzL9j0" width=270>
- Implemented bottom bar player
- <img src="https://drive.google.com/uc?id=1oGJiETOtaB95ww0iZbatfncyyTpXBSxC" width=270>

- Updated firebase queries so that they are less cumbersome.
  
- SHA1 key importing
  - Get debug.keystore
  - Replace file located in C:/users/"Your name"/.android

# Sprint 4
- Implemented firebase functions for backend functionality
- Refactored files for better readability and modularity
- Continued work with figma designs
- Began testing with iOS devices
- Player now dynamically updates song artwork, name, and artist


# Sprint 3
- Added docker files for easier development among the group
- Created figma designs for UI elements located [here](https://www.figma.com/design/n5rjdga4WZAQx89wpn3wYk/Harmony?node-id=0-1&p=f "figma")
  ### Figma Example
  - Click the Thumbnail for full demo
 
  [![Watch the video](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgUuEAqofMyGsPNkrzu5z1ZClxWrnoA2Lhfg&s)](https://youtube.com/shorts/yiSObtaE4_A?feature=share) 

  ![Alt Text](https://drive.google.com/uc?id=1ifnWtoUFT6l9LHNNJQkTMhv0tqt-CDqY)


  ### Flutter & Docker
  - Harmony running on docker container
 
  ![Alt Text](https://drive.google.com/uc?id=1Ia8aCp3Vngtgf13HnzglHYUqIFD7QUgm)
  


# Sprint 2 Application
- Click the Thumbnail for full demo

[![Watch the video](https://i9.ytimg.com/vi/vt8k38zFdDc/mq2.jpg?sqp=CJj23b4G-oaymwEoCMACELQB8quKqQMcGADwAQH4AfQGgAKAD4oCDAgAEAEYPyBOKH8wDw==&rs=AOn4CLDLsl2JQyOJxze1pyO65F-d8HEMhQ)](https://youtube.com/shorts/vt8k38zFdDc?feature=share) 

![Alt Text](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbWZuNWhwaTNqNG04OXRocWE0amJhb2g1d2VtZ2QzaDZsNGs5YTh4byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hhbnnHSjuRwyNUi6Cy/giphy.gif)![Alt Text](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZm05MG8yeDQ2ZWw2MXdqeW4wMWhiaHpueGpvZnYyY2ZwdzhkYzBtOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/r7LFaCkoBcLXSJ4sJe/giphy.gif)


# Documentation(Sprint 1)
<object data="https://github.com/goobGoblin/Harmony/tree/main/docs/Agile Documentation.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="https://github.com/goobGoblin/Harmony/tree/main/docs/Agile Documentation.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="https://github.com/goobGoblin/Harmony/tree/main/docs/Agile Documentation.pdf">Download PDF</a>.</p>
    </embed>
</object>

# Firebase Layout

## Playlists
![alt text](/database_layout/playlists.png "Playlists")
## Songs
![alt text](/database_layout/Songs.png "songs")
## Users
### Here we have each document containing collections for albums,artists, and playlists. Where each document in the collection contains references to other parts of the database.
![alt text](/database_layout/users.png "users")



## Flutter Instalation
[Click here to learn more](https://docs.flutter.dev/get-started/install)

## Firebase Setup
1. Install the [Firebase CLI](https://firebase.google.com/docs/cli?hl=en&authuser=0#install_the_firebase_cli) and log in (run firebase login)
2. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install)
3. pull branch for local repository
4. run "dart pub global activate flutterfire_cli"
5. flutterfire configure --(Project id)

