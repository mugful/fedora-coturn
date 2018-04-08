fedora-coturn
=============

A Coturn TURN server image built on top of Fedora.

Build
-----

    git clone https://github.com/dockingbay/fedora-coturn
    cd fedora-coturn
    docker build --force-rm -t dockingbay/fedora-coturn:latest .

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
        dockingbay/fedora-coturn
