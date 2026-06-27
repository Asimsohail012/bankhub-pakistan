import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/section_header.dart';
import '../widgets/error_dialog.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final List<_Notification> notifications = [
    _Notification(
      id: 'notif_1',
      title: 'KIBOR Rate Updated',
      message: '1M KIBOR increased to 16.25%',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: 'market',
      icon: Icons.trending_up,
      color: Colors.red,
      read: false,
    ),
    _Notification(
      id: 'notif_2',
      title: 'Gold Price Alert',
      message: 'Gold price reached PKR 300,000 per 10g',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: 'price',
      icon: Icons.workspace_premium,
      color: AppColors.gold,
      read: false,
    ),
    _Notification(
      id: 'notif_3',
      title: 'New Banking Product',
      message: 'HBL launched new savings account with 8.5% profit rate',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      type: 'product',
      icon: Icons.card_membership,
      color: AppColors.blue,
      read: true,
    ),
    _Notification(
      id: 'notif_4',
      title: 'Exchange Rate Change',
      message: 'USD/PKR dropped to 278.5',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: 'market',
      icon: Icons.currency_exchange,
      color: Colors.green,
      read: true,
    ),
  ];

  void _markAsRead(String id) {
    setState(() {
      final idx = notifications.indexWhere((n) => n.id == id);
      if (idx != -1) {
        notifications[idx] = notifications[idx].copyWith(read: true);
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      notifications.replaceRange(0, notifications.length, 
        notifications.map((n) => n.copyWith(read: true))
      );
    });
  }

  void _clearNotifications() {
    setState(() => notifications.clear());
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n.read).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Center'),
        elevation: 0,
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark All Read'),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionHeader(
                      title: 'Notifications',
                      subtitle: 'You have $unreadCount new notifications',
                    ),
                    if (notifications.isNotEmpty)
                      Semantics(
                        button: true,
                        label: 'Clear all notifications',
                        enabled: true,
                        onTap: _clearNotifications,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _clearNotifications,
                            borderRadius: BorderRadius.circular(12),
                            child: Tooltip(
                              message: 'Clear all notifications',
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                ...notifications.map((notif) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _NotificationTile(
                      notification: notif,
                      onTap: () => _markAsRead(notif.id),
                    ),
                  );
                }),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      icon: Icons.notifications_none_rounded,
      title: 'No notifications',
      subtitle: 'Stay tuned for banking updates',
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final _Notification notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: notification.read ? Colors.white : notification.color.withValues(alpha: 0.08),
            border: Border.all(
              color: notification.read ? Colors.grey.shade200 : notification.color.withValues(alpha: 0.24),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: notification.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(notification.icon, color: notification.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!notification.read)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: notification.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatTime(notification.timestamp),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}

class _Notification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final String type;
  final IconData icon;
  final Color color;
  final bool read;

  _Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.icon,
    required this.color,
    required this.read,
  });

  _Notification copyWith({bool? read}) {
    return _Notification(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      type: type,
      icon: icon,
      color: color,
      read: read ?? this.read,
    );
  }
}
