import 'package:flutter/material.dart';
import '../models/tool.dart';
import '../viewmodels/tool_viewmodel.dart';
import '../widgets/snackbar_widget.dart';

class ToolFormScreen extends StatefulWidget {
  final Tool? tool;

  ToolFormScreen({this.tool});

  @override
  _ToolFormScreenState createState() => _ToolFormScreenState();
}

class _ToolFormScreenState extends State<ToolFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = ToolViewModel();

  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.tool?.title ?? '';
    _description = widget.tool?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tool == null ? 'Adicionar Ferramenta' : 'Editar Ferramenta')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Informe um título' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) => value!.isEmpty ? 'Informe uma descrição' : null,
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final tool = Tool(id: widget.tool?.id ?? '', title: _title, description: _description);
                    String message;

                    if (widget.tool == null) {
                      message = await _viewModel.createTool(tool);
                    } else {
                      message = await _viewModel.updateTool(tool);
                    }

                    showCustomSnackbar(context, message);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
