# Robot Framework with hardware testing - Course

This course is for adept software testers and python users for getting a good grasp on efficient usage of Robot Framework. This course will utilise basic hardware testing with an Arduino based system. The course is planned to take place over two days, and will include lots of practical work with testing several Arduino setups, some theory and slides, using tools affiliated with Robot Framework such as Docker and robotidy.

## 1 System setup

To manage dependencies, `uv` will be used on this course. If you do not have `uv` installed, please see [these instructions](https://docs.astral.sh/uv/getting-started/installation/) for how to install uv on your system. Please clone this repository to work in, and initiate an environment within the folder:

```
git clone https://github.com/ArttuKnowit/rf-with-hardware-testing.git
cd rf-with-hardware-testing
uv init
uv add -r requirements.txt
```

Whenever you encounter run instructions during the course that state "Run the suite with `robot ...` you should in fact use `uv run robot ...` instead to ensure you run with the correct environment.

Install the [Robot Code](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode) extension on VS Code if you use VS Code as your IDE. 

## 2 Ways of working

The course is instructor-lead and we will progress between the slides and practical exercises. The slides are split into informational short lectures between practical assignments. However most of the learning will be done with the exercises. All exercises should explain their intended goal and split the required actions into reasonably sized steps. The solution as code is available after the assignment.

## Flashing an arduino with code

Any firmware that gets flashed to the Arudino should be in its own directory with no other .ino files in the same directory. Take a look a tthe firmware directory for examples. To flash the Arduino with correct firmware, please plug in the USB to your machine which has arudino-cli installed. Then run

```shell
arduino-cli board list
```

to see which boards are available. You should see something like

```output
Port Protocol Type              Board Name  FQBN            Core
COM3 serial   Serial Port       Unknown
COM4 serial   Serial Port (USB) Arduino UNO arduino:avr:uno arduino:avr
```

Should Arduino be on COM3, you should use COM3, and if on COM4, then use COM4 for the following:

```shell
arduino-cli compile --fqbn arduino:avr:uno target_directory
arduino-cli upload -p COM4 --fqbn arduino:avr:uno target_directory
```

