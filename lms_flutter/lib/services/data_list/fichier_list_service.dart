import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:lms_flutter/services/stockage_service.dart';

class FichierListService extends DataService<Fichier> {
  StockageService stockageService;
  String baseUrl;

  FichierListService(this.stockageService, this.baseUrl);

  @override
  Future<DataWrapper<Fichier>> addData(int n, int p) {
    Uri url = Uri.parse("$baseUrl?page=$p&size=$n");
    return stockageService
        .getFichiers(url)
        .then((value) => DataWrapper(value.last, value.content));
  }
}
