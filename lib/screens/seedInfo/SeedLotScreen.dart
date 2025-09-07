// main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'seed_lot_provider.dart';

class SeedLotScreen extends ConsumerWidget {
  const SeedLotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 👇 pass your lotId here
    final lotId = "588cda70-2843-487a-bc30-f91c4f30a3e8";
    final seedLotAsync = ref.watch(seedLotProvider(lotId));

    return Scaffold(
      appBar: AppBar(title: const Text("Seed Lot Info")),
      body: seedLotAsync.when(
        data: (lot) {
          if (lot == null) {
            return const Center(child: Text("No data found"));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lot Code: ${lot.lotCode}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Received Date: ${lot.receivedDate}"),
                const Divider(),
                Text("Seed Name: ${lot.seed?.name}"),
                Text("Scientific Name: ${lot.seed?.scientificName}"),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
