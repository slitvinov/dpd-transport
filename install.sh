#!/bin/sh

: ${PREFIX=$HOME/.local}
me=install.sh
err () {
    printf >&2 %s\\n "$me: $*"
    exit 2
}

test -d lammps ||
    git clone --depth 1 https://github.com/lammps/lammps.git lammps || err 'failed to clone lammps'

(cd lammps/src
 make yes-USER-DPD || err 'failed to install package'
 make mpi || err 'make mpi failed'
 mkdir -p "$PREFIX"/bin
 cp lmp_mpi "$PREFIX"/bin/lmp || err "fail to install lammps"
) || exit 2
