import 'package:childfund_evaluation/presentation/screens/parent/child_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/api_service.dart';
import '../../../utils/models/child.dart'; // Importa la clase Child

class ChildrenListPage extends StatefulWidget {
  final int parentId;

  const ChildrenListPage({Key? key, required this.parentId}) : super(key: key);

  @override
  _ChildrenListPageState createState() => _ChildrenListPageState();
}

class _ChildrenListPageState extends State<ChildrenListPage> {
  List<Child>? children;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    final childrenData = await ApiService.getChildrenByParentId(widget.parentId);
    setState(() {
      children = childrenData?.map((data) => Child(
        childId: data['child_id'],
        name: data['name'],
        lastname: data['lastname'],
        childNumber: data['child_number'],
        gender: data['gender'],
        birthdate: data['birthdate'],
        community: data['community'],
        communityType: data['community_type'],
        village: data['village'],
        status: data['status'],
        updatedAt: data['updated_at'],
        createdAt: data['created_at'],
      )).toList();
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
                  title: Text('${child.name} ${child.lastname}'),
                  subtitle: Text('Género: ${child.gender}, Fecha de nacimiento: ${child.birthdate}'),
                  onTap: () {
                    _navigateToChildDetails(child); // Navegar a la página de detalles del niño al hacer clic
                  },
                );
              },
            ),
    );
  }

  void _navigateToChildDetails(Child child) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildDetailsPage(child: child), // Pasa el niño seleccionado a la página de detalles
      ),
    );
  }
}
