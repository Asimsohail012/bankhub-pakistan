import 'package:flutter/material.dart';

import '../widgets/section_header.dart';
import '../widgets/pro_dashboard_card.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _queryController = TextEditingController();
  final List<Map<String, String>> _conversation = [];
  bool _isProcessing = false;

  void _sendQuery() {
    final query = _queryController.text.trim();
    if (query.isEmpty || _isProcessing) return;

    setState(() {
      _conversation.add({'role': 'user', 'message': query});
      _isProcessing = true;
      _queryController.clear();
    });

    Future.delayed(const Duration(milliseconds: 450), () {
      final response = _generateResponse(query);
      setState(() {
        _conversation.add({'role': 'assistant', 'message': response});
        _isProcessing = false;
      });
    });
  }

  String _generateResponse(String query) {
    final normalized = query.toLowerCase();
    if (normalized.contains('best bank') || normalized.contains('top bank')) {
      return 'I recommend a digital-first bank with strong savings yields and excellent customer service for fast account opening.';
    }
    if (normalized.contains('exchange') || normalized.contains('currency')) {
      return 'Exchange rates remain stable. Compare PKR rates across major banks before converting large amounts.';
    }
    if (normalized.contains('credit card') || normalized.contains('reward')) {
      return 'Use a premium cashback card for grocery and utility spending, then pay it off monthly to maximize rewards.';
    }
    if (normalized.contains('islamic') || normalized.contains('shariah')) {
      return 'Islamic banking offers competitive profit-sharing plans; choose a bank with transparent wakala or mudarabah terms.';
    }
    return 'The premium assistant suggests reviewing your savings and rewards profile, then selecting a bank with the best digital onboarding and rate structure.';
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Banking Assistant'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const SectionHeader(
            title: 'Smart Banking Assistant',
            subtitle: 'Ask instant questions about banks, cards, rates, and premium services.',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.shade900.withValues(alpha: 0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your virtual banking advisor for Pakistan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Get customized insights for account selection, exchange trends, rewards cards, and regulatory news.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _queryController,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _sendQuery(),
            decoration: InputDecoration(
              hintText: 'Try: Which bank has the best savings account?',
              suffixIcon: IconButton(
                icon: _isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                onPressed: _sendQuery,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick prompts',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildActionChip('Best bank for savings'),
              _buildActionChip('Islamic banking advice'),
              _buildActionChip('Credit card rewards'),
              _buildActionChip('Latest SBP alert'),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Assistant chat',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ..._conversation.map((message) {
            final isUser = message['role'] == 'user';
            return Container(
              margin: EdgeInsets.only(bottom: 14, left: isUser ? 60 : 0, right: isUser ? 0 : 60),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? Colors.indigo.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                message['message']!,
                style: TextStyle(
                  color: isUser ? Colors.indigo.shade900 : Colors.black87,
                ),
              ),
            );
          }),
          if (_conversation.isEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'Start with a question and the premium assistant will provide actionable banking guidance.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Suggested strategies',
            subtitle: 'AI-driven recommendations for your banking goals.',
          ),
          const SizedBox(height: 16),
          ProDashboardCard(
            title: 'Savings Optimization',
            subtitle: 'Match your goals to high-yield accounts and digital savings plans.',
            icon: Icons.savings,
            color: Colors.green,
            onTap: () {},
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Bank Match',
            subtitle: 'Find the top bank based on your profile and product needs.',
            icon: Icons.account_balance_wallet,
            color: Colors.indigo,
            onTap: () {},
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Risk Alert',
            subtitle: 'Watch SBP notifications and currency drift for smarter timing.',
            icon: Icons.warning_amber,
            color: Colors.orange,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label) {
    return ActionChip(
      label: Text(label),
      backgroundColor: Colors.indigo.shade50,
      labelStyle: TextStyle(color: Colors.indigo.shade900),
      onPressed: () {
        _queryController.text = label;
        _sendQuery();
      },
    );
  }
}
