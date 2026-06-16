import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/xp_service.dart';
import '../utils/colors.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Training 💪",
          style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TrainingCard(
              title: "Reaction Test",
              description: "Test your reflexes",
              xp: "+15 XP",
              icon: "⚡",
              onPressed: () {
                context.read<XPService>().addReactionTestXP();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added 15 XP!")),
                );
              },
            ),
            const SizedBox(height: 16),
            _TrainingCard(
              title: "Headshot Training",
              description: "Improve accuracy",
              xp: "+25 XP",
              icon: "🎯",
              onPressed: () {
                context.read<XPService>().addAccuracyXP();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added 25 XP!")),
                );
              },
            ),
            const SizedBox(height: 16),
            _TrainingCard(
              title: "Recoil Training",
              description: "Control spray patterns",
              xp: "+20 XP",
              icon: "🔫",
              onPressed: () {
                context.read<XPService>().addXP(20);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added 20 XP!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final String title;
  final String description;
  final String xp;
  final String icon;
  final VoidCallback onPressed;

  const _TrainingCard({
    required this.title,
    required this.description,
    required this.xp,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.3),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$icon $title",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                xp,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonCyan,
                foregroundColor: AppColors.background,
              ),
              child: Text(
                "Start Training",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
