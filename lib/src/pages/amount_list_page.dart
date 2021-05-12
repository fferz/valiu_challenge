import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/bloc/provider.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/widgets/bullet_icon.dart';

class AmountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagBloc = Provider.of(context);
    // get all tags
    tagBloc.loadTags();

    final socketService = Provider.socketService(context);
    socketService.socket.on('ADD_TAG', (payload) {
      Map<String, dynamic> map = new Map<String, dynamic>.from(payload);
      final socketTag = fromMapToList(map);
      tagBloc.addTagToStream(socketTag);
    });

    final _screenWdith = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                expandedHeight: 100,
                elevation: 0,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final top = constraints.biggest.height;
                    print('top: $top');
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
                              width: _screenWdith * 0.4,
                            )
                          ],
                        ),
                      ),
                      collapseMode: CollapseMode.parallax,
                    );
                  },
                )),
            _sliverItems(tagBloc),
          ],
        ),
        bottomNavigationBar: SafeArea(
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
        ));
  }

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
}
