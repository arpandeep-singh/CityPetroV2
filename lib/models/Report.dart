import 'package:CityPetro/models/Load.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

class Report {
  List<Load> loads = [];
  DateTime fromDate = new DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day >= 15 ? 15 : 1);
  DateTime toDate = DateTime.now();
  double totalEarnings = 0;
  double totalHST = 0;
  double totalWaiting = 0;

  Future<void> refreshData() async {
    this.totalEarnings = 0;
    this.totalHST = 0;
    this.totalWaiting = 0;

    this.loads = await _firebaseService.getAllLoads(this.fromDate, this.toDate);
    loads.forEach((load) {
      if(!load.isOnHold){
      totalEarnings += load.totalCostWithHST;
      totalHST += load.HST;
      totalWaiting += load.waitingCost;
      }
    });
    return;
  }

  

  Future<void> deleteLoad(Load load) async {
    //await Future.delayed(Duration(seconds: 1));
    await _firebaseService.deleteSingleLoad(load.docId);
    int index = this.loads.indexOf(load);
    this.loads.removeAt(index);
    totalEarnings -= load.totalCostWithHST;
    totalHST -= load.HST;
    totalWaiting -= load.waitingCost;
  }
}
