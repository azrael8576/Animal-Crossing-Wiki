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
  final String imgUrl_ture;
  final String imgUrl_false1;
  final String imgUrl_false2;
  final String imgUrl_false3;
  final String imgUrl_false4;
  final String price;
  final String remark;

  ItemEntity({this.id, this.name, this.imgUrl_ture,
    this.imgUrl_false1, this.imgUrl_false2,
    this.imgUrl_false3, this.imgUrl_false4,
    this.price, this.remark});
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'imgUrl_ture': imgUrl_ture,
      'imgUrl_false1': imgUrl_false1,
      'imgUrl_false2': imgUrl_false2,
      'imgUrl_false3': imgUrl_false3,
      'imgUrl_false4': imgUrl_false4,
      'price': price,
      'remark': remark,
    };
  }
}
// 構造請求頭
var header = {
  'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36',
};
// 數據的請求Category:魚類(集合啦！動物森友會)
request_data() async{
  var url = "https://wiki.biligame.com/dongsen/%E8%89%BA%E6%9C%AF%E5%93%81%E9%89%B4%E4%BC%AA";
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
  String imgUrl_ture;
  String imgUrl_false1;
  String imgUrl_false2;
  String imgUrl_false3;
  String imgUrl_false4;
  String price;
  String remark;
  int idNum = 1;

  var html = await request_data();
  Document document = parse(html);
  List<ItemEntity> data = [];

// 這裡使用css選擇器語法提取數據
  Element table = document.querySelectorAll('table.wikitable')[0];

  for (int tr = 1; tr < table.querySelectorAll('tr').length; tr++) {
    for (int td = 0; td < table.querySelectorAll('tr')[tr].querySelectorAll('td').length; td++) {
      switch (td) {
        case 0:
          name = table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].text.replaceAll(" ", "").replaceAll("　", "").replaceAll("\n", "");
          break;
        case 1:
          if (table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img').length > 0) {
            imgUrl_ture = table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img')[0].attributes['src'];
          } else {
            imgUrl_ture = "";
          }
          break;
        case 2:
          if (table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img').length > 0) {
            imgUrl_false1 = table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img')[0].attributes['src'];
          } else {
            imgUrl_false1 = "";
          }
          break;
        case 3:
          if (table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img').length > 0) {
            imgUrl_false2 = table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].querySelectorAll('img')[0].attributes['src'];
          } else {
            imgUrl_false2 = "";
          }
          break;
        case 4:
          remark = table.querySelectorAll('tr')[tr].querySelectorAll('td')[td].text.replaceAll(" ", "").replaceAll("　", "").replaceAll("\n", "");
          break;
      }

    }
    data.add(
        ItemEntity(
          id: idNum.toString(),
          name: name,
          imgUrl_ture: imgUrl_ture,
          imgUrl_false1: imgUrl_false1,
          imgUrl_false2: imgUrl_false2,
          imgUrl_false3: imgUrl_false3,
          remark: remark,
        )
    );
    idNum ++;
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