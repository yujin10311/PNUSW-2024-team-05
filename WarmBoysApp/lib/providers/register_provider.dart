import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/register_state.dart';

class RegisterProvider extends StatelessWidget {
  final Widget child;

  RegisterProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterState(),
      child: child,
    );
  }
}
