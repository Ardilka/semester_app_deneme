import 'package:flutter/material.dart';

Widget buildChunkWidget(Map<String, dynamic> chunk, bool isSelected,
    Function(Map<String, dynamic>) onUpdate) {
  switch (chunk['type']) {
    case 'header':
    case 'text':
      return isSelected
          ? _buildEditableTextChunk(chunk, onUpdate)
          : Text(chunk['content'] ?? '',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    case 'image':
      return _buildImageChunk(chunk, isSelected, onUpdate);
    case 'bullet_list':
      return BulletListEditor(chunk: chunk, onUpdate: onUpdate);
    default:
      return const Text('Unknown chunk type');
  }
}

Widget _buildEditableTextChunk(
    Map<String, dynamic> chunk, Function(Map<String, dynamic>) onUpdate) {
  final controller = TextEditingController(text: chunk['content']);
  return TextField(
    controller: controller,
    onChanged: (val) => onUpdate({...chunk, 'content': val}),
  );
}

Widget _buildImageChunk(Map<String, dynamic> chunk, bool isSelected,
    Function(Map<String, dynamic>) onUpdate) {
  final controller = TextEditingController(text: chunk['url']);
  return Column(
    children: [
      if (isSelected)
        TextField(
            controller: controller,
            onChanged: (val) => onUpdate({...chunk, 'url': val})),
      Image.network(chunk['url'],
          height: 150,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) => const Text('Error loading image')),
    ],
  );
}

class BulletListEditor extends StatelessWidget {
  final Map<String, dynamic> chunk;
  final Function(Map<String, dynamic>) onUpdate;

  const BulletListEditor(
      {Key? key, required this.chunk, required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List<String>.from(chunk['items'] ?? []);

    return Column(
      children: items.map((item) => Text('• $item')).toList(),
    );
  }
}
