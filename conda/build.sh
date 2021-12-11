#!/bin/sh

[ ! -d $PREFIX/bin ] && mkdir -p $PREFIX/bin
cp --no-dereference $SRC_DIR/src/R/*.R $PREFIX/bin
