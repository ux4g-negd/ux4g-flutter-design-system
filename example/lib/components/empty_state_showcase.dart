import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class EmptyStateShowcase extends StatelessWidget {
  const EmptyStateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Preset variants ──────────────────────────────────────────────
        Text(
          'Empty State',
          style: typography.tS_strong.copyWith(color: colors.onBackground),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // No results found
            _card(
              colors,
              Ux4gEmptyState(
                variant: Ux4gEmptyStateVariant.noResults,
                title: 'No results found',
                subtitle: 'Did you mean:',
                description: 'Driving License, Ration Card',
                buttonText: 'Clear all filters',
                onButtonPressed: () {},
              ),
              width: double.infinity,
            ),

            const SizedBox(height: 16),

            // No active applications
            _card(
              colors,
              Ux4gEmptyState(
                variant: Ux4gEmptyStateVariant.noData,
                title: 'No active applications',
                subtitle: 'Start your application easily',
                description: 'by clicking on the button below.',
                buttonText: 'Start application',
                onButtonPressed: () {},
              ),
              width: double.infinity,
            ),

            const SizedBox(height: 16),

            // Coming soon
            _card(
              colors,
              Ux4gEmptyState(
                variant: Ux4gEmptyStateVariant.comingSoon,
                title: 'Coming soon',
                subtitle: 'This feature is under development.',
                buttonText: 'Go Back',
                onButtonPressed: () {},
              ),
              width: double.infinity,
            ),

            const SizedBox(height: 16),

            // Could not load data
            _card(
              colors,
              Ux4gEmptyState(
                variant: Ux4gEmptyStateVariant.error,
                title: 'Could not load data',
                subtitle: 'Last updated: 4 minutes ago',
                buttonText: 'Refresh',
                onButtonPressed: () {},
              ),
              width: double.infinity,
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ── Custom variant ───────────────────────────────────────────────
        Text(
          'Empty State — Custom',
          style: typography.tS_strong.copyWith(color: colors.onBackground),
        ),
        const SizedBox(height: 12),
        _card(
          colors,
          Ux4gEmptyState(
            variant: Ux4gEmptyStateVariant.custom,
            icon: Icons.lock_outline_rounded,
            iconColor: Ux4gPalette.secondary,
            title: 'Access restricted',
            subtitle: 'You do not have permission to view this content.',
            description: 'Please contact your administrator.',
            buttonText: 'Request access',
            onButtonPressed: () {},
          ),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _card(Ux4gColors colors, Widget child, {double? width}) {
    return Container(
      width: width ?? 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.12),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
