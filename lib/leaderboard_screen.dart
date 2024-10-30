import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    future = _getLeaderboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading leaderboard'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Data is available
            List<Map<String, dynamic>> leaderboard = snapshot.data!;

            return ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange[300],
                    child: Text(
                      leaderboard[index]["name"][0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    leaderboard[index]["name"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                    ),
                  ),
                  trailing: Text(
                    "${leaderboard[index]["score"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.orangeAccent,
                    ),
                  ),
                );
              },
            );
          } else {
            // If no data or empty leaderboard
            return const Center(child: Text('No leaderboard data available.'));
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    String? leaderboardJson = prefs.getString('leaderboard');
    if (leaderboardJson != null) {
      List<Map<String, dynamic>> leaderboard =
          List<Map<String, dynamic>>.from(jsonDecode(leaderboardJson));
      leaderboard.sort((a, b) => b['score'].compareTo(a['score']));
      return leaderboard;
    }
    return [];
  }
}
