import 'package:flutter/cupertino.dart';

class ListDataModel<T> extends ChangeNotifier {
  List<T> listeData;
  List<Widget> listeWidgets;

  /// Fonction qui convertit un objet (contenant des données) en un widget
  /// correspondant
  Widget Function(T item) dataToWidget;

  /// Fonction qui renvoie l'id de l'objet
  dynamic Function(T item) getDataId;

  ListDataModel(this.dataToWidget, this.getDataId) {
    listeData = [];
    listeWidgets = [];
  }

  void deleteWhere(bool Function(T item) findWhere) {
    var index = listeData.indexWhere(findWhere);
    listeData.removeAt(index);
    listeWidgets.removeAt(index);
    notifyListeners();
  }

  void addFirst(T item) {
    if (listeData.any((element) => getDataId(element) == getDataId(item)))
      return;
    listeData.insert(0, item);
    listeWidgets.insert(0, dataToWidget(item));
    notifyListeners();
  }

  void addLast(T item) {
    if (listeData.any((element) => getDataId(element) == getDataId(item)))
      return;
    listeData.add(item);
    listeWidgets.add(dataToWidget(item));
    notifyListeners();
  }

  void updateWithData(List<T> items) {
    items.forEach((item) {
      addLast(item);
    });
    notifyListeners();
  }
}
