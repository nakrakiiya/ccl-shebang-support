#!/bin/sh

# TODO build with only one image

lx86cl --no-init --load patch.lisp
lx86cl64 --no-init --load patch.lisp
