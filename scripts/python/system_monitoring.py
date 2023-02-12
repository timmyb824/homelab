# from https://medium.com/@naseer1015922/5-killer-python-scripts-for-automation-part1-e83383740154
import psutil

# Get the current CPU usage
cpu_usage = psutil.cpu_percent()

# Get the current memory usage
memory_usage = psutil.virtual_memory().percent

# Get the current disk usage
disk_usage = psutil.disk_usage("/").percent

# Get the network activity
# Get the current input/output data rates for each network interface
io_counters = psutil.net_io_counters(pernic=True)
for interface, counters in io_counters.items():
    print(f"Interface {interface}:")
    print(f"  bytes sent: {counters.bytes_sent}")
    print(f"  bytes received: {counters.bytes_recv}")

# Get a list of active connections
connections = psutil.net_connections()
for connection in connections:
    print(f"{connection.laddr} <-> {connection.raddr} ({connection.status})")

# Print the collected data
print(f"CPU usage: {cpu_usage}%")
print(f"Memory usage: {memory_usage}%")
print(f"Disk usage: {disk_usage}%")