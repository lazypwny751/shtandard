#!/bin/bash

check:have:specialchar() {
    if [[ "${1}" =~ ['\[!@#$ %^&*()+|?{}"=,;/£½'] ]] ; then
        return 1
    elif [[ "${1}" =~ "'" ]] ; then
        return 1
    elif [[ "${1}" = *"]"* ]] ; then
        return 1
    else
        return 0
    fi
}

check:is:online() {
    if command -v "ping" &> /dev/null ; then
        if ping -c 1 -q google.com &>/dev/null ; then
            return 0
        else
            return 1
        fi
    else
        echo -e "\t${0##*/}: command: ping not found."
        return 1
    fi
}

check:set:version() {
    # Değişken dönüşümü (matematikte yapamadık bari burada yapalım)

    local version=( ${1//./" "} )

    # Check major
    if [[ "${version[0]}" =~ ^[0-9]+$ ]] ; then
        local major="${version[0]}"
    else
        local major="1"
    fi

    # Check minor
    if [[ "${version[1]}" =~ ^[0-9]+$ ]] ; then
        local minor="${version[1]}"
    else
        local minor="0"
    fi

    # Check patch
    if [[ "${version[2]}" =~ ^[0-9]+$ ]] ; then
        local patch="${version[2]}"
    else
        local patch="0"
    fi

    local realversion="${major}.${minor}.${patch}"

    echo "${realversion}"
    unset version major minor patch realversion
    return 0
}

check:is:64bit() {
    if [[ "$(uname -m)" = "x86_64" ]]; then
        return 0
    else
        return 1
    fi
}

check:is:root() {
    if [[ "${UID}" = 0 ]] ; then
        return 0
    else
        return 1
    fi
}

check:is:arch() {
    local i="" status="false"

    if [[ "${#}" -ge "1" ]] ; then
        if command -v "uname" &> /dev/null ;  then
            for i in ${@} ; do
                if [[ "${i}" = "$(umane -m)" ]] ; then
                    local status="true"
                fi
            done

            if [[ "${status}" = "true" ]] ; then
                return 0
            else
                return 3
            fi
        else
            echo -e "\t${0##*/}: ERROR: ${FUNCNAME##*:}: 'uname' is required but not found."
            return 2
        fi
    else
        echo -e "\t${0##*/}: ERROR: ${FUNCNAME##*:}: insufficient parameters."
        1
    fi
}

check:compare:version() {
    local i="" divnumber="100" metaver=( ${1//./" "} ) pkgver=( ${2//./" "} )
    for i in {0..2} ; do
        local metavercol="$(( (${metaver[i]} * ${divnumber}) + $([[ -n ${metavercol} ]] && echo "${metavercol}" || echo "0") ))"
        local pkgvercol="$(( (${pkgver[i]} * ${divnumber}) + $([[ -n ${pkgvercol} ]] && echo "${pkgvercol}" || echo "0") ))"
        local divnumber="$(( ${divnumber} / 10 ))"
    done
    
    if [[ "${metavercol}" -gt "${pkgvercol}" ]] ; then
        return 0 # >
    elif [[ "${metavercol}" -eq "${pkgvercol}" ]] ; then
        return 1 # =
    else
        return 2 # <,?
    fi
}
