from robot.api.deco import keyword, library
from robot.api import logger
import serial
import time


@library
class ArduinoLib:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.connection = None

    @keyword
    def connect_to_device(self, port, baud_rate=9600):
        self.connection = serial.Serial(port, int(baud_rate), timeout=2)
        time.sleep(2)
        logger.info(f"Connected to {port} at {baud_rate} baud")
        logger.info(self.connection)

    @keyword
    def disconnect_from_device(self):
        if self.connection and self.connection.is_open:
            self.connection.close()
            logger.info("Disconnected from device")

    @keyword
    def write_serial(self, data):
        self.connection.write(data.encode())
        logger.info(f"Sent: {data!r}")
        time.sleep(0.2)  # Short delay to allow device to process command

    @keyword
    def read_serial(self):
        response = self.connection.readline().decode().strip()
        logger.info(f"Received: {response!r}")
        return response

    @keyword
    def reset_device(self):
        self.connection.write('R'.encode())
        time.sleep(0.1)
        self.connection.reset_input_buffer()
        time.sleep(2)
        logger.info("Device reset")

    @keyword
    def read_analog_voltage(self, pin_index):
        self.write_serial(f"ReadAnalog {pin_index}")
        response = self.read_serial()
        voltage = float(response)
        return voltage