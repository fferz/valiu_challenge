import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/widgets/bullet_icon.dart';

class AmountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 60.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              BulletIcon(),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text('20.000'),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              TextButton(onPressed: () {}, child: Text('Edit')),
                              TextButton(
                                  onPressed: () {}, child: Text('Delete'))
                            ],
                          ),
                        )
                      ]),
                );
              },
              childCount: 14,
            ),
          ),
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
      ),
    );
  }
}
