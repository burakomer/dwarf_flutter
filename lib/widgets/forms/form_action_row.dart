import 'package:flutter/material.dart';

class FormActionRow extends StatelessWidget {
  final bool showDelete;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  final IconData saveIcon;
  final IconData deleteIcon;

  FormActionRow({
    Key? key,
    required this.showDelete,
    required this.onSave,
    required this.onDelete,
    this.saveIcon = Icons.save,
    this.deleteIcon = Icons.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showDelete
              ? TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.red),
                  icon: Icon(deleteIcon),
                  label: Text("Delete"),
                  onPressed: onDelete,
                )
              : SizedBox(),
          ElevatedButton.icon(
            icon: Icon(saveIcon),
            label: Text("Save"),
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}
