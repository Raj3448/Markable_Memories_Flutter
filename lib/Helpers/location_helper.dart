const GOOGLE_MAP_API = 'AIzaSyBTWPlGWmaLioHf6E9nWbltSuOmvNMpHjM';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:R%7C$latitude,$longitude&key=$GOOGLE_MAP_API&signature=YOUR_SIGNATURE';
  }
}
