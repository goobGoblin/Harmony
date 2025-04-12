import '../dependencies.dart';

List<Widget> getConnectedImages(Map<String, dynamic> thisSong) {
  List<Widget> connectedImages = [
    Flexible(
      child: Text(
        thisSong["Name"],
        overflow: TextOverflow.ellipsis,
        softWrap: false, // add this line to handle overflow
      ), //Text(thisSong["Name"]),
    ),
  ];

  for (var i = 0; i < thisSong["LinkedService"].length; i++) {
    connectedImages.add(
      const SizedBox(width: 5),
    ); // add some space between images
    var thisImage = null;

    if (thisSong["LinkedService"][i] == "Spotify") {
      thisImage = Image.asset(
        'assets/images/Spotify_logo.png', // your image path
        height: 20,
        width: 20,
        fit: BoxFit.contain,
      );
    } else if (thisSong["LinkedService"][i] == "Soundcloud") {
      thisImage = Image.asset(
        'assets/images/Soundcloud_logo.png', // your image path
        height: 20,
        width: 20,
        fit: BoxFit.contain,
      );
    }

    //TODO add more images here

    connectedImages.add(thisImage);
  }

  return connectedImages;
}
