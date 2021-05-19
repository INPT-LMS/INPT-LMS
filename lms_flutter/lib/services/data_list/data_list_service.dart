/// Classe abstraite utilisée pour la récupération des données dans une
/// liste. <br />
abstract class DataService<T> {
  /// Methode appelée lorsqu'on arrive à la fin de la scrollbar et qu'il faut
  /// ajouter des données. <br />
  /// n est le nombre d'élements à récuperer du serveur et p la page
  Future<DataWrapper<T>> addData(int n, int p);
}

class DataWrapper<T> {
  bool last;
  List<T> data;

  DataWrapper(this.last, this.data);
}
