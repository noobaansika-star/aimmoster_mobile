import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/xp_service.dart';
import '../utils/colors.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Challenges 🏁",
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
          children: [
            _ChallengeCard(
              title: "Accuracy Master",
              description: "Hit 90%+ accuracy in practice",
              progress: 0.75,
              reward: "+50 XP",
              isCompleted: false,
              onComplete: () {
                context.read<XPService>().addChallengeXP();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Challenge Completed! +50 XP")),
                );
              },
            ),
            const SizedBox(height: 16),
            _ChallengeCard(
              title: "Speed Demon",
              description: "Complete 10 reaction tests",
              progress: 1.0,
              reward: "+50 XP",
              isCompleted: true,
              onComplete: () {},
            ),
            const SizedBox(height: 16),
            _ChallengeCard(
              title: "Consistency King",
              description: "Maintain 7-day streak",
              progress: 0.57,
              reward: "+100 XP",
              isCompleted: false,
              onComplete: () {
                context.read<XPService>().addXP(100);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final String reward;
  final bool isCompleted;
  final VoidCallback onComplete;

  const _ChallengeCard({
    required this.title,
    required this.description,
    required this.progress,
    required this.reward,
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? AppColors.gold : AppColors.neonCyan.withOpacity(0.3),
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
                isCompleted ? "✅ $title" : "🎯 $title",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                reward,
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
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation(
                isCompleted ? AppColors.gold : AppColors.neonCyan,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCompleted ? null : onComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCompleted ? Colors.grey : AppColors.neonCyan,
              ),
              child: Text(
                isCompleted ? "Completed" : "Complete Challenge",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
