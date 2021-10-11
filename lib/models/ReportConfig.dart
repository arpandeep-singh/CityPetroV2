class ReportConfig {
  int splitRate;
  int waitingRate;
  int maxSplits;
  int maxWaiting;
  int waitingTimeStep;
  bool uptLinkRequired;
  bool truckNumberRequired;

  ReportConfig(
      {this.splitRate = 20,
      this.waitingRate = 20,
      this.maxSplits = -1,
      this.waitingTimeStep = 5,
      this.uptLinkRequired = true,
      this.truckNumberRequired = true,
      this.maxWaiting = -1});

  factory ReportConfig.fromJson(Map<String, dynamic> json, String level) {
    return ReportConfig(
        splitRate: json[level]['splitRate'] ?? 20,
        waitingRate: json[level]['waitingRate'] ?? 20,
        maxSplits: json[level]['maxSplits'] ?? -1,
        maxWaiting: json[level]['maxWaiting'] ?? -1,
        uptLinkRequired: json['uptLinkRequired'] ?? true,
        truckNumberRequired: json['truckNumberRequired'] ?? true,
        waitingTimeStep: json['waitingTimeStep'] ?? 5);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['splitRate'] = this.splitRate;
    data['waitingRate'] = this.waitingRate;
    data['maxSplits'] = this.maxSplits;
    data['maxWaiting'] = this.maxWaiting;
    data['waitingTimeStep'] = this.waitingTimeStep;
    data['uptLinkRequired'] = this.uptLinkRequired;
    data['truckNumberRequired'] = this.truckNumberRequired;
    return data;
  }

  @override
  String toString() {
    return 'mS: $maxSplits sR:$splitRate mW: $maxWaiting wR:$waitingRate wStep: $waitingTimeStep uptReq: $uptLinkRequired tNReq: $truckNumberRequired';
  }
}
