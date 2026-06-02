import re

file_path = r'lib/src/components/steppers.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add fields to Ux4gStepItem
pattern_step_item = r'''class Ux4gStepItem \{
  final String title;
  final String\? description;
  final String\? statusLabel;
  final bool isError;

  const Ux4gStepItem\(\{
    required this\.title,
    this\.description,
    this\.statusLabel,
    this\.isError = false,
  \}\);
\}'''

replacement_step_item = '''class Ux4gStepItem {
  final String title;
  final String? description;
  final String? statusLabel;
  final bool isError;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? statusLabelStyle;

  const Ux4gStepItem({
    required this.title,
    this.description,
    this.statusLabel,
    this.isError = false,
    this.titleStyle,
    this.descriptionStyle,
    this.statusLabelStyle,
  });
}'''

content = re.sub(pattern_step_item, replacement_step_item, content)

# 2. Add fields to _StepLabels
pattern_step_labels_class = r'''class _StepLabels extends StatelessWidget \{
  final String title;
  final String\? description;
  final String\? statusLabel;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isError;
  final TextAlign textAlign;

  const _StepLabels\(\{
    required this\.title,
    this\.description,
    this\.statusLabel,
    required this\.isCompleted,
    required this\.isActive,
    required this\.isPending,
    required this\.isError,
    required this\.textAlign,
  \}\);'''

replacement_step_labels_class = '''class _StepLabels extends StatelessWidget {
  final String title;
  final String? description;
  final String? statusLabel;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isError;
  final TextAlign textAlign;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? statusLabelStyle;

  const _StepLabels({
    required this.title,
    this.description,
    this.statusLabel,
    required this.isCompleted,
    required this.isActive,
    required this.isPending,
    required this.isError,
    required this.textAlign,
    this.titleStyle,
    this.descriptionStyle,
    this.statusLabelStyle,
  });'''

content = re.sub(pattern_step_labels_class, replacement_step_labels_class, content)

# 3. Update Text widgets in _StepLabels
pattern_step_labels_build = r'''        Text\(
          title,
          style: \(ux4gTypography\?\.lL_strong \?\? materialTheme\.textTheme\.labelLarge\?\.copyWith\(fontWeight: FontWeight\.bold\)\)\?\.copyWith\(color: titleColor\),
          textAlign: textAlign,
        \),
        if \(description != null\)
          Text\(
            description!,
            style: \(ux4gTypography\?\.lM_default \?\? materialTheme\.textTheme\.labelMedium\)\?\.copyWith\(
              color: resolvedDescriptionColor,
            \),
            textAlign: textAlign,
          \),
        if \(resolvedStatus != null\)
          Text\(
            resolvedStatus,
            style: \(ux4gTypography\?\.lS_strong \?\? materialTheme\.textTheme\.labelSmall\?\.copyWith\(fontWeight: FontWeight\.bold\)\)\?\.copyWith\(color: statusColor\),
            textAlign: textAlign,
          \),'''

replacement_step_labels_build = '''        Text(
          title,
          style: titleStyle ?? (ux4gTypography?.lL_strong ?? materialTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold))?.copyWith(color: titleColor),
          textAlign: textAlign,
        ),
        if (description != null)
          Text(
            description!,
            style: descriptionStyle ?? (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium)?.copyWith(
              color: resolvedDescriptionColor,
            ),
            textAlign: textAlign,
          ),
        if (resolvedStatus != null)
          Text(
            resolvedStatus,
            style: statusLabelStyle ?? (ux4gTypography?.lS_strong ?? materialTheme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold))?.copyWith(color: statusColor),
            textAlign: textAlign,
          ),'''

content = re.sub(pattern_step_labels_build, replacement_step_labels_build, content)

# 4. Update invocations of _StepLabels in Horizontal and Vertical stepper
pattern_step_labels_invoke = r'''_StepLabels\(
(.*?)title: stepData\?\.title \?\? 'Step \$stepIndex',
(.*?)description: stepData\?\.description,
(.*?)statusLabel: stepData\?\.statusLabel,
(.*?)isCompleted: isCompleted,
(.*?)isActive: isActive,
(.*?)isPending: isPending,
(.*?)isError: stepData\?\.isError \?\? false,
(.*?)textAlign: (.*?),
(.*?)?\)'''

replacement_step_labels_invoke = r'''_StepLabels(
\1title: stepData?.title ?? 'Step $stepIndex',
\2description: stepData?.description,
\3statusLabel: stepData?.statusLabel,
\4isCompleted: isCompleted,
\5isActive: isActive,
\6isPending: isPending,
\7isError: stepData?.isError ?? false,
\8textAlign: \9,
\10titleStyle: stepData?.titleStyle,
\10descriptionStyle: stepData?.descriptionStyle,
\10statusLabelStyle: stepData?.statusLabelStyle,
\10)'''

# Using string replace or a simpler regex because the spacing might be tricky
pattern_labels_1 = r'''_StepLabels\(
                      title: stepData\?\.title \?\? 'Step \$stepIndex',
                      description: stepData\?\.description,
                      statusLabel: stepData\?\.statusLabel,
                      isCompleted: isCompleted,
                      isActive: isActive,
                      isPending: isPending,
                      isError: stepData\?\.isError \?\? false,
                      textAlign: TextAlign\.center,
                    \)'''

rep_labels_1 = '''_StepLabels(
                      title: stepData?.title ?? 'Step $stepIndex',
                      description: stepData?.description,
                      statusLabel: stepData?.statusLabel,
                      isCompleted: isCompleted,
                      isActive: isActive,
                      isPending: isPending,
                      isError: stepData?.isError ?? false,
                      textAlign: TextAlign.center,
                      titleStyle: stepData?.titleStyle,
                      descriptionStyle: stepData?.descriptionStyle,
                      statusLabelStyle: stepData?.statusLabelStyle,
                    )'''

pattern_labels_2 = r'''_StepLabels\(
                    title: stepData\?\.title \?\? 'Step \$stepIndex',
                    description: stepData\?\.description,
                    statusLabel: stepData\?\.statusLabel,
                    isCompleted: isCompleted,
                    isActive: isActive,
                    isPending: isPending,
                    isError: stepData\?\.isError \?\? false,
                    textAlign: TextAlign\.start,
                  \)'''

rep_labels_2 = '''_StepLabels(
                    title: stepData?.title ?? 'Step $stepIndex',
                    description: stepData?.description,
                    statusLabel: stepData?.statusLabel,
                    isCompleted: isCompleted,
                    isActive: isActive,
                    isPending: isPending,
                    isError: stepData?.isError ?? false,
                    textAlign: TextAlign.start,
                    titleStyle: stepData?.titleStyle,
                    descriptionStyle: stepData?.descriptionStyle,
                    statusLabelStyle: stepData?.statusLabelStyle,
                  )'''

content = re.sub(pattern_labels_1, rep_labels_1, content)
content = re.sub(pattern_labels_2, rep_labels_2, content)


with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
    
print("Updated steppers.dart to support TextStyle overrides.")
