# VHS tape file for JXL-Pure
Output assets/demo.gif

Set Shell bash
Set FontFamily "DejaVu Sans Mono"
Set FontSize 20
Set Width 800
Set Height 450
Set Padding 20
Set Theme "Catppuccin Mocha"
Set WindowBar Colorful
Set BorderRadius 10

# Initial Setup
Hide
Type "export PS1='\[\033[36m\]╭─\[\033[1;35m\]archlinux\[\033[0;36m\] ➜ \[\033[1;34m\]\W\[\033[0m\]\n\[\033[36m\]╰─➤ \[\033[0m\]'"
Enter
Type "mkdir -p demo_pics"
Enter
# Create real dummy images because cjxl fails on empty files
Type "convert -size 100x100 xc:white demo_pics/vacation_1.jpg"
Enter
Type "convert -size 100x100 xc:red demo_pics/vacation_2.jpg"
Enter
Type "convert -size 100x100 xc:blue demo_pics/vacation_3.jpg"
Enter
Type "convert -size 100x100 xc:green demo_pics/logo.png"
Enter
Type "clear"
Enter
Show

# Start the demo
Type "jxl-pure demo_pics/ --effort 3"
Sleep 500ms
Enter

# Wait for processing simulation
Sleep 2s

# Show help
Type "jxl-pure --help"
Sleep 500ms
Enter
Sleep 3s

# Clean up
Hide
Type "rm -rf demo_pics"
Enter
Show
