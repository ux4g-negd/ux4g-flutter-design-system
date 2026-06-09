import re

file_path = r'lib/stories/application_and_submission/eligibility_check_wizard/eligibility_check_wizard_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace cases where the next line is `],`
def repl(m):
    # m.group(1) is the newline + spaces before `),`
    # m.group(2) is the spaces before `],`
    return f"{m.group(1)}),\n{m.group(2)}  ),\n{m.group(2)}],"

content = re.sub(r'(\n +)\),\n +\n( +)\],', repl, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
