import 'package:flutter/material.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[300],
            maxRadius: 15,
            child: const Text(
              'Te',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Jhancarlos',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          )
        ],
      ),
    );
  }
}
