import re
import sys

file_path = r'lib/stories/application_and_submission/eligibility_check_wizard/eligibility_check_wizard_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def repl_radio(m):
    indent = m.group(1)
    val = m.group(2)
    label = m.group(3)
    subtitle = m.group(4)
    # The groupValue is usually _selected
    
    return f"""{indent}GestureDetector(
{indent}  onTap: () => setState(() => _selected = '{val}'),
{indent}  child: Container(
{indent}    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
{indent}    decoration: BoxDecoration(
{indent}      color: _selected == '{val}' ? const Color(0xFFF5F3FF) : const Color(0xFFF9FAFB),
{indent}      borderRadius: BorderRadius.circular(12),
{indent}    ),
{indent}    child: Row(
{indent}      children: [
{indent}        Container(
{indent}          width: 22, height: 22,
{indent}          decoration: BoxDecoration(
{indent}            shape: BoxShape.circle,
{indent}            border: Border.all(
{indent}              color: _selected == '{val}' ? const Color(0xFF6A4EFF) : const Color(0xFFD1D5DB),
{indent}              width: _selected == '{val}' ? 6 : 2,
{indent}            ),
{indent}            color: Colors.white,
{indent}          ),
{indent}        ),
{indent}        const SizedBox(width: 14),
{indent}        Expanded(
{indent}          child: Column(
{indent}            crossAxisAlignment: CrossAxisAlignment.start,
{indent}            children: [
{indent}              Text(
{indent}                '{label}',
{indent}                style: TextStyle(
{indent}                  fontSize: 16,
{indent}                  fontWeight: FontWeight.w700,
{indent}                  color: _selected == '{val}' ? const Color(0xFF6A4EFF) : const Color(0xFF111827),
{indent}                ),
{indent}              ),
{indent}              const SizedBox(height: 2),
{indent}              Text(
{indent}                '{subtitle}',
{indent}                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.3),
{indent}              ),
{indent}            ],
{indent}          ),
{indent}        ),
{indent}      ],
{indent}    ),
{indent}  ),
{indent}),"""

# Match:
# _buildRadioOption(
#   value: 'yes',
#   label: 'Yes',
#   subtitle: 'I am a resident of Maharashtra',
#   groupValue: _selected,
#   onChanged: (val) => setState(() => _selected = val),
# ),

pattern = re.compile(r'( +)\_buildRadioOption\(\s*value:\s*\'([^\']+)\',\s*label:\s*\'([^\']+)\',\s*subtitle:\s*\'([^\']+)\',.*?\),?', re.DOTALL)
content = pattern.sub(repl_radio, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
