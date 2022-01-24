import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const FlareActor(
        "assets/animations/loading_circle.flr",
        snapToEnd: true,
        animation: 'load',
      ),
    );
  }
}
