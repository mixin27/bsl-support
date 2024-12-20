import 'package:bsl_support/src/features/live_sport/domain/live_sport_model.dart';
import 'package:bsl_support/src/routes/app_router.dart';
import 'package:bsl_support/src/shared/utils/extensions/flutter_extensions.dart';
import 'package:bsl_support/src/shared/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveSportView extends ConsumerWidget {
  const LiveSportView({super.key, required this.item});

  final LiveSportModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item.data.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
            "No ${item.sportName} match streams found",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: item.data.length,
      itemBuilder: (context, index) {
        final itemData = item.data[index];
        final title = "${itemData.teamOne} - ${itemData.teamTwo}";
        final date = Format.format(DateTime.parse(itemData.startTime));

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
                child: Text(
                  title,
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
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16.0),
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
                        itemData.m3u8Source,
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
                        await Clipboard.setData(
                          ClipboardData(text: itemData.m3u8Source),
                        );
                      },
                      iconSize: 18,
                      style: IconButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withValues(alpha: 0.3)),
                      icon: const Icon(Icons.copy_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.videoPlayer.name,
                      queryParameters: {"url": itemData.m3u8Source},
                    );
                  },
                  label: const Text("Play"),
                  icon: const Icon(Icons.play_circle_outline),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
