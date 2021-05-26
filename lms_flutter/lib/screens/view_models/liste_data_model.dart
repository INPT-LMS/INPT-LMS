import 'package:flutter/cupertino.dart';

class ListDataModel<T> extends ChangeNotifier {
  List<T> listeData;
  List<Widget> listeWidgets;
  Widget Function(T item) dataToWidget;

  ListDataModel(this.listeData, this.listeWidgets, this.dataToWidget);

  void deleteWhere(bool Function(T item) findWhere) {
    var index = listeData.indexWhere(findWhere);
    listeData.removeAt(index);
    listeWidgets.removeAt(index);
    notifyListeners();
  }

  void addFirst(T item) {
    listeData.insert(0, item);
    listeWidgets.insert(0, dataToWidget(item));
    notifyListeners();
  }

  void addLast(T item) {
    listeData.add(item);
    listeWidgets.add(dataToWidget(item));
    notifyListeners();
  }

  void updateWithData(List<T> items) {
    listeData.addAll(items);
    listeWidgets
        .addAll(items.map<Widget>((item) => dataToWidget(item)).toList());
    notifyListeners();
  }
}
