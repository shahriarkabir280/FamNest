// import 'package:flutter/material.dart';

// class AppGradients {
//   static LinearGradient blueToCyan = LinearGradient(
//     colors: [Colors.lightBlueAccent.withOpacity(0.8), Colors.purple.withOpacity(.6)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static LinearGradient greenToBlue = LinearGradient(
//     colors: [Colors.green, Colors.blue],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );

//   static LinearGradient orangeToRed = LinearGradient(
//     colors: [Colors.orange, Colors.red],
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//   );
// }
// class DynamicGradient {
//   static LinearGradient createGradient(List<Color> colors, Alignment begin, Alignment end) {
//     return LinearGradient(
//       colors: colors,
//       begin: begin,
//       end: end,
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient blueToPurple = LinearGradient(
    colors: [Colors.lightBlueAccent.withOpacity(0.8), Colors.purple.withOpacity(.6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient greenToBlue = LinearGradient(
    colors: [Colors.green, Colors.blue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient orangeToRed = LinearGradient(
    colors: [Colors.orange, Colors.red],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
class DynamicGradient {
  static LinearGradient createGradient(List<Color> colors, Alignment begin, Alignment end) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );
  }
}


