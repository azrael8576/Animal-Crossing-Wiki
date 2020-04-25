import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animalcrossingwiki/model/animal.dart';
import 'package:animalcrossingwiki/ui/common/animal_summary.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: new Color(0xFF736AB7),
        child: new FutureBuilder(
            future: Animal().loadAsset(),
            builder: (context, snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  List datas = jsonDecode(snapshot.data);
                  return new CustomScrollView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        sliver: new SliverList(
                          delegate: new SliverChildBuilderDelegate(
                            (context, index) =>
                                new AnimalSummary(Animal.fromJson(datas[index])),
                            childCount: datas.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
