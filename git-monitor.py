#!/usr/bin/env python3
from git import Repo
from ruamel.yaml import YAML

git_monitor_config = "~/volume/git-monitor.yaml"


def configcheck(config):
    try:
        fd = open(config, "r")
        return fd
    except IOError:
        print('Git monitor config file not found in {}'.format(git_monitor_config))
        return None


yaml = YAML(typ='safe')   # default, if not specfied, is 'rt' (round-trip)

yaml.load(configcheck(git_monitor_config))

