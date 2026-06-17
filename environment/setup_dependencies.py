"""
setup_dependencies.py

Downloads the testbench dependencies.
"""

import os
import sys

# Make the current directory (for the subprocess) relative to the testbench program
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

python = sys.executable

# Download the dependencies
os.system(f"{python} -m pip install -r .{os.sep}dependencies.txt")

print("\nDependencies downloaded.")