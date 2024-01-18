import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/page/examgraphview/layer_graphview.dart';

import 'directed_graphview.dart';
import 'tree_graphview.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: TreeViewPage(),
                              )),
                    ),
                child: Text(
                  'Tree View (BuchheimWalker)',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: GraphClusterViewPage(),
                              )),
                    ),
                child: Text(
                  'Graph Cluster View (FruchtermanReingold)',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: LayeredGraphViewPage(),
                              )),
                    ),
                child: Text(
                  'Layered View (Sugiyama)',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ]),
        ),
      ),
    );
  }
}
