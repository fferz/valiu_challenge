import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/bloc/provider.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/widgets/bullet_icon.dart';

// Home page - here the user can see all the tags
class AmountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // instance of tag provider
    final tagBloc = Provider.of(context);
    // get all tags from DB
    tagBloc.loadTags();
    // instance of socket provider
    final socketService = Provider.socketService(context);

    // socket alert - new tag created
    socketService.socket.on('ADD_TAG', (payload) {
      Map<String, dynamic> mapNew = new Map<String, dynamic>.from(payload);
      final TagModel socketTagNew = TagModel.fromMap(mapNew);
      tagBloc.addTagToStream(socketTagNew);
    });

    // socket alert - edited tag
    socketService.socket.on('MODIFY_TAG', (payload) {
      Map<String, dynamic> mapEdit = new Map<String, dynamic>.from(payload);
      final socketTagEdit = TagModel.fromMap(mapEdit);
      tagBloc.editTagInStream(socketTagEdit);
    });

    // socket alert - deleted tag
    socketService.socket.on('REMOVE_TAG', (payload) {
      tagBloc.removeTagFromStream(payload);
    });

    final double _screenWdith = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _sliverAppBar(_screenWdith),
            _sliverItems(tagBloc),
          ],
        ),
        bottomNavigationBar: _createAmountTag(context));
  }

  // appBar
  SliverAppBar _sliverAppBar(double screenWidth) {
    return SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        expandedHeight: 100,
        elevation: 0,
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double _top = constraints.biggest.height;
            return _spaceBar(screenWidth, _top);
          },
        ));
  }

  // the part of the appBar that expands and collapses
  FlexibleSpaceBar _spaceBar(double screenWidth, double top) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: (top < 110)
          ? Text(
              'Amount Tags',
              style: TextStyle(color: Colors.grey.shade800),
            )
          : null,
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w800,
                      fontSize: 30),
                ),
                Text('tags',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800,
                        fontSize: 30))
              ],
            ),
            Image(
              image: AssetImage('assets/valiu_logo.png'),
              width: screenWidth * 0.4,
            )
          ],
        ),
      ),
      collapseMode: CollapseMode.parallax,
    );
  }

  // list of tags
  Widget _sliverItems(TagBloc tagBloc) {
    return StreamBuilder(
        stream: tagBloc.tagStream,
        builder: (context, snapshot) {
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 60.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            BulletIcon(color: snapshot.data[index].color),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(snapshot.data[index].title),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            TextButton(
                              child: Text('Edit'),
                              onPressed: () {
                                Navigator.pushNamed(context, 'new-amount',
                                    arguments: snapshot.data[index]);
                              },
                            ),
                            TextButton(
                                onPressed: () => {
                                      tagBloc
                                          .deleteTag(snapshot.data[index].id),
                                      //tagBloc.loadTags()
                                    },
                                child: Text('Delete'))
                          ],
                        ),
                      )
                    ]),
              );
            },
            childCount: snapshot.hasData ? snapshot.data.length : 0,
          ));
        });
  }

  // button for creating new tag
  Widget _createAmountTag(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'new-amount');
          },
          child: Text('Create amount tag'),
          style: ButtonStyle(),
        ),
      ),
    );
  }
}
