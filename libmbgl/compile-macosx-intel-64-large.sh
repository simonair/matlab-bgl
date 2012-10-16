#!/bin/bash -e

BOOST_DIR=boost_1_36_0
BOOST_URL='http://iweb.dl.sourceforge.net/project/boost/boost/1.36.0/boost_1_36_0.tar.bz2'

if [[ ! -d $BOOST_DIR ]]; then
    curl BOOST_URL | tar xf
fi

YASMIC_DIR=.

source ccfiles.sh
OFILES=`echo ${CCFILES} | sed -e 's/\.cc/\.o/g'`

CFLAGS="-O2 -arch x86_64 -DMATLAB_BGL_LARGE_ARRAYS -fPIC -c -I${BOOST_DIR} -I${YASMIC_DIR}"
#CFLAGS="-g -W -DMATLAB_BGL_LARGE_ARRAYS -fPIC -c -I${BOOST_DIR} -I${YASMIC_DIR}"

function echocmd {
	echo $@
	$@
}

for file in ${CCFILES}; do
	echocmd g++ $CFLAGS $file
done

echocmd ar rc libmbgl-macosx-intel-64-large.a ${OFILES} 
	
echocmd rm ${OFILES}	
