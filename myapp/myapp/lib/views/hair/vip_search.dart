import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:provider/provider.dart';

class VipSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print('------$query');
    var data = {
      'shop_id': Provider.of<ShopModel>(context).shop.id,
      'name': query
    };
    // HairApi.pageVip(data)
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
              text: 'adf',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: '55555', style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
    );
  }
}
