class Station extends Comparable{
  String name="";
  String id="";

  Station({this.name="", this.id=""});

  Station.fromJson(String name, String docId) {
    name = name;
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