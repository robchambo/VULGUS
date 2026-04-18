import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../auth/auth_service.dart';
import '../notifications/notification_service.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    try {
      final granted = await Permission.notification.isGranted;
      if (mounted) setState(() => _notificationsEnabled = granted);
    } catch (_) {}
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() => _notificationsEnabled = value);
    try {
      if (value) {
        final granted = await Permission.notification.request();
        if (granted.isGranted) {
          await NotificationService.scheduleDailyReminder();
        } else {
          setState(() => _notificationsEnabled = false);
        }
      } else {
        await NotificationService.cancelReminder();
      }
    } catch (_) {
      setState(() => _notificationsEnabled = !value);
    }
  }

  Future<void> _signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
    } catch (_) {}
    if (mounted) setState(() {});
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const Text('Delete account?'),
        content: const Text(
          'Your stats and streak will be permanently deleted. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(authRepositoryProvider).deleteAccount();
    } catch (_) {}
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = ref.watch(authRepositoryProvider);
    final isAnon = authRepo.isAnonymous;
    final user = authRepo.currentUser;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const _BauhausAppBar(title: 'SETTINGS'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Account ────────────────────────────────────────────────
          const _SectionHeader('ACCOUNT'),
          _BauhausCard(
            child: isAnon
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Playing anonymously',
                        style: t.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to sync your streak across devices.',
                        style: t.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      _BauhausButton(
                        label: 'Sign in with Google',
                        onPressed: () async {
                          try {
                            await authRepo.signInWithGoogle();
                            if (mounted) setState(() {});
                          } catch (_) {}
                        },
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user?.displayName != null)
                        Text(user!.displayName!, style: t.titleMedium),
                      if (user?.email != null)
                        Text(user!.email!, style: t.bodyMedium),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _BauhausButton(
                              label: 'Sign out',
                              onPressed: _signOut,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _BauhausButton(
                              label: 'Delete account',
                              onPressed: _deleteAccount,
                              destructive: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 24),

          // ── Notifications ──────────────────────────────────────────
          const _SectionHeader('NOTIFICATIONS'),
          _BauhausCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily puzzle reminder', style: t.bodyLarge),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: _toggleNotifications,
                  activeThumbColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── About ──────────────────────────────────────────────────
          const _SectionHeader('ABOUT'),
          _BauhausCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AboutRow(
                  label: 'Version',
                  trailing: Text('VULGUS v0.1.0', style: t.bodyMedium),
                ),
                const _Divider(),
                _AboutTap(
                  label: 'Privacy Policy',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon')),
                  ),
                ),
                const _Divider(),
                _AboutTap(
                  label: 'Terms of Service',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon')),
                  ),
                ),
                const _Divider(),
                _AboutTap(
                  label: 'Licences',
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: 'VULGUS',
                    applicationVersion: '0.1.0',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Internal widgets ─────────────────────────────────────────────────────────

class _BauhausAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _BauhausAppBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back, color: AppColors.onSurface, size: 28),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
          ),
          const Spacer(),
          const SizedBox(width: 44), // balance the back button
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurface,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _BauhausCard extends StatelessWidget {
  final Widget child;
  const _BauhausCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: child,
    );
  }
}

class _BauhausButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool destructive;
  const _BauhausButton({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: destructive ? Colors.red : AppColors.onSurface,
        side: BorderSide(
          color: destructive ? Colors.red : AppColors.onSurface,
          width: 2,
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String label;
  final Widget trailing;
  const _AboutRow({required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          trailing,
        ],
      ),
    );
  }
}

class _AboutTap extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _AboutTap({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            const Icon(Icons.chevron_right, color: AppColors.onSurface),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.onSurface, height: 1, thickness: 1);
  }
}
