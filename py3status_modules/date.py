import os
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(dir_path)

import common

class Py3status:
    def date(self):
        next_update = self.py3.time_in(5)
        color, date = common.get_date()
        return {
            'cached_until': next_update,
            'composite': [{'full_text': date, 'color': color}]
        }