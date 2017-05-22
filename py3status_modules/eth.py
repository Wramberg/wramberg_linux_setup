import os
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(dir_path)

import common

class Py3status:
    def eth(self):
        next_update = self.py3.time_in(5)
        color, eth_state = common.get_eth()
        if eth_state is None:
        	return None

        return {
            'cached_until': next_update,
            'composite': [
            	{'full_text': "Eth: ", 'color': common.WHITE},
            	{'full_text': eth_state, 'color': color}
        	]
        }