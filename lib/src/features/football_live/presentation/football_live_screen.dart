import 'package:bsl_support/src/features/football_live/domain/football_live_model.dart';
import 'package:bsl_support/src/features/football_live/presentation/football_live_controller.dart';
import 'package:bsl_support/src/shared/utils/extensions/flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FootballLiveScreen extends ConsumerWidget {
  const FootballLiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllFootballLiveProvider);

    final isLoading =
        state.isLoading || state.isRefreshing || state.isReloading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Live API'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(getAllFootballLiveProvider);
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : state.when(
              data: (data) {
                if (data.result.isEmpty) {
                  return const Center(
                    child: Text("No data available"),
                  );
                }

                return FootballLiveContent(items: data.result);
              },
              error: (err, st) => Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      child: Icon(
                        Icons.sports_outlined,
                        size: 35,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      err.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    FilledButton(
                      onPressed: () {
                        ref.invalidate(getAllFootballLiveProvider);
                      },
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}

class FootballLiveContent extends StatelessWidget {
  const FootballLiveContent({super.key, required this.items});

  final List<FootballLiveData> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return FootballLiveListItem(item: item);
      },
    );
  }
}

class FootballLiveListItem extends ConsumerStatefulWidget {
  const FootballLiveListItem({
    super.key,
    required this.item,
  });

  final FootballLiveData item;

  @override
  ConsumerState<FootballLiveListItem> createState() =>
      _FootballLiveListItemState();
}

class _FootballLiveListItemState extends ConsumerState<FootballLiveListItem> {
  String _url = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final title = '${widget.item.homeName} - ${widget.item.awayName}';

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.red.shade100,
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(widget.item.homeFlag),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${widget.item.date} ${widget.item.time}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      FilledButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            final result = await ref
                                .read(getLinkControllerProvider.notifier)
                                .getLink(widget.item.id);
                            setState(() {
                              _url = result.url;
                            });
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Get link"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(widget.item.awayFlag),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          if (_url.isNotEmpty) ...[
            Container(
              width: context.screenWidth,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red.shade300,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _url,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () async {
                      if (_url.isEmpty) return;
                      await Clipboard.setData(
                        ClipboardData(text: _url),
                      );
                    },
                    iconSize: 18,
                    style: IconButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.3)),
                    icon: const Icon(Icons.copy_outlined),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
