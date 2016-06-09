# morse-decode
Morse code decoder using the Altera DE2 board.

How it works: An audio signal with morse code is sent to the line-in input of the DE2's audio codec. The signal is analyzed to find the characters encoded within the morse code, and the letters and numbers are displayed on a VGA monitor.

Usage: Connect the line-in of the DE2 board to an audio source. When a morse signal is detected, the green LEDs will blink. Use the slide switches to set the words per minute that are decoded. The output will appear on the monitor.