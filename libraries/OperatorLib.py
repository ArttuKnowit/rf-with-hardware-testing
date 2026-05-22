from robot.api.deco import library, keyword
from robot.api import logger

@library
class OperatorLib:
    @keyword
    def confirm_user_has_pressed_button(self):
        logger.info("Waiting for user to press the button on the Arduino...", also_console=True)
        input("Press Enter after pressing the button on the Arduino...")