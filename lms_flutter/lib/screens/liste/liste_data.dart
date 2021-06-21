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
  final bool canRefresh;

  ListeData(this.dataService,
      {Key key,
      this.reverse = false,
      this.shrinkWrap = false,
      this.canRefresh = true})
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
    clearValues();
  }

  void clearValues() {
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

    if (hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
          context,
          "Une erreur est survenue durant la "
          "recupération des données"));
      hasError = false;
    }

    if (modele.isCleared) {
      clearValues();
      modele.finishClear();
    }

    if (modele.listeWidgets.isEmpty && !isLoading) {
      if (!isListFinished)
        addData();
      else
        return RefreshIndicator(
            child: ListView(
              children: [Center(child: Text("Rien à afficher"))],
              shrinkWrap: this.widget.shrinkWrap,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () {
              return Future(() => modele.clear());
            });
    }
    var listView = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: this.widget.shrinkWrap,
        reverse: this.widget.reverse,
        controller: scrollController,
        children: modele.listeWidgets.toList());
    return this.widget.canRefresh
        ? RefreshIndicator(
            child: listView,
            onRefresh: () {
              return Future(() => modele.clear());
            })
        : listView;
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
