#!/bin/bash

#    Simple bourne again shell library standards for bych4n group projects - Shtandard  
#    Copyright (C) 2022  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Define variables:
if [[ -z "${REQUIRESH_LIBDIR}"]] ; then
    export REQUIRESH_LIBDIR="/usr/local/lib/bahs-5.1.16"
fi
export i="" x="" status=true version="1.0.0" DO="source" OPTARG=()

# Parse parameters:
while [[ "${#}" -gt 0 ]] ; do
    case "${1}" in
        --[pP][aA][tT][hH]|-[pP])
            shift
            export DO="path"
        ;;
        --[vV][eE][rR][sS][iI][oO][nN]|-[vV])
            shift
            export DO="version"
        ;;
        --[hH][eE][lL][pP]|-[hH])
            shift
            export DO="help"
        ;;
        *)
            export OPTARG+=("${1}")
            shift
        ;;
    esac
done

# Processing the option:
case "${DO}" in
    source)
        export IFS=":"
        for x in ${OPTARG[@]} ; do
            for i in ${REQUIRESH_LIBDIR} ; do
                if [[ -f "${i}/${x}.sh" ]] ; then
                    source "${i}/${x}.sh" || {
                        echo "${x}.sh could not sourcing.."
                        export status=false
                    }
                elif [[ -f "${i}/${x}.sh" ]] ; then
                    source "${i}/${x}" || {
                        echo "${x} could not sourcing.."
                        export status=false
                    }
                else
                    echo "${x} doesn't exist."
                    export status=false
                fi
            done
        done

        if ! ${status} ; then
            echo "${0##*/}: some libraries couldn't sourced."
            exit 1
        fi
    ;;
    path)
        echo "${REQUIRESH_LIBDIR}"
    ;;
    version)
        echo "${version}"
    ;;
    help)
        echo "${0##*/}: there is X options:"
    ;;
    *)
        echo "${0##*/}: there is no option like '${DO}'."
        exit 1
    ;;
esac