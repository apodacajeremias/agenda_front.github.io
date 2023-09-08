import 'package:agenda_front/services/local_storage.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String src;
  final double? size;
  const Avatar(this.src, {super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          'http://localhost:8080/api/downloadFile/$src',
          headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}'
          },
          errorBuilder: (context, error, stackTrace) =>
              Icon(size: size, Icons.account_circle_outlined),
        ),
      ),
    );
  }
}
