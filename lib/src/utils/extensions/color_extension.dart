import 'dart:ui';

extension ColorExtension on Color {
  bool get isLightColor {
    // Рассчитываем яркость цвета
    final double brightness =
        (red * 0.299 + green * 0.587 + blue * 0.114) / 255;

    // Если яркость выше 0.5, цвет считается светлым, иначе темным
    return brightness > 0.5;
  }
}
