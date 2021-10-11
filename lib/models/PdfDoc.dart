import 'package:city_petro/utils/extensions.dart';

class PdfDoc {
  String name="";
  String url="";

  PdfDoc({this.name="", this.url=""});

  PdfDoc.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString().capitalize();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.capitalize();
    data['url'] = this.url;
    return data;
  }
}