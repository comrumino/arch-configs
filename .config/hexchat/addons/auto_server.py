__module_name__ = "auto_server"
__module_version__ = "1.0"
__module_description__ = "auto connect to server and auth"
import hexchat
freenode = None
oftc = None
context_freenode = None
context_oftc = None


def srv_conn_freenode(userdata):
    global freenode
    global context_freenode
    if hexchat.get_info("server"):
        context_freenode.set()
        hexchat.command("quote PASS strayArch/freenode:NotRealPasswd")
        hexchat.unhook(freenode)

def srv_conn_oftc(userdata):
    global oftc
    global context_oftc
    if hexchat.get_info("server"):
        context_oftc.set()
        hexchat.command("quote PASS strayArch/OFTC:NotRealPasswd")
        hexchat.unhook(oftc)


hexchat.command("server bouncer.com 80")
context_freenode = hexchat.find_context(server='bouncer.com')

hexchat.command("newserver oftc.bouncer.com")
context_oftc = hexchat.find_context(server='oftc.bouncer.com')

freenode = hexchat.hook_timer(5000, srv_conn_freenode)
oftc = hexchat.hook_timer(5000, srv_conn_oftc)
