import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

import '../devoir_service.dart';

/// Implementation de DataService chargée de recupérer des discussions
class DevoirListService extends DataService<DevoirData> {
  DevoirService service;
  String idCours;
  DevoirListService(this.service, this.idCours);

  @override
  Future<DataWrapper<DevoirData>> addData(int n, int p) {
    return service
        .getDevoirsCours(idCours)
        .then((value) => DataWrapper(value.last, value.content));
  }
}
