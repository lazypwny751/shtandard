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
if [[ -z "${REQUIRESH_LIBDIR}" ]] ; then
    export REQUIRESH_LIBDIR="/usr/local/lib/bash-5.1.16:/usr/local/lib/POSIX"
fi
export i="" x="" status="true" version="1.0.0" DO="source" OPTARG=()

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

# If the process mode on source and the options are null:
if [[ "${DO}" = "source" ]] && [[ "${#OPTARG[@]}" -le 0 ]] ; then
    export DO="help"
fi

# Processing the option:
case "${DO}" in
    source)
        export IFS=":"
        for x in "${OPTARG[@]}" ; do
            export isfound="false"
            for i in ${REQUIRESH_LIBDIR} ; do
                if [[ -f "${i}/${x}.sh" ]] ; then
                    source "${i}/${x}.sh" || {
                        echo "${x}.sh could not sourcing.."
                        export status="false"
                    }
                    export isfound="true"
                    break
                elif [[ -f "${i}/${x}.sh" ]] ; then
                    source "${i}/${x}" || {
                        echo "${x} could not sourcing.."
                        export status="false"
                    }
                    export isfound="true"
                    break
                elif [[ -f "${i}" ]] ; then
                    source "${i}" || {
                        echo "${x} could not sourcing.."
                        export status="false"
                    }
                    export isfound="true"
                    break
                fi
            done

            if ! ${isfound} ; then
                echo -e "\t${BASH_SOURCE[0]##*/}: library '${x}' doesn't exist.."
                export status="false"
            fi
        done

        if ! ${status} ; then
            echo "${BASH_SOURCE[0]##*/}: some libraries couldn't sourced."
            if [[ -z "${REQUIRESH_RETURN}" ]] ; then
                exit 1
            else
                return 1
            fi
        fi
    ;;
    path)
        echo "${REQUIRESH_LIBDIR}"
    ;;
    version)
        echo "${version}"
    ;;
    help)
        echo -e "${BASH_SOURCE[0]##*/}: there is 4 options:
\t${BASH_SOURCE[0]##*/} --path, -p
\t\tit shows library path directories of ${BASH_SOURCE[0]##*/}.

\t${BASH_SOURCE[0]##*/} --version, -v
\t\tit shows current version of ${BASH_SOURCE[0]##*/}.

\t${BASH_SOURCE[0]##*/} --help, -h
\t\tit shows this helper text.

\t${BASH_SOURCE[0]##*/} <lib> <lib>..
\t\tyou can source that libraries using with directly 
\t\ttyping by names and there is no needed filename extension ('.sh')
\t\tif the file couldn't be sourced then the program will be return
\t\tnon-zero exit code, also you can set the exit type 'exit' to 'return'
\t\twith define a variable called by \${REQUIRESH_RETURN} to non-null value.

abi benim ştandart kütüphanelerim bu.
\t--Shtandard Kazim."
    ;;
    *)
        echo "${BASH_SOURCE[0]##*/}: there is no option like '${DO}'."
        exit 1
    ;;
esac
