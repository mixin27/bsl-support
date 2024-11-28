import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';
import 'package:bsl_support/src/features/live_sport/presentation/live_sport_view.dart';
import 'package:bsl_support/src/features/live_sport/presentation/live_sport_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveSportScreen extends ConsumerWidget {
  const LiveSportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getLiveSportsProvider);

    final isLoading =
        state.isLoading || state.isRefreshing || state.isReloading;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : state.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text("No data available"),
                  );
                }

                return LiveSportContent(data: data);
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
                        ref.invalidate(getLiveSportsProvider);
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

class LiveSportContent extends StatefulWidget {
  const LiveSportContent({super.key, required this.data});

  final List<LiveSportModel> data;

  @override
  State<LiveSportContent> createState() => _LiveSportContentState();
}

class _LiveSportContentState extends State<LiveSportContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: widget.data.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Sport API"),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.invalidate(getLiveSportsProvider);
                },
                icon: const Icon(Icons.refresh_outlined),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: List.generate(widget.data.length, (index) {
            final item = widget.data[index];
            return Tab(
              key: ValueKey('${item.sportId}-${item.sportName}'),
              text: item.sportName,
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          widget.data.length,
          (index) => LiveSportView(item: widget.data[index]),
        ),
      ),
    );
  }
}
