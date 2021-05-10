import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class NewAmountPage extends StatefulWidget {
  @override
  _NewAmountPageState createState() => _NewAmountPageState();
}

class _NewAmountPageState extends State<NewAmountPage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWdith = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey.shade800),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          title: Text('Add amount tag',
              style: TextStyle(color: Colors.grey.shade800)),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20.0),
                  width: _screenWdith * 0.6,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  width: _screenWdith * 0.3,
                  child: ElevatedButton(onPressed: () {}, child: Text('Add')),
                )
              ],
            )));
  }
}
