import 'package:flutter/material.dart';

class CustomLogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String? title;
  final String? message;

  const CustomLogoutDialog({Key? key, required this.onConfirm, this.onCancel, this.title, this.message})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'Logout'),
      content: Text(message ?? 'Apakah Anda yakin ingin logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
