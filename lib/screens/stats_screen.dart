import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/xp_service.dart';
import '../utils/colors.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stats 📊",
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
        child: Consumer<XPService>(
          builder: (context, xpService, _) {
            final progress = xpService.userProgress;

            return Column(
              children: [
                _StatCard(
                  title: "Total XP",
                  value: progress.totalXP.toString(),
                  icon: "⭐",
                  color: AppColors.gold,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: "Current Level",
                  value: progress.level.toString(),
                  icon: xpService.getLevelEmoji(),
                  color: AppColors.neonCyan,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: "Current Streak",
                  value: "${progress.streak} days",
                  icon: "🔥",
                  color: AppColors.red,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: "Achievements",
                  value: progress.achievements.length.toString(),
                  icon: "🏆",
                  color: AppColors.purple,
                ),
                const SizedBox(height: 30),
                Text(
                  "Level Breakdown",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _LevelBreakdown(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(icon, style: const TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}

class _LevelBreakdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LevelTier(
          name: "🥉 Bronze",
          range: "0 - 100 XP",
          color: const Color(0xFFCD7F32),
        ),
        const SizedBox(height: 12),
        _LevelTier(
          name: "🥈 Silver",
          range: "100 - 300 XP",
          color: const Color(0xFFC0C0C0),
        ),
        const SizedBox(height: 12),
        _LevelTier(
          name: "🥇 Gold",
          range: "300 - 700 XP",
          color: AppColors.gold,
        ),
        const SizedBox(height: 12),
        _LevelTier(
          name: "👑 Heroic",
          range: "700+ XP",
          color: AppColors.purple,
        ),
      ],
    );
  }
}

class _LevelTier extends StatelessWidget {
  final String name;
  final String range;
  final Color color;

  const _LevelTier({
    required this.name,
    required this.range,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            range,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
