class Station extends Comparable{
  String name="";
  String id="";

  Station({this.name="", this.id=""});

  Station.fromJson(Map<String, dynamic> json, String docId) {
    name = json['stationId'];
    id =docId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationId'] = this.name;
    return data;
  }

  @override
  int compareTo(other) {
    throw this.name==other;
  }

  
}