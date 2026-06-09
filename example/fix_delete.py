import re
import sys

file_path = r'lib/stories/application_and_submission/eligibility_check_wizard/eligibility_check_wizard_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Remove _buildInfoBullet
content = re.sub(r'Widget _buildInfoBullet\(String text\) \{.*?\n\}\n\n', '', content, flags=re.DOTALL)

# Remove _buildCriteriaItem
content = re.sub(r'Widget _buildCriteriaItem\(String text, \{bool\? isMet = true\}\) \{.*?\n\}\n\n', '', content, flags=re.DOTALL)

# Remove _buildRadioOption
content = re.sub(r'// ───────────────────────────────────────────────────────────────────────\n// Radio option card builder\n// ───────────────────────────────────────────────────────────────────────\n\nWidget _buildRadioOption.*?\}\n\n', '', content, flags=re.DOTALL)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
