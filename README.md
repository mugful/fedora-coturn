fedora-coturn
=============

A Coturn TURN server image built on top of Fedora.

Pull
----

Either pull from Quay.io:

    docker pull quay.io/mugful/fedora-coturn:master

Or build your own:

    git clone https://github.com/mugful/fedora-coturn
    cd fedora-coturn
    docker build --force-rm -t mugful/fedora-coturn:master .

Run
---

The image expects the turnserver config to be mounted under
`/etc/turnserver/turnserver.conf`. See
[coturn example config](https://github.com/coturn/coturn/blob/master/examples/etc/turnserver.conf) for
reference. When you've created the config that suits your setup, run
the container for example like this:

    docker run -d \
        --name my_coturn \
        -v /var/lib/coturn/turnserver.conf:/etc/turnserver/turnserver.conf:ro,z \
        -p 3478:3478 -p 5349:5349 \
        quay.io/mugful/fedora-coturn:master
