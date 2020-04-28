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
  final String type;
  final String group;

  ItemEntity({this.id, this.name, this.imgUrl, this.price,
    this.type, this.group});
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
      'type': type,
      'group': group,
    };
  }
}
// 構造請求頭
var header = {
  'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36',
};
// 數據的請求Category:魚類(集合啦！動物森友會)
request_data() async{
  var url = "https://animalcrossing.fandom.com/zh/wiki/Category:%E5%8C%96%E7%9F%B3(%E9%9B%86%E5%90%88%E5%95%A6%EF%BC%81%E5%8B%95%E7%89%A9%E6%A3%AE%E5%8F%8B%E6%9C%83)";
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
html_parse() async {
  String id;
  String name;
  String imgUrl;
  String price;
  String type;
  String group;
  int idNum = 1;
  List<String> groupList = [];

  var html = await request_data();
  Document document = parse(html);
  List<ItemEntity> data = [];

// 這裡使用css選擇器語法提取數據
  List<Element> dataTdList = document.querySelectorAll('table.roundy');
  List<Element> dataTdList1 = document.querySelectorAll('.sortable');

  Element dataTd_1 = dataTdList1[1].querySelectorAll('tbody')[0];

  //兩張表
  for (var table = 0; table < 2; table++) {
    type = dataTdList[table].querySelectorAll('th')[0].text.replaceAll(" ", "").replaceAll("\n", "");
    switch (table) {
      case 0:
        //獨立化石 - 每列
        for (var tr = 1; tr < dataTdList1[table].querySelectorAll('tr').length; tr++) {
          //獨立化石 - 每欄
          for (var td = 0; td < dataTdList1[table].querySelectorAll('tr')[tr].querySelectorAll('td').length; td++) {
            switch (td) {
              case 0:
                name = dataTdList1[table].querySelectorAll('tr')[tr].querySelectorAll('td')[td].text.replaceAll(" ", "").replaceAll("\n", "");
                break;
              case 1:
                imgUrl = dataTdList1[table].querySelectorAll('tr')[tr].querySelectorAll('td')[td].children[0].attributes['href'];
                break;
              case 2:
                price = dataTdList1[table].querySelectorAll('tr')[tr].querySelectorAll('td')[td].text.replaceAll(" ", "").replaceAll("\n", "");
                break;
            }
          }
          data.add(
              ItemEntity(
                  id: idNum.toString(),
                  name: name,
                  imgUrl: imgUrl,
                  price: price,
                  type: type,
                  group: group,
              )
          );
          idNum ++;
        }
        break;
      case 1:
        //group
        for (var th = 3; th < dataTdList1[table].querySelectorAll('th').length; th++) {
          groupList.add(dataTdList1[table].querySelectorAll('th')[th].text.replaceAll(" ", "").replaceAll("\n", ""));
        }

        for (var td = 0; td < dataTd_1.querySelectorAll('td').length; td++) {
          var column = td % 3;
          switch (column) {
            case 0:
              name = dataTd_1.querySelectorAll('td')[td].text.replaceAll(
                  " ", "").replaceAll("\n", "");
              groupList.forEach((e) {
                if (name.contains(e)) {
                 group =  e;
                }
              });
//                logger.e(name);
              break;
            case 1:
              imgUrl = dataTd_1.querySelectorAll('td')[td].children[0]
                  .attributes['href'];
//                logger.e(imgUrl);
              break;
            case 2:
              price = dataTd_1.querySelectorAll('td')[td].text.replaceAll(
                  " ", "").replaceAll("\n", "");
//              logger.e(price);
              break;
          }
          data.add(
              ItemEntity(
                id: idNum.toString(),
                name: name,
                imgUrl: imgUrl,
                price: price,
                type: type,
                group: group,
              )
          );
          idNum ++;
        }
        break;
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