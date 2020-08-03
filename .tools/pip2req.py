import json

with open("Pipfile.lock", "r") as f:
    vals = json.loads(f.read())

modules = vals['default']

for v in modules:
    if 'version' in modules[v]:
        print(f"{v}{modules[v]['version']}")
    # else:
    #     print(v, "????????????????????")
