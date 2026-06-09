import re
import sys

file_path = r'lib/stories/application_and_submission/eligibility_check_wizard/eligibility_check_wizard_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def repl_bullet(m):
    text = m.group(1)
    return f"""            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 8, color: Color(0xFF111827))),
                  SizedBox(width: 12),
                  Expanded(child: Text('{text}', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4))),
                ],
              ),
            ),"""

# _buildInfoBullet('text') or _buildInfoBullet('text'),
content = re.sub(r' *\_buildInfoBullet\(\'([^\']+)\'\),?', repl_bullet, content)

def repl_criteria(m):
    indent = m.group(1)
    text = m.group(2)
    kwargs = m.group(3)
    
    bg_color = '0xFFDCFCE7'
    icon_code = "Icon(Icons.check, size: 16, color: Color(0xFF16A34A))"
    
    if kwargs and 'isMet: false' in kwargs:
        bg_color = '0xFFFEE2E2'
        icon_code = "Icon(Icons.close, size: 16, color: Color(0xFFDC2626))"
    elif kwargs and 'isMet: null' in kwargs:
        bg_color = '0xFFFFEDD5'
        icon_code = "Text('?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)))"
        
    return f"""{indent}Padding(
{indent}  padding: EdgeInsets.only(bottom: 14),
{indent}  child: Row(
{indent}    crossAxisAlignment: CrossAxisAlignment.start,
{indent}    children: [
{indent}      Expanded(child: Text('{text}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF374151), height: 1.4))),
{indent}      SizedBox(width: 12),
{indent}      Container(width: 20, height: 20, alignment: Alignment.center, decoration: BoxDecoration(color: Color({bg_color}), borderRadius: BorderRadius.circular(4)), child: {icon_code}),
{indent}    ],
{indent}  ),
{indent}),"""

# Only replace in code string literals! We don't want to replace in UI mockups if possible, but the user said "kese bhi pattern mai tumnai aagar esh tarha se method create kar ke code section mai use keya ho tho, ushai remove kar"
# Wait, actually, replacing it everywhere (even mockups) is fine! It just makes the mockups a bit longer, but guarantees we don't miss anything.
# Let's just replace all _buildCriteriaItem calls globally in this file.
content = re.sub(r'( +)\_buildCriteriaItem\(\'([^\']+)\'(.*?)\),?', repl_criteria, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
