import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> items = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await ServerConection.httpGet('/items');
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
    if (data.containsKey('ID') && data['ID'] != null) {
      // Actualiza
      await _actualizar(data['ID'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await ServerConection.httpPost('/items', data);
      final item = Item.fromJson(json);
      items.add(item);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a items');
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a items');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConection.httpPut('/items/$id', data);
      final item = Item.fromJson(json);
      // Buscamos el index en lista del ID Item
      final index = items.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      items[index] = item;
      notifyListeners();
      NotificationService.showSnackbar('Item actualizado');
    } catch (e) {
      NotificationService.showSnackbarError('Item no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConection.httpDelete('/items/$id', {});
      final confirmado = json;
      if (confirmado) {
        items.removeWhere((item) => item.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 item eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Item no eliminado');
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
