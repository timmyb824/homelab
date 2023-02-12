from pyinfra.operations import files
from pyinfra.operations import server

files.file(
    name="Create new rsyslog file",
    path="/etc/rsyslog.d/90-graylog.conf",
    touch=True,
    _sudo=True
)

graylog_host = os.environ['graylog_server']
graylog_syslog = f"*.* @{graylog_host}:5140;RSYSLOG_SyslogProtocol23Format"
files.line(
    name=f"Add graylog syslog line",
    path="/etc/rsyslog.d/90-graylog.conf",
    line=graylog_syslog,
    present=True,
    _sudo=True
)  # type: ignore

server.service(
    name="Restart rsyslog service",
    service="rsyslog.service",
    restarted=True,
    _sudo=True,
    _use_sudo_password=True
) # type: ignore