import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/item.dart';
import 'package:agenda_front/services/notifications_service.dart';
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

  Future<Item> buscar(String id) async {
    final json = await AgendaAPI.httpGet('/items/$id');
    return Item.fromJson(json);
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      await _actualizar(data['id'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/items', data);
      final itemNueva = Item.fromJson(json);
      items.add(itemNueva);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a items');
    } catch (e) {
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/items/$id', data);
      final itemModificada = Item.fromJson(json);
      // Buscamos el index en lista del ID Item
      final index = items.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      items[index] = itemModificada;
      notifyListeners();
      NotificationsService.showSnackbar('Item actualizado');
    } catch (e) {
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/items/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        items.removeWhere((item) => item.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 item eliminado');
      }
    } catch (e) {
      rethrow;
    }
  }

  saveAndValidate() {
    return formKey.currentState!.saveAndValidate();
  }

  formData() {
    return formKey.currentState!.value;
  }
}
