import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
part 'stream_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<String>> usersInChat (Ref ref) async* {
  final names = <String>[];
  // yield names;
  await for (final name in RandomGenerator.randomNameStream()) {
    names.add(name);
    yield names;
  }
}