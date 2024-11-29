import 'package:bsl_support/src/features/live_tv/presentation/live_tv_controller.dart';
import 'package:bsl_support/src/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveTvScreen extends ConsumerWidget {
  const LiveTvScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllLiveTvsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live TVs"),
      ),
      body: state.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Tvs found"),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final tv = data[index];
              return ListTile(
                onTap: () {
                  context.pushNamed(
                    AppRoute.videoPlayer.name,
                    queryParameters: {"url": tv.url},
                  );
                },
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  child: Center(
                    child: Text(
                      tv.title.characters.first,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ),
                title: Text(tv.title),
                subtitle: Text(tv.url),
                trailing: IconButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: tv.url),
                    );
                  },
                  icon: const Icon(Icons.copy_outlined),
                ),
              );
            },
          );
        },
        error: (err, st) => Center(
          child: Text(err.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
