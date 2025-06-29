// import 'dart:ui';

// class CanvasObject<T> {
//   final double dx;
//   final double dy;
//   final Size size;
//   final T child;

//   CanvasObject({
//     this.dx = 0,
//     this.dy = 0,
//     required this.size,

//     required this.child,
//   });

//   CanvasObject<T> copyWith({
//     double? dx,
//     double? dy,
//     Size? size,
//     T?   child,
//   }) {
//     return CanvasObject<T>(
//       dx: dx ?? this.dx,
//       dy: dy ?? this.dy,
//       size: size ?? this.size,
//       child: child ?? this.child,
//     );
//   }

//   Offset get offset => Offset(dx, dy);
//   Rect get rect => offset & size;
// }
