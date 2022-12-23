import 'package:flutter/material.dart';

import 'model/task.dart';

class AnimatedLabel extends StatelessWidget {
  final bool show;
  final Label label;


  AnimatedLabel({required this.show, required this.label});

  @override
  Widget build(BuildContext context) {
    var duration = Duration(milliseconds: 500);
    var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: label.color);
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
          curve: Curves.easeInOutCubicEmphasized,
          alignment: Alignment.center,
          margin: const EdgeInsetsDirectional.only(end: 2, bottom: 2),
          child: AnimatedOpacity(
              duration: Duration(milliseconds: 50),
              opacity: show ? 1 : 0,
              child: Text(label.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600))),
          duration: duration,
          width: show ? calculateWidthPerWord() : 40,
          height: show ? 18 : 8,
          decoration: boxDecoration),
    );
  }

  ///
  ///   ? label.length < 10
  //                 ? label.length * 10
  //                 : label.length * 8
  double calculateWidthPerWord() {
    var wordLength = label.name.length;
    if (wordLength < 2) {
      return wordLength * 20;
    } else if (wordLength <= 4) {
      return wordLength * 12;
    } else if (wordLength <= 9) {
      return wordLength * 10;
    } else {
      return wordLength * 8;
    }
  }
}
