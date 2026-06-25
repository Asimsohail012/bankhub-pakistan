import 'package:flutter/material.dart';

import '../data/ai_insights_data.dart';
import '../models/ai_insight.dart';
import '../widgets/section_header.dart';

class PremiumAnalyticsScreen extends StatelessWidget {
  const PremiumAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Analytics'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const SectionHeader(
            title: 'Premium Analytics',
            subtitle: 'Personal finance insights and premium banking scorecards.',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Insights overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'Track performance across savings, rewards, banking products, and currency outlook.',
                  style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: aiInsights.map((insight) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width < 760 ? 1 : 2) - 24,
                child: _AnalyticsCard(insight: insight),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Banking pulse',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _PulseTile(
            label: 'SBP Policy Review',
            value: 'Next announcement expected next week. Expect a stable outlook with mild rate support.',
          ),
          const SizedBox(height: 12),
          _PulseTile(
            label: 'FX Monitor',
            value: 'PKR is consolidating. Watch rate windows for low-cost currency conversions.',
          ),
          const SizedBox(height: 12),
          _PulseTile(
            label: 'Digital Adoption',
            value: 'Mobile and digital account opening activity is up 14% month-over-month.',
          ),
        ],
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final AiInsight insight;

  const _AnalyticsCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insight.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              insight.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              insight.detail,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              insight.trend,
              style: const TextStyle(
                color: Color(0xFF34D399),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulseTile extends StatelessWidget {
  final String label;
  final String value;

  const _PulseTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(color: Colors.grey.shade700, height: 1.5),
          ),
        ],
      ),
    );
  }
}
