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

  Item? buscar(String id) {
    return items.where((element) => element.id!.contains(id)).first;
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
      final item = Item.fromJson(json);
      items.add(item);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a items');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a items');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/items/$id', data);
      final item = Item.fromJson(json);
      // Buscamos el index en lista del ID Item
      final index = items.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      items[index] = item;
      notifyListeners();
      NotificationsService.showSnackbar('Item actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Item no actualizado');
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
      NotificationsService.showSnackbarError('Item no eliminado');
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
