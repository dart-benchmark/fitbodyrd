#!/usr/bin/env python3
"""
Exception Registry Generator for FitBodyRD Server

This script automatically scans all *_exceptions.dart files in the server,
extracts exception information, and generates/updates the exception registry README.

Usage:
    python3 scripts/generate_exception_registry.py
    
Or make it executable:
    chmod +x scripts/generate_exception_registry.py
    ./scripts/generate_exception_registry.py
"""

import os
import re
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Tuple, Optional
from dataclasses import dataclass, field


@dataclass
class Exception:
    """Represents a single exception"""
    method_name: str
    error_code: int
    http_status: int
    message: str
    parameters: str = ""
    
    @property
    def full_signature(self) -> str:
        """Returns the full method signature"""
        return f"{self.method_name}({self.parameters})" if self.parameters else f"{self.method_name}()"


@dataclass
class ModuleExceptions:
    """Represents all exceptions for a module"""
    module_name: str
    module_range: str
    file_path: str
    exceptions: List[Exception] = field(default_factory=list)
    sub_modules: Dict[str, List[Exception]] = field(default_factory=dict)
    
    @property
    def count(self) -> int:
        return len(self.exceptions)
    
    @property
    def available(self) -> int:
        range_parts = self.module_range.split('-')
        if len(range_parts) == 2:
            start, end = int(range_parts[0]), int(range_parts[1])
            return (end - start + 1) - self.count
        return 0


