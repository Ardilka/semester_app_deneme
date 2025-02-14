import 'package:flutter/material.dart';
import 'package:semester_app_deneme/tutors/components/selectable_chunk.dart';

class TutorEditorPage extends StatefulWidget {
  const TutorEditorPage({Key? key}) : super(key: key);

  @override
  State<TutorEditorPage> createState() => _TutorEditorPageState();
}

class _TutorEditorPageState extends State<TutorEditorPage> {
  String _lessonTitle = 'My Amazing Lesson';
  List<Map<String, dynamic>> _lessonChunks = [];

  int? _selectedIndex;

  void _addChunk(String type) {
    setState(() {
      _lessonChunks.add(_getNewChunk(type));
    });
  }

  void _removeChunk(int index) {
    setState(() {
      _lessonChunks.removeAt(index);
      if (_selectedIndex == index) {
        _selectedIndex = null;
      }
    });
  }

  void _updateChunk(int index, Map<String, dynamic> updatedChunk) {
    setState(() {
      _lessonChunks[index] = updatedChunk;
    });
  }

  Map<String, dynamic> _getNewChunk(String type) {
    switch (type) {
      case 'header':
        return {'type': 'header', 'content': 'New Header'};
      case 'text':
        return {'type': 'text', 'content': 'New text here...'};
      case 'image':
        return {'type': 'image', 'url': 'https://example.com/image.png'};
      case 'bullet_list':
        return {'type': 'bullet_list', 'items': []};
      default:
        return {'type': 'text', 'content': 'Default Text'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_lessonTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Render each chunk inside a SelectableChunkContainer
            Expanded(
              child: ListView.builder(
                itemCount: _lessonChunks.length,
                itemBuilder: (context, index) {
                  return SelectableChunk(
                    isSelected: _selectedIndex == index,
                    chunk: _lessonChunks[index],
                    onTap: () => setState(() => _selectedIndex = index),
                    onConfirm: () => setState(() => _selectedIndex = null),
                    onDelete: () => _removeChunk(index),
                    onUpdate: (updatedChunk) =>
                        _updateChunk(index, updatedChunk),
                  );
                },
              ),
            ),

            // Button to add a new chunk
            ElevatedButton.icon(
              onPressed: () =>
                  showChunkSelectionBottomSheet(context, _addChunk),
              icon: const Icon(Icons.add),
              label: const Text('Add New Chunk'),
            ),
          ],
        ),
      ),
    );
  }
}

void showChunkSelectionBottomSheet(
    BuildContext context, Function(String) onChunkSelected) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: const Text('Header'),
              onTap: () {
                onChunkSelected('header');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Text'),
              onTap: () {
                onChunkSelected('text');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Image'),
              onTap: () {
                onChunkSelected('image');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_list_bulleted),
              title: const Text('Bullet List'),
              onTap: () {
                onChunkSelected('bullet_list');
                Navigator.pop(ctx);
              },
            ),
            // If you want to add "Chart" or "Side by Side," add them here:
            // ListTile(
            //   leading: const Icon(Icons.bar_chart),
            //   title: const Text('Chart'),
            //   onTap: () {
            //     onChunkSelected('chart');
            //     Navigator.pop(ctx);
            //   },
            // ),
          ],
        ),
      );
    },
  );
}
