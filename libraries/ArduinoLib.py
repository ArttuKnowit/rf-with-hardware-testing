"""
ArduinoLib.py — Robot Framework library for serial communication with Arduino.

Keywords:
    Connect To Arduino
    Disconnect From Arduino
    Read Serial Line
    Write To Serial
    Wait For Serial Message

Usage in a Robot Framework suite:
    Library    ArduinoLib.py    port=/dev/ttyUSB0    baud_rate=9600
"""

import time
import serial
from robot.api.deco import keyword, library
from robot.api import logger


@library(scope="SUITE", version="1.0")
class ArduinoLib:
    """Library for communicating with an Arduino over a serial (USB) connection.

    The library is suite-scoped so a single connection is shared across all
    test cases within a suite.  Open the connection in Suite Setup via
    ``Connect To Arduino`` and close it in Suite Teardown via
    ``Disconnect From Arduino``.
    """

    ROBOT_LIBRARY_DOC_FORMAT = "reST"

    def __init__(self, port: str = "/dev/ttyUSB0", baud_rate: int = 9600) -> None:
        """Configure the serial connection parameters.

        :param port:      Serial port the Arduino is connected to.
                          Examples: ``/dev/ttyUSB0``, ``/dev/ttyACM0``,
                          ``/dev/cu.usbmodem14101``, ``COM3``.
        :param baud_rate: Baud rate matching the firmware's ``Serial.begin()`` call.
                          Defaults to ``9600``.
        """
        self._port = port
        self._baud_rate = int(baud_rate)
        self._serial: serial.Serial | None = None

    # ------------------------------------------------------------------
    # Connection management
    # ------------------------------------------------------------------

    @keyword("Connect To Arduino")
    def connect_to_arduino(self) -> None:
        """Open the serial connection to the Arduino.

        A 2-second pause is inserted after opening the port so the Arduino
        has time to complete its hardware reset before any communication
        begins.  This is required when the DTR line triggers a reset on
        connection (default behaviour for Arduino Uno).

        Raises ``RuntimeError`` if the port cannot be opened.
        """
        logger.info(f"Connecting to Arduino on {self._port} at {self._baud_rate} baud")
        try:
            self._serial = serial.Serial(
                port=self._port,
                baudrate=self._baud_rate,
                timeout=1,
            )
        except serial.SerialException as exc:
            raise RuntimeError(
                f"Could not open serial port '{self._port}': {exc}"
            ) from exc

        # Wait for the Arduino to finish resetting after DTR assertion.
        time.sleep(2)
        self._serial.reset_input_buffer()
        logger.info("Connected. Input buffer cleared.")

    @keyword("Disconnect From Arduino")
    def disconnect_from_arduino(self) -> None:
        """Close the serial connection.

        Safe to call even if the connection was never opened.
        """
        if self._serial and self._serial.is_open:
            self._serial.close()
            logger.info("Serial connection closed.")
        self._serial = None

    # ------------------------------------------------------------------
    # Reading
    # ------------------------------------------------------------------

    @keyword("Read Serial Line")
    def read_serial_line(self) -> str:
        """Read one line from the Arduino's serial output.

        Blocks until a newline-terminated line is received or the port's
        read timeout expires (1 second by default).

        Returns the decoded line with leading/trailing whitespace stripped.

        Raises ``RuntimeError`` if the connection is not open.
        """
        self._assert_connected()
        raw = self._serial.readline()
        line = raw.decode("utf-8", errors="replace").strip()
        logger.debug(f"Serial ← '{line}'")
        return line

    # ------------------------------------------------------------------
    # Writing
    # ------------------------------------------------------------------

    @keyword("Write To Serial")
    def write_to_serial(self, message: str) -> None:
        """Send a string to the Arduino over serial.

        A newline character is appended automatically so that Arduino's
        ``Serial.readStringUntil('\\n')`` can detect the end of the message.

        :param message: The string to send.

        Raises ``RuntimeError`` if the connection is not open.
        """
        self._assert_connected()
        payload = (message + "\n").encode("utf-8")
        self._serial.write(payload)
        logger.info(f"Serial → '{message}'")

    # ------------------------------------------------------------------
    # Higher-level keywords
    # ------------------------------------------------------------------

    @keyword("Wait For Serial Message")
    def wait_for_serial_message(self, expected: str, timeout: float = 10) -> str:
        """Wait until a line matching ``expected`` is received from the Arduino.

        Reads lines from the serial port in a loop until either:

        - A line that *contains* ``expected`` (case-sensitive) is found, or
        - ``timeout`` seconds have elapsed.

        :param expected: The substring to look for in incoming serial lines.
        :param timeout:  Maximum number of seconds to wait (default: 10).

        Returns the first matching line.

        Raises ``AssertionError`` if no matching line is received before
        the timeout expires.

        Example usage in a Robot Framework suite::

            Wait For Serial Message    LED ON     timeout=10
            Wait For Serial Message    LED OFF    timeout=10
        """
        self._assert_connected()
        deadline = time.monotonic() + float(timeout)
        logger.info(f"Waiting up to {timeout}s for serial message containing '{expected}'")

        while time.monotonic() < deadline:
            raw = self._serial.readline()
            if not raw:
                continue
            line = raw.decode("utf-8", errors="replace").strip()
            if line:
                logger.debug(f"Serial ← '{line}'")
            if expected in line:
                logger.info(f"Received expected message: '{line}'")
                return line

        raise AssertionError(
            f"Timed out after {timeout}s waiting for serial message containing '{expected}'"
        )

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _assert_connected(self) -> None:
        if self._serial is None or not self._serial.is_open:
            raise RuntimeError(
                "Not connected to Arduino. Call 'Connect To Arduino' first."
            )
