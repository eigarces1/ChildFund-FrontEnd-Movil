import 'package:flutter/material.dart';
import '../../../utils/api_service.dart';

class ChildrenListPage extends StatefulWidget {
  final int parentId;

  const ChildrenListPage({Key? key, required this.parentId}) : super(key: key);

  @override
  _ChildrenListPageState createState() => _ChildrenListPageState();
}

class _ChildrenListPageState extends State<ChildrenListPage> {
  List<Map<String, dynamic>>? children;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    final childrenData = await ApiService.getChildrenByParentId(widget.parentId);
    setState(() {
      children = childrenData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Hijos'),
      ),
      body: children == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: children!.length,
              itemBuilder: (context, index) {
                final child = children![index];
                return ListTile(
                  title: Text(child['name']),
                  subtitle: Text(child['lastname']),
                  // Otros campos del hijo que desees mostrar
                );
              },
            ),
    );
  }
}
