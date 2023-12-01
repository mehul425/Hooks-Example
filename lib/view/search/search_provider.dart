import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchList extends _$SearchList {
  @override
  FutureOr<List<String>> build() async {
    return [];
  }

  getNewData({required String query}) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 3));
    state = AsyncData(generateRandomStrings(query));
  }
}

List<String> generateRandomStrings(String query) {
  final Random random = Random();
  final List<String> characters = 'abcdefghijklmnopqrstuvwxyz'.split('');
  final List<String> result = [];

  for (int i = 0; i < 20; i++) {
    String randomString = query;
    for (int j = 0; j < 5; j++) {
      final int randomIndex = random.nextInt(characters.length);
      randomString += characters[randomIndex];
    }
    result.add(randomString);
  }

  return result;
}
