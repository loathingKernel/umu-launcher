#!/usr/bin/env python3

"""Set the DISPLAY environment variable if certain conditions are met.

Set the DISPLAY environment variable if certain conditions are met
and execute the passed command.

"""

import os
import sys
from typing import Union


def _nonzero(value: Union[str, None]) -> bool:
    return bool(value) and value != "0"


def main() -> int:  # noqa: RET503
    """Do the work.

    :return:
    """
    current_desktop = os.environ.get("XDG_CURRENT_DESKTOP")
    session_desktop = os.environ.get("XDG_SESSION_DESKTOP")
    multiple_xwaylands = os.environ.get("STEAM_MULTIPLE_XWAYLANDS")
    display = os.environ.get("DISPLAY")

    # If we are in gamescope
    # If we are using multiple xwaylands (steamos session usually)
    # If DISPLAY is unset
    if (
        (current_desktop == "gamescope" or session_desktop == "gamescope")
        and _nonzero(multiple_xwaylands)
        and display is None
    ):
        os.environ["DISPLAY"] = ":1"

    # Execute the passed command
    minimum_args = 2
    if len(sys.argv) < minimum_args:
        return 1
    os.execvp(sys.argv[1], sys.argv[1:])  # noqa: S606


if __name__ == "__main__":
    sys.exit(main())
