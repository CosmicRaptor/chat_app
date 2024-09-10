import 'package:chat_app/providers/shared_prefs_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/widgets.dart';

import '../home_screen/home_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: YaruDetailPage(
          appBar: YaruWindowTitleBar(
            title: const Text('Onboarding'),
          ),
          body: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome to the Chat App'),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      ref.read(setUsernameProvider(value));
                      ref.read(getUserProvider).when(
                        data: (user) => print(user.toJson()),
                        loading: () => print('Loading...'),
                        error: (error, stack) => print('Error: $error'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(getUserProvider).when(
                        data: (user) {
                          if (user.name == null) {
                            print('null');
                            return;
                          }
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                        },
                        loading: () => print('Loading...'),
                        error: (error, stack) => print('Error: $error'),
                      );
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}