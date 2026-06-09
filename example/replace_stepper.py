import re

file_path = r'lib/stories/application_and_submission/journey_progress_indicator/journey_progress_indicator_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Define the regex pattern to find the inline Row stepper and replace it with Ux4gStepper
# The inline stepper starts with:
#                     Row(
#                       crossAxisAlignment: CrossAxisAlignment.start,
#                       children: [
#                         // Step 1
# ...
#                         // Step 4
#                         Container(
#                           width: 24, height: 24,
# ...
#                         ),
#                       ],
#                     ),
# And it is followed by `const SizedBox(height: 40),`

pattern = re.compile(
    r'([ \t]+)// Journey Progress Indicator \(Stepper\) inline\n[ \t]+Row\(\n[ \t]+crossAxisAlignment: CrossAxisAlignment\.start,.*?// Step 4.*?Container\(.*?\]\n[ \t]+,\n[ \t]+\),\n[ \t]+\]\n[ \t]+\),\n',
    re.DOTALL
)

replacement = r'''\1// Journey Progress Indicator using Design System Component
\1Ux4gStepper(
\1  totalSteps: 4,
\1  currentStep: 3,
\1  steps: const [
\1    Ux4gStepItem(title: '', statusLabel: ''),
\1    Ux4gStepItem(title: '', statusLabel: ''),
\1    Ux4gStepItem(title: 'Documents', statusLabel: ''),
\1    Ux4gStepItem(title: '', statusLabel: ''),
\1  ],
\1),
'''

new_content = pattern.sub(replacement, content)

# If regex failed to match, fallback to exact string replacement
if new_content == content:
    print("Regex didn't match perfectly, trying more relaxed match...")
    pattern2 = re.compile(r'([ \t]+)// Journey Progress Indicator \(Stepper\) inline\n[ \t]+Row\(.*?children: \[(?:.*?// Step 4.*?)\]\n[ \t]+\),', re.DOTALL)
    new_content = pattern2.sub(replacement, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)
    
print("Replaced inline stepper with Ux4gStepper component.")
