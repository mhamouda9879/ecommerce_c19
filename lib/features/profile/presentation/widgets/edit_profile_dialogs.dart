import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/validators.dart';

Future<String?> showEditFieldDialog(
  BuildContext context, {
  required String title,
  required String initialValue,
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
}) => showDialog<String>(
  context: context,
  builder: (_) => _EditFieldDialog(
    title: title,
    initialValue: initialValue,
    validator: validator,
    keyboardType: keyboardType,
  ),
);

Future<({String currentPassword, String newPassword})?>
showChangePasswordDialog(BuildContext context) =>
    showDialog(context: context, builder: (_) => const _ChangePasswordDialog());

class _EditFieldDialog extends StatefulWidget {
  const _EditFieldDialog({
    required this.title,
    required this.initialValue,
    this.validator,
    this.keyboardType,
  });

  final String title;
  final String initialValue;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  State<_EditFieldDialog> createState() => _EditFieldDialogState();
}

class _EditFieldDialogState extends State<_EditFieldDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _FormDialog(
      title: widget.title,
      formKey: _formKey,
      onSave: () => Navigator.pop(context, _controller.text.trim()),
      children: [
        TextFormField(
          controller: _controller,
          autofocus: true,
          keyboardType: widget.keyboardType,
          validator: widget.validator ?? Validators.required,
        ),
      ],
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _FormDialog(
      title: 'Change password',
      formKey: _formKey,
      onSave: () => Navigator.pop(context, (
        currentPassword: _current.text,
        newPassword: _next.text,
      )),
      children: [
        TextFormField(
          controller: _current,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Current password'),
          validator: Validators.required,
        ),
        TextFormField(
          controller: _next,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'New password'),
          validator: Validators.password,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Confirm new password'),
          validator: (value) =>
              value == _next.text ? null : 'Passwords do not match',
        ),
      ],
    );
  }
}

class _FormDialog extends StatelessWidget {
  const _FormDialog({
    required this.title,
    required this.formKey,
    required this.onSave,
    required this.children,
  });

  final String title;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) onSave();
          },
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
