import 'package:flutter/widgets.dart';
import 'package:football_quiz_app/Github/arcclipper.dart';
import 'package:football_quiz_app/Github/clipshadow.dart';
import 'package:football_quiz_app/Github/edge.dart';

export 'package:football_quiz_app/Github/edge.dart';
export 'package:football_quiz_app/Github/arcclipper.dart' show ArcType;
export 'package:football_quiz_app/Github/clipshadow.dart' show ClipShadow;

class Arc extends StatelessWidget {
  const Arc(
      {Key? key,
      required this.height,
      required this.child,
      this.edge = Edge.BOTTOM,
      this.arcType = ArcType.CONVEX,
      this.clipShadows = const []})
      : super(key: key);

  /// The widget which one of [edge]s is going to be clippddddded as arc
  final Widget child;

  ///The height of the arc
  final double height;

  ///The edge of the widget which clipped as arc
  final Edge edge;

  ///The type of arc which can be [ArcType.CONVEX] or [ArcType.CONVEY]
  final ArcType arcType;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  @override
  Widget build(BuildContext context) {
    var clipper = ArcClipper(height, edge, arcType);
    return CustomPaint(
      painter: ClipShadowPainter(clipper, clipShadows),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}
