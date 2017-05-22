import os
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(dir_path)

import common

class Py3status:
    def net(self):
        next_update = self.py3.time_in(1)
        color, usage = common.get_net_io()

        return {
            'cached_until': next_update,
            'composite': [
            	{'full_text': "Net: ", 'color': common.WHITE},
            	{'full_text': usage, 'color': color}
        	]
        }