# Harmony
Application that unifies all of your music streaming services with one interface and application

# Sprint 1 Application

![Alt Text](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYjhoeGxwNmp2bGdiamx3Z2RtaTZ0MWI1cHFsYXBxeXRvNmg0cG80NyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/g2z1lhDcDC9kkCOsBC/giphy.gif)

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

