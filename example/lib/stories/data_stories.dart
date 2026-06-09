import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Stepper ───────────────────────────────────────────────────────────────────

final stepperComponent = WidgetbookComponent(
  name: 'Ux4gStepper',
  useCases: [
    WidgetbookUseCase(
      name: 'Horizontal',
      builder: (context) {
        int current = 1;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gStepper',
              description:
                  'A multi-step progress indicator for form wizards. '
                  'Supports horizontal and vertical orientations, solid or dashed lines.',
              code: '''Ux4gStepper(
  totalSteps: 4,
  currentStep: 1,
  orientation: StepperOrientation.horizontal,
  steps: const [
    Ux4gStepItem(title: 'Personal'),
    Ux4gStepItem(title: 'Address'),
    Ux4gStepItem(title: 'Documents'),
    Ux4gStepItem(title: 'Review'),
  ],
);

// Capsule variant with prev/next
Ux4gCapsuleStepper(
  totalSteps: 5,
  currentStep: 1,
  stepLabel: 'Step 2 of 5',
  onNext: () {},
  onPrevious: () {},
);''',
              props: const [
                PropRow(
                  name: 'totalSteps',
                  type: 'int',
                  description: 'Total number of steps.',
                  required: true,
                ),
                PropRow(
                  name: 'currentStep',
                  type: 'int',
                  description: 'Zero-based active step index.',
                  required: true,
                ),
                PropRow(
                  name: 'steps',
                  type: 'List<Ux4gStepItem>',
                  description: 'Step data items.',
                  required: true,
                ),
                PropRow(
                  name: 'orientation',
                  type: 'StepperOrientation',
                  description: 'horizontal or vertical.',
                  defaultValue: 'horizontal',
                ),
                PropRow(
                  name: 'lineStyle',
                  type: 'StepperLineStyle',
                  description: 'solid or dashed.',
                  defaultValue: 'solid',
                ),
                PropRow(
                  name: 'stepSize',
                  type: 'double?',
                  description: 'Custom size for the step indicator circle.',
                ),
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 380,
                    child: Ux4gStepper(
                      totalSteps: 4,
                      currentStep: current,
                      orientation: StepperOrientation.horizontal,
                      steps: const [
                        Ux4gStepItem(title: 'Personal'),
                        Ux4gStepItem(title: 'Address'),
                        Ux4gStepItem(title: 'Documents'),
                        Ux4gStepItem(title: 'Review'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ux4gButton(
                        onPressed: current > 0
                            ? () => setState(() => current--)
                            : null,
                        text: 'Back',
                        variant: Ux4gButtonVariant.outline,
                      ),
                      const SizedBox(width: 12),
                      Ux4gButton(
                        onPressed: current < 3
                            ? () => setState(() => current++)
                            : null,
                        text: 'Next',
                        variant: Ux4gButtonVariant.primary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Vertical',
      builder: (context) {
        int cur = 2;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gStepper — Vertical',
              description: 'Vertical orientation stacks steps top-to-bottom.',
              code:
                  'Ux4gStepper(totalSteps: 4, currentStep: cur, orientation: StepperOrientation.vertical, steps: steps);',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 280,
                    child: Ux4gStepper(
                      totalSteps: 4,
                      currentStep: cur,
                      orientation: StepperOrientation.vertical,
                      steps: const [
                        Ux4gStepItem(
                          title: 'Personal',
                          description: 'Name and contact',
                        ),
                        Ux4gStepItem(
                          title: 'Address',
                          description: 'Home address',
                        ),
                        Ux4gStepItem(title: 'Documents'),
                        Ux4gStepItem(title: 'Review'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ux4gButton(
                        onPressed: cur > 1 ? () => setState(() => cur--) : null,
                        text: 'Back',
                        variant: Ux4gButtonVariant.outline,
                      ),
                      const SizedBox(width: 12),
                      Ux4gButton(
                        onPressed: cur < 4 ? () => setState(() => cur++) : null,
                        text: 'Next',
                        variant: Ux4gButtonVariant.primary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Dashed line',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStepper — Dashed Line',
        description: 'lineStyle=dashed renders dotted connector lines.',
        code:
            'Ux4gStepper(totalSteps: 4, currentStep: 2, lineStyle: StepperLineStyle.dashed, steps: steps);',
        child: SizedBox(
          width: 380,
          child: Ux4gStepper(
            totalSteps: 4,
            currentStep: 2,
            lineStyle: StepperLineStyle.dashed,
            steps: const [
              Ux4gStepItem(title: 'Step 1'),
              Ux4gStepItem(title: 'Step 2'),
              Ux4gStepItem(title: 'Step 3'),
              Ux4gStepItem(title: 'Step 4'),
            ],
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With error step',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStepper — Error Step',
        description:
            'Mark a step as errored with isError: true on Ux4gStepItem.',
        code:
            'Ux4gStepItem(title: \'Address\', isError: true, statusLabel: \'Needs review\'),',
        child: SizedBox(
          width: 380,
          child: Ux4gStepper(
            totalSteps: 4,
            currentStep: 3,
            steps: const [
              Ux4gStepItem(title: 'Personal'),
              Ux4gStepItem(
                title: 'Address',
                isError: true,
                statusLabel: 'Needs review',
              ),
              Ux4gStepItem(title: 'Documents'),
              Ux4gStepItem(title: 'Review'),
            ],
          ),
        ),
      ),
    ),
  ],
);

final capsuleStepperComponent = WidgetbookComponent(
  name: 'Ux4gCapsuleStepper',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        int cap = 1;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gCapsuleStepper',
              description:
                  'Compact capsule-style progress bar with Prev/Next navigation '
                  'and four layout variants: linear, rightAligned, centered, split.',
              code:
                  'Ux4gCapsuleStepper(totalSteps: 5, currentStep: cap, stepLabel: \"Step \$cap of 5\", onNext: () {}, onPrevious: () {});',
              props: const [
                PropRow(
                  name: 'totalSteps',
                  type: 'int',
                  description: 'Total steps.',
                  required: true,
                ),
                PropRow(
                  name: 'currentStep',
                  type: 'int',
                  description: 'Current step (1-based).',
                  required: true,
                ),
                PropRow(
                  name: 'stepLabel',
                  type: 'String',
                  description: 'Text shown alongside capsules.',
                  required: true,
                ),
                PropRow(
                  name: 'description',
                  type: 'String?',
                  description: 'Sub-label below stepLabel.',
                ),
                PropRow(
                  name: 'layout',
                  type: 'Ux4gCapsuleStepperLayout',
                  description: 'linear / rightAligned / centered / split.',
                  defaultValue: 'linear',
                ),
                PropRow(
                  name: 'onNext',
                  type: 'VoidCallback',
                  description: 'Next button callback.',
                ),
                PropRow(
                  name: 'onPrevious',
                  type: 'VoidCallback',
                  description: 'Previous button callback.',
                ),
                PropRow(
                  name: 'labelAlignment',
                  type: 'CrossAxisAlignment',
                  description: 'Alignment for labels.',
                  defaultValue: 'start',
                ),
                PropRow(
                  name: 'activeColor',
                  type: 'Color?',
                  description: 'Color for active step.',
                ),
                PropRow(
                  name: 'inactiveColor',
                  type: 'Color?',
                  description: 'Color for inactive steps.',
                ),
              ],
              child: SizedBox(
                width: 380,
                child: Ux4gCapsuleStepper(
                  totalSteps: 5,
                  currentStep: cap,
                  stepLabel: 'Step \$cap of 5',
                  description: 'Complete all steps to finish',
                  layout: context.knobs.list(
                    label: 'Layout',
                    options: Ux4gCapsuleStepperLayout.values,
                    initialOption: Ux4gCapsuleStepperLayout.linear,
                    labelBuilder: (v) => v.name,
                  ),
                  onNext: cap < 5 ? () => setState(() => cap++) : () {},
                  onPrevious: cap > 1 ? () => setState(() => cap--) : () {},
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── Result Row ────────────────────────────────────────────────────────────────

final resultRowComponent = WidgetbookComponent(
  name: 'Ux4gResultRow',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gResultRow',
        description:
            'An expandable list-row that summarises a record with a status tag, '
            'key-value detail pairs, and an optional action button.',
        code: '''Ux4gResultRow(
  title: 'Application #2024-001',
  statusTag: 'Approved',
  tagColorScheme: Ux4gTagColor.success,
  actionButtonText: 'View',
  onActionPressed: () {},
  details: const [
    Ux4gResultDetail(label: 'Applicant', value: 'Ravi Kumar'),
    Ux4gResultDetail(label: 'Date', value: '12 May 2025'),
  ],
);''',
        props: const [
          PropRow(
            name: 'title',
            type: 'String',
            description: 'Row heading.',
            required: true,
          ),
          PropRow(
            name: 'statusTag',
            type: 'String?',
            description: 'Tag label.',
          ),
          PropRow(
            name: 'tagColorScheme',
            type: 'Ux4gTagColor',
            description: 'Tag colour.',
            defaultValue: 'neutral',
          ),
          PropRow(
            name: 'metadataSegments',
            type: 'List<Ux4gPillSegment>?',
            description: 'Metadata pill segments.',
          ),
          PropRow(
            name: 'details',
            type: 'List<Ux4gResultDetail>',
            description: 'Key-value pairs shown when expanded.',
            defaultValue: '[]',
          ),
          PropRow(
            name: 'actionButtonText',
            type: 'String?',
            description: 'CTA button label.',
          ),
          PropRow(
            name: 'onActionPressed',
            type: 'VoidCallback?',
            description: 'Action button callback.',
          ),
          PropRow(
            name: 'actionButtonIcon',
            type: 'IconData?',
            description: 'Icon for action button.',
          ),
          PropRow(
            name: 'actionButtonColor',
            type: 'Color?',
            description: 'Color for action button.',
          ),
          PropRow(
            name: 'expandedChild',
            type: 'Widget?',
            description: 'Custom widget to show when expanded.',
          ),
          PropRow(
            name: 'detailsColumns',
            type: 'int',
            description: 'Number of columns for details.',
            defaultValue: '2',
          ),
          PropRow(
            name: 'initialExpanded',
            type: 'bool',
            description: 'Start in expanded state.',
            defaultValue: 'false',
          ),
          PropRow(
            name: 'onToggle',
            type: 'ValueChanged<bool>?',
            description: 'Called when expansion state changes.',
          ),
          PropRow(
            name: 'showBottomDivider',
            type: 'bool',
            description: 'Show divider at bottom.',
            defaultValue: 'true',
          ),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gResultRow(
            title: 'Application #2024-001',
            statusTag: 'Approved',
            tagColorScheme: Ux4gTagColor.success,
            actionButtonText: 'View',
            onActionPressed: () {},
            details: const [
              Ux4gResultDetail(label: 'Applicant', value: 'Ravi Kumar'),
              Ux4gResultDetail(label: 'Date', value: '12 May 2025'),
              Ux4gResultDetail(
                label: 'Amount',
                value: '₹1,20,000',
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

// ── Social Links ──────────────────────────────────────────────────────────────

final socialLinkComponent = WidgetbookComponent(
  name: 'Ux4gSocialLink',
  useCases: [
    WidgetbookUseCase(
      name: 'Icons row',
      builder: (context) => ComponentDocs(
        name: 'Ux4gSocialLink',
        description:
            'SVG social-media icon buttons. Choose from the SocialMediaIcon enum. '
            'Enable background for a contained pill appearance.',
        code: '''Ux4gSocialLink(
  icon: SocialMediaIcon.twitter,
  useColoredIcon: true,
);

// With background container
Ux4gSocialLink(
  icon: SocialMediaIcon.github,
  useColoredIcon: true,
  enableBackground: true,
  containerSize: 48,
);''',
        props: const [
          PropRow(
            name: 'icon',
            type: 'SocialMediaIcon',
            description: 'Social icon type.',
            required: true,
          ),
          PropRow(
            name: 'size',
            type: 'SocialLinkSize',
            description: 'xs / s / m / l / xl / xxl.',
            defaultValue: 'm',
          ),
          PropRow(
            name: 'color',
            type: 'Color?',
            description: 'Custom icon color.',
          ),
          PropRow(
            name: 'onPressed',
            type: 'VoidCallback?',
            description: 'Tap callback.',
          ),
          PropRow(
            name: 'tooltip',
            type: 'String?',
            description: 'Tooltip text.',
          ),
          PropRow(
            name: 'containerSize',
            type: 'double?',
            description: 'Custom background container size.',
          ),
          PropRow(
            name: 'containerColor',
            type: 'Color?',
            description: 'Custom background color.',
          ),
          PropRow(
            name: 'enableBackground',
            type: 'bool',
            description: 'Wrap in background container.',
            defaultValue: 'false',
          ),
          PropRow(
            name: 'useColoredIcon',
            type: 'bool',
            description: 'Show brand colour.',
            defaultValue: 'false',
          ),
        ],
        child: Wrap(
          spacing: 12,
          children: [
            Ux4gSocialLink(icon: SocialMediaIcon.twitter, useColoredIcon: true),
            Ux4gSocialLink(icon: SocialMediaIcon.github, useColoredIcon: true),
            Ux4gSocialLink(
              icon: SocialMediaIcon.instagram,
              useColoredIcon: true,
            ),
            Ux4gSocialLink(icon: SocialMediaIcon.youtube, useColoredIcon: true),
            Ux4gSocialLink(icon: SocialMediaIcon.google, useColoredIcon: true),
          ],
        ),
      ),
    ),
  ],
);

// ── Journey Timeline ──────────────────────────────────────────────────────────

final journeyTimelineComponent = WidgetbookComponent(
  name: 'Ux4gJourneyTimeline',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gJourneyTimeline',
        description:
            'A vertical timeline showing the progress of a multi-stage journey. '
            'Steps are: completed, current, or upcoming.',
        code: '''Ux4gJourneyTimeline(
  currentStep: 1,
  steps: const [
    Ux4gJourneyStep(
      title: 'Application Submitted',
      date: '01 Jan 2025',
      state: Ux4gJourneyStepState.completed,
    ),
    Ux4gJourneyStep(
      title: 'Under Review',
      date: '05 Jan 2025',
      state: Ux4gJourneyStepState.current,
    ),
    Ux4gJourneyStep(
      title: 'Approval Pending',
      state: Ux4gJourneyStepState.upcoming,
    ),
  ],
);''',
        props: const [
          PropRow(
            name: 'steps',
            type: 'List<Ux4gJourneyStep>',
            description: 'Timeline steps.',
            required: true,
          ),
          PropRow(
            name: 'header',
            type: 'Ux4gJourneyHeader?',
            description: 'Header above the timeline.',
          ),
          PropRow(
            name: 'currentStep',
            type: 'int?',
            description: 'Index of the active step.',
          ),
          PropRow(
            name: 'orientation',
            type: 'Ux4gJourneyOrientation',
            description: 'vertical or horizontal.',
            defaultValue: 'vertical',
          ),
          PropRow(
            name: 'indicatorSize',
            type: 'double',
            description: 'Size of circle indicator.',
            defaultValue: '20',
          ),
          PropRow(
            name: 'lineWidth',
            type: 'double',
            description: 'Width of connector line.',
            defaultValue: '3',
          ),
          PropRow(
            name: 'indicatorCardSpacing',
            type: 'double',
            description: 'Gap between indicator and card.',
            defaultValue: '12',
          ),
          PropRow(
            name: 'stepSpacing',
            type: 'double',
            description: 'Gap between steps.',
            defaultValue: '12',
          ),
          PropRow(
            name: 'activeColor',
            type: 'Color?',
            description: 'Color for completed/current steps.',
          ),
          PropRow(
            name: 'inactiveColor',
            type: 'Color?',
            description: 'Color for upcoming steps.',
          ),
          PropRow(
            name: 'cardBorderRadius',
            type: 'double',
            description: 'Corner radius of step cards.',
            defaultValue: '8',
          ),
          PropRow(
            name: 'cardPadding',
            type: 'EdgeInsetsGeometry?',
            description: 'Padding inside cards.',
          ),
          PropRow(
            name: 'cardColor',
            type: 'Color?',
            description: 'Background color of cards.',
          ),
          PropRow(
            name: 'cardBorderColor',
            type: 'Color?',
            description: 'Border color of cards.',
          ),
        ],
        child: SizedBox(
          width: 340,
          child: Ux4gJourneyTimeline(
            currentStep: 1,
            steps: const [
              Ux4gJourneyStep(
                title: 'Application Submitted',
                date: '01 Jan 2025',
                state: Ux4gJourneyStepState.completed,
              ),
              Ux4gJourneyStep(
                title: 'Under Review',
                date: '05 Jan 2025',
                state: Ux4gJourneyStepState.current,
              ),
              Ux4gJourneyStep(
                title: 'Approval Pending',
                date: 'Upcoming',
                state: Ux4gJourneyStepState.upcoming,
              ),
              Ux4gJourneyStep(
                title: 'Disbursement',
                state: Ux4gJourneyStepState.upcoming,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

// ── Status Pipeline ───────────────────────────────────────────────────────────

final statusPipelineComponent = WidgetbookComponent(
  name: 'Ux4gStatusPipeline',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStatusPipeline',
        description:
            'A horizontal pipeline showing discrete processing stages. '
            'Steps can be completed, current, upcoming, error, or warning.',
        code: '''Ux4gStatusPipeline(
  currentStep: 2,
  steps: const [
    Ux4gPipelineStep(label: 'Submitted', description: '5 Apr'),
    Ux4gPipelineStep(label: 'Verified',  description: '6 Apr'),
    Ux4gPipelineStep(label: 'In Review', description: 'In progress'),
    Ux4gPipelineStep(label: 'Approved',  description: 'Est. 10 Apr'),
    Ux4gPipelineStep(label: 'Disbursed', description: 'Est. 12 Apr'),
  ],
);''',
        props: const [
          PropRow(
            name: 'steps',
            type: 'List<Ux4gPipelineStep>',
            description: 'Pipeline stages.',
            required: true,
          ),
          PropRow(
            name: 'currentStep',
            type: 'int',
            description: 'Active stage index.',
            required: true,
          ),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gStatusPipeline(
            currentStep: 2,
            steps: const [
              Ux4gPipelineStep(label: 'Submitted', description: '5 Apr'),
              Ux4gPipelineStep(label: 'Verified', description: '6 Apr'),
              Ux4gPipelineStep(label: 'In Review', description: 'In progress'),
              Ux4gPipelineStep(label: 'Approved', description: 'Est. 10 Apr'),
              Ux4gPipelineStep(label: 'Disbursed', description: 'Est. 12 Apr'),
            ],
          ),
        ),
      ),
    ),
  ],
);

// ── Carousel ──────────────────────────────────────────────────────────────────

final carouselComponent = WidgetbookComponent(
  name: 'Ux4gCarousel',
  useCases: [
    WidgetbookUseCase(
      name: 'Image carousel',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCarousel',
        description:
            'A horizontal swipe carousel. Pass any list of widgets as items.',
        code: '''Ux4gCarousel(
  items: List.generate(
    4,
    (i) => Image.network(
      'https://picsum.photos/seed/\/360/200',
      fit: BoxFit.cover,
    ),
  ),
);''',
        props: const [
          PropRow(
            name: 'items',
            type: 'List<Widget>',
            description: 'Carousel slide widgets.',
            required: true,
          ),
        ],
        child: SizedBox(
          width: 360,
          child: Ux4gCarousel(
            items: List.generate(
              4,
              (i) => Image.network(
                'https://picsum.photos/seed//360/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ],
);

// ── Social Link Group ─────────────────────────────────────────────────────────

final socialLinkGroupComponent = WidgetbookComponent(
  name: 'Ux4gSocialLinkGroup',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gSocialLinkGroup',
        description:
            'A horizontal row of social media icon buttons rendered as a group. '
            'Supports size, background, color, and spacing customisation.',
        code: '''Ux4gSocialLinkGroup(
  icons: [
    SocialMediaIcon.twitter,
    SocialMediaIcon.github,
    SocialMediaIcon.instagram,
    SocialMediaIcon.youtube,
  ],
  size: SocialLinkSize.m,
  enableBackground: false,
  spacing: 12,
);''',
        props: const [
          PropRow(
            name: 'icons',
            type: 'List<SocialMediaIcon>',
            description: 'Social icons to display.',
            required: true,
          ),
          PropRow(
            name: 'size',
            type: 'SocialLinkSize',
            description: 'xs / s / m / l / xl / xxl.',
            defaultValue: 'm',
          ),
          PropRow(
            name: 'enableBackground',
            type: 'bool',
            description: 'Show background circle per icon.',
            defaultValue: 'false',
          ),
          PropRow(
            name: 'spacing',
            type: 'double',
            description: 'Gap between icons.',
            defaultValue: '8',
          ),
          PropRow(
            name: 'onIconPressed',
            type: 'Function(SocialMediaIcon)?',
            description: 'Called when an icon is tapped.',
          ),
        ],
        child: Ux4gSocialLinkGroup(
          icons: const [
            SocialMediaIcon.twitter,
            SocialMediaIcon.github,
            SocialMediaIcon.instagram,
            SocialMediaIcon.youtube,
            SocialMediaIcon.google,
          ],
          size: context.knobs.list(
            label: 'Size',
            options: SocialLinkSize.values,
            initialOption: SocialLinkSize.m,
            labelBuilder: (v) => v.name,
          ),
          enableBackground: context.knobs.boolean(
            label: 'Background',
            initialValue: false,
          ),
          onIconPressed: (icon) => () {},
        ),
      ),
    ),
  ],
);

// ── Social Link List ──────────────────────────────────────────────────────────

final socialLinkListComponent = WidgetbookComponent(
  name: 'Ux4gSocialLinkList',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gSocialLinkList',
        description:
            'A list of social media icon buttons that can be arranged horizontally or vertically '
            'with configurable alignment.',
        code: '''Ux4gSocialLinkList(
  icons: [
    SocialMediaIcon.twitter,
    SocialMediaIcon.github,
    SocialMediaIcon.instagram,
  ],
  size: SocialLinkSize.m,
  direction: Axis.horizontal,
  alignment: MainAxisAlignment.center,
  enableBackground: true,
);''',
        props: const [
          PropRow(
            name: 'icons',
            type: 'List<SocialMediaIcon>',
            description: 'Social icons to display.',
            required: true,
          ),
          PropRow(
            name: 'size',
            type: 'SocialLinkSize',
            description: 'xs / s / m / l / xl / xxl.',
            defaultValue: 'm',
          ),
          PropRow(
            name: 'direction',
            type: 'Axis',
            description: 'horizontal or vertical.',
            defaultValue: 'horizontal',
          ),
          PropRow(
            name: 'alignment',
            type: 'MainAxisAlignment',
            description: 'Flex alignment.',
            defaultValue: 'start',
          ),
          PropRow(
            name: 'enableBackground',
            type: 'bool',
            description: 'Show background circle per icon.',
            defaultValue: 'false',
          ),
          PropRow(
            name: 'onIconPressed',
            type: 'Function(SocialMediaIcon)?',
            description: 'Called when an icon is tapped.',
          ),
        ],
        child: Ux4gSocialLinkList(
          icons: const [
            SocialMediaIcon.twitter,
            SocialMediaIcon.github,
            SocialMediaIcon.instagram,
            SocialMediaIcon.youtube,
          ],
          size: context.knobs.list(
            label: 'Size',
            options: SocialLinkSize.values,
            initialOption: SocialLinkSize.m,
            labelBuilder: (v) => v.name,
          ),
          enableBackground: context.knobs.boolean(
            label: 'Background',
            initialValue: true,
          ),
          direction: context.knobs.list(
            label: 'Direction',
            options: Axis.values,
            initialOption: Axis.horizontal,
            labelBuilder: (v) => v.name,
          ),
          onIconPressed: (icon) => () {},
        ),
      ),
    ),
  ],
);

// ── SlotGrid ──────────────────────────────────────────────────────────────────

// ── SlotGrid ──────────────────────────────────────────────────────────────────

final slotGridComponent = WidgetbookComponent(
  name: 'SlotGrid',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            final data = SlotGridData(
              year: 2026,
              month: 5,
              today: DateTime(2026, 5, 21),
              selectedDate: selected,
              weeklyOffWeekdays: const [6, 7],
              viewMode: SlotPickerViewMode.expanded,
            );
            return ComponentDocs(
              name: 'SlotGrid',
              description:
                  'A calendar-style date picker that marks dates as available, '
                  'no-slots, public holiday, or weekly-off. '
                  'Optionally opens a time-slot bottom sheet when a date is tapped.',
              code: '''// Build the data model
final data = SlotGridData(
  year: 2026,
  month: 5,
  today: DateTime(2026, 5, 21),
  selectedDate: _selected,
  weeklyOffWeekdays: const [6, 7],
  dates: [
    SlotDateEntry(date: DateTime(2026, 5, 1),  status: SlotDateStatus.publicHoliday),
    SlotDateEntry(date: DateTime(2026, 5, 14), status: SlotDateStatus.noSlots),
  ],
  allowTapOnPublicHoliday: false,
  allowTapOnWeeklyOff: false,
  viewMode: SlotPickerViewMode.expanded,
);

SlotGrid(
  data: data,
  onDateSelected: (date) => setState(() => _selected = date),
  onMonthChanged: (year, month) { /* fetch data for new month */ },
  timeSlotProvider: (date) => [
    SlotTimeEntry(time: '09:00 AM', slotCount: 3),
    SlotTimeEntry(time: '11:00 AM', slotCount: 1, status: SlotTimeStatus.limited),
    SlotTimeEntry(time: '02:00 PM', slotCount: 0, status: SlotTimeStatus.noSlots),
  ],
  onSlotConfirmed: (date, slot) { /* booking confirmed */ },
);''',
              props: const [
                PropRow(
                  name: 'data',
                  type: 'SlotGridData',
                  description:
                      'Calendar data model (year, month, dates, view mode).',
                  required: true,
                ),
                PropRow(
                  name: 'onDateSelected',
                  type: 'ValueChanged<DateTime>?',
                  description:
                      'Called when user taps an available date (no timeSlotProvider).',
                ),
                PropRow(
                  name: 'onMonthChanged',
                  type: 'void Function(int year, int month)?',
                  description:
                      'Called when the prev/next month arrow is tapped.',
                ),
                PropRow(
                  name: 'timeSlotProvider',
                  type: 'List<SlotTimeEntry> Function(DateTime)?',
                  description:
                      'Supply time slots — auto-opens SlotTimePickerSheet on date tap.',
                ),
                PropRow(
                  name: 'onSlotConfirmed',
                  type: 'void Function(DateTime, SlotTimeEntry)?',
                  description: 'Called when the user confirms a time slot.',
                ),
              ],
              child: SingleChildScrollView(
                child: SlotGrid(
                  data: data,
                  onDateSelected: (date) => setState(() => selected = date),
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'With holidays & no-slots',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            final data = SlotGridData(
              year: 2026,
              month: 5,
              today: DateTime(2026, 5, 21),
              selectedDate: selected,
              weeklyOffWeekdays: const [6, 7],
              dates: [
                SlotDateEntry(
                  date: DateTime(2026, 5, 1),
                  status: SlotDateStatus.publicHoliday,
                ),
                SlotDateEntry(
                  date: DateTime(2026, 5, 9),
                  status: SlotDateStatus.publicHoliday,
                ),
                SlotDateEntry(
                  date: DateTime(2026, 5, 14),
                  status: SlotDateStatus.noSlots,
                ),
                SlotDateEntry(
                  date: DateTime(2026, 5, 19),
                  status: SlotDateStatus.noSlots,
                ),
              ],
              viewMode: SlotPickerViewMode.expanded,
            );
            return ComponentDocs(
              name: 'SlotGrid - Holidays and No-Slots',
              description:
                  'publicHoliday and noSlots dates are styled differently and '
                  'are non-interactive by default.',
              code: '''SlotGridData(
  year: 2026, month: 5,
  weeklyOffWeekdays: [6, 7],
  dates: [
    SlotDateEntry(date: DateTime(2026, 5, 1),  status: SlotDateStatus.publicHoliday),
    SlotDateEntry(date: DateTime(2026, 5, 14), status: SlotDateStatus.noSlots),
  ],
  viewMode: SlotPickerViewMode.expanded,
);''',
              child: SingleChildScrollView(
                child: SlotGrid(
                  data: data,
                  onDateSelected: (date) => setState(() => selected = date),
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'With time slots',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            final data = SlotGridData(
              year: 2026,
              month: 5,
              today: DateTime(2026, 5, 21),
              selectedDate: selected,
              weeklyOffWeekdays: const [6, 7],
              viewMode: SlotPickerViewMode.expanded,
            );
            return ComponentDocs(
              name: 'SlotGrid - Time Slots',
              description:
                  'When timeSlotProvider is set, tapping an available date '
                  'automatically opens the SlotTimePickerSheet bottom sheet.',
              code: '''SlotGrid(
  data: data,
  timeSlotProvider: (date) => [
    SlotTimeEntry(time: '09:00 AM', slotCount: 3),
    SlotTimeEntry(time: '11:00 AM', slotCount: 1, status: SlotTimeStatus.limited),
    SlotTimeEntry(time: '02:00 PM', slotCount: 0, status: SlotTimeStatus.noSlots),
  ],
  onSlotConfirmed: (date, slot) { /* booking confirmed */ },
);''',
              child: SingleChildScrollView(
                child: SlotGrid(
                  data: data,
                  onDateSelected: (date) => setState(() => selected = date),
                  timeSlotProvider: (date) => const [
                    SlotTimeEntry(time: '09:00 AM', slotCount: 3),
                    SlotTimeEntry(
                      time: '11:00 AM',
                      slotCount: 1,
                      status: SlotTimeStatus.limited,
                    ),
                    SlotTimeEntry(
                      time: '02:00 PM',
                      slotCount: 0,
                      status: SlotTimeStatus.noSlots,
                    ),
                  ],
                  onSlotConfirmed: (date, slot) {},
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'JSON data source',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            final data = SlotGridData.fromJson({
              'year': 2026,
              'month': 6,
              'today': '2026-06-01',
              'weeklyOffWeekdays': [6, 7],
              'viewMode': 'compact',
              'dates': [
                {'date': '2026-06-05', 'status': 'publicHoliday'},
                {'date': '2026-06-12', 'status': 'noSlots'},
              ],
            });
            return ComponentDocs(
              name: 'SlotGrid - JSON',
              description:
                  'SlotGridData.fromJson() deserialises a server response directly. '
                  'viewMode can be "expanded" or "compact".',
              code: '''final data = SlotGridData.fromJson({
  "year": 2026,
  "month": 6,
  "today": "2026-06-01",
  "weeklyOffWeekdays": [6, 7],
  "viewMode": "compact",
  "dates": [
    { "date": "2026-06-05", "status": "publicHoliday" },
    { "date": "2026-06-12", "status": "noSlots" },
  ],
});

SlotGrid(data: data, onDateSelected: (d) {});''',
              child: SingleChildScrollView(
                child: SlotGrid(
                  data: data,
                  onDateSelected: (date) => setState(() => selected = date),
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);
