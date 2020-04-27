import 'dart:convert';

import 'package:animalcrossingwiki/model/animal.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../constant.dart';
import 'home_page_body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new GradientAppBar("小動物", null, (){Logger().e('安安');}, null,),
          new HomePageBody(),
        ],
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;
  final double barHeight = 66.0;

  GradientAppBar(@required this.title, this.child, this.onPressed, this.onTitleTapped);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child:  Hero(
        tag: 'topBarBtn',
        child: Card(
          elevation: 10,
          shape: kBackButtonShape,
          child: MaterialButton(
            height: 50,
            minWidth: 50,
            elevation: 10,
            shape: kBackButtonShape,
            onPressed: onPressed,
            child: child,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
