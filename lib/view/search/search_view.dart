import 'package:flutter/material.dart';
import 'package:hooks_exapmle/hooks/debounced_text_controller.dart';
import 'package:hooks_exapmle/view/search/search_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = useDebouncedTextController((value) {
      ref.read(searchListProvider.notifier).getNewData(query: value);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search with hooks"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Type Here...",
            ),
          ),
          Expanded(
            child: ref.watch(searchListProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        child: const Text("Empty Data"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              data[index],
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) => Container(
                    alignment: Alignment.center,
                    child: Text(error.toString()),
                  ),
                  loading: () => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
