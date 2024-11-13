import 'package:flutter/material.dart';

class EditableDataTableExample extends StatefulWidget {
  @override
  _EditableDataTableExampleState createState() =>
      _EditableDataTableExampleState();
}

class _EditableDataTableExampleState extends State<EditableDataTableExample> {
  List<Map<String, dynamic>> data = [
    {'name': 'John', 'age': 25},
    {'name': 'Alice', 'age': 30},
    {'name': 'Bob', 'age': 22},
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Age')),
      ],
      rows: data.map((item) {
        int index = data.indexOf(item);
        return DataRow(
          cells: [
            DataCell(
              TextFormField(
                initialValue: item['name'],
                onFieldSubmitted: (newValue) {
                  setState(() {
                    data[index]['name'] = newValue;
                  });
                },
              ),
            ),
            DataCell(
              TextFormField(
                initialValue: item['age'].toString(),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (newValue) {
                  setState(() {
                    data[index]['age'] = int.tryParse(newValue) ?? item['age'];
                  });
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
