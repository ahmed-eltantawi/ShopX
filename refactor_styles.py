import os
import re
import subprocess

lib_dir = "d:/projects/Flutter/new_shopx/lib"

def process_dart_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Skip files that define them
    if "class AppColors" in content or "class AppStyles" in content:
        return False
        
    original = content
        
    # AppColors.background -> AppColors.of(context).background
    content = re.sub(r'AppColors\.(?!of)(?!light)(?!dark)(?!appLight)(?!appDark)([a-zA-Z0-9_]+)', r'AppColors.of(context).\1', content)
    
    # AppStyles.bodySmall -> AppStyles.bodySmall(context)
    # Be careful not to replace it if it's already AppStyles.bodySmall(context)
    content = re.sub(r'AppStyles\.([a-zA-Z0-9_]+)(?!\()', r'AppStyles.\1(context)', content)

    if original != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

def fix_const_errors():
    print("Running flutter analyze to find const errors...")
    result = subprocess.run(['flutter', 'analyze'], capture_output=True, text=True, cwd="d:/projects/Flutter/new_shopx")
    lines = result.stdout.split('\n')
    
    # Parse errors like:
    # error • Invalid constant value • lib\screens\update_product\update_product_screen.dart:86:44 • invalid_annotation_constant_value_from_deferred_library
    # Actually, const errors look like:
    # error - Arguments of a constant creation must be constant expressions - lib\screens\update_product\update_product_screen.dart:40:20 - const_with_non_constant_argument
    # error - Cannot invoke a non-'const' constructor where a const expression is expected - ...
    # info - Don't use 'BuildContext's across asynchronous gaps - ...

    errors_fixed = 0
    for line in lines:
        if 'const' in line.lower() and ('error' in line or 'warning' in line):
            parts = line.split(' - ')
            if len(parts) >= 3:
                file_location_part = parts[-2].strip()
                # e.g., lib\screens\update_product\update_product_screen.dart:86:44
                loc_parts = file_location_part.split(':')
                if len(loc_parts) >= 2:
                    filepath = os.path.join("d:/projects/Flutter/new_shopx", loc_parts[0])
                    line_num = int(loc_parts[1]) - 1
                    
                    if os.path.exists(filepath):
                        with open(filepath, 'r', encoding='utf-8') as f:
                            file_lines = f.readlines()
                            
                        # Try to remove 'const ' from the line or previous line iteratively
                        target_line = file_lines[line_num]
                        # Just strip 'const ' naively
                        new_line = target_line.replace('const ', '')
                        if new_line != target_line:
                            file_lines[line_num] = new_line
                            with open(filepath, 'w', encoding='utf-8') as f:
                                f.writelines(file_lines)
                            errors_fixed += 1
                        else:
                            # Might be on previous line due to formatting
                            for offset in range(-1, -4, -1):
                                if line_num + offset >= 0:
                                    prev_line = file_lines[line_num + offset]
                                    new_prev_line = prev_line.replace('const ', '')
                                    if prev_line != new_prev_line:
                                        file_lines[line_num + offset] = new_prev_line
                                        with open(filepath, 'w', encoding='utf-8') as f:
                                            f.writelines(file_lines)
                                        errors_fixed += 1
                                        break
    return errors_fixed

# phase 1: regex
changed = 0
for root, _, files in os.walk(lib_dir):
    for f in files:
        if f.endswith('.dart'):
            if process_dart_file(os.path.join(root, f)):
                changed += 1

print(f"Phase 1: Updated {changed} files with regex.")

# phase 2: loop flutter analyze until no const errors fixed
loops = 0
while loops < 5:
    loops += 1
    fixed = fix_const_errors()
    print(f"Loop {loops}: fixed {fixed} const errors.")
    if fixed == 0:
        break

print("Done.")
