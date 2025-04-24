import '../constants/icon_assets.dart';

extension IconAssetExtension on IconAsset {
  String get fileName {
    final String enumString = this.toString().split('.').last;
    
    return enumString.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (Match match) => '-${match.group(1)!.toLowerCase()}',
    ).replaceFirst('-', '');
  }
}
