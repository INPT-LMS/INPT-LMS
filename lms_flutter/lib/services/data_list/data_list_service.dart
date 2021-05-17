import 'package:flutter/material.dart';

/// Classe abstraite utilisée pour la récupération des données dans une
/// liste. <br />
abstract class DataService {
  /// Methode appelée lorsqu'on arrive à la fin de la scrollbar et qu'il faut
  /// ajouter des données. <br />
  /// n est le nombre d'élements à récuperer du serveur et p la page
  Future<DataWrapper> addData(int n, int p);
}

class DataWrapper {
  bool last;
  Column column;

  DataWrapper(this.last, this.column);
}
