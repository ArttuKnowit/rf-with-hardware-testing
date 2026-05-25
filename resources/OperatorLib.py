from robot.api.deco import keyword, library
from robot.api import logger


@library
class OperatorLib:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword
    def confirm_proceeding(self):
        logger.info("Press enter to proceed")
        input()