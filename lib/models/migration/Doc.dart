class Doc {
  String name="";
  String url="";

  Doc({this.name="", this.url=""});

  Doc.fromJson(Map<String, dynamic> json, String id) {
    name = id;
    url = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}