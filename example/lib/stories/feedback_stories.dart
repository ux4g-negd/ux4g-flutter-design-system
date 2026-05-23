import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Feedback Form (Star Rating) ───────────────────────────────────────────────

final feedbackFormComponent = WidgetbookComponent(
  name: 'Ux4gFeedbackForm',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gFeedbackForm',
        description:
            'A star-rating feedback form with improvement chip options and a comment text area. '
            'Shows a success state after submission.',
        code: '''Ux4gFeedbackForm(
  improvementOptions: [
    'App speed',
    'UI design',
    'Content quality',
    'Navigation',
  ],
  onSubmit: (rating, chip, comment) {
    print('Rating: \$rating, Issue: \$chip, Comment: \$comment');
  },
  onSkip: () {},
);''',
        props: const [
          PropRow(name: 'improvementOptions', type: 'List<String>', description: 'Chip choices for "what can we improve".', required: true),
          PropRow(name: 'onSubmit', type: 'Function(int, String, String)', description: 'Called with rating, selected chip, and comment.', required: true),
          PropRow(name: 'minWords', type: 'int', description: 'Minimum word count for comment.', defaultValue: '0'),
          PropRow(name: 'maxLength', type: 'int', description: 'Max character length.', defaultValue: '200'),
          PropRow(name: 'title', type: 'String', description: 'Form heading.', defaultValue: '"Rate your experience"'),
          PropRow(name: 'onSkip', type: 'VoidCallback?', description: 'Called when user skips.'),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gFeedbackForm(
            improvementOptions: const ['App speed', 'UI design', 'Content quality', 'Navigation'],
            onSubmit: (rating, chip, comment) {},
            onSkip: () {},
          ),
        ),
      ),
    ),
  ],
);

// ── Feedback Form NPS ─────────────────────────────────────────────────────────

final feedbackFormNpsComponent = WidgetbookComponent(
  name: 'Ux4gFeedbackFormNps',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gFeedbackFormNps',
        description:
            'A Net Promoter Score (NPS) feedback form. User selects a score 0–10 '
            'and optionally provides a comment. Shows success state after submission.',
        code: '''Ux4gFeedbackFormNps(
  onSubmit: (score, comment) {
    print('NPS Score: \$score, Comment: \$comment');
  },
  onSkip: () {},
);''',
        props: const [
          PropRow(name: 'onSubmit', type: 'Function(int, String)', description: 'Called with NPS score (0–10) and comment.', required: true),
          PropRow(name: 'title', type: 'String', description: 'Form heading.', defaultValue: '"How likely are you to recommend us?"'),
          PropRow(name: 'unlikelyLabel', type: 'String', description: 'Left scale label.', defaultValue: '"0 - Extremely Unlikely"'),
          PropRow(name: 'likelyLabel', type: 'String', description: 'Right scale label.', defaultValue: '"10 - Extremely Likely"'),
          PropRow(name: 'onSkip', type: 'VoidCallback?', description: 'Called when user skips.'),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gFeedbackFormNps(
            onSubmit: (score, comment) {},
            onSkip: () {},
          ),
        ),
      ),
    ),
  ],
);

// ── Feedback Form CSAT ────────────────────────────────────────────────────────

final feedbackFormCsatComponent = WidgetbookComponent(
  name: 'Ux4gFeedbackFormCsat',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gFeedbackFormCsat',
        description:
            'A Customer Satisfaction (CSAT) feedback form with emoji-based satisfaction levels '
            'and an optional comment field.',
        code: '''Ux4gFeedbackFormCsat(
  onSubmit: (score, comment) {
    print('CSAT Score: \$score, Comment: \$comment');
  },
  onSkip: () {},
);''',
        props: const [
          PropRow(name: 'onSubmit', type: 'Function(int, String)', description: 'Called with CSAT score and comment.', required: true),
          PropRow(name: 'onSkip', type: 'VoidCallback?', description: 'Called when user skips.'),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gFeedbackFormCsat(
            onSubmit: (score, comment) {},
            onSkip: () {},
          ),
        ),
      ),
    ),
  ],
);
