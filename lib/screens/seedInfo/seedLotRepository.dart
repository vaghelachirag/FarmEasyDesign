// seed_lot_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'seed_lot_model.dart';

class SeedLotRepository {
  final String baseUrl = "https://farmeasy-m6p9.onrender.com/seed/lot";
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsInVzZXJuYW1lIjoibmV3VXNlcjJAbWFpbC5jb20iLCJpYXQiOjE3NTcwOTE0NzksImV4cCI6MTc1NzE3Nzg3OX0._7zyFavg5oaupA17EQjKqnOT-AvPnQNACpLPS_41u6A";

  Future<SeedLot> fetchSeedLot(String id) async {

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SeedLot.fromJson(data['data']);
    } else {
      throw Exception("Failed to load Seed Lot");
    }
  }
}
