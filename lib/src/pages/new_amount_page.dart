import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:valiu_challenge/src/bloc/provider.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/utils/bullet_colors.dart' as utils;

class NewAmountPage extends StatefulWidget {
  @override
  _NewAmountPageState createState() => _NewAmountPageState();
}

class _NewAmountPageState extends State<NewAmountPage> {
  TextEditingController _controller;
  TagBloc tagBloc;
  TagModel _tag;
  TagModel _tagArg;
  bool _saving = false;

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
    tagBloc = Provider.of(context);
    // args from tags list
    _tagArg = ModalRoute.of(context).settings.arguments;

    if (_tagArg != null) {
      _controller.text = _tagArg.title;
    }

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
                  child: ElevatedButton(
                      onPressed: _saving ? null : _submit, child: Text('Add')),
                )
              ],
            )));
  }

  void _submit() async {
    final tagTitle = this._controller.text;

    if (this._controller.text == "0.00") {
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please, insert value')));

      return;
    }

    // start saving
    setState(() {
      this._saving = true;
    });

    if (this._tagArg == null) {
      // CREATE

      // save value in tag
      this._tag = new TagModel.create(title: tagTitle, color: utils.setColor());
      // save in DB
      this.tagBloc.newTag(this._tag);
      // get all tags
      //this.tagBloc.loadTags();

      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tag saved'),
        duration: Duration(seconds: 3),
      ));
    } else {
      // EDIT

      // update tag object
      this._tagArg.title = tagTitle;
      // save in DB
      this.tagBloc.editTag(this._tagArg);
      // get all tags
      //this.tagBloc.loadTags();

      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tag updated'),
        duration: Duration(seconds: 3),
      ));
    }

    // stop saving
    setState(() {
      this._saving = false;
    });

    // back to home
    await Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context);
    });
  }
}
