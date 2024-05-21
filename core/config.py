# Base path for log files and sessions
base_path = '~/.evilshell/'

# History path
history_path = '~/.evilshell/history'

# Session path
sessions_path = '~/.evilshell/sessions/'
sessions_ext = '.session'

# Supported Channels
channels = [
    # Obfuscated channel inside POST requests introduced 
    # in Evilshell 3.6
    'ObfPost',
]

# Append random GET parameters to every request to
# make sure the page is not cache by proxies.
add_random_param_nocache = False

# Add additional headers to be sent at every request e.g.
# additional_headers = [
#   ( 'Authentication', 'Basic QWxhZGRpbjpvcGVuIHNlc2FtBl==' )
# ]
additional_headers = []

# Agents and obfuscators used by generator.py
agent_templates_folder_path = 'bd/agents/'
obfuscators_templates_folder_path = 'bd/obfuscators/'





#######################################
# Resolve given paths - DO NOT CHANGE #
#######################################
import os, sys
base_path = os.path.expanduser(base_path)
history_path = os.path.expanduser(history_path)
sessions_path = os.path.expanduser(sessions_path)
evilshell_path = os.path.dirname(os.path.realpath(sys.argv[0]))
agent_templates_folder_path = os.path.join(
    evilshell_path,
    agent_templates_folder_path
)
obfuscators_templates_folder_path = os.path.join(
    evilshell_path,
    obfuscators_templates_folder_path
)
