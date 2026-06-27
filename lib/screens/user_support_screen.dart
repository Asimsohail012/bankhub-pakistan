import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';

class UserSupportScreen extends StatefulWidget {
  const UserSupportScreen({super.key});

  @override
  State<UserSupportScreen> createState() => _UserSupportScreenState();
}

class _UserSupportScreenState extends State<UserSupportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support & Feedback'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.bug_report), text: 'Report Issue'),
            Tab(icon: Icon(Icons.comment), text: 'Feedback'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Feature'),
            Tab(icon: Icon(Icons.share), text: 'Share'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ReportIssueTab(),
          _FeedbackTab(),
          _FeatureRequestTab(),
          _ShareAppTab(),
        ],
      ),
    );
  }
}

class _ReportIssueTab extends StatefulWidget {
  const _ReportIssueTab();

  @override
  State<_ReportIssueTab> createState() => _ReportIssueTabState();
}

class _ReportIssueTabState extends State<_ReportIssueTab> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Bug';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thank you! We\'ll investigate this issue.')),
        );
        _titleController.clear();
        _descriptionController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Report an Issue',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Help us improve by reporting bugs and issues you encounter',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          initialValue: _selectedCategory,
          items: ['Bug', 'Crash', 'Performance', 'Data', 'Other']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: _isSubmitting ? null : (value) => setState(() => _selectedCategory = value ?? 'Bug'),
          decoration: InputDecoration(
            labelText: 'Issue Category',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _titleController,
          enabled: !_isSubmitting,
          decoration: InputDecoration(
            labelText: 'Issue Title',
            hintText: 'Brief title of the issue',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          enabled: !_isSubmitting,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Describe the issue in detail',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitReport,
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit Report'),
        ),
      ],
    );
  }
}

class _FeedbackTab extends StatefulWidget {
  const _FeedbackTab();

  @override
  State<_FeedbackTab> createState() => _FeedbackTabState();
}

class _FeedbackTabState extends State<_FeedbackTab> {
  final _feedbackController = TextEditingController();
  int _rating = 5;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your feedback')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thank you for your feedback!')),
        );
        _feedbackController.clear();
        _rating = 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Send Feedback',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Share your thoughts and suggestions to help us improve',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'How satisfied are you with BankHub Pakistan?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: _isSubmitting ? null : () => setState(() => _rating = index + 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.star,
                  size: 32,
                  color: index < _rating ? Colors.amber : Colors.grey[300],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _feedbackController,
          enabled: !_isSubmitting,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Your Feedback',
            hintText: 'Tell us what you think',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitFeedback,
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit Feedback'),
        ),
      ],
    );
  }
}

class _FeatureRequestTab extends StatefulWidget {
  const _FeatureRequestTab();

  @override
  State<_FeatureRequestTab> createState() => _FeatureRequestTabState();
}

class _FeatureRequestTabState extends State<_FeatureRequestTab> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitFeatureRequest() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thank you! We\'ll consider this feature.')),
        );
        _titleController.clear();
        _descriptionController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Request a Feature',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Suggest new features or improvements you\'d like to see',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _titleController,
          enabled: !_isSubmitting,
          decoration: InputDecoration(
            labelText: 'Feature Title',
            hintText: 'Brief title of the feature',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          enabled: !_isSubmitting,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Describe how this feature would help you',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitFeatureRequest,
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit Feature Request'),
        ),
      ],
    );
  }
}

class _ShareAppTab extends StatelessWidget {
  const _ShareAppTab();

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shareMessage = 'Check out BankHub Pakistan - Your complete guide to Pakistani banking!\n\n'
        'Browse all major banks, compare services, get live market data, '
        'and access advanced financial tools.\n\n'
        'Download now from the App Store and Google Play!';

    final reviewMessage = 'BankHub Pakistan Review: ⭐⭐⭐⭐⭐\n\n'
        'An amazing banking information app that makes it easy to find and compare '
        'Pakistani banks, access live market data, and get financial insights.\n\n'
        'Highly recommended!';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Share BankHub Pakistan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Love BankHub Pakistan? Share it with your friends and family!',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(Icons.favorite, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                'Help us grow!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share with your network',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => _copyToClipboard(context, shareMessage),
          icon: const Icon(Icons.content_copy),
          label: const Text('Copy Share Message'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => _copyToClipboard(context, reviewMessage),
          icon: const Icon(Icons.message),
          label: const Text('Copy Review Message'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Download Links',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                _DownloadLink(
                  label: 'Google Play Store',
                  url: 'https://play.google.com/store/apps',
                  onCopy: () => _copyToClipboard(context, 'https://play.google.com/store/apps'),
                ),
                const SizedBox(height: 8),
                _DownloadLink(
                  label: 'Apple App Store',
                  url: 'https://apps.apple.com',
                  onCopy: () => _copyToClipboard(context, 'https://apps.apple.com'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(
                      'Why Share?',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Help your friends find the right bank\n'
                  '• Support our mission to improve financial accessibility\n'
                  '• Get early access to new features\n'
                  '• Join our growing community of banking-savvy users',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DownloadLink extends StatelessWidget {
  final String label;
  final String url;
  final VoidCallback onCopy;

  const _DownloadLink({
    required this.label,
    required this.url,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                url,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.content_copy),
          onPressed: onCopy,
          tooltip: 'Copy link',
        ),
      ],
    );
  }
}
