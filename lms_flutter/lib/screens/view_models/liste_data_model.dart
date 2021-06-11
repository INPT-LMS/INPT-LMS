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

  void deleteWhere(dynamic id) {
    var index = listeData.indexWhere((element) => getDataId(element) == id);
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

  void addLast(T item, {bool update = true}) {
    if (listeData.any((element) => getDataId(element) == getDataId(item)))
      return;
    listeData.add(item);
    listeWidgets.add(dataToWidget(item));
    if (update) notifyListeners();
  }

  void updateWithData(List<T> items) {
    items.forEach((item) {
      addLast(item, update: false);
    });
    notifyListeners();
  }

  void updateWhere(dynamic id, T newData) {
    var index = listeData.indexWhere((element) => getDataId(element) == id);
    listeData.removeAt(index);
    listeWidgets.removeAt(index);

    listeData.insert(index, newData);
    listeWidgets.insert(index, dataToWidget(newData));
    notifyListeners();
  }
}
