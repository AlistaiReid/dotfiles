# sudo ln -s .tools/smart_embed.py /usr.lib/python3.6
import inspect
import IPython
import sys


def embed(scope, globs):
    globs.update(scope)
    caller = inspect.currentframe().f_back
    _header = "\nYou are in {}:{}\n".format(
        caller.f_code.co_filename, caller.f_lineno)
    IPython.embed(header=_header, simple_prompt=False, user_ns=globs)
    sys.exit()
