[![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)](https://bitbucket.org/lbesson/ansi-colors)
[![Generic badge](https://img.shields.io/badge/Status-Deprecated-orange.svg)](https://shields.io/)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://GitHub.com/Naereen/ama)

# Graphic Environment on Clipper Language
Graphic environment implemented on Clipper language for old DOS Operational System.

![Screenshot 01](https://github.com/marcelkohl/graphic-env-clipper/blob/main/SAMPLES/sample-animated.gif?raw=true)

## History Behind
This code is the core that I've used on my 90's projects on MS-DOS on Clipper Language.
With this core I was able not only to have a graphical interface on MS-DOS but also resources that were only available on Windows (that was not so wide used as MS-DOS).

*Unfortunately I could only "revive" the core of the system from the backups, there is still missing the window editor that was part of that (like an IDE for drag-and-drop components), and some commercial software made over this platform. With some luck I will be able to find these files and share them one day.*

**Standard DOS apps looked like this:**

<img alt="Sample DOS app Clipper" src="https://github.com/marcelkohl/graphic-env-clipper/blob/main/SAMPLES/sample-dos.png?raw=true" width="400" height="auto">&nbsp;&nbsp;<img alt="Sample DOS app Clipper 2" src="https://github.com/marcelkohl/graphic-env-clipper/blob/main/SAMPLES/sample-dos-2.png?raw=true" width="400" height="auto">

**Using this graphical environment it looks like this:**

<img alt="Graphics on Clipper DOS" src="https://github.com/marcelkohl/graphic-env-clipper/blob/main/SAMPLES/sample-graphics-DOS-clipper-2.png?raw=true" width="400" height="auto">&nbsp;&nbsp;<img alt="Graphics on Clipper DOS" src="https://github.com/marcelkohl/graphic-env-clipper/blob/main/SAMPLES/sample-graphics-DOS-clipper-3.png?raw=true" width="400" height="auto">

## Compiling and Running
To run this app properly it is needed to have a MS-DOS compatible environment. Using FreeDOS does the job very well.

- Copy the content of the project to a folder;
- Inside the folder run `C.BAT`, it will compile and link everything;

## How does it work?
The graphical environment works by loading external `window` files and mounting on the screen. Every object loaded from the window file enters into the core flow.

Objects in the flow are:
- Input (text, number, formated floats, formated data)
- Checkbox
- Selectbox
- Button
- Data Browser

## TODO
- Finish some variable translations (originally it is in portuguese)
- Prepare some documentation about the `window` files;
