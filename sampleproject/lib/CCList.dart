import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sampleproject/CCData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome CC Tracker'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              subtitle: Text(f.symbol),
              title: Text(f.name),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text('\$${f.price.toStringAsFixed(2)}'),
            ))
        .toList();
  }

  _loadCC() async {
    final response = await http.get(
        'https://min-api.cryptocompare.com/data/top/totalvolfull?limit=57&tsym=USD');
    var allData = (json.decode(response.body) as Map)['Data']
        as List; // as Map<String, dynamic>;

    var ccDataList = List<CCData>();
    var i = 1;

    allData.forEach((listData) {
      var coinInfo = listData['CoinInfo'] as Map<String, dynamic>;
      var raw = listData['RAW']['USD'] as Map<String, dynamic>;

      var record = CCData(
        name: coinInfo['FullName'],
        symbol: coinInfo['Name'],
        rank: i++,
        price: raw['PRICE'],
      );
      ccDataList.add(record);
    });

    setState(() {
      data = ccDataList;
    });
  }
  
  @override
  void initState(){
    super.initState();
    _loadCC();
  }
}