class ExceptionParser:
    """Parses Dart exception files"""
    
    # Module code ranges
    MODULE_RANGES = {
        'generic': '1000-1999',
        'exercise': '2000-2999',
        'food': '3000-3999',
        'nutrition': '4000-4999',
        'nutrition_plan': '5000-5999',
        'user': '6000-6999',
        'workout': '7000-7999',
    }
    
    # Sub-module ranges (for organizing large modules)
    SUB_MODULE_RANGES = {
        'food': {
            'Categories': ('3000-3099', 'Food category operations'),
            'Food Items': ('3100-3199', 'Food item CRUD operations'),
            'Serving Sizes': ('3200-3299', 'Serving size management'),
            'Micronutrients': ('3300-3399', 'Micronutrient management'),
        }
    }
    
    def __init__(self, server_path: str):
        self.server_path = Path(server_path)
        self.modules: List[ModuleExceptions] = []
    
    def find_exception_files(self) -> List[Path]:
        """Find all *_exceptions.dart files"""
        exception_files = []
        for path in self.server_path.rglob('*_exceptions.dart'):
            if 'generated' not in str(path):  # Skip generated files
                exception_files.append(path)
        return sorted(exception_files)
    
    def extract_module_name(self, content: str) -> Optional[str]:
        """Extract module name from the static const String declaration"""
        # Try both _module and module patterns
        patterns = [
            r"static\s+const\s+String\s+_module\s*=\s*['\"](\w+)['\"]",
            r"static\s+const\s+String\s+module\s*=\s*['\"](\w+)['\"]",
        ]
        for pattern in patterns:
            match = re.search(pattern, content)
            if match:
                return match.group(1)
        return None
    
    def extract_exceptions(self, content: str) -> List[Exception]:
        """Extract all exception methods from file content"""
        exceptions = []
        
        # First, find all static AppException methods
        # Split by method to handle each separately
        method_starts = list(re.finditer(r'static\s+AppException\s+(\w+)\s*\(', content))
        
        for i, method_start in enumerate(method_starts):
            method_name = method_start.group(1)
            start_pos = method_start.start()
            
            # Find the end of this method (next method start or end of content)
            if i + 1 < len(method_starts):
                end_pos = method_starts[i + 1].start()
            else:
                end_pos = len(content)
            
            method_content = content[start_pos:end_pos]
            
            # Find the closing brace of this method
            brace_count = 0
            method_end = -1
            for j, char in enumerate(method_content):
                if char == '{':
                    brace_count += 1
                elif char == '}':
                    brace_count -= 1
                    if brace_count == 0:
                        method_end = j
                        break
            
            if method_end == -1:
                continue
            
            method_content = method_content[:method_end + 1]
            
            # Extract parameters
            param_match = re.search(r'static\s+AppException\s+\w+\s*\((.*?)\)\s*\{', method_content, re.DOTALL)
            if not param_match:
                continue
            parameters = param_match.group(1).strip()
            
            # Find the return AppException statement
            return_match = re.search(r'return\s+AppException\s*\((.*?)\);', method_content, re.DOTALL)
            if not return_match:
                continue
            
            exception_body = return_match.group(1)
            
            # Extract errorCode
            error_code_match = re.search(r'errorCode:\s*(\d+)', exception_body)
            if not error_code_match:
                continue
            error_code = int(error_code_match.group(1))
            
            # Extract httpStatus
            http_status_match = re.search(r'httpStatus:\s*(\d+)', exception_body)
            if not http_status_match:
                continue
            http_status = int(http_status_match.group(1))
            
            # Extract message - handle various formats
            message_field_match = re.search(r'message:\s*(.+?)(?:,\s*$|$)', exception_body, re.DOTALL | re.MULTILINE)
            if not message_field_match:
                continue
            
            message_content = message_field_match.group(1).strip().rstrip(',')
            
            # Handle ternary operators - extract both branches
            if '?' in message_content and ':' in message_content:
                # Try to extract both branches of the ternary (handles $var and ${var} interpolation)
                ternary_parts = re.findall(r'["\']([^"\']*(?:\$\{[^}]+\}[^"\']*|\$\w+[^"\']*)*)["\']\s*', message_content)
                if len(ternary_parts) >= 2:
                    message = f"{ternary_parts[0]} OR {ternary_parts[1]}"
                elif len(ternary_parts) == 1:
                    message = ternary_parts[0].strip()
                else:
                    message = "Dynamic message (ternary)"
            else:
                # Normal string extraction (handles $var and ${var} interpolation)
                string_match = re.search(r'["\']([^"\']*(?:\$\{[^}]+\}[^"\']*|\$\w+[^"\']*)*)["\']\s*', message_content)
                if string_match:
                    message = string_match.group(1).strip()
                else:
                    message = "Complex message"
            
            # Clean up message
            message = re.sub(r'\s+', ' ', message)
            
            # Clean up parameters
            if parameters:
                param_parts = []
                for param in parameters.split(','):
                    param = param.strip()
                    if param:
                        param = re.sub(r'\s+', ' ', param)
                        param_parts.append(param)
                parameters = ', '.join(param_parts)
            
            exceptions.append(Exception(
                method_name=method_name,
                error_code=error_code,
                http_status=http_status,
                message=message,
                parameters=parameters
            ))
        
        return sorted(exceptions, key=lambda e: e.error_code)
    
    def categorize_by_sub_module(self, module_name: str, exceptions: List[Exception]) -> Dict[str, List[Exception]]:
        """Categorize exceptions into sub-modules based on error code ranges"""
        if module_name not in self.SUB_MODULE_RANGES:
            return {}
        
        sub_modules = {}
        sub_module_config = self.SUB_MODULE_RANGES[module_name]
        
        for sub_name, (range_str, _) in sub_module_config.items():
            start, end = map(int, range_str.split('-'))
            sub_exceptions = [e for e in exceptions if start <= e.error_code <= end]
            if sub_exceptions:
                sub_modules[sub_name] = sub_exceptions
        
        return sub_modules
    
    def parse_file(self, file_path: Path) -> Optional[ModuleExceptions]:
        """Parse a single exception file"""
        content = file_path.read_text()
        
        module_name = self.extract_module_name(content)
        if not module_name:
            print(f"Warning: Could not extract module name from {file_path}")
            return None
        
        exceptions = self.extract_exceptions(content)
        if not exceptions:
            print(f"Warning: No exceptions found in {file_path}")
            return None
        
        # Get module range
        module_range = self.MODULE_RANGES.get(module_name, 'Unknown')
        
        # Get relative path from server root
        relative_path = file_path.relative_to(self.server_path)
        
        module = ModuleExceptions(
            module_name=module_name,
            module_range=module_range,
            file_path=str(relative_path),
            exceptions=exceptions
        )
        
        # Categorize by sub-modules if applicable
        module.sub_modules = self.categorize_by_sub_module(module_name, exceptions)
        
        return module
    
    def parse_all(self):
        """Parse all exception files"""
        files = self.find_exception_files()
        print(f"Found {len(files)} exception files")
        
        for file_path in files:
            print(f"Parsing {file_path.name}...")
            module = self.parse_file(file_path)
            if module:
                self.modules.append(module)
        
        # Sort modules by range start
        self.modules.sort(key=lambda m: int(m.module_range.split('-')[0]) if m.module_range != 'Unknown' else 999999)


