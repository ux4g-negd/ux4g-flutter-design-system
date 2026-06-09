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
          PropRow(
            name: 'improvementOptions',
            type: 'List<String>',
            description: 'Chip choices for "what can we improve".',
            required: true,
          ),
          PropRow(
            name: 'onSubmit',
            type: 'Function(int, String, String)',
            description: 'Called with rating, selected chip, and comment.',
            required: true,
          ),
          PropRow(
            name: 'minWords',
            type: 'int',
            description: 'Minimum word count for comment.',
            defaultValue: '0',
          ),
          PropRow(
            name: 'maxLength',
            type: 'int',
            description: 'Max character length.',
            defaultValue: '200',
          ),
          PropRow(
            name: 'onSkip',
            type: 'VoidCallback?',
            description: 'Called when user skips.',
          ),
          PropRow(
            name: 'onCloseSuccess',
            type: 'VoidCallback?',
            description: 'Called when closing success screen.',
          ),
          PropRow(
            name: 'chipBorderRadius',
            type: 'double',
            description: 'Border radius of improvement chips.',
            defaultValue: '4.0',
          ),
          PropRow(
            name: 'title',
            type: 'String',
            description: 'Form heading.',
            defaultValue: '"Rate your experience"',
          ),
          PropRow(
            name: 'improvementTitle',
            type: 'String',
            description: 'Improvement section title.',
            defaultValue: '"What can we improve?"',
          ),
          PropRow(
            name: 'commentPlaceholder',
            type: 'String',
            description: 'Text area placeholder.',
            defaultValue: '"Tell us more..."',
          ),
          PropRow(
            name: 'submitButtonText',
            type: 'String',
            description: 'Submit button label.',
            defaultValue: '"Submit"',
          ),
          PropRow(
            name: 'skipButtonText',
            type: 'String',
            description: 'Skip button label.',
            defaultValue: '"Skip"',
          ),
          PropRow(
            name: 'successTitle',
            type: 'String',
            description: 'Title on success screen.',
            defaultValue: '"Feedback submitted"',
          ),
          PropRow(
            name: 'successMessage',
            type: 'String',
            description: 'Message on success screen.',
            defaultValue: '"Thank you..."',
          ),
          PropRow(
            name: 'titleStyle',
            type: 'TextStyle?',
            description: 'Style for main title.',
          ),
          PropRow(
            name: 'improvementTitleStyle',
            type: 'TextStyle?',
            description: 'Style for improvement title.',
          ),
          PropRow(
            name: 'successTitleStyle',
            type: 'TextStyle?',
            description: 'Style for success title.',
          ),
          PropRow(
            name: 'successMessageStyle',
            type: 'TextStyle?',
            description: 'Style for success message.',
          ),
          PropRow(
            name: 'ratingIcon',
            type: 'IconData',
            description: 'Icon used for rating stars.',
            defaultValue: 'Icons.star',
          ),
          PropRow(
            name: 'successIcon',
            type: 'IconData',
            description: 'Icon on success screen.',
            defaultValue: 'Icons.thumb_up',
          ),
          PropRow(
            name: 'activeRatingColor',
            type: 'Color?',
            description: 'Color of active stars.',
          ),
          PropRow(
            name: 'inactiveRatingColor',
            type: 'Color?',
            description: 'Color of inactive stars.',
          ),
          PropRow(
            name: 'successIconColor',
            type: 'Color?',
            description: 'Color of success icon.',
          ),
          PropRow(
            name: 'successBackgroundColor',
            type: 'Color?',
            description: 'Background of success screen.',
          ),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gFeedbackForm(
            improvementOptions: const [
              'App speed',
              'UI design',
              'Content quality',
              'Navigation',
            ],
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
          PropRow(
            name: 'onSubmit',
            type: 'Function(int, String)',
            description: 'Called with NPS score (0–10) and comment.',
            required: true,
          ),
          PropRow(
            name: 'minWords',
            type: 'int',
            description: 'Minimum word count for comment.',
            defaultValue: '0',
          ),
          PropRow(
            name: 'maxLength',
            type: 'int',
            description: 'Max character length.',
            defaultValue: '200',
          ),
          PropRow(
            name: 'onSkip',
            type: 'VoidCallback?',
            description: 'Called when user skips.',
          ),
          PropRow(
            name: 'onCloseSuccess',
            type: 'VoidCallback?',
            description: 'Called when closing success screen.',
          ),
          PropRow(
            name: 'title',
            type: 'String',
            description: 'Form heading.',
            defaultValue: '"How likely are you..."',
          ),
          PropRow(
            name: 'unlikelyLabel',
            type: 'String',
            description: 'Left scale label.',
            defaultValue: '"0 - Extremely Unlikely"',
          ),
          PropRow(
            name: 'likelyLabel',
            type: 'String',
            description: 'Right scale label.',
            defaultValue: '"10 - Extremely Likely"',
          ),
          PropRow(
            name: 'commentPlaceholder',
            type: 'String',
            description: 'Text area placeholder.',
            defaultValue: '"Please tell us why..."',
          ),
          PropRow(
            name: 'submitButtonText',
            type: 'String',
            description: 'Submit button label.',
            defaultValue: '"Submit"',
          ),
          PropRow(
            name: 'skipButtonText',
            type: 'String',
            description: 'Skip button label.',
            defaultValue: '"Skip"',
          ),
          PropRow(
            name: 'successTitle',
            type: 'String',
            description: 'Title on success screen.',
            defaultValue: '"Feedback submitted"',
          ),
          PropRow(
            name: 'successMessage',
            type: 'String',
            description: 'Message on success screen.',
            defaultValue: '"Thank you..."',
          ),
          PropRow(
            name: 'titleStyle',
            type: 'TextStyle?',
            description: 'Style for main title.',
          ),
          PropRow(
            name: 'successTitleStyle',
            type: 'TextStyle?',
            description: 'Style for success title.',
          ),
          PropRow(
            name: 'successMessageStyle',
            type: 'TextStyle?',
            description: 'Style for success message.',
          ),
          PropRow(
            name: 'successIcon',
            type: 'IconData',
            description: 'Icon on success screen.',
            defaultValue: 'Icons.thumb_up',
          ),
          PropRow(
            name: 'successIconColor',
            type: 'Color?',
            description: 'Color of success icon.',
          ),
          PropRow(
            name: 'successBackgroundColor',
            type: 'Color?',
            description: 'Background of success screen.',
          ),
          PropRow(
            name: 'selectedScoreBackgroundColor',
            type: 'Color?',
            description: 'Background color for selected score.',
          ),
          PropRow(
            name: 'selectedScoreTextColor',
            type: 'Color?',
            description: 'Text color for selected score.',
          ),
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
          PropRow(
            name: 'onSubmit',
            type: 'Function(int, String)',
            description: 'Called with CSAT score and comment.',
            required: true,
          ),
          PropRow(
            name: 'minWords',
            type: 'int',
            description: 'Minimum word count for comment.',
            defaultValue: '0',
          ),
          PropRow(
            name: 'maxLength',
            type: 'int',
            description: 'Max character length.',
            defaultValue: '200',
          ),
          PropRow(
            name: 'onSkip',
            type: 'VoidCallback?',
            description: 'Called when user skips.',
          ),
          PropRow(
            name: 'onCloseSuccess',
            type: 'VoidCallback?',
            description: 'Called when closing success screen.',
          ),
          PropRow(
            name: 'title',
            type: 'String',
            description: 'Form heading.',
            defaultValue: '"How do you feel..."',
          ),
          PropRow(
            name: 'badLabel',
            type: 'String',
            description: 'Left scale label.',
            defaultValue: '"← Bad"',
          ),
          PropRow(
            name: 'goodLabel',
            type: 'String',
            description: 'Right scale label.',
            defaultValue: '"Good →"',
          ),
          PropRow(
            name: 'commentPlaceholder',
            type: 'String',
            description: 'Text area placeholder.',
            defaultValue: '"Please tell us how..."',
          ),
          PropRow(
            name: 'submitButtonText',
            type: 'String',
            description: 'Submit button label.',
            defaultValue: '"Submit"',
          ),
          PropRow(
            name: 'skipButtonText',
            type: 'String',
            description: 'Skip button label.',
            defaultValue: '"Skip"',
          ),
          PropRow(
            name: 'successTitle',
            type: 'String',
            description: 'Title on success screen.',
            defaultValue: '"Feedback submitted"',
          ),
          PropRow(
            name: 'successMessage',
            type: 'String',
            description: 'Message on success screen.',
            defaultValue: '"Thank you..."',
          ),
          PropRow(
            name: 'ratingIcons',
            type: 'List<IconData>',
            description: 'Icons for CSAT levels.',
            defaultValue: 'Sentiment icons',
          ),
          PropRow(
            name: 'titleStyle',
            type: 'TextStyle?',
            description: 'Style for main title.',
          ),
          PropRow(
            name: 'successTitleStyle',
            type: 'TextStyle?',
            description: 'Style for success title.',
          ),
          PropRow(
            name: 'successMessageStyle',
            type: 'TextStyle?',
            description: 'Style for success message.',
          ),
          PropRow(
            name: 'successIcon',
            type: 'IconData',
            description: 'Icon on success screen.',
            defaultValue: 'Icons.thumb_up',
          ),
          PropRow(
            name: 'successIconColor',
            type: 'Color?',
            description: 'Color of success icon.',
          ),
          PropRow(
            name: 'successBackgroundColor',
            type: 'Color?',
            description: 'Background of success screen.',
          ),
          PropRow(
            name: 'selectedScoreBackgroundColor',
            type: 'Color?',
            description: 'Background color for selected score.',
          ),
          PropRow(
            name: 'selectedScoreIconColor',
            type: 'Color?',
            description: 'Icon color for selected score.',
          ),
          PropRow(
            name: 'unselectedScoreBackgroundColor',
            type: 'Color?',
            description: 'Background color for unselected scores.',
          ),
          PropRow(
            name: 'unselectedScoreIconColor',
            type: 'Color?',
            description: 'Icon color for unselected scores.',
          ),
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
