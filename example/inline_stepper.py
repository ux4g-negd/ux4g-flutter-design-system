import re
import sys

file_path = r'lib/stories/application_and_submission/journey_progress_indicator/journey_progress_indicator_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

inline_stepper_code = """Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step 1
                        Container(
                          width: 24, height: 24,
                          decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFF432CBB),
                          ),
                        ),
                        
                        // Step 2
                        Container(
                          width: 24, height: 24,
                          decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFF432CBB),
                          ),
                        ),
                        
                        // Step 3 (Active)
                        SizedBox(
                          width: 24, height: 24,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: 24, height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xFF432CBB), width: 2),
                                ),
                                child: Center(
                                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle)),
                                ),
                              ),
                              const Positioned(
                                top: 32,
                                child: Text(
                                  'Documents', 
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        
                        // Step 4
                        Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFD1D5DB), width: 2),
                          ),
                          child: const Center(child: Text('4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF)))),
                        ),
                      ],
                    )"""

# First, replace `_buildStepper()` with the inline_stepper_code.
# There are two occurrences: one inside the string, one in the mockup class.
content = content.replace('_buildStepper()', inline_stepper_code)

# Second, we need to remove the helper methods `_buildStepper`, `_buildStepItem`, `_buildStepCircle`, `_buildStepLine`
# They exist twice in the file.
# The methods start with `Widget _buildStepper() {` and end before the next class or end of string.

pattern = re.compile(r'  Widget _buildStepper\(\) \{.*?  \}\n', re.DOTALL)
content = pattern.sub('', content)

pattern = re.compile(r'  Widget _buildStepItem.*?  \}\n', re.DOTALL)
content = pattern.sub('', content)

pattern = re.compile(r'  Widget _buildStepCircle.*?  \}\n', re.DOTALL)
content = pattern.sub('', content)

pattern = re.compile(r'  Widget _buildStepLine.*?  \}\n', re.DOTALL)
content = pattern.sub('', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
