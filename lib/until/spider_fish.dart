import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'dart:io';

import '../main.dart';
// 數據實體
class ItemEntity{
  final String id;
  final String name;
  final String imgUrl;
  final String price;
  final String place;
  final String size;
  final String appearTime;
  final String appearMonth_1;
  final String appearMonth_2;
  final String appearMonth_3;
  final String appearMonth_4;
  final String appearMonth_5;
  final String appearMonth_6;
  final String appearMonth_7;
  final String appearMonth_8;
  final String appearMonth_9;
  final String appearMonth_10;
  final String appearMonth_11;
  final String appearMonth_12;
  final String hemispheres;

  ItemEntity({this.id, this.name, this.imgUrl, this.price,
  this.place, this.size, this.appearTime,
    this.appearMonth_1, this.appearMonth_2,
    this.appearMonth_3, this.appearMonth_4,
    this.appearMonth_5, this.appearMonth_6,
    this.appearMonth_7, this.appearMonth_8,
    this.appearMonth_9, this.appearMonth_10,
    this.appearMonth_11, this.appearMonth_12,
    this.hemispheres});
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
      'place': place,
      'size': size,
      'appearTime': appearTime,
      'appearMonth_1': appearMonth_1,
      'appearMonth_2': appearMonth_2,
      'appearMonth_3': appearMonth_3,
      'appearMonth_4': appearMonth_4,
      'appearMonth_5': appearMonth_5,
      'appearMonth_6': appearMonth_6,
      'appearMonth_7': appearMonth_7,
      'appearMonth_8': appearMonth_8,
      'appearMonth_9': appearMonth_9,
      'appearMonth_10': appearMonth_10,
      'appearMonth_11': appearMonth_11,
      'appearMonth_12': appearMonth_12,
      'hemispheres': hemispheres,
    };
  }
}
// 構造請求頭
var header = {
  'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36',
};
// 數據的請求Category:魚類(集合啦！動物森友會)
request_data() async{
  var url = "https://animalcrossing.fandom.com/zh/wiki/Category:%E9%AD%9A%E9%A1%9E(%E9%9B%86%E5%90%88%E5%95%A6%EF%BC%81%E5%8B%95%E7%89%A9%E6%A3%AE%E5%8F%8B%E6%9C%83)";
  var response = await http.get(url,headers: header);
  if (response.statusCode == 200) {
//    logger.e(response.body);
    return response.body;
  } else {
//    logger.e('<html>error! status:${response.statusCode}</html>');
    return response.body;
  }
}
// 數據的解析
html_parse() async{
  String id;
  String name;
  String imgUrl;
  String price;
  String place;
  String size;
  String appearTime;
  String appearMonth_1;
  String appearMonth_2;
  String appearMonth_3;
  String appearMonth_4;
  String appearMonth_5;
  String appearMonth_6;
  String appearMonth_7;
  String appearMonth_8;
  String appearMonth_9;
  String appearMonth_10;
  String appearMonth_11;
  String appearMonth_12;
  String hemispheres;


  var html = await request_data();
  Document document = parse(html);
  List<ItemEntity> data = [];

// 這裡使用css選擇器語法提取數據
  List<Element> images = document.querySelectorAll('.tabbertab');
  List<Element> dataTdList = document.querySelectorAll('.sortable');
  List<Element> dataTdList1 = dataTdList[0].querySelectorAll('tr');
  //半球
  for (var ball = 0; ball < images.length ; ball++) {
    //筆數
    for (var i = 1; i < dataTdList1.length ; i++) {
      //data
      List<Element> dataTdList1_1 = dataTdList1[i].querySelectorAll('td');
      for (var i = 0; i < dataTdList1_1.length; i++) {
        switch (i) {
          case 0:
            name =
                dataTdList1_1[i].children[0].children[0].attributes['title'].replaceAll(" ", "").replaceAll(
                    "\n", "");
            imgUrl =
                dataTdList1_1[i].children[0].children[0].querySelectorAll('img')[0].attributes['data-src'];

                break;
          case 1:
            price =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 2:
            place =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 3:
            size =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 4:
            appearTime =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 5:
            appearMonth_1 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 6:
            appearMonth_2 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 7:
            appearMonth_3 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 8:
            appearMonth_4 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 9:
            appearMonth_5 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 10:
            appearMonth_6 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 11:
            appearMonth_7 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 12:
            appearMonth_8 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 13:
            appearMonth_9 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 14:
            appearMonth_10 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 15:
            appearMonth_11 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
          case 16:
            appearMonth_12 =
                dataTdList1_1[i].text.toString().replaceAll(" ", "").replaceAll(
                    "\n", "");
            break;
        }
      }
      if (ball == 0) {
        hemispheres = "北半球";
      } else {
        hemispheres = "南半球";
      }

      data.add(
          ItemEntity(
              id: i.toString(),
              name: name,
              imgUrl: imgUrl,
              price: price,
              place: place,
              size: size,
              appearTime: appearTime,
              appearMonth_1: appearMonth_1,
              appearMonth_2: appearMonth_2,
              appearMonth_3: appearMonth_3,
              appearMonth_4: appearMonth_4,
              appearMonth_5: appearMonth_5,
              appearMonth_6: appearMonth_6,
              appearMonth_7: appearMonth_7,
              appearMonth_8: appearMonth_8,
              appearMonth_9: appearMonth_9,
              appearMonth_10: appearMonth_10,
              appearMonth_11: appearMonth_11,
              appearMonth_12: appearMonth_12,
              hemispheres: hemispheres)
      );
    }

  }
  return data;
}

// 數據的儲存
void save_data() async{
  var data = await html_parse();
  var json_str = json.encode(data);
// 將json寫入文件中
//  print(json_str);

//   Write file
  var fileCopy = await File('D:\\Users\\s417437\\Downloads\\data.json').writeAsString(json_str);
  print(await fileCopy.exists());
  print(await fileCopy.path);

}