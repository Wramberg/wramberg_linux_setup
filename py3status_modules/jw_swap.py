import os
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(dir_path)

import common

class Py3status:
    def disk(self):
        next_update = self.py3.time_in(5)
        color, usage = common.get_swap_usage()

        return {
            'cached_until': next_update,
            'composite': [
            	{'full_text': "Swap: ", 'color': common.WHITE},
            	{'full_text': usage, 'color': color}
        	]
        }