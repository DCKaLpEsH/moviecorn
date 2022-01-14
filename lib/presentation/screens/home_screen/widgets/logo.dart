import 'package:flutter/material.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.height,
  })  : assert(height > 0, "height should be greater than zero"),
        super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        "assets/pngs/logo.png",
      ),
      height: height.h.toDouble(),
    );
  }
}
