import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

class ListeData extends StatefulWidget {
  DataService service;
  int numberPerPage;
  bool reverse;
  ListeData(
      {Key key, this.service, this.numberPerPage = 5, this.reverse = false})
      : super(key: key);

  @override
  _ListeDataState createState() => _ListeDataState();
}

class _ListeDataState<D> extends State<ListeData> {
  List<FutureBuilder<Column>> listeData;
  ScrollController scrollController;
  bool isListFinished;
  bool isLoading;
  int numberPerPage;
  int page;
  DataService service;

  @override
  void initState() {
    super.initState();
    listeData = [];
    numberPerPage = this.widget.numberPerPage;
    service = this.widget.service;
    scrollController = ScrollController();
    page = 0;
    isLoading = false;
    isListFinished = false;
    addData();
  }

  void addData() {
    if (isListFinished) return;
    isLoading = true;
    var futureColumn = service.addData(numberPerPage, page).then((value) {
      isListFinished = value.last;
      isLoading = false;
      return value.column;
    });
    setState(() {
      listeData.add(FutureBuilder<Column>(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              isListFinished = true;
              return Container(child: ErrorWidget("Une erreur est survenue"));
              //TODO : gérer cas erreur
            }
            return !snapshot.hasData
                ? Container(height: 400, child: CircularProgressIndicator())
                : snapshot.data;
          },
          future: futureColumn));
      page++;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  ListeData get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          scrollController.position.atEdge &&
          !isLoading) addData();
    });
    return ListView(
      shrinkWrap: true,
      reverse: this.widget.reverse,
      controller: scrollController,
      children: listeData,
    );
  }
}
