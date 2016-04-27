A vagrantfile for setting up a rethinkdb cluster.

## Bringing up the cluster

```vagrant up /rt*/```

## Destroying the cluster

```vagrant destroy /rt*/ -f```

## Connecting to a node

Nodes will be named rt1 - rt4

```vagrant ssh rt1```

## WebUI

The webui will be accessible as http://192.168.175.100:8080
