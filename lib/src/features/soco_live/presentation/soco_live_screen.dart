import 'package:bsl_support/src/features/soco_live/domain/soco_live_model.dart';
import 'package:bsl_support/src/features/soco_live/presentation/soco_live_controller.dart';
import 'package:bsl_support/src/routes/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SocoLiveScreen extends ConsumerWidget {
  const SocoLiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getSocoLiveMatchesProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Soco Lives'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(getSocoLiveMatchesProvider);
            },
            icon: state.isRefreshing
                ? const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(),
                  )
                : const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: state.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SocoLiveMatchListView(matches: data),
          );
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
                  ref.invalidate(getSocoLiveMatchesProvider);
                },
                child: const Text("Try again"),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class SocoLiveMatchListView extends StatelessWidget {
  const SocoLiveMatchListView({
    super.key,
    required this.matches,
  });

  final List<SocoLiveMatch> matches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: match.homeTeamLogo,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            match.leaguename,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.blue, fontSize: 18),
                          ),
                          Text(
                            match.homeTeamName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black87),
                          ),
                          Text(
                            match.matchStatus.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            match.awayTeamName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    CachedNetworkImage(
                      imageUrl: match.awayTeamLogo,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
                if (match.servers.isNotEmpty) ...[
                  const Divider(),
                  Column(
                    children: List.generate(
                      match.servers.length,
                      (index) {
                        final server = match.servers[index];

                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                              AppRoute.videoPlayer.name,
                              queryParameters: {"url": server.streamUrl},
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(server.name),
                                      Text(
                                        server.streamUrl,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: server.streamUrl),
                                  );
                                },
                                icon: const Icon(Icons.copy_outlined),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
