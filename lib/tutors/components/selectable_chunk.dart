import 'package:flutter/material.dart';
import 'package:semester_app_deneme/tutors/components/build_chunk_widget.dart';

class SelectableChunk extends StatelessWidget {
  final bool isSelected;
  final Map<String, dynamic> chunk;
  final VoidCallback onTap;
  final VoidCallback onConfirm;
  final VoidCallback onDelete;
  final Function(Map<String, dynamic>) onUpdate;

  const SelectableChunk({
    Key? key,
    required this.isSelected,
    required this.chunk,
    required this.onTap,
    required this.onConfirm,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
              width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildChunkWidget(chunk, isSelected, onUpdate),
            if (isSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      onPressed: onConfirm),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
