import 'package:chat_app/providers/connection_provider.dart';
import 'package:chat_app/providers/multicast_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bypasses Riverpod lazy initialization.
class EagerInitialization extends ConsumerWidget {
  /// The widget child.
  final Widget child;

  /// Creates a new eager initialization widget instance.
  const EagerInitialization({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    ref.watch(broadcastModelProvider);
    ref.watch(discoveryModelProvider);
    ref.watch(tcpListenerProvider.notifier).startListening(4000);
    return child;
  }
}
