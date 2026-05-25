from robot import result, running
from robot.api.interfaces import ListenerV3
from robot.libraries.BuiltIn import BuiltIn

class ArduinoListener(ListenerV3):

    def start_test(self, data: running.TestCase, result: result.TestCase):
        BuiltIn().log_to_console(f"\nWe are now running the test case {data.name}")

    def end_keyword(self, data: running.Keyword, result: result.Keyword):
        BuiltIn().log_to_console(f"\nWe are now running the keyword {data.name}")
