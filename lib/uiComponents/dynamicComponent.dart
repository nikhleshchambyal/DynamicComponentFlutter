import 'package:flutter/material.dart';
import 'package:marbles_health/Statics/decorations.dart';

class DynamicComponent extends StatefulWidget {
  final Key key;
  final void Function(Key key)? onDelete;

  DynamicComponent({required this.key, this.onDelete}) : super(key: key);

  @override
  DynamicComponentState createState() => DynamicComponentState();
}

class DynamicComponentState extends State<DynamicComponent> {
  String? _selectedOption = 'Required';
  final _infotextController = TextEditingController();
  final _labelController = TextEditingController();

  Map<String, String> getData() {
    return {
      'label': _labelController.text,
      'infoText': _infotextController.text,
      'setting': _selectedOption ?? 'Required',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bdec,
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          if (widget.onDelete != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onDelete!(widget.key);
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Label"),
              SizedBox(height: 5),
              TextFormField(
                decoration: idec,
                controller: _labelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Info-Text"),
              SizedBox(height: 5),
              TextFormField(
                decoration: idec,
                controller: _infotextController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Settings"),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text('Required'),
                      leading: Radio<String>(
                        value: 'Required',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Readonly'),
                      leading: Radio<String>(
                        value: 'Readonly',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Hidden Field'),
                      leading: Radio<String>(
                        value: 'Hidden Field',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
