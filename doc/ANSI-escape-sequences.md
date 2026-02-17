# ANSI Escape Sequences

Standard escape codes are prefixed with `Escape`:

- Ctrl-Key: `^[`
- Octal: `\033`
- Unicode: `\u001b`
- Hexadecimal: `\x1B`
- Decimal: `27`

Followed by the command, somtimes delimited by opening square bracket (`[`), known as a Control Sequence Introducer (CSI), optionally followed by arguments and the command itself.

Arguments are delimeted by semi colon (`;`).

For example:

```sh
\x1b[1;31m  # Set style to bold, red foreground.
```

## Sequences

- `ESC` - sequence starting with `ESC` (`\x1B`)
- `CSI` - Control Sequence Introducer: sequence starting with `ESC [` or CSI (`\x9B`)
- `DCS` - Device Control String: sequence starting with `ESC P` or DCS (`\x90`)
- `OSC` - Operating System Command: sequence starting with `ESC ]` or OSC (`\x9D`)

Any whitespaces between sequences and arguments should be ignored. They are present for improved readability.

## General ASCII Codes

| Name  | decimal | octal | hex  | C-escape | Ctrl-Key | Description                    |
| ----- | ------- | ----- | ---- | -------- | -------- | ------------------------------ |
| `BEL` | 7       | 007   | 0x07 | `\a`     | `^G`     | Terminal bell                  |
| `BS`  | 8       | 010   | 0x08 | `\b`     | `^H`     | Backspace                      |
| `HT`  | 9       | 011   | 0x09 | `\t`     | `^I`     | Horizontal TAB                 |
| `LF`  | 10      | 012   | 0x0A | `\n`     | `^J`     | Linefeed (newline)             |
| `VT`  | 11      | 013   | 0x0B | `\v`     | `^K`     | Vertical TAB                   |
| `FF`  | 12      | 014   | 0x0C | `\f`     | `^L`     | Formfeed (also: New page `NP`) |
| `CR`  | 13      | 015   | 0x0D | `\r`     | `^M`     | Carriage return                |
| `ESC` | 27      | 033   | 0x1B | `\e`[*](#escape) | `^[` | Escape character           |
| `DEL` | 127     | 177   | 0x7F | `<none>` | `<none>` | Delete character               |

<div id="escape"></div>

> **Note:** Some control escape sequences, like `\e` for `ESC`, are not guaranteed to work in all languages and compilers. It is recommended to use the decimal, octal or hex representation as escape code.

  

> **Note:** The **Ctrl-Key** representation is simply associating the non-printable characters from ASCII code 1 with the printable (letter) characters from ASCII code 65 ("A"). ASCII code 1 would be `^A` (Ctrl-A), while ASCII code 7 (BEL) would be `^G` (Ctrl-G). This is a common representation (and input method) and historically comes from one of the VT series of terminals.

## Cursor Controls

> Hide cursor for 5 seconds
```shell
echo -e "\e[?25l" ; sleep 5 ; echo -e "\e[?25h"
```

| ESC Code Sequence                                  | Description                                              |
| :------------------------------------------------- | :------------------------------------------------------- |
| `ESC[H`                                            | moves cursor to home position (0, 0)                     |
| `ESC[{line};{column}H` <br> `ESC[{line};{column}f` | moves cursor to line #, column #                         |
| `ESC[#A`                                           | moves cursor up # lines                                  |
| `ESC[#B`                                           | moves cursor down # lines                                |
| `ESC[#C`                                           | moves cursor right # columns                             |
| `ESC[#D`                                           | moves cursor left # columns                              |
| `ESC[#E`                                           | moves cursor to beginning of next line, # lines down     |
| `ESC[#F`                                           | moves cursor to beginning of previous line, # lines up   |
| `ESC[#G`                                           | moves cursor to column #                                 |
| `ESC[6n`                                           | request cursor position (reports as `ESC[#;#R`)          |
| `ESC M`                                            | moves cursor one line up, scrolling if needed            |
| `ESC 7`                                            | save cursor position (DEC)                               |
| `ESC 8`                                            | restores the cursor to the last saved position (DEC)     |
| `ESC[s`                                            | save cursor position (SCO)                               |
| `ESC[u`                                            | restores the cursor to the last saved position (SCO)     |

> **Note:** Some sequences, like saving and restoring cursors, are private sequences and are not standardized. While some terminal emulators (i.e. xterm and derived) support both SCO and DEC sequences, they are likely to have different functionality. It is therefore recommended to use DEC sequences.

## Erase Functions

| ESC Code Sequence | Description                               |
| :---------------- | :---------------------------------------- |
| `ESC[J`           | erase in display (same as ESC\[0J)        |
| `ESC[0J`          | erase from cursor until end of screen     |
| `ESC[1J`          | erase from cursor to beginning of screen  |
| `ESC[2J`          | erase entire screen                       |
| `ESC[3J`          | erase saved lines                         |
| `ESC[K`           | erase in line (same as ESC\[0K)           |
| `ESC[0K`          | erase from cursor to end of line          |
| `ESC[1K`          | erase start of line to the cursor         |
| `ESC[2K`          | erase the entire line                     |

> Note: Erasing the line won't move the cursor, meaning that the cursor will stay at the last position it was at before the line was erased. You can use `\r` after erasing the line, to return the cursor to the start of the current line.

## Colors / Graphics Mode

| ESC Code Sequence | Reset Sequence | Description                                                |
| :---------------- | :------------- | :--------------------------------------------------------- |
| `ESC[1;34;{...}m` |                | Set graphics modes for cell, separated by semicolon (`;`). |
| `ESC[0m`          |                | reset all modes (styles and colors)                        |
| `ESC[1m`          | `ESC[22m`      | set bold mode.                                             |
| `ESC[2m`          | `ESC[22m`      | set dim/faint mode.                                        |
| `ESC[3m`          | `ESC[23m`      | set italic mode.                                           |
| `ESC[4m`          | `ESC[24m`      | set underline mode.                                        |
| `ESC[5m`          | `ESC[25m`      | set blinking mode                                          |
| `ESC[7m`          | `ESC[27m`      | set inverse/reverse mode                                   |
| `ESC[8m`          | `ESC[28m`      | set hidden/invisible mode                                  |
| `ESC[9m`          | `ESC[29m`      | set strikethrough mode.                                    |

> **Note:** Some terminals may not support some of the graphic mode sequences listed above.

> **Note:** Both dim and bold modes are reset with the `ESC[22m` sequence. The `ESC[21m` sequence is a non-specified sequence for double underline mode and only work in some terminals and is reset with `ESC[24m`.

### Color codes

Most terminals support 8 and 16 colors, as well as 256 (8-bit) colors. These colors are set by the user, but have commonly defined meanings.

#### 8-16 Colors

| Color Name | Foreground Color Code | Background Color Code |
| :--------- | :-------------------- | :-------------------- |
| Black      | `30`                  | `40`                  |
| Red        | `31`                  | `41`                  |
| Green      | `32`                  | `42`                  |
| Yellow     | `33`                  | `43`                  |
| Blue       | `34`                  | `44`                  |
| Magenta    | `35`                  | `45`                  |
| Cyan       | `36`                  | `46`                  |
| White      | `37`                  | `47`                  |
| Default    | `39`                  | `49`                  |
| Reset      | `0`                   | `0`                   |

> **Note:** the _Reset_ color is the reset code that resets _all_ colors and text effects, Use _Default_ color to reset colors only.

Most terminals, apart from the basic set of 8 colors, also support the "bright" or "bold" colors. These have their own set of codes, mirroring the normal colors, but with an additional `;1` in their codes:

```sh
# Set style to bold, red foreground.
\x1b[1;31mHello
# Set style to dimmed white foreground with red background.
\x1b[2;37;41mWorld
```

Terminals that support the [aixterm specification](https://sites.ualberta.ca/dept/chemeng/AIX-43/share/man/info/C/a_doc_lib/cmds/aixcmds1/aixterm.htm) provides bright versions of the ISO colors, without the need to use the bold modifier:

| Color Name     | Foreground Color Code | Background Color Code |
| :------------- | :-------------------- | :-------------------- |
| Bright Black   | `90`                  | `100`                 |
| Bright Red     | `91`                  | `101`                 |
| Bright Green   | `92`                  | `102`                 |
| Bright Yellow  | `93`                  | `103`                 |
| Bright Blue    | `94`                  | `104`                 |
| Bright Magenta | `95`                  | `105`                 |
| Bright Cyan    | `96`                  | `106`                 |
| Bright White   | `97`                  | `107`                 |

#### 256 Colors

The following escape codes tells the terminal to use the given color ID:

| ESC Code Sequence | Description           |
| :---------------- | :-------------------- |
| `ESC[38;5;{ID}m` | Set foreground color. |
| `ESC[48;5;{ID}m` | Set background color. |

Where `{ID}` should be replaced with the color index from 0 to 255 of the following color table:

![256 Color table](https://user-images.githubusercontent.com/995050/47952855-ecb12480-df75-11e8-89d4-ac26c50e80b9.png)

The table starts with the original 16 colors (0-15).

The proceeding 216 colors (16-231) or formed by a 3bpc RGB value offset by 16, packed into a single value.

The final 24 colors (232-255) are grayscale starting from a shade slighly lighter than black, ranging up to shade slightly darker than white.

Some emulators interpret these steps as linear increments (`256 / 24`) on all three channels, although some emulators may explicitly define these values.

#### RGB Colors

More modern terminals supports [Truecolor](https://en.wikipedia.org/wiki/Color_depth#True_color_.2824-bit.29) (24-bit RGB), which allows you to set foreground and background colors using RGB.

These escape sequences are usually not well documented.

| ESC Code Sequence       | Description                  |
| :---------------------- | :--------------------------- |
| `ESC[38;2;{r};{g};{b}m` | Set foreground color as RGB. |
| `ESC[48;2;{r};{g};{b}m` | Set background color as RGB. |

> Note that `;38` and `;48` corresponds to the 16 color sequence and is interpreted by the terminal to set the foreground and background color respectively. Where as `;2` and `;5` sets the color format.

## Screen Modes

### Set Mode

| ESC Code Sequence | Description                                                                                                                                                           |
| :---------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ESC[={value}h`   | Changes the screen width or type to the mode specified by value.                                                                                                      |
| `ESC[=0h`         | 40 x 25 monochrome (text)                                                                                                                                             |
| `ESC[=1h`         | 40 x 25 color (text)                                                                                                                                                  |
| `ESC[=2h`         | 80 x 25 monochrome (text)                                                                                                                                             |
| `ESC[=3h`         | 80 x 25 color (text)                                                                                                                                                  |
| `ESC[=4h`         | 320 x 200 4-color (graphics)                                                                                                                                          |
| `ESC[=5h`         | 320 x 200 monochrome (graphics)                                                                                                                                       |
| `ESC[=6h`         | 640 x 200 monochrome (graphics)                                                                                                                                       |
| `ESC[=7h`         | Enables line wrapping                                                                                                                                                 |
| `ESC[=13h`        | 320 x 200 color (graphics)                                                                                                                                            |
| `ESC[=14h`        | 640 x 200 color (16-color graphics)                                                                                                                                   |
| `ESC[=15h`        | 640 x 350 monochrome (2-color graphics)                                                                                                                               |
| `ESC[=16h`        | 640 x 350 color (16-color graphics)                                                                                                                                   |
| `ESC[=17h`        | 640 x 480 monochrome (2-color graphics)                                                                                                                               |
| `ESC[=18h`        | 640 x 480 color (16-color graphics)                                                                                                                                   |
| `ESC[=19h`        | 320 x 200 color (256-color graphics)                                                                                                                                  |
| `ESC[={value}l`   | Resets the mode by using the same values that Set Mode uses, except for 7, which disables line wrapping. The last character in this escape sequence is a lowercase L. |

### Common Private Modes

These are some examples of private modes, which are not defined by the specification, but are implemented in most terminals.

| ESC Code Sequence | Description                     |
| :---------------- | :------------------------------ |
| `ESC[?25l`        | make cursor invisible           |
| `ESC[?25h`        | make cursor visible             |
| `ESC[?47l`        | restore screen                  |
| `ESC[?47h`        | save screen                     |
| `ESC[?1049h`      | enables the alternative buffer  |
| `ESC[?1049l`      | disables the alternative buffer |

Refer to the [XTerm Control Sequences](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html) for a more in-depth list of private modes defined by XTerm.

> Note: While these modes may be supported by the most terminals, some may not work in multiplexers like tmux.

### Keyboard Strings

```sh
ESC[{code};{string};{...}p
```

Redefines a keyboard key to a specified string.

The parameters for this escape sequence are defined as follows:

- `code` is one or more of the values listed in the following table. These values represent keyboard keys and key combinations. When using these values in a command, you must type the semicolons shown in this table in addition to the semicolons required by the escape sequence. The codes in parentheses are not available on some keyboards. `ANSI.SYS` will not interpret the codes in parentheses for those keyboards unless you specify the `/X` switch in the `DEVICE` command for `ANSI.SYS`.

- `string` is either the ASCII code for a single character or a string contained in quotation marks. For example, both 65 and "A" can be used to represent an uppercase A.

> **IMPORTANT:** Some of the values in the following table are not valid for all computers. Check your computer's documentation for values that are different.

#### List of keyboard strings

| Key                      | Code     | SHIFT+code | CTRL+code | ALT+code  |
| ------------------------ | -------- | ---------- | --------- | --------- |
| F1                       | 0;59     | 0;84       | 0;94      | 0;104     |
| F2                       | 0;60     | 0;85       | 0;95      | 0;105     |
| F3                       | 0;61     | 0;86       | 0;96      | 0;106     |
| F4                       | 0;62     | 0;87       | 0;97      | 0;107     |
| F5                       | 0;63     | 0;88       | 0;98      | 0;108     |
| F6                       | 0;64     | 0;89       | 0;99      | 0;109     |
| F7                       | 0;65     | 0;90       | 0;100     | 0;110     |
| F8                       | 0;66     | 0;91       | 0;101     | 0;111     |
| F9                       | 0;67     | 0;92       | 0;102     | 0;112     |
| F10                      | 0;68     | 0;93       | 0;103     | 0;113     |
| F11                      | 0;133    | 0;135      | 0;137     | 0;139     |
| F12                      | 0;134    | 0;136      | 0;138     | 0;140     |
| HOME (num keypad)        | 0;71     | 55         | 0;119     | \--       |
| UP ARROW (num keypad)    | 0;72     | 56         | (0;141)   | \--       |
| PAGE UP (num keypad)     | 0;73     | 57         | 0;132     | \--       |
| LEFT ARROW (num keypad)  | 0;75     | 52         | 0;115     | \--       |
| RIGHT ARROW (num keypad) | 0;77     | 54         | 0;116     | \--       |
| END (num keypad)         | 0;79     | 49         | 0;117     | \--       |
| DOWN ARROW (num keypad)  | 0;80     | 50         | (0;145)   | \--       |
| PAGE DOWN (num keypad)   | 0;81     | 51         | 0;118     | \--       |
| INSERT (num keypad)      | 0;82     | 48         | (0;146)   | \--       |
| DELETE (num keypad)      | 0;83     | 46         | (0;147)   | \--       |
| HOME                     | (224;71) | (224;71)   | (224;119) | (224;151) |
| UP ARROW                 | (224;72) | (224;72)   | (224;141) | (224;152) |
| PAGE UP                  | (224;73) | (224;73)   | (224;132) | (224;153) |
| LEFT ARROW               | (224;75) | (224;75)   | (224;115) | (224;155) |
| RIGHT ARROW              | (224;77) | (224;77)   | (224;116) | (224;157) |
| END                      | (224;79) | (224;79)   | (224;117) | (224;159) |
| DOWN ARROW               | (224;80) | (224;80)   | (224;145) | (224;154) |
| PAGE DOWN                | (224;81) | (224;81)   | (224;118) | (224;161) |
| INSERT                   | (224;82) | (224;82)   | (224;146) | (224;162) |
| DELETE                   | (224;83) | (224;83)   | (224;147) | (224;163) |
| PRINT SCREEN             | \--      | \--        | 0;114     | \--       |
| PAUSE/BREAK              | \--      | \--        | 0;0       | \--       |
| BACKSPACE                | 8        | 8          | 127       | (0)       |
| ENTER                    | 13       | \--        | 10        | (0        |
| TAB                      | 9        | 0;15       | (0;148)   | (0;165)   |
| NULL                     | 0;3      | \--        | \--       | \--       |
| A                        | 97       | 65         | 1         | 0;30      |
| B                        | 98       | 66         | 2         | 0;48      |
| C                        | 99       | 66         | 3         | 0;46      |
| D                        | 100      | 68         | 4         | 0;32      |
| E                        | 101      | 69         | 5         | 0;18      |
| F                        | 102      | 70         | 6         | 0;33      |
| G                        | 103      | 71         | 7         | 0;34      |
| H                        | 104      | 72         | 8         | 0;35      |
| I                        | 105      | 73         | 9         | 0;23      |
| J                        | 106      | 74         | 10        | 0;36      |
| K                        | 107      | 75         | 11        | 0;37      |
| L                        | 108      | 76         | 12        | 0;38      |
| M                        | 109      | 77         | 13        | 0;50      |
| N                        | 110      | 78         | 14        | 0;49      |
| O                        | 111      | 79         | 15        | 0;24      |
| P                        | 112      | 80         | 16        | 0;25      |
| Q                        | 113      | 81         | 17        | 0;16      |
| R                        | 114      | 82         | 18        | 0;19      |
| S                        | 115      | 83         | 19        | 0;31      |
| T                        | 116      | 84         | 20        | 0;20      |
| U                        | 117      | 85         | 21        | 0;22      |
| V                        | 118      | 86         | 22        | 0;47      |
| W                        | 119      | 87         | 23        | 0;17      |
| X                        | 120      | 88         | 24        | 0;45      |
| Y                        | 121      | 89         | 25        | 0;21      |
| Z                        | 122      | 90         | 26        | 0;44      |
| 1                        | 49       | 33         | \--       | 0;120     |
| 2                        | 50       | 64         | 0         | 0;121     |
| 3                        | 51       | 35         | \--       | 0;122     |
| 4                        | 52       | 36         | \--       | 0;123     |
| 5                        | 53       | 37         | \--       | 0;124     |
| 6                        | 54       | 94         | 30        | 0;125     |
| 7                        | 55       | 38         | \--       | 0;126     |
| 8                        | 56       | 42         | \--       | 0;126     |
| 9                        | 57       | 40         | \--       | 0;127     |
| 0                        | 48       | 41         | \--       | 0;129     |
| \-                       | 45       | 95         | 31        | 0;130     |
| \=                       | 61       | 43         | \---      | 0;131     |
| \[                       | 91       | 123        | 27        | 0;26      |
| \]                       | 93       | 125        | 29        | 0;27      |
|                          | 92       | 124        | 28        | 0;43      |
| ;                        | 59       | 58         | \--       | 0;39      |
| '                        | 39       | 34         | \--       | 0;40      |
| ,                        | 44       | 60         | \--       | 0;51      |
| .                        | 46       | 62         | \--       | 0;52      |
| /                        | 47       | 63         | \--       | 0;53      |
| \`                       | 96       | 126        | \--       | (0;41)    |
| ENTER (keypad)           | 13       | \--        | 10        | (0;166)   |
| / (keypad)               | 47       | 47         | (0;142)   | (0;74)    |
| \* (keypad)              | 42       | (0;144)    | (0;78)    | \--       |
| \- (keypad)              | 45       | 45         | (0;149)   | (0;164)   |
| \+ (keypad)              | 43       | 43         | (0;150)   | (0;55)    |
| 5 (keypad)               | (0;76)   | 53         | (0;143)   | \--       |

## Resources

- [Wikipedia: ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code)
- [Build your own Command Line with ANSI escape codes](http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html)
- [ascii-table: ANSI Escape sequences](http://ascii-table.com/ansi-escape-sequences.php)
- [bluesock: ansi codes](https://bluesock.org/~willkg/dev/ansi.html)
- [bash-hackers: Terminal Codes (ANSI/VT100) introduction](http://wiki.bash-hackers.org/scripting/terminalcodes)
- [XTerm Control Sequences](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html)
- [VT100 – Various terminal manuals](https://vt100.net/)
- [xterm.js – Supported Terminal Sequences](https://xtermjs.org/docs/api/vtfeatures/)

<details>
<summary><em>click to expand</em>⣿⣿⣷⣶⣦⣤⣄⣀⡀  <b>Control Characters</b> - <a href="https://vt100.net/docs/vt100-ug/chapter3.html"><b><em>VT100 User Guide</em</b></a></summary>



[Control Characters](https://vt100.net/docs/vt100-ug/chapter3.html)

Control characters have values of 0008 - 0378, and 1778. The control characters recognized by the VT100 are shown in Table 3-10. All other control codes cause no action to be taken.

Control characters (codes 08 to 378 inclusive) are specifically excluded from the control sequence syntax, but may be embedded within a control sequence. Embedded control characters are executed as soon as they are encountered by the VT100. The processing of the control sequence then continues with the next character received. The exceptions are: if the character ESC occurs, the current control sequence is aborted, and a new one commences beginning with the ESC just received. If the character CAN (308) or the character SUB (328) occurs, the current control sequence is aborted. The ability to embed control characters allows the synchronization characters XON and XOFF to be interpreted properly without affecting the control sequence.
Table 3-10 Control Characters Control Character   Octal Code  Action Taken
NUL   000   Ignored on input (not stored in input buffer; see full duplex protocol).
ENQ   005   Transmit answerback message.
BEL   007   Sound bell tone from keyboard.
BS  010   Move the cursor to the left one character position, unless it is at the left margin, in which case no action occurs.
HT  011   Move the cursor to the next tab stop, or to the right margin if no further tab stops are present on the line.
LF  012   This code causes a line feed or a new line operation. (See new line mode).
VT  013   Interpreted as LF.
FF  014   Interpreted as LF.
CR  015   Move cursor to the left margin on the current line.
SO  016   Invoke G1 character set, as designated by SCS control sequence.
SI  017   Select G0 character set, as selected by ESC ( sequence.
XON   021   Causes terminal to resume transmission.
XOFF  023   Causes terminal to stop transmitted all codes except XOFF and XON.
CAN   030   If sent during a control sequence, the sequence is immediately terminated and not executed. It also causes the error character to be displayed.
SUB   032   Interpreted as CAN.
ESC   033   Invokes a control sequence.
DEL   177   Ignored on input (not stored in input buffer).
Control Sequences

The VT100 is an upward and downward software compatible terminal; that is, previous DIGITAL video terminals have DIGITAL private standards for control sequences. The American National Standards Institute (ANSI) has since standardized escape and control sequences in terminals in documents X3.41-1974 and X3.64-1977.

NOTE: The ANSI standards allow the manufacturer flexibility in implementing each function. This manual describes how the VT100 will respond to the implemented ANSI control function.

The VT100 is compatible with both the previous DIGITAL standard and ANSI standards. Customers may use existing DIGITAL software designed around the VT52 or new VT100 software. The VT100 has a “VT52 compatible” mode in which the VT100 responds to control sequences like a VT52. In this mode, most of the new VT100 features cannot be used.

Throughout this section of the manual, references will be made to “VT52 mode” or “ANSI mode.” These two terms are used to indicate the VT100’s software compatibility. All new software should be designed around the VT100 “ANSI mode.” Future DIGITAL video terminals will not necessarily be committed to VT52 compatibility.

NOTE: ANSI standards may be obtained by writing:
Sales Department
American National Standards Institute
1430 Broadway
New York, New York 10018
Valid ANSI Mode Control Sequences
Definitions

The following listing defines the basic elements of the ANSI mode control sequences. A more complete listing appears in Appendix A.

Control Sequence Introducer (CSI)
    An escape sequence that provides supplementary controls and is itself a prefix affecting the interpretation of a limited number of contiguous characters. In the VT100 the CSI is ESC [.
    Parameter
    
            A string of zero or more decimal characters which represent a single value. Leading zeroes are ignored. The decimal characters have a range of 0 (608) to 9 (718).
                    The value so represented.
                    
                    Numeric Parameter
                        A parameter that represents a number, designated by Pn.
                        Selective Parameter
                            A parameter that selects a subfunction from a specified list of subfunctions, designated by Ps. In general, a control sequence with more than one selective parameter causes the same effect as several control sequences, each with one selective parameter, e.g., CSI Psa; Psb; Psc F is identical to CSI Psa F CSI Psb F CSI Psc F.
                            Parameter String
                                A string of parameters separated by a semicolon (738).
                                Default
                                    A function-dependent value that is assumed when no explicit value, or a value of 0, is specified.
                                    Final character
                                        A character whose bit combination terminates an escape or control sequence.
                                        
                                        Examples:
                                        
                                            Control sequence for double-width line (DECDWL) ESC # 6
                                                Sequence  Octal Representation of Sequence
                                                      
                                                      
                                                          Control sequence to turn off all character attributes, and then turn on underscore and blink attributes (SGR). ESC [ 0 ; 4 ; 5 m
                                                              Sequence  Octal Representation of Sequence
                                                                    
                                                                    
                                                                    Alternative sequences which will accomplish the same thing:
                                                                        Sequence  Octal Representation of Sequence
                                                                        a.  ESC [ ; 4 ; 5 m   033 133 073 064 073 065 155
                                                                        b.  ESC [ m   033 133 155
                                                                        ESC [ 4 m   033 133 064 155
                                                                        ESC [ 5 m   033 133 065 155
                                                                        c.  ESC [ 0 ; 04; 005 m     033 133 060 073 060 064 073 060 060 065 155
                                                                        Control Sequences
                                                                        
                                                                        All of the following escape and control sequences are transmitted from the host computer to the VT100 unless otherwise noted. All of the control sequences are a subset of those specified in ANSI X3.64-1977 and ANSI X3.41-1974.
                                                                        CPR – Cursor Position Report – VT100 to Host
                                                                        ESC [ Pn ; Pn R   default value: 1
                                                                        
                                                                        The CPR sequence reports the active position by means of the parameters. This sequence has two parameter values, the first specifying the line and the second specifying the column. The default condition with no parameters present, or parameters of 0, is equivalent to a cursor at home position.
                                                                        
                                                                        The numbering of lines depends on the state of the Origin Mode (DECOM).
                                                                        
                                                                        This control sequence is solicited by a device status report (DSR) sent from the host.
                                                                        CUB – Cursor Backward – Host to VT100 and VT100 to Host
                                                                        ESC [ Pn D  default value: 1
                                                                        
                                                                        The CUB sequence moves the active position to the left. The distance moved is determined by the parameter. If the parameter value is zero or one, the active position is moved one position to the left. If the parameter value is n, the active position is moved n positions to the left. If an attempt is made to move the cursor to the left of the left margin, the cursor stops at the left margin. Editor Function
                                                                        CUD – Cursor Down – Host to VT100 and VT100 to Host
                                                                        ESC [ Pn B  default value: 1
                                                                        
                                                                        The CUD sequence moves the active position downward without altering the column position. The number of lines moved is determined by the parameter. If the parameter value is zero or one, the active position is moved one line downward. If the parameter value is n, the active position is moved n lines downward. In an attempt is made to move the cursor below the bottom margin, the cursor stops at the bottom margin. Editor Function
                                                                        CUF – Cursor Forward – Host to VT100 and VT100 to Host
                                                                        ESC [ Pn C  default value: 1
                                                                        
                                                                        The CUF sequence moves the active position to the right. The distance moved is determined by the parameter. A parameter value of zero or one moves the active position one position to the right. A parameter value of n moves the active position n positions to the right. If an attempt is made to move the cursor to the right of the right margin, the cursor stops at the right margin. Editor Function
                                                                        CUP – Cursor Position
                                                                        ESC [ Pn ; Pn H   default value: 1
                                                                        
                                                                        The CUP sequence moves the active position to the position specified by the parameters. This sequence has two parameter values, the first specifying the line position and the second specifying the column position. A parameter value of zero or one for the first or second parameter moves the active position to the first line or column in the display, respectively. The default condition with no parameters present is equivalent to a cursor to home action. In the VT100, this control behaves identically with its format effector counterpart, HVP. Editor Function
                                                                        
                                                                        The numbering of lines depends on the state of the Origin Mode (DECOM).
                                                                        CUU – Cursor Up – Host to VT100 and VT100 to Host
                                                                        ESC [ Pn A  default value: 1
                                                                        
                                                                        Moves the active position upward without altering the column position. The number of lines moved is determined by the parameter. A parameter value of zero or one moves the active position one line upward. A parameter value of n moves the active position n lines upward. If an attempt is made to move the cursor above the top margin, the cursor stops at the top margin. Editor Function
                                                                        DA – Device Attributes
                                                                        ESC [ Pn c  default value: 0
                                                                        
                                                                            The host requests the VT100 to send a device attributes (DA) control sequence to identify itself by sending the DA control sequence with either no parameter or a parameter of 0.
                                                                                Response to the request described above (VT100 to host) is generated by the VT100 as a DA control sequence with the numeric parameters as follows:
                                                                                    Option Present  Sequence Sent
                                                                                        No options  ESC [?1;0c
                                                                                            Processor option (STP)  ESC [?1;1c
                                                                                                Advanced video option (AVO)   ESC [?1;2c
                                                                                                    AVO and STP   ESC [?1;3c
                                                                                                        Graphics option (GPO)   ESC [?1;4c
                                                                                                            GPO and STP   ESC [?1;5c
                                                                                                                GPO and AVO   ESC [?1;6c
                                                                                                                    GPO, STP and AVO  ESC [?1;7c
                                                                                                                    
                                                                                                                    DECALN – Screen Alignment Display (DEC Private)
                                                                                                                    ESC # 8    
                                                                                                                    
                                                                                                                    This command fills the entire screen area with uppercase Es for screen focus and alignment. This command is used by DEC manufacturing and Field Service personnel.
                                                                                                                    DECANM – ANSI/VT52 Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes only VT52 compatible escape sequences to be interpreted and executed. The set state causes only ANSI "compatible" escape and control sequences to be interpreted and executed.
                                                                                                                    DECARM – Auto Repeat Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes no keyboard keys to auto-repeat. The set state causes certain keyboard keys to auto-repeat.
                                                                                                                    DECAWM – Autowrap Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes any displayable characters received when the cursor is at the right margin to replace any previous characters there. The set state causes these characters to advance to the start of the next line, doing a scroll up if required and permitted.
                                                                                                                    DECCKM – Cursor Keys Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. This mode is only effective when the terminal is in keypad application mode (see DECKPAM) and the ANSI/VT52 mode (DECANM) is set (see DECANM). Under these conditions, if the cursor key mode is reset, the four cursor function keys will send ANSI cursor control commands. If cursor key mode is set, the four cursor function keys will send application functions.
                                                                                                                    DECCOLM – Column Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes a maximum of 80 columns on the screen. The set state causes a maximum of 132 columns on the screen.
                                                                                                                    DECDHL – Double Height Line (DEC Private)
                                                                                                                    Top Half: ESC # 3    
                                                                                                                    Bottom Half: ESC # 4   
                                                                                                                    
                                                                                                                    These sequences cause the line containing the active position to become the top or bottom half of a double-height double-width line. The sequences must be used in pairs on adjacent lines and the same character output must be sent to both lines to form full double-height characters. If the line was single-width single-height, all characters to the right of the center of the screen are lost. The cursor remains over the same character position unless it would be to the right of the right margin, in which case it is moved to the right margin.
                                                                                                                    
                                                                                                                    NOTE: The use of double-width characters reduces the number of characters per line by half.
                                                                                                                    DECDWL – Double-Width Line (DEC Private)
                                                                                                                    ESC # 6    
                                                                                                                    
                                                                                                                    This causes the line that contains the active position to become double-width single-height. If the line was single-width single-height, all characters to the right of the screen are lost. The cursor remains over the same character position unless it would be to the right of the right margin, in which case, it is moved to the right margin.
                                                                                                                    
                                                                                                                    NOTE: The use of double-width characters reduces the number of characters per line by half.
                                                                                                                    DECID – Identify Terminal (DEC Private)
                                                                                                                    ESC Z    
                                                                                                                    
                                                                                                                    This sequence causes the same response as the ANSI device attributes (DA). This sequence will not be supported in future DEC terminals, therefore, DA should be used by any new software.
                                                                                                                    DECINLM – Interlace Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state (non-interlace) causes the video processor to display 240 scan lines per frame. The set state (interlace) causes the video processor to display 480 scan lines per frame. There is no increase in character resolution.
                                                                                                                    DECKPAM – Keypad Application Mode (DEC Private)
                                                                                                                    ESC =    
                                                                                                                    
                                                                                                                    The auxiliary keypad keys will transmit control sequences as defined in Tables 3-7 and 3-8.
                                                                                                                    DECKPNM – Keypad Numeric Mode (DEC Private)
                                                                                                                    ESC >    
                                                                                                                    
                                                                                                                    The auxiliary keypad keys will send ASCII codes corresponding to the characters engraved on the keys.
                                                                                                                    DECLL – Load LEDS (DEC Private)
                                                                                                                    ESC [ Ps q  default value: 0
                                                                                                                    
                                                                                                                    Load the four programmable LEDs on the keyboard according to the parameter(s).
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Clear LEDs L1 through L4
                                                                                                                    1   Light L1
                                                                                                                    2   Light L2
                                                                                                                    3   Light L3
                                                                                                                    4   Light L4
                                                                                                                    
                                                                                                                    LED numbers are indicated on the keyboard.
                                                                                                                    DECOM – Origin Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes the origin to be at the upper-left character position on the screen. Line and column numbers are, therefore, independent of current margin settings. The cursor may be positioned outside the margins with a cursor position (CUP) or horizontal and vertical position (HVP) control.
                                                                                                                    
                                                                                                                    The set state causes the origin to be at the upper-left character position within the margins. Line and column numbers are therefore relative to the current margin settings. The cursor is not allowed to be positioned outside the margins.
                                                                                                                    
                                                                                                                    The cursor is moved to the new home position when this mode is set or reset.
                                                                                                                    
                                                                                                                    Lines and columns are numbered consecutively, with the origin being line 1, column 1.
                                                                                                                    DECRC – Restore Cursor (DEC Private)
                                                                                                                    ESC 8    
                                                                                                                    
                                                                                                                    This sequence causes the previously saved cursor position, graphic rendition, and character set to be restored.
                                                                                                                    DECREPTPARM – Report Terminal Parameters
                                                                                                                    ESC [ <sol>; <par>; <nbits>; <xspeed>; <rspeed>; <clkmul>; <flags> x   
                                                                                                                    
                                                                                                                    These sequence parameters are explained below in the DECREQTPARM sequence.
                                                                                                                    DECREQTPARM – Request Terminal Parameters
                                                                                                                    ESC [ <sol> x    
                                                                                                                    
                                                                                                                    The sequence DECREPTPARM is sent by the terminal controller to notify the host of the status of selected terminal parameters. The status sequence may be sent when requested by the host or at the terminal’s discretion. DECREPTPARM is sent upon receipt of a DECREQTPARM. On power-up or reset, the VT100 is inhibited from sending unsolicited reports.
                                                                                                                    
                                                                                                                    The meanings of the sequence parameters are:
                                                                                                                    Parameter   Value   Meaning
                                                                                                                    <sol>   0 or none   This message is a request (DECREQTPARM) and the terminal will be allowed to send unsolicited reports. (Unsolicited reports are sent when the terminal exits the SET-UP mode).
                                                                                                                    1   This message is a request; from now on the terminal may only report in response to a request.
                                                                                                                    2   This message is a report (DECREPTPARM).
                                                                                                                    3   This message is a report and the terminal is only reporting on request.
                                                                                                                    <par>   1   No parity set
                                                                                                                    4   Parity is set and odd
                                                                                                                    5   Parity is set and even
                                                                                                                    <nbits>   1   8 bits per character
                                                                                                                    2   7 bits per character
                                                                                                                    <xspeed>, <rspeed>  ⎧   0   50  ⎫   
                                                                                                                    ⎪   8   75  ⎪
                                                                                                                    ⎪   16  110   ⎪
                                                                                                                    ⎪   24  134.5   ⎪
                                                                                                                    ⎪   32  150   ⎪
                                                                                                                    ⎪   40  200   ⎪
                                                                                                                    ⎪   48  300   ⎪
                                                                                                                    ⎨   56  600   ⎬   Bits per second
                                                                                                                    ⎪   64  1200  ⎪   
                                                                                                                    ⎪   72  1800  ⎪
                                                                                                                    ⎪   80  2000  ⎪
                                                                                                                    ⎪   88  2400  ⎪
                                                                                                                    ⎪   96  3600  ⎪
                                                                                                                    ⎪   104   4800  ⎪
                                                                                                                    ⎪   112   9600  ⎪
                                                                                                                    ⎩   120   19200   ⎭
                                                                                                                    <clkmul>  1   The bit rate multiplier is 16.
                                                                                                                    <flags>   0-15  This value communicates the four switch values in block 5 of SET UP B, which are only visible to the user when an STP option is installed. These bits may be assigned for an STP device. The four bits are a decimal-encoded binary number.
                                                                                                                    DECSC – Save Cursor (DEC Private)
                                                                                                                    ESC 7    
                                                                                                                    
                                                                                                                    This sequence causes the cursor position, graphic rendition, and character set to be saved. (See DECRC).
                                                                                                                    DECSCLM – Scrolling Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes scrolls to "jump" instantaneously. The set state causes scrolls to be "smooth" at a maximum rate of six lines per second.
                                                                                                                    DECSCNM – Screen Mode (DEC Private)
                                                                                                                    
                                                                                                                    This is a private parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes the screen to be black with white characters. The set state causes the screen to be white with black characters.
                                                                                                                    DECSTBM – Set Top and Bottom Margins (DEC Private)
                                                                                                                    ESC [ Pn; Pn r  default values: see below
                                                                                                                    
                                                                                                                    This sequence sets the top and bottom margins to define the scrolling region. The first parameter is the line number of the first line in the scrolling region; the second parameter is the line number of the bottom line in the scrolling region. Default is the entire screen (no margins). The minimum size of the scrolling region allowed is two lines, i.e., the top margin must be less than the bottom margin. The cursor is placed in the home position (see Origin Mode DECOM).
                                                                                                                    DECSWL – Single-width Line (DEC Private)
                                                                                                                    ESC # 5    
                                                                                                                    
                                                                                                                    This causes the line which contains the active position to become single-width single-height. The cursor remains on the same character position. This is the default condition for all new lines on the screen.
                                                                                                                    DECTST – Invoke Confidence Test
                                                                                                                    ESC [ 2 ; Ps y   
                                                                                                                    
                                                                                                                    Ps is the parameter indicating the test to be done. Ps is computed by taking the weight indicated for each desired test and adding them together. If Ps is 0, no test is performed but the VT100 is reset.
                                                                                                                    Test  Weight
                                                                                                                    Power up self-test (ROM check sum, RAM, NVR keyboard and AVO if installed)  1
                                                                                                                    Data Loop Back  2 (loop back connector required)
                                                                                                                    EIA modem control test  4 (loop back connector required)
                                                                                                                    Repeat Selected Test(s)
                                                                                                                    indefinitely (until failure or power off)   8
                                                                                                                    DSR – Device Status Report
                                                                                                                    ESC [ Ps n  default value: 0
                                                                                                                    
                                                                                                                    Requests and reports the general status of the VT100 according to the following parameter(s).
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Response from VT100 – Ready, No malfunctions detected (default)
                                                                                                                    3   Response from VT100 – Malfunction – retry
                                                                                                                    5   Command from host – Please report status (using a DSR control sequence)
                                                                                                                    6   Command from host – Please report active position (using a CPR control sequence)
                                                                                                                    
                                                                                                                    DSR with a parameter value of 0 or 3 is always sent as a response to a requesting DSR with a parameter value of 5.
                                                                                                                    ED – Erase In Display
                                                                                                                    ESC [ Ps J  default value: 0
                                                                                                                    
                                                                                                                    This sequence erases some or all of the characters in the display according to the parameter. Any complete line erased by this sequence will return that line to single width mode. Editor Function
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Erase from the active position to the end of the screen, inclusive (default)
                                                                                                                    1   Erase from start of the screen to the active position, inclusive
                                                                                                                    2   Erase all of the display – all lines are erased, changed to single-width, and the cursor does not move.
                                                                                                                    EL – Erase In Line
                                                                                                                    ESC [ Ps K  default value: 0
                                                                                                                    
                                                                                                                    Erases some or all characters in the active line according to the parameter. Editor Function
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Erase from the active position to the end of the line, inclusive (default)
                                                                                                                    1   Erase from the start of the screen to the active position, inclusive
                                                                                                                    2   Erase all of the line, inclusive
                                                                                                                    HTS – Horizontal Tabulation Set
                                                                                                                    ESC H    
                                                                                                                    
                                                                                                                    Set one horizontal stop at the active position. Format Effector
                                                                                                                    HVP – Horizontal and Vertical Position
                                                                                                                    ESC [ Pn ; Pn f   default value: 1
                                                                                                                    
                                                                                                                    Moves the active position to the position specified by the parameters. This sequence has two parameter values, the first specifying the line position and the second specifying the column. A parameter value of either zero or one causes the active position to move to the first line or column in the display, respectively. The default condition with no parameters present moves the active position to the home position. In the VT100, this control behaves identically with its editor function counterpart, CUP. The numbering of lines and columns depends on the reset or set state of the origin mode (DECOM). Format Effector
                                                                                                                    IND – Index
                                                                                                                    ESC D    
                                                                                                                    
                                                                                                                    This sequence causes the active position to move downward one line without changing the column position. If the active position is at the bottom margin, a scroll up is performed. Format Effector
                                                                                                                    LNM – Line Feed/New Line Mode
                                                                                                                    
                                                                                                                    This is a parameter applicable to set mode (SM) and reset mode (RM) control sequences. The reset state causes the interpretation of the line feed (LF), defined in ANSI Standard X3.4-1977, to imply only vertical movement of the active position and causes the RETURN key (CR) to send the single code CR. The set state causes the LF to imply movement to the first position of the following line and causes the RETURN key to send the two codes (CR, LF). This is the New Line (NL) option.
                                                                                                                    
                                                                                                                    This mode does not affect the index (IND), or next line (NEL) format effectors.
                                                                                                                    NEL – Next Line
                                                                                                                    ESC E    
                                                                                                                    
                                                                                                                    This sequence causes the active position to move to the first position on the next line downward. If the active position is at the bottom margin, a scroll up is performed. Format Effector
                                                                                                                    RI – Reverse Index
                                                                                                                    ESC M    
                                                                                                                    
                                                                                                                    Move the active position to the same horizontal position on the preceding line. If the active position is at the top margin, a scroll down is performed. Format Effector
                                                                                                                    RIS  Reset To Initial State
                                                                                                                    ESC c    
                                                                                                                    
                                                                                                                    Reset the VT100 to its initial state, i.e., the state it has after it is powered on. This also causes the execution of the power-up self-test and signal INIT H to be asserted briefly.
                                                                                                                    RM – Reset Mode
                                                                                                                    ESC [ Ps ; Ps ; . . . ; Ps l  default value: none
                                                                                                                    
                                                                                                                    Resets one o1 sets are invoked by the codes SI and SO (shift in and shift out) respectively.
                                                                                                                    G0 Sets Sequence  G1 Sets Sequence  Meaning
                                                                                                                    ESC ( A   ESC ) A   United Kingdom Set
                                                                                                                    ESC ( B   ESC ) B   ASCII Set
                                                                                                                    ESC ( 0   ESC ) 0   Special Graphics
                                                                                                                    ESC ( 1   ESC ) 1   Alternate Character ROM Standard Character Set
                                                                                                                    ESC ( 2   ESC ) 2   Alternate Character ROM Special Graphics
                                                                                                                    
                                                                                                                    The United Kingdom and ASCII sets conform to the "ISO international register of character sets to be used with escape sequences". The other sets are private character sets. Special graphics means that the graphic characters for the codes 1378 to 1768 are replaced with other characters. The specified character set will be used until another SCS is received.
                                                                                                                    
                                                                                                                    NOTE: Additional information concerning the SCS escape sequence may be obtained in ANSI standard X3.41-1974.
                                                                                                                    SGR – Select Graphic Rendition
                                                                                                                    ESC [ Ps ; . . . ; Ps m   default value: 0
                                                                                                                    
                                                                                                                    Invoke the graphic rendition specified by the parameter(s). All following characters transmitted to the VT100 are rendered according to the parameter(s) until the next occurrence of SGR. Format Effector
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Attributes off
                                                                                                                    1   Bold or increased intensity
                                                                                                                    4   Underscore
                                                                                                                    5   Blink
                                                                                                                    7   Negative (reverse) image
                                                                                                                    
                                                                                                                    All other parameter values are ignored.
                                                                                                                    
                                                                                                                    With the Advanced Video Option, only one type of character attribute is possible as determined by the cursor selection; in that case specifying either the underscore or the reverse attribute will activate the currently selected attribute. (See cursor selection in Chapter 1).
                                                                                                                    SM – Set Mode
                                                                                                                    ESC [ Ps ; . . . ; Ps h   default value: none
                                                                                                                    
                                                                                                                    Causes one or more modes to be set within the VT100 as specified by each selective parameter in the parameter string. Each mode to be set is specified by a separate parameter. A mode is considered set until it is reset by a reset mode (RM) control sequence.
                                                                                                                    TBC – Tabulation Clear
                                                                                                                    ESC [ Ps g  default value: 0
                                                                                                                    Parameter   Parameter Meaning
                                                                                                                    0   Clear the horizontal tab stop at the active position (the default case).
                                                                                                                    3   Clear all horizontal tab stops.
                                                                                                                    
                                                                                                                    Any other parameter values are ignored. Format Effector
                                                                                                                    Modes
                                                                                                                    
                                                                                                                    The following is a list of VT100 modes which may be changed with set mode (SM) and reset mode (RM) controls.
                                                                                                                    ANSI Specified Modes
                                                                                                                    Parameter   Mode Mnemonic   Mode Function
                                                                                                                    0     Error (ignored)
                                                                                                                    20  LNM   Line feed new line mode
                                                                                                                    DEC Private Modes
                                                                                                                    
                                                                                                                    If the first character in the parameter string is ? (778), the parameters are interpreted as DEC private parameters according to the following:
                                                                                                                    Parameter   Mode Mnemonic   Mode Function
                                                                                                                    0     Error (ignored)
                                                                                                                    1   DECCKM  Cursor key
                                                                                                                    2   DECANM  ANSI/VT52
                                                                                                                    3   DECCOLM   Column
                                                                                                                    4   DECSCLM   Scrolling
                                                                                                                    5   DECSCNM   Screen
                                                                                                                    6   DECOM   Origin
                                                                                                                    7   DECAWM  Auto wrap
                                                                                                                    8   DECARM  Auto repeating
                                                                                                                    9   DECINLM   Interlace
                                                                                                                    
                                                                                                                    Any other parameter values are ignored.
                                                                                                                    
                                                                                                                    The following modes, which are specified in the ANSI X3.64-1977 standard, may be considered to be permanently set, permanently reset, or not applicable, as noted. Refer to that standard for further information concerning these modes.
                                                                                                                    Mode Mnemonic   Mode Function   State
                                                                                                                    CRM   Control representation  Reset
                                                                                                                    EBM   Editing boundary  Reset
                                                                                                                    ERM   Erasure   Set
                                                                                                                    FEAM  Format effector action  Reset
                                                                                                                    FETM  Format effector transfer  Reset
                                                                                                                    GATM  Guarded area transfer   NA
                                                                                                                    HEM   Horizontal editing  NA
                                                                                                                    IRM   Insertion-replacement   Reset
                                                                                                                    KAM   Keyboard action   Reset
                                                                                                                    MATM  Multiple area transfer  NA
                                                                                                                    PUM   Positioning unit  Reset
                                                                                                                    SATM  Selected area transfer  NA
                                                                                                                    SRTM  Status reporting transfer   Reset
                                                                                                                    TSM   Tabulation stop   Reset
                                                                                                                    TTM   Transfer termination  NA
                                                                                                                    VEM   Vertical editing  NA
                                                                                                                    Valid VT52 Mode Control Sequences
                                                                                                                    Cursor Up
                                                                                                                    ESC A    
                                                                                                                    
                                                                                                                    Move the active position upward one position without altering the horizontal position. If an attempt is made to move the cursor above the top margin, the cursor stops at the top margin.
                                                                                                                    Cursor Down
                                                                                                                    ESC B    
                                                                                                                    
                                                                                                                    Move the active position downward one position without altering the horizontal position. If an attempt is made to move the cursor below the bottom margin, the cursor stops at the bottom margin.
                                                                                                                    Cursor Right
                                                                                                                    ESC C    
                                                                                                                    
                                                                                                                    Move the active position to the right. If an attempt is made to move the cursor to the right of the right margin, the cursor stops at the right margin.
                                                                                                                    Cursor Left
                                                                                                                    ESC D    
                                                                                                                    
                                                                                                                    Move the active position one position to the left. If an attempt is made to move the cursor to the left of the left margin, the cursor stops at the left margin.
                                                                                                                    Enter Graphics Mode
                                                                                                                    ESC F    
                                                                                                                    
                                                                                                                    Causes the special graphics character set to be used.
                                                                                                                    
                                                                                                                    NOTE: The special graphics characters in the VT100 are different from those in the VT52.
                                                                                                                    Exit Graphics Mode
                                                                                                                    ESC G    
                                                                                                                    
                                                                                                                    This sequence causes the standard ASCII character set to be used.
                                                                                                                    Cursor to Home
                                                                                                                    ESC H    
                                                                                                                    
                                                                                                                    Move the cursor to the home position.
                                                                                                                    Reverse Line Feed
                                                                                                                    ESC I    
                                                                                                                    
                                                                                                                    Move the active position upward one position without altering the column position. If the active position is at the top margin, a scroll down is performed.
                                                                                                                    Erase to End of Screen
                                                                                                                    ESC J    
                                                                                                                    
                                                                                                                    Erase all characters from the active position to the end of the screen. The active position is not changed.
                                                                                                                    Erase to End of Line
                                                                                                                    ESC K    
                                                                                                                    
                                                                                                                    Erase all characters from the active position to the end of the current line. The active position is not changed.
                                                                                                                    Direct Cursor Address
                                                                                                                    ESC Y line column    
                                                                                                                    
                                                                                                                    Move the cursor to the specified line and column. The line and column numbers are sent as ASCII codes whose values are the number plus 0378; e.g., 0408 refers to the first line or column, 0508 refers to the eighth line or column, etc.
                                                                                                                    Identify
                                                                                                                    ESC Z    
                                                                                                                    
                                                                                                                    This sequence causes the terminal to send its identifier escape sequence to the host. This sequence is:
                                                                                                                    
                                                                                                                        ESC / Z
                                                                                                                        
                                                                                                                        Enter Alternate Keypad Mode
                                                                                                                        ESC =    
                                                                                                                        
                                                                                                                        The optional auxiliary keypad keys will send unique identifiable escape sequences for use by applications programs.
                                                                                                                        
                                                                                                                        NOTE: Information regarding options must be obtained in ANSI mode, using the device attributes (DA) control sequences.
                                                                                                                        Exit Alternate Keypad Mode
                                                                                                                        ESC >    
                                                                                                                        
                                                                                                                        The optional auxiliary keypad keys send the ASCII codes for the functions or characters engraved on the key.
                                                                                                                        Enter ANSI Mode
                                                                                                                        ESC <    
                                                                                                                        
                                                                                                                        All subsequent escape sequences will be interpreted according to ANSI Standards X3.64-1977 and X3.41-1974. The VT52 escape sequence designed in this section will not be recognized.
                                                                                                                        Control Sequence Summary
                                                                                                                        
                                                                                                                        The following is a summary of the VT100 control sequences.
                                                                                                                        ANSI Compatible Mode
                                                                                                                        
                                                                                                                        Cursor Movement Commands
                                                                                                                        Cursor up   ESC [ Pn A
                                                                                                                        Cursor down   ESC [ Pn B
                                                                                                                        Cursor forward (right)  ESC [ Pn C
                                                                                                                        Cursor backward (left)  ESC [ Pn D
                                                                                                                        Direct cursor addressing  ESC [ Pl ; Pc H† or
                                                                                                                        ESC [ Pl ; Pc f†
                                                                                                                        Index   ESC D
                                                                                                                        New line  ESC E
                                                                                                                        Reverse index   ESC M
                                                                                                                        Save cursor and attributes  ESC 7
                                                                                                                        Restore cursor and attributes   ESC 8
                                                                                                                        † Pl = line number; Pc = column number
                                                                                                                        
                                                                                                                        NOTE: Pn refers to a decimal parameter expressed as a string of ASCII digits. Multiple parameters are separated by the semicolon character (0738). If a parameter is omitted or specified to be 0 the default parameter value is used. For the cursor movement commands, the default parameter value is 1.
                                                                                                                        
                                                                                                                        Line Size (Double-Height and Double-Width) Commands
                                                                                                                        Change this line to double-height top half  ESC # 3
                                                                                                                        Change this line to double-height bottom half   ESC # 4
                                                                                                                        Change this line to single-width single-height  ESC # 5
                                                                                                                        Change this line to double-width single-height  ESC # 6
                                                                                                                        
                                                                                                                        Character Attributes
                                                                                                                        
                                                                                                                        ESC [ Ps;Ps;Ps;...;Ps m
                                                                                                                        
                                                                                                                        Ps refers to a selective parameter. Multiple parameters are separated by the semicolon character (0738). The parameters are executed in order and have the following meanings:
                                                                                                                        0 or None   All Attributes Off
                                                                                                                        1   Bold on
                                                                                                                        4   Underscore on
                                                                                                                        5   Blink on
                                                                                                                        7   Reverse video on
                                                                                                                        
                                                                                                                        Any other parameter values are ignored.
                                                                                                                        
                                                                                                                        Erasing
                                                                                                                        From cursor to end of line  ESC [ K or ESC [ 0 K
                                                                                                                        From beginning of line to cursor  ESC [ 1 K
                                                                                                                        Entire line containing cursor   ESC [ 2 K
                                                                                                                        From cursor to end of screen  ESC [ J or ESC [ 0 J
                                                                                                                        From beginning of screen to cursor  ESC [ 1 J
                                                                                                                        Entire screen   ESC [ 2 J
                                                                                                                        
                                                                                                                        Programmable LEDs
                                                                                                                        
                                                                                                                        ESC [ Ps;Ps;...Ps q
                                                                                                                        
                                                                                                                        Ps are selective parameters separated by semicolons (0738) and executed in order, as follows:
                                                                                                                        0 or None   All LEDs Off
                                                                                                                        1   L1 On
                                                                                                                        2   L2 On
                                                                                                                        3   L3 On
                                                                                                                        4   L4 On
                                                                                                                        
                                                                                                                        Any other parameter values are ignored.
                                                                                                                        
                                                                                                                        Character Sets (G0 and G1 Designators)
                                                                                                                        
                                                                                                                        The G0 and G1 character sets are designated as follows:
                                                                                                                        Character set   G0 designator   G1 designator
                                                                                                                        United Kingdom (UK)   ESC ( A   ESC ) A
                                                                                                                        United States (USASCII)   ESC ( B   ESC ) B
                                                                                                                        Special graphics characters and line drawing set  ESC ( 0   ESC ) 0
                                                                                                                        Alternate character ROM   ESC ( 1   ESC ) 1
                                                                                                                        Alternate character ROM special graphics characters   ESC ( 2   ESC ) 2
                                                                                                                        
                                                                                                                        Scrolling Region
                                                                                                                        
                                                                                                                        ESC [ Pt ; Pb r
                                                                                                                        
                                                                                                                        Pt is the number of the top line of the scrolling region; Pb is the number of the bottom line of the scrolling region and must be greater than Pt.
                                                                                                                        
                                                                                                                        Tab Stops
                                                                                                                        Set tab at current column   ESC H
                                                                                                                        Clear tab at current column   ESC [ g or ESC [ 0 g
                                                                                                                        Clear all tabs  ESC [ 3 g
                                                                                                                        
                                                                                                                        Modes
                                                                                                                        Mode Name   To Set  To Reset
                                                                                                                        Mode  Sequence  Mode  Sequence
                                                                                                                        Line feed/new line  New line  ESC [20h  Line feed   ESC [20l*
                                                                                                                        Cursor key mode   Application   ESC [?1h  Cursor  ESC [?1l*
                                                                                                                        ANSI/VT52 mode  ANSI  N/A   VT52  ESC [?2l*
                                                                                                                        Column mode   132 Col   ESC [?3h  80 Col  ESC [?3l*
                                                                                                                        Scrolling mode  Smooth  ESC [?4h  Jump  ESC [?4l*
                                                                                                                        Screen mode   Reverse   ESC [?5h  Normal  ESC [?5l*
                                                                                                                        Origin mode   Relative  ESC [?6h  Absolute  ESC [?6l*
                                                                                                                        Wraparound  On  ESC [?7h  Off   ESC [?7l*
                                                                                                                        Auto repeat   On  ESC [?8h  Off   ESC [?8l*
                                                                                                                        Interlace   On  ESC [?9h  Off   ESC [?9l*
                                                                                                                        Keypad mode   Application   ESC =   Numeric   ESC >
                                                                                                                        
                                                                                                                        * The last character of the sequence is a lowercase L (1548).
                                                                                                                        
                                                                                                                        Reports
                                                                                                                        
                                                                                                                        Cursor Position Report
                                                                                                                        Invoked by  ESC [ 6 n
                                                                                                                        Response is   ESC [ Pl ; Pc R †
                                                                                                                        
                                                                                                                        † Pl = line number; Pc = column number
                                                                                                                        
                                                                                                                        Status Report
                                                                                                                        Invoked by  ESC [ 5 n
                                                                                                                        Response is   ESC [ 0 n (terminal ok)
                                                                                                                        ESC [ 3 n (terminal not ok)
                                                                                                                        
                                                                                                                        What Are You
                                                                                                                        Invoked by  ESC [ c or ESC [ 0 c
                                                                                                                        Response is   ESC [ ? 1 ; Ps c
                                                                                                                        
                                                                                                                        Ps is the "option present" parameter with the following meaning:
                                                                                                                        Ps  Meaning
                                                                                                                        0   Base VT100, no options
                                                                                                                        1   Processor options (STP)
                                                                                                                        2   Advanced video option (AVO)
                                                                                                                        3   AVO and STP
                                                                                                                        4   Graphics processor option (GPO)
                                                                                                                        5   GPO and STP
                                                                                                                        6   GPO and AVO
                                                                                                                        7   GPO, STP, and AVO
                                                                                                                        
                                                                                                                        Alternatively invoked by ESC Z (not recommended). Response is the same.
                                                                                                                        
                                                                                                                        Reset
                                                                                                                        
                                                                                                                        Reset causes the power-up reset routine to be executed.
                                                                                                                        
                                                                                                                        ESC c
                                                                                                                        
                                                                                                                        Confidence Tests
                                                                                                                        Fill Screen with "Es"   ESC # 8
                                                                                                                        Invoke Test(s)  ESC [ 2 ; Ps y
                                                                                                                        
                                                                                                                        Ps is the parameter indicating the test to be done and is a decimal number computed by taking the "weight" indicated for each desired test and adding them together.
                                                                                                                        Test  Weight
                                                                                                                        Power-up self test (ROM checksum, RAM, NVR, keyboard and AVO if installed)  1
                                                                                                                        Data Loop Back  2 (loop back connector required)
                                                                                                                        EIA modem control test  4 (loop back connector required)
                                                                                                                        Repeat selected test(s) indefinitely (until failure or power off)   8
                                                                                                                        VT52 Compatible Mode
                                                                                                                        
                                                                                                                        The following is a summary of the VT100 control sequences.
                                                                                                                        Cursor Up   ESC A    
                                                                                                                        Cursor Down   ESC B    
                                                                                                                        Cursor Right  ESC C    
                                                                                                                        Cursor Left   ESC D    
                                                                                                                        Select Special Graphics character set   ESC F    
                                                                                                                        Select ASCII character set  ESC G    
                                                                                                                        Cursor to home  ESC H    
                                                                                                                        Reverse line feed   ESC I    
                                                                                                                        Erase to end of screen  ESC J    
                                                                                                                        Erase to end of line  ESC K    
                                                                                                                        Direct cursor address   ESC Y l c   (see note 1)
                                                                                                                        Identify  ESC Z   (see note 2)
                                                                                                                        Enter alternate keypad mode   ESC =    
                                                                                                                        Exit alternate keypad mode  ESC >    
                                                                                                                        Enter ANSI mode   ESC <    
                                                                                                                        NOTE 1:   Line and column numbers for direct cursor address are single character codes whose values are the desired number plus 378. Line and column numbers start at 1.
                                                                                                                        NOTE 2:   Response to ESC Z is ESC / Z.r more

</details>
<div align="center"><b>

```【𝐄𝐍𝐃】```

</b></div>
 <p align="right">⦗ <a href="#top">𝔟𝔞𝔠𝔨 𝔱𝔬 𝔱𝔬𝔭 ⤒</a> ⦘</p>

<!--
 <p align="right">(<a href="#top">𝜟 𝐛𝐚𝐜𝐤 𝒕𝒐 𝒕𝒐𝐩 𝜟</a>)</p>
 <p align="right">(<a href="#top">𝜟 𝑏𝑎𝑐𝑘 𝑡𝑜 𝑡𝑜𝑝 𝜟</a>)</p>
 <p align="right">(<a href="#top"> 𝓑𝒷𝒶𝒸𝓀 𝓉𝒐 𝓉𝒐𝓅 𝜟</a>)</p>
 <p align="right">Random<a href="#top">𝜟🔝⤊⟰⤉⤒𝅉 </a>Symbols</p>
 <p align="right">Random<a href="#top">🢕⬔⦇⦈</a>Symbols</p>
-->

<!--
https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b
License: GPLv2 / LGPL
-->
