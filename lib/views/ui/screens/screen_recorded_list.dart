import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/business_logic/blocs/bloc.dart';
import 'package:test_app/business_logic/enums/connectivity_status.dart';
import 'package:test_app/business_logic/models/model_test.dart';
import 'package:test_app/views/ui/common_widgets/container_list_content.dart';

class RecordedListScreen extends StatefulWidget {
  @override
  _RecordedListScreenState createState() => _RecordedListScreenState();
}

class _RecordedListScreenState extends State<RecordedListScreen> {
  var _scrollController = ScrollController();
  var isOffline = false;

  @override
  void initState() {
    testBloc.fetchTestList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkConnectivity(context: context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()=>testBloc.fetchTestList(),
          child: Stack(
            children: [
              ListView(),
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    AnimatedSwitcher(duration: Duration(
                      milliseconds: 1000,
                    ),
                    child: isOffline?Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      height: 30.0,
                      child: Text("Mobile is offline !!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ):SizedBox.shrink(
                      child: Container(
                        height: 40.0,
                          color: Colors.green,child: Text("Back Online")),
                    ),),
                    CustomScrollView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.black,
                          expandedHeight: 150.0,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: false,
                            title: Container(
                              // color: Colors.amber,
                              child: Text(
                                'Record List',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: testBloc.testListStream,
                        builder: (context, AsyncSnapshot<TestModel> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: snapshot.data.data.records.length,
                                itemBuilder: (context, index) {
                                  var img =
                                      snapshot.data.data.records[index].mainImageURL;
                                  return ListContent(
                                    imgURL: img ??= "assets/images/placeholder.png",
                                    imgHeight:
                                        MediaQuery.of(context).size.height / 2 - 130,
                                    imgWidth: MediaQuery.of(context).size.width,
                                    title: snapshot.data.data.records[index].title,
                                    desc: snapshot
                                        .data.data.records[index].shortDescription,
                                    countONE: snapshot
                                        .data.data.records[index].collectedValue
                                        .toString(),
                                    countTWO: snapshot
                                        .data.data.records[index].totalValue
                                        .toString(),
                                    countTHREE:
                                        snapshot.data.data.records[index].endDate,
                                    countTitleONE: "FUNDED",
                                    countTitleTWO: "GOALS",
                                    countTitleTHREE: "ENDS IN",
                                  );
                                });
                          }
                          return Center(
                            child: Container(
                                // height: 100.0,
                                // width: 100.0,
                                child: LinearProgressIndicator()),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkConnectivity({BuildContext context}) async {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      Timer.run(() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        if (!mounted) return;
        setState(() {
          isOffline = true;
        });
      });
    }
    if (connectionStatus == ConnectivityStatus.WiFi && isOffline == true) {
      Timer.run(() {
        if (!mounted) return;
        setState(() {
          isOffline = false;
        });
      });
    }
    if (connectionStatus == ConnectivityStatus.Cellular && isOffline == true) {
      Timer.run(() {
        if (!mounted) return;
        setState(() {
          isOffline = false;
        });
      });
    }
  }
}
