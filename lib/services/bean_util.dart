class BeanUtil {
  static void findDateTimeObjects(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (value is DateTime) {
        print('Clave: $key, Valor: $value es de tipo DateTime');
      }
    });
  }

    static void findTypeObjects<T>(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (value is T) {
        print('Clave: $key, Valor: $value es de tipo $T');
      }
    });
  }
}
