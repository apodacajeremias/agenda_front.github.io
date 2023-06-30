class BeanUtil {
  static void findDateTimeObjects(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (value is DateTime) {
        print('Clave: $key, Valor: $value es de tipo DateTime');
      }
    });
  }

  static void formatDateTimeToSend(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (value is DateTime) {
        data[key] = value.toIso8601String();
      }
    });
    print('review');
    findDateTimeObjects(data);
  }
}
