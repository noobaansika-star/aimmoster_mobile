import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/xp_service.dart';
import '../utils/colors.dart';
import '../widgets/xp_card.dart';
import '../widgets/glow_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("🐺 "),
            Text(
              "AIMMonster",
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.neonCyan,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<XPService>(
          builder: (context, xpService, _) {
            if (!xpService.isLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final progress = xpService.userProgress;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonCyan.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "${xpService.getLevelEmoji()} Level ${progress.level}",
                        style: GoogleFonts.roboto(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonCyan,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        progress.getLevelName(),
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress.totalXP / 700,
                          minHeight: 10,
                          backgroundColor: Colors.grey[800],
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.neonCyan,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${progress.totalXP} / 700 XP",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "🔥 Current Streak",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Day ${progress.streak}",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Quick Start",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GlowButton(
                  text: "Practice Session",
                  onPressed: () {
                    xpService.addPracticeXP();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added 10 XP! 🎯")),
                    );
                  },
                ),
                const SizedBox(height: 10),
                GlowButton(
                  text: "Reaction Test",
                  color: AppColors.purple,
                  onPressed: () {
                    xpService.addReactionTestXP();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added 15 XP! ⚡")),
                    );
                  },
                ),
                const SizedBox(height: 30),
                XPCard(
                  title: "Achievements",
                  value: "${progress.achievements.length}",
                  icon: "🏆",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
