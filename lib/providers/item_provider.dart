import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> items = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/items');
    List<Item> itemsResponse =
        List<Item>.from(response.map((model) => Item.fromJson(model)));
    items = [...itemsResponse];
    notifyListeners();
  }

// Buscamos la item seleccionada en la lista, sin reconsultar el servidor C;
  Item? buscar(String id) {
    return items.isNotEmpty
        ? items.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/items', data);
      final itemNueva = Item.fromJson(json);
      items.add(itemNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/items/$id', data);
      final itemModificada = Item.fromJson(json);
      // Buscamos el index en lista del ID Item
      final index = items.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      items[index] = itemModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/items/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        items.removeWhere((item) => item.id == id);
      } else {
        throw Exception('No se ha eliminado el registro');
      }
      notifyListeners();
      return confirmado;
    } catch (e) {
      rethrow;
    }
  }

  validateForm() {
    return formKey.currentState!.validate();
  }

  saveForm() {
    formKey.currentState!.save();
  }
}
