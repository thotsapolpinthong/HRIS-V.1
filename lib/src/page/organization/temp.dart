import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:hris_app_prototype/src/page/organization/tree.dart';

class TestOrganization extends StatefulWidget {
  const TestOrganization({super.key});

  @override
  State<TestOrganization> createState() => _TestOrganizationState();
}

class _TestOrganizationState extends State<TestOrganization> {
  TextEditingController controller = TextEditingController();
  Map<String, dynamic>? orgData;
  bool isExpandedGraphView = true;
  bool isExpandedTree = false;
  // GetOrganizationStuctureModel? getStuctureModel;
  final List<String> nodeDataList = [
    "Node 1",
    "Node 2",
    "Node 3",
    "Node 4"
  ]; // รายการข้อมูลของโหนด

  Random r = Random();
  final Graph graph = Graph()..isTree = true;

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  fetchData() async {
    // getStuctureModel = await ApiOrgService.fetchDataOrganizationStucture();
  }

  getdata(int index) {
    // final data = getStuctureModel!.children[index];
    return;
  }

  @override
  void initState() {
    super.initState();
    // for (var nodeData in nodeDataList) {
    //   var node1 = Node.Id(nodeData); // สร้างโหนดใหม่โดยใช้ข้อมูลจากรายการ
    //   graph.addNode(node1); // เพิ่มโหนดลงในกราฟ
    // }

    // final node1 = Node.Id(1);
    // final node2 = Node.Id(2);
    // final node3 = Node.Id(3);
    // final node4 = Node.Id(4);
    // final node5 = Node.Id(5);
    // final node6 = Node.Id(6);
    // final node8 = Node.Id(7);
    // final node7 = Node.Id(8);
    // final node9 = Node.Id(9);
    // final node10 = Node.Id(10);
    // final node11 = Node.Id(11);
    // final node12 = Node.Id(12);

    // graph.addEdge(node1, node2);
    // graph.addEdge(node1, node3 /*paint: Paint()..color = Colors.red*/
    //     );
    // graph.addEdge(node1, node4 /*paint: Paint()..color = Colors.blue*/
    //     );
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node6, node7 /* paint: Paint()..color = Colors.red*/
    //     );
    // graph.addEdge(node6, node8 /*paint: Paint()..color = Colors.red*/
    //     );
    // graph.addEdge(node4, node9);
    // graph.addEdge(node4, node10 /*paint: Paint()..color = Colors.black*/
    //     );
    // graph.addEdge(node4, node11 /*paint: Paint()..color = Colors.red*/
    //     );
    // graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    nodeDataList.forEach((nodeData) {
      final node = Node.Id(nodeData); // สร้างโหนดใหม่โดยใช้ข้อมูลจากรายการ
      graph.addNode(node);
      // เพิ่มโหนดลงในกราฟ
    });
    var node = Node.Id(nodeDataList.toString());
    graph.addNode(node);
    return SafeArea(
        child: Scaffold(
      // floatingActionButton: SizedBox(
      //   width: 80,
      //   child: ElevatedButton(
      //     onPressed: () {
      //       setState(() {
      //         isExpandedGraphView = !isExpandedGraphView;
      //         isExpandedTree = !isExpandedTree;
      //       });
      //     },
      //     style: ElevatedButton.styleFrom(
      //         backgroundColor: isExpandedGraphView == true
      //             ? Colors.blue[400]
      //             : Colors.greenAccent[400]),
      //     child: isExpandedGraphView == true
      //         ? const Text('Graph')
      //         : const Text('Tree'),
      //   ),
      // ),
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Wrap(
                //   alignment: WrapAlignment.end,
                //   spacing: 20,
                //   children: [
                //     SizedBox(
                //       width: 100,
                //       child: TextFormField(
                //         initialValue: builder.siblingSeparation.toString(),
                //         decoration: const InputDecoration(
                //             labelText: "Sibling Separation"),
                //         onChanged: (text) {
                //           builder.siblingSeparation = int.tryParse(text) ?? 100;
                //           setState(() {});
                //         },
                //       ),
                //     ),
                //     SizedBox(
                //       width: 100,
                //       child: TextFormField(
                //         initialValue: builder.levelSeparation.toString(),
                //         decoration: const InputDecoration(
                //             labelText: "Level Separation"),
                //         onChanged: (text) {
                //           builder.levelSeparation = int.tryParse(text) ?? 100;
                //           setState(() {});
                //         },
                //       ),
                //     ),
                //     SizedBox(
                //       width: 100,
                //       child: TextFormField(
                //         initialValue: builder.subtreeSeparation.toString(),
                //         decoration: const InputDecoration(
                //             labelText: "Subtree separation"),
                //         onChanged: (text) {
                //           builder.subtreeSeparation = int.tryParse(text) ?? 100;
                //           setState(() {});
                //         },
                //       ),
                //     ),
                //     SizedBox(
                //       width: 100,
                //       child: TextFormField(
                //         initialValue: builder.orientation.toString(),
                //         decoration:
                //             const InputDecoration(labelText: "Orientation"),
                //         onChanged: (text) {
                //           builder.orientation = int.tryParse(text) ?? 100;
                //           setState(() {});
                //         },
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         final node12 = Node.Id(r.nextInt(100));
                //         var edge = graph
                //             .getNodeAtPosition(r.nextInt(graph.nodeCount()));
                //         // ignore: avoid_print
                //         print(edge);
                //         graph.addEdge(edge, node12);
                //         setState(() {});
                //       },
                //       child: const Text("Add"),
                //     )
                //   ],
                // ),
                if (isExpandedGraphView)
                  Expanded(
                    child: InteractiveViewer(
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(100),
                        minScale: 0.01,
                        maxScale: 5.6,
                        child: GraphView(
                          graph: graph,
                          algorithm: BuchheimWalkerAlgorithm(
                              builder, TreeEdgeRenderer(builder)),
                          paint: Paint()
                            ..color = Colors.black
                            ..strokeWidth = 2
                            ..style = PaintingStyle.stroke,
                          builder: (Node node) {
                            // I can decide what widget should be shown here based on the id
                            // var a = node.key!.value;

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                node.key!.value, // นี่คือข้อมูลหรือคีย์ของโหนด
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                            //rectangleWidget(a);
                          },
                        )),
                  ),
                if (isExpandedTree) Expanded(child: MyTreeView())
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget rectangleWidget(a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Row(
        children: [
          Container(
              width: 120,
              height: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 187, 222, 251),
                      spreadRadius: 1),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Node ${a == 1 ? "Stec." : nodeDataList[1]}'),
              )),
          const SizedBox(width: 5),
          Column(
            children: [
              SizedBox(
                width: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {},
                    child: const Icon(Icons.add, size: 15)),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                        padding: const EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {},
                    child: const Icon(Icons.delete_rounded, size: 15)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
