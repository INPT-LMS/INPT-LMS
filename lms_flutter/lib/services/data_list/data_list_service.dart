/// Classe abstraite utilisée pour la récupération des données dans une
/// liste.
abstract class DataService<T> {
  /// Methode appelée lorsqu'on arrive à la fin de la liste  et qu'il faut
  /// ajouter des données. <br />
  /// n est le nombre d'élements à récuperer du serveur et p la page à récuperer
  Future<DataWrapper<T>> addData(int n, int p);
}

class DataWrapper<T> {
  /// Indique s'il y a des données après
  bool last;
  List<T> data;

  DataWrapper(this.last, this.data);
}
