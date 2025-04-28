import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/icon_assets.dart';
import '../constants/icon_size.dart';
import '../extensions/icon_extensions.dart';

class AppIcon extends StatelessWidget {
  final IconAsset icon;
  final IconSize size;
  final double? width;
  final double? height;
  final Color? color;
  final bool filled;

  const AppIcon({
    Key? key,
    required this.icon,
    this.size = IconSize.big,
    this.width,
    this.height,
    this.color,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fileName = _getFileName();
    final String path = _getIconPath(fileName);
    return SvgPicture.asset(
      path,
      width: width ?? _getDefaultSize(),
      height: height ?? _getDefaultSize(),
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }

  String _getFileName() {
    final String iconName = icon.fileName;
    
    // Add filled variant handling
    final String variant = filled ? '-filled' : '';
    
    if (size == IconSize.small) {
      return '$iconName$variant.svg';  // Changed to use same naming convention
    } else {
      return '$iconName$variant.svg';
    }
  }

  String _getIconPath(String fileName) {
    if (size == IconSize.small) {
      return 'assets/images/icons/iconsSmall/$fileName';
    } else {
      return 'assets/images/icons/iconsBig/$fileName';
    }
  }

  double _getDefaultSize() {
    // This method is only called when width or height is null
    return size == IconSize.small ? 24.0 : 40.0;
  }
}
