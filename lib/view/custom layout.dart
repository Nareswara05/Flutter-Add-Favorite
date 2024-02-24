import 'package:flutter/cupertino.dart';

class CustomLayout extends MultiChildLayoutDelegate {
  static const String childId = 'childId';

  @override
  void performLayout(Size size) {
    for (int i = 0; i < 2; i++) {
      final childId = 'Child$i';
      if (hasChild(childId)) {
        layoutChild(childId, BoxConstraints.loose(size));
        positionChild(childId, Offset(0.0, i * size.height / 2));
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
