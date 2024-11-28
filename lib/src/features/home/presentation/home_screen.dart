// import 'package:bsl_support/src/features/football_live/presentation/football_live_view.dart';
// import 'package:bsl_support/src/features/live_sport/presentation/live_sport_screen.dart';
// import 'package:bsl_support/src/features/live_sport/presentation/live_sport_view.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(
//               icon: Icon(Icons.sports_soccer_outlined),
//               text: "Football Live",
//             ),
//             Tab(
//               icon: Icon(Icons.sports_soccer_outlined),
//               text: "Live Sport",
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           FootballLiveView(),
//           // LiveSportScreen(),
//         ],
//       ),
//     );
//   }
// }
