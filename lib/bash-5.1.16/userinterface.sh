#!/bin/bash

userinterface:question() {
    local input="" text="sure?[y/N]:> " true="[yY]"

    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --[tT][eE][xX][tT]|-[tT][eE])
                shift
                if [[ -n "${1}" ]] ; then
                    local text="${1}"
                    shift
                fi
            ;;
            --[tT][rR][uU][eE]|-[tT][rR])
                shift
                if [[ -n "${1}" ]] ; then
                    local true="${1}"
                    shift
                fi
            ;;
            *)
                shift
            ;;
        esac
    done

    read -p "${text}" input
    case "${input}" in
        ${true})
            return 0
        ;;
        *)
            return 1
        ;;
    esac

}

userinterface:spinner:line() {
    local count="0" total="34" sleep="0.5" pstr="[=======================================================================]"
    
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --[cC][oO][uU][nN][tT]|-[cC])
                shift
                if [[ -n "${1}" ]] ; then
                    local count="${1}"
                    shift
                fi
            ;;
            --[tT][oO][tT][aA][lL]|-[tT])
                shift
                if [[ -n "${1}" ]] ; then
                    local total="${1}"
                    shift
                fi
            ;;
            --[sS][lL][eE][eE][pP]|-[sS])
                shift
                if [[ -n "${1}" ]] ; then
                    local sleep="${1}"
                    shift
                fi
            ;;
            *)
                shift
            ;;
        esac
    done

    while [ $count -lt $total ]; do
        sleep "${sleep}" # this is work
        count=$(( $count + 1 ))
        pd=$(( $count * 73 / $total ))
        printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
    done
}

userinterface:output() {
    local text="sample output text from ${0##*/}:${FUNCNAME}" TYPE="success"
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --[tT][eE][xX][tT]|-[tT])
                shift
                if [[ -n "${1}" ]] ; then
                    local text="${1}"
                    shift
                fi
            ;;
            --[sS][uU][cC][cC][eE][sS][sS]|-[sS])
                shift
                local TYPE="success"
            ;;
            --[eE][rR][rR][oO][rR]|-[eE])
                shift
                local TYPE="error"
            ;;
            --[iI][nN][fF][oO]|-[iI])
                shift
                local TYPE="info"
            ;;
            --[tT][yY][pP][eE]|-[tT])
                shift
                if [[ -n "${1}" ]] ; then
                    local TYPE="${1}"
                    shift
                fi
            ;;
            *)
                shift
            ;;
        esac
    done

    case "${TYPE}" in
        success)
            echo -e "\t${0##*/}: \033[0;32mSUCCESS\033[0m: ${text}\033[0m"
        ;;
        error)
            echo -e "\t${0##*/}: \033[0;31mERROR\033[0m: ${text}\033[0m"
            return 1
        ;;
        info)
            echo -e "\t${0##*/}: \033[0;34mINFO\033[0m: ${text}\033[0m"
        ;;
        *)
            echo -e "\t${0##*/}: ${FUNCNAME}: ${TYPE}: ${text}"
        ;;
    esac
}