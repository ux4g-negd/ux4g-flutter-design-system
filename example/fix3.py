import re

file_path = r'lib/stories/application_and_submission/eligibility_check_wizard/eligibility_check_wizard_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def repl(m):
    container_close_spaces = m.group(1)
    empty_line_spaces = m.group(2)
    next_statement = m.group(3)
    
    # We matched:
    # {container_close_spaces}),
    # {empty_line_spaces}
    # {empty_line_spaces}{next_statement}
    
    # We want to return:
    # {container_close_spaces}),
    # {empty_line_spaces}),
    # {empty_line_spaces}{next_statement}
    
    return f"{container_close_spaces}),\n{empty_line_spaces}),\n{empty_line_spaces}{next_statement}"

content = re.sub(r'(\n\s+)\),\n(\s+)\n\2(const SizedBox|\]|GestureDetector|Padding)', repl, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
