import time
import psutil
import pickle

GREEN = "#33cc33"
AMBER = "#ffcc00"
RED = "#ff3300"
WHITE = "#ffffff"


def format_number(number, width):
    string = "%.10f" % (number, )
    truncated_str = string[:width]
    if truncated_str[-1] == ".":
        truncated_str = truncated_str[:-1] + " "
        #truncated_str = " " + truncated_str[:width-1]
    return truncated_str


def get_date():
    return (WHITE, time.strftime("%a %b %d (W%V)"))


def get_eth(): 
	net_ifs = psutil.net_if_stats()
	eth_if = None
	for key in net_ifs.keys():
		if "en" in key or "eth" in key:
			eth_if = key
			break

	if eth_if is not None:
		if net_ifs[eth_if].isup:
			#return (GREEN, "Up (%iM)" % (net_ifs[eth_if].speed,))
			return (GREEN, "Up")
		else:
			return (RED, "Down")

	return None, None


def get_disk_usage():
	usage = psutil.disk_usage("/")
	if usage.percent > 90:
		return (RED, format_number(usage.percent, 4)+"%")
	elif usage.percent > 75:
		return (AMBER, format_number(usage.percent, 4)+"%")
	else:
		return (GREEN, format_number(usage.percent, 4)+"%")



def get_swap_usage():
	usage = psutil.swap_memory()
	if usage.percent > 50:
		return (RED, format_number(usage.percent, 4)+"%")
	elif usage.percent > 0:
		return (AMBER, format_number(usage.percent, 4)+"%")
	else:
		return (GREEN, format_number(usage.percent, 4)+"%")


def get_mem_usage():
	usage = psutil.virtual_memory()
	if usage.percent > 75:
		return (RED, format_number(usage.percent, 4)+"%")
	elif usage.percent > 50:
		return (AMBER, format_number(usage.percent, 4)+"%")
	else:
		return (GREEN, format_number(usage.percent, 4)+"%")


def get_cpu_usage():
	#usage_percent = psutil.cpu_percent(interval=0.1)
	usage_percent = psutil.cpu_percent()
	if usage_percent > 90:
		return (RED, format_number(usage_percent, 4)+"%")
	elif usage_percent > 70:
		return (AMBER, format_number(usage_percent, 4)+"%")
	else:
		return (GREEN, format_number(usage_percent, 4)+"%")


def get_net_io():
	tmp_file_path="/tmp/.panel_status_net_stats.pickle"

	ts = time.time()
	stats = psutil.net_io_counters()
	cur_stats = {"ts": ts, "rx": stats.bytes_recv, "tx": stats.bytes_sent}
	
	try:
		last_stats = pickle.load(open(tmp_file_path, "rb"))
		time_diff = cur_stats["ts"] - last_stats["ts"]
		bytes_rxed = cur_stats["rx"] - last_stats["rx"]
		bytes_txed = cur_stats["tx"] - last_stats["tx"]
		kbytes_rxed_ps = (bytes_rxed / time_diff) / 1000
		kbytes_txed_ps = (bytes_txed / time_diff) / 1000
	except:
		kbytes_rxed_ps = 0
		kbytes_txed_ps = 0

	pickle.dump(cur_stats, open(tmp_file_path, "wb"))

	if kbytes_txed_ps > 1000 or kbytes_rxed_ps > 1000:
		mbytes_rxed_ps = kbytes_rxed_ps / 1000.
		mbytes_txed_ps = kbytes_txed_ps / 1000.
		rx_str = format_number(mbytes_rxed_ps, 3) + "M"
		tx_str = format_number(mbytes_txed_ps, 3) + "M"
		return (AMBER, tx_str + " / " + rx_str)
	else:
		rx_str = format_number(kbytes_rxed_ps, 3) + "K"
		tx_str = format_number(kbytes_txed_ps, 3) + "K"
		return (GREEN, tx_str + " / " + rx_str)
