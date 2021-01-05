/*
 * rflutter_alert
 * Created by Ratel
 * https://ratel.com.tr
 * 
 * Copyright (c) 2018 Ratel, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:flutter/material.dart';
import 'package:covid_analytics_web/Utils/Utility.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// import 'alert_style.dart';
// import 'animation_transition.dart';
// import 'constants.dart';
// import 'dialog_button.dart';

/// Main class to create alerts.
///
/// You must call the "show()" method to view the alert class you have defined.
class MyAlert extends Alert {
  final BuildContext context;
  final AlertType type;
  final AlertStyle style;
  final Image image;
  final Icon icona;
  final Widget titoloWidget;
  final Widget descrizioneWidget;
  final Widget content;
  final List<DialogButton> buttons;
  final Function closeFunction;

  /// Alert constructor
  ///
  /// [context], [title] are required.
  MyAlert({
    @required this.context,
    this.type,
    this.style = const AlertStyle(),
    this.image,
    this.icona,
    @required this.titoloWidget,
    this.descrizioneWidget,
    this.content,
    this.buttons,
    this.closeFunction,
  });

  /// Displays defined alert window
  Future<bool> show() async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _buildDialog();
      },
      barrierDismissible: style.isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: style.overlayColor,
      transitionDuration: style.animationDuration,
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

// Will be added in next version.
  // void dismiss() {
  //   Navigator.pop(context);
  // }

  // Alert dialog content widget
  Widget _buildDialog() {
    return Center(
      child: ConstrainedBox(
        constraints:
            style.constraints ?? BoxConstraints.expand(width: double.infinity),
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: style.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              shape: style.alertBorder ?? _defaultShape(),
              titlePadding: EdgeInsets.all(0.0),
              title: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _getCloseButton(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            20, (style.isCloseButton ? 0 : 20), 20, 0),
                        child: Column(
                          children: <Widget>[
                            _getImage(),
                            SizedBox(
                              height: 15,
                            ),
                            titoloWidget,
                            SizedBox(
                              height: descrizioneWidget == null ? 5 : 10,
                            ),
                            Container(
                                constraints: BoxConstraints(
                                    maxHeight: Utility.height * 0.35),
                                child: SingleChildScrollView(
                                    child: descrizioneWidget)),
                            content == null ? Container() : content,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              contentPadding: style.buttonAreaPadding,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getButtons(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.blueGrey,
      ),
    );
  }

// Returns the close button on the top right
  Widget _getCloseButton() {
    return style.isCloseButton
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Container(
              alignment: FractionalOffset.topRight,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      '$kImagePath/close.png',
                      package: 'rflutter_alert',
                    ),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      closeFunction != null ?? closeFunction();
                    },
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  // Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (buttons != null) {
      buttons.forEach(
        (button) {
          var buttonWidget = Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: button,
          );
          if (button.width != null && buttons.length == 1) {
            expandedButtons.add(buttonWidget);
          } else {
            expandedButtons.add(Expanded(
              child: buttonWidget,
            ));
          }
        },
      );
    } else {
      expandedButtons.add(
        Expanded(
          child: DialogButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );
    }

    return expandedButtons;
  }

// Returns alert image for icon
  Widget _getImage() {
    Widget response;
    if (icona == null) {
      response = image ?? Container();
    } else {
      response = icona;
    }
    switch (type) {
      case AlertType.success:
        response = Image.asset(
          '$kImagePath/icon_success.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.error:
        response = Image.asset(
          '$kImagePath/icon_error.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.info:
        response = Image.asset(
          '$kImagePath/icon_info.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.warning:
        response = Image.asset(
          '$kImagePath/icon_warning.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.none:
        response = Container();
        break;
    }
    return response;
  }

// Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    if (style.animationType == AnimationType.fromRight) {
      return AnimationTransition.fromRight(
          animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.fromLeft) {
      return AnimationTransition.fromLeft(animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.fromBottom) {
      return AnimationTransition.fromBottom(
          animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.grow) {
      return AnimationTransition.grow(animation, secondaryAnimation, child);
    } else if (style.animationType == AnimationType.shrink) {
      return AnimationTransition.shrink(animation, secondaryAnimation, child);
    } else {
      return AnimationTransition.fromTop(animation, secondaryAnimation, child);
    }
  }
}

class AnimationTransition {
  /// Slide animation, from right to left (SlideTransition)
  static fromRight(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from left to right (SlideTransition)
  static fromLeft(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromTop(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromBottom(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Scale animation, from in to out (ScaleTransition)
  static grow(Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }

  /// Scale animation, from out to in (ScaleTransition)
  static shrink(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.2,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }
}
