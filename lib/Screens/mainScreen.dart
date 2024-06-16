import 'package:flutter/material.dart';
import 'package:marbles_health/uiComponents/dynamicComponent.dart';

class DynamicApp extends StatefulWidget {
  const DynamicApp({super.key});

  @override
  State<DynamicApp> createState() => _DynamicAppState();
}

class _DynamicAppState extends State<DynamicApp> {
  List<GlobalKey<DynamicComponentState>> componentKeys = [
    GlobalKey<DynamicComponentState>()
  ];

  void _addComponent() {
    setState(() {
      componentKeys.add(GlobalKey<DynamicComponentState>());
    });
  }

  void _deleteComponent(Key key) {
    if (componentKeys.length > 1) {
      setState(() {
        componentKeys.removeWhere((componentKey) => componentKey == key);
      });
    }
  }

  void _submitForm() {
    List<Map<String, String>> formData = componentKeys.map((key) {
      return key.currentState?.getData() ?? {};
    }).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Form Data"),
          content: SingleChildScrollView(
            child: Column(
              children: formData.map((data) {
                return Card(
                  child: ListTile(
                    title: Text("Label: ${data['label']}"),
                    subtitle: Text("Info-Text: ${data['infoText']}"),
                    trailing: Text("Setting: ${data['setting']}"),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
      color: Colors.grey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
              ],
            ),
            ...componentKeys.map((key) {
              return DynamicComponent(
                key: key,
                onDelete: key == componentKeys.first ? null : _deleteComponent,
              );
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: _addComponent, child: Text('Add')),
                SizedBox(width: 25),
              ],
            )
          ],
        ),
      ),
    );
  }
}