class ReadmeGenerator:
    """Generates the exception registry README"""
    
    def __init__(self, parser: ExceptionParser):
        self.parser = parser
    
    def generate(self) -> str:
        """Generate complete README"""
        sections = []
        
        # Header
        sections.append(self._generate_header())
        
        # Overview table
        sections.append(self._generate_overview_table())
        
        # Module details
        for module in self.parser.modules:
            sections.append(self._generate_module_section(module))
        
        # Footer
        sections.append(self._generate_footer())
        
        return '\n\n'.join(sections)
    
    def _generate_header(self) -> str:
        """Generate README header"""
        total_exceptions = sum(m.count for m in self.parser.modules)
        total_available = sum(m.available for m in self.parser.modules)
        
        return f"""# Exception Registry

This document is automatically generated from the exception files in the codebase.

**Last Updated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Overview

- **Total Modules:** {len(self.parser.modules)}
- **Total Exceptions:** {total_exceptions}
- **Available Codes:** {total_available}"""
    
    def _generate_overview_table(self) -> str:
        """Generate overview table of all modules"""
        lines = [
            "## Module Overview",
            "",
            "| Module | Range | Defined | Available | File |",
            "|--------|-------|---------|-----------|------|"
        ]
        
        for module in self.parser.modules:
            lines.append(
                f"| {module.module_name.title()} | {module.module_range} | "
                f"{module.count} | {module.available} | `{module.file_path}` |"
            )
        
        return '\n'.join(lines)
    
    def _generate_module_section(self, module: ModuleExceptions) -> str:
        """Generate detailed section for a module"""
        lines = [
            f"## {module.module_name.title()} Module",
            "",
            f"**Range:** {module.module_range}  ",
            f"**File:** `{module.file_path}`  ",
            f"**Exceptions:** {module.count}  ",
            f"**Available:** {module.available}",
            ""
        ]
        
        # If module has sub-modules, organize by sub-module
        if module.sub_modules:
            for sub_name, sub_exceptions in module.sub_modules.items():
                lines.append(f"### {sub_name}")
                lines.append("")
                lines.extend(self._generate_exception_table(sub_exceptions))
                lines.append("")
        else:
            # Show all exceptions in a single table
            lines.extend(self._generate_exception_table(module.exceptions))
        
        return '\n'.join(lines)
    
    def _generate_exception_table(self, exceptions: List[Exception]) -> List[str]:
        """Generate exception table"""
        lines = [
            "| Code | HTTP | Method | Message |",
            "|------|------|--------|---------|"
        ]
        
        for exc in exceptions:
            lines.append(
                f"| {exc.error_code} | {exc.http_status} | "
                f"`{exc.full_signature}` | {exc.message} |"
            )
        
        return lines
    
    def _generate_footer(self) -> str:
        """Generate README footer"""
        return """---

## Adding New Exceptions

1. Add your exception method to the appropriate `*_exceptions.dart` file
2. Run `python3 scripts/generate_exception_registry.py` to update this README
3. Ensure your error code is within the module's range
4. Follow the naming conventions for consistency

## Error Code Ranges

Error codes are organized by module to prevent conflicts:

- **1000-1999**: Generic/System errors
- **2000-2999**: Exercise module
- **3000-3999**: Food module
- **4000-4999**: Nutrition module
- **5000-5999**: Nutrition Plan module
- **6000-6999**: User module
- **7000-7999**: Workout module

---
*This file is auto-generated. Do not edit manually.*"""


def main():
    """Main entry point"""
    # Get server path (script is in fitbodyrd_server/scripts/)
    script_dir = Path(__file__).parent
    server_path = script_dir.parent
    
    print("=" * 60)
    print("FitBodyRD Exception Registry Generator")
    print("=" * 60)
    print(f"Server path: {server_path}\n")
    
    # Parse exception files
    parser = ExceptionParser(str(server_path))
    parser.parse_all()
    
    print(f"\nFound {len(parser.modules)} modules")
    
    # Generate and write README
    generator = ReadmeGenerator(parser)
    readme_content = generator.generate()
    
    readme_path = server_path / 'lib' / 'src' / 'errors' / 'README.md'
    readme_path.write_text(readme_content)
    
    print(f"✅ Successfully generated README at: {readme_path}")


if __name__ == "__main__":
    main()