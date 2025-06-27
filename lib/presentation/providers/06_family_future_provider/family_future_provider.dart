import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
part 'family_future_provider.g.dart';

@Riverpod(keepAlive: true)
Future<String> pokemon (Ref ref, int pokemonId) async{
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  return pokemonName;
}