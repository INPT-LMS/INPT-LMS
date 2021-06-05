import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:provider/provider.dart';

import '../view_models/liste_data_model.dart';

class ListeData<T> extends StatefulWidget {
  final bool reverse;
  final DataService<T> dataService;
  final bool shrinkWrap;

  ListeData(this.dataService, this.reverse, {Key key, this.shrinkWrap = false})
      : super(key: key);

  @override
  _ListeDataState<T> createState() => _ListeDataState<T>();
}

class _ListeDataState<T> extends State<ListeData<T>> {
  ScrollController scrollController;
  DataService<T> dataService;
  ListDataModel<T> modele;
  bool isListFinished;
  bool isLoading;
  bool hasError;
  int page;
  int size;
  @override
  void initState() {
    super.initState();
    dataService = this.widget.dataService;
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    isListFinished = false;
    isLoading = false;
    hasError = false;
    page = 0;
    size = 10;
  }

  void scrollListener() {
    if (!isLoading &&
        !isListFinished &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        scrollController.position.atEdge) {
      addData();
    }
  }

  @override
  ListeData<T> get widget => super.widget;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modele = Provider.of<ListDataModel<T>>(context);
    if (modele.listeWidgets.isEmpty && !isListFinished && !isLoading) addData();

    if (hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
          context,
          "Une erreur est survenue durant la "
          "recupération des données"));
      hasError = false;
    }
    return ListView(
        shrinkWrap: this.widget.shrinkWrap,
        reverse: this.widget.reverse,
        controller: scrollController,
        children: this.widget.reverse
            ? modele.listeWidgets.toList()
            : modele.listeWidgets.toList());
  }

  void addData() {
    isLoading = true;
    dataService.addData(size, page).then((value) {
      isListFinished = value.last;
      isLoading = false;
      modele.updateWithData(value.data);
    }).catchError((error) {
      makeError();
      isListFinished = true;
      isLoading = false;
    });
    page++;
  }

  void makeError() {
    setState(() {
      hasError = true;
    });
  }
}
