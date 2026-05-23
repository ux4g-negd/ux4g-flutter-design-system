path = r"C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories\data_stories.dart"

with open(path, encoding='utf-8') as f:
    lines = f.readlines()

print(f"Total lines: {len(lines)}")

# Find the indices of all 'final slotGridComponent' lines
indices = [i for i, l in enumerate(lines) if 'final slotGridComponent' in l]
print(f"slotGridComponent at 1-indexed lines: {[i+1 for i in indices]}")

if len(indices) == 2:
    first = indices[0]
    second = indices[1]
    # Keep lines before first, skip from first up to (but not including) second - 3 blank lines
    # The comment header before second is at second-2 (// ── SlotGrid ──)
    # We want to keep everything before the first duplicate start
    # Also remove the blank lines before the comment of the second block that follow the first block
    # Find where the first block ends: look for the ');\n' before the second comment
    # The second block's comment is at second-2 (two lines: blank + comment)
    cut_end = second - 3  # skip blank line before second block's blank line
    kept = lines[:first] + lines[cut_end:]
    with open(path, 'w', encoding='utf-8') as f:
        f.writelines(kept)
    print(f"Removed lines {first+1} to {cut_end} (1-indexed), kept {len(kept)} lines")
else:
    print("Expected 2 matches, found:", len(indices))
