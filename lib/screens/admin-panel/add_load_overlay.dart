import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';


class TutorialOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 50);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.95);

  @override
  String get barrierLabel => "Barrier";

  @override
  bool get maintainState => false;

  

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: ListView(
        //mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        children: <Widget>[
         Lottie.network('https://assets5.lottiefiles.com/packages/lf20_ielxmmb6.json',repeat: true),
         LinearProgressIndicator().cornerRadius(10).h(8).px16(),
          // RaisedButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text('Dismiss'),
          // )
        ],
      ).centered().px32(),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}