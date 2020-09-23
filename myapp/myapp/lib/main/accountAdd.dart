import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountAddState();
  }
}

class AccountAddState extends State<AccountAdd>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('记账'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: Column(children: [
          TabBar(
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 18),
            controller: this.tabController,
            tabs: <Widget>[
              Tab(
                text: '支出',
              ),
              Tab(
                text: '收入',
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Icon(
                                  Icons.scatter_plot,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                            ),
                            Text('餐饮')
                          ],
                        );
                      }, childCount: 50),
                    )
                  ],
                ),
              ),
              Text('data'),
            ],
            controller: this.tabController,
          ))
        ]));
  }
}
