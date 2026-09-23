import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    required this.user,
    super.key,
  });

  final UserProfile user;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  String _getFirstName() {
    final fullName = user.fullName.trim();
    if (fullName.isEmpty) {
      return 'Usuario';
    }
    // Get first name (first word)
    final firstName = fullName.split(' ').first;
    return firstName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText.headlineMedium(
            '${_getGreeting()}, ${_getFirstName()}',
          ),
        ],
      ),
    );
  }
}
