import 'package:flutter_svg/flutter_svg.dart';

class SvgCacheHandler {
  SvgCacheHandler({
    required this.imagePaths,
  });

  final List<String> imagePaths;

  Future<void> cache() async {
    for (final image in imagePaths) {
      await _precacheSvgPicture(image);
    }
  }

  Future _precacheSvgPicture(String svgPath) async {
    final logo = SvgAssetLoader(svgPath);
    await svg.cache
        .putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));
  }
}
