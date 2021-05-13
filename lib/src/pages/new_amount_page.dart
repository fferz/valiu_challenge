import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:valiu_challenge/src/bloc/provider.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/utils/bullet_colors.dart' as utils;

// In this page, the user can create or edit a tag
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
    // initialize text field controller with Mask
    _controller = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // instance of tag provider
    tagBloc = Provider.of(context);
    // args from tags list page
    _tagArg = ModalRoute.of(context).settings.arguments;

    if (_tagArg != null) {
      // edit tag
      _controller.text = _tagArg.title;
    }

    final double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: _backButton(),
          elevation: 0,
          title: Text('Add amount tag',
              style: TextStyle(color: Colors.grey.shade800)),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [_inputField(_screenWidth), _addButton(_screenWidth)],
            )));
  }

  // input text field
  Widget _inputField(double screenWidth) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: screenWidth * 0.6,
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
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [],
      ),
    );
  }

  // save changes button - add button
  Widget _addButton(double screenWidth) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: screenWidth * 0.3,
      child: ElevatedButton(
          onPressed: _saving ? null : _submit, child: Text('Add')),
    );
  }

  // arrow back button for menu
  IconButton _backButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey.shade800),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  // save changes in DB
  void _submit() async {
    // text field value
    final String tagTitle = this._controller.text;

    // empty value
    if (this._controller.text == "0.00") {
      // show snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please, insert value')));

      return;
    }

    // start saving - blocks add button
    setState(() {
      this._saving = true;
    });

    if (this._tagArg == null) {
      // CREATE
      _createTag(tagTitle);
    } else {
      // EDIT
      _editTag(tagTitle);
    }

    // stop saving - unblocks add button
    setState(() {
      this._saving = false;
    });

    // back to home
    await Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context);
    });
  }

  // creates new tag
  void _createTag(String tagTitle) {
    // save value in tag
    this._tag = new TagModel.create(title: tagTitle, color: utils.setColor());
    // save in DB
    this.tagBloc.newTag(this._tag);

    // show message in snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tag saved'),
      duration: Duration(seconds: 3),
    ));
  }

  // updates existing tag
  void _editTag(String tagTitle) {
    // update tag object
    this._tagArg.title = tagTitle;
    // save in DB
    this.tagBloc.editTag(this._tagArg);

    // show message in snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tag updated'),
      duration: Duration(seconds: 3),
    ));
  }
}
