import 'package:flutter/material.dart';
import '../models/tool.dart';
import '../viewmodels/tool_viewmodel.dart';
import 'tool_form_screen.dart';
import '../widgets/snackbar_widget.dart';

class ToolListScreen extends StatelessWidget {
  final ToolViewModel viewModel = ToolViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Ferramentas')),
      body: StreamBuilder<List<Tool>>(
        stream: viewModel.getTools(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma ferramenta encontrada.'));
          }

          final tools = snapshot.data!;
          return ListView.builder(
            itemCount: tools.length,
            itemBuilder: (context, index) {
              final tool = tools[index];
              return ListTile(
                title: Text(tool.title),
                subtitle: Text(tool.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final message = await viewModel.deleteTool(tool.id);
                    showCustomSnackbar(context, message);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ToolFormScreen(tool: tool),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ToolFormScreen(),
            ),
          );
        },
      ),
    );
  }
}
