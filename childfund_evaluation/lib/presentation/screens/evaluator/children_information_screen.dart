import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/models/children.dart';
import 'package:flutter/material.dart';

class ChildrenInfoPage extends StatefulWidget {
  final int childId;
  const ChildrenInfoPage({Key? key, required this.childId}) : super(key: key);

  @override
  _ChildrenInfoPageState createState() => _ChildrenInfoPageState();
}

class _ChildrenInfoPageState extends State<ChildrenInfoPage> {
  Children? children;
  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    Children? childrenData = await ApiService.getChildrenInfo(widget.childId);
    setState(() {
      children = childrenData;
    });
    print(childrenData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del infante'),
      ),
      body: children == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final child = children;
                return ListTile(
                  title: Text('a'),
                  // Otros campos del hijo que desees mostrar
                );
              },
            ),
    );
  }
}
