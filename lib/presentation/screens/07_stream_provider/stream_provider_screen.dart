import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';


class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const SteamView(),
    );
  }
}

class SteamView extends ConsumerWidget {
  const SteamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChat = ref.watch(usersInChatProvider);
    if (usersInChat.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (usersInChat.hasError) {
      return Center(child: Text('Error: ${usersInChat.error}'));
    }
    final users = usersInChat.value!;
    return ListView.builder(
    itemCount: users.length,
      itemBuilder: (context, index) {
      final user = users[index];
      return ListTile(
        title: Text(user)
      );
    });
  }
}