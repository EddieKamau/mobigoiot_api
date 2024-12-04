class PrinterTextStyle {
  PrinterTextStyle({
    this.textSize,
    this.textDirection,
    this.textFont,
    this.alignment,
    this.isBold = false,
    this.isUnderlined = false,
  });

  final PTextSize? textSize;
  final PTextDirection? textDirection;
  final PTextFont? textFont;
  final PTextAlignment? alignment;
  final bool isBold;
  final bool isUnderlined;
}

enum PTextSize {
  size1(1),
  size2(2),
  size3(3),
  size4(4),
  size5(5);

  final int value;
  const PTextSize(this.value);
}

enum PTextDirection {
  reversed(1),
  forwad(2),
  other(3);

  final int value;
  const PTextDirection(this.value);
}

enum PTextFont {
  font1(1),
  font2(2),
  font3(3),
  font4(4),
  font5(5);

  final int value;
  const PTextFont(this.value);
}

enum PTextAlignment {
  center(1),
  right(2),
  left(3);

  final int value;
  const PTextAlignment(this.value);
}
