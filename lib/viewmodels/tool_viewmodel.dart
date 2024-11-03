import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tool.dart';

class ToolViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instância do Firestore

  // Criar uma ferramenta
  Future<String> createTool(Tool tool) async {
    try {
      await _firestore.collection('tools').add(tool.toMap());
      return 'Ferramenta adicionada com sucesso!';
    } catch (e) {
      return 'Erro ao adicionar ferramenta: $e';
    }
  }

  // Ler/exibir todas as ferramentas
  Stream<List<Tool>> getTools() {
    return _firestore.collection('tools').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Tool.fromMap(doc.data(), doc.id)).toList();
    });
  }

  // Atualizar ferramenta
  Future<String> updateTool(Tool tool) async {
    try {
      await _firestore.collection('tools').doc(tool.id).update(tool.toMap());
      return 'Ferramenta atualizada com sucesso!';
    } catch (e) {
      return 'Erro ao atualizar ferramenta: $e';
    }
  }

  // Excluir ferramenta
  Future<String> deleteTool(String id) async {
    try {
      await _firestore.collection('tools').doc(id).delete();
      return 'Ferramenta excluída com sucesso!';
    } catch (e) {
      return 'Erro ao excluir ferramenta: $e';
    }
  }
}
