#!/bin/bash

in=${1:?need file name as param1}
out=$in.paultemp

FOUND=111

function agrep()
{
    local pat=${1:?need a awk regex pattern}
    local fil=${2:?need a file}
    awk "/$pat/{exit($FOUND);}" $fil
}

function remove_BOM()
{
    agrep '^\xEF\xBB\xBF' $in
    [ $? -eq $FOUND ] || return

    echo " .. remove BOM"
    awk 'NR==1{sub("^\xEF\xBB\xBF", "");}{print;}' $in > $out
    mv $out $in
}

function remove_CR()
{
    agrep '\r' $in
    [ $? -eq $FOUND ] || return

    echo " .. CRLF to LF"
    awk '{gsub("\r", "");print;}' $in > $out
    mv $out $in
}

function handle_cycle_phase1()
{
    agrep '\x87' $in
    [ $? -eq $FOUND ] || return

    echo " .. windows cycle-digits to ascii symbols"
    LANG=C awk '
    /\x87/{
        # from windows cycle-digits to ASCII
        gsub("\x87\x40", "__CYCLE__01__");
        gsub("\x87\x41", "__CYCLE__02__");
        gsub("\x87\x42", "__CYCLE__03__");
        gsub("\x87\x43", "__CYCLE__04__");
        gsub("\x87\x44", "__CYCLE__05__");
        gsub("\x87\x45", "__CYCLE__06__");
        gsub("\x87\x46", "__CYCLE__07__");
        gsub("\x87\x47", "__CYCLE__08__");
        gsub("\x87\x48", "__CYCLE__09__");
        gsub("\x87\x49", "__CYCLE__10__");
        gsub("\x87\x4A", "__CYCLE__11__");
        gsub("\x87\x4B", "__CYCLE__12__");
        gsub("\x87\x4C", "__CYCLE__13__");
        gsub("\x87\x4D", "__CYCLE__14__");
        gsub("\x87\x4E", "__CYCLE__15__");
        gsub("\x87\x4F", "__CYCLE__16__");
        gsub("\x87\x50", "__CYCLE__17__");
        gsub("\x87\x51", "__CYCLE__18__");
        gsub("\x87\x52", "__CYCLE__19__");
        gsub("\x87\x53", "__CYCLE__20__");
        gsub("\x87\x71", "__CYCLE__KM__");  # SQUARE KM
    }
    {
        print;
    }' $in > $out
    mv $out $in
}


function handle_cycle_phase2()
{
    egrep -q '__CYCLE__' $in || return

    echo " .. cycle-digits to utf8"
    awk '
    /__CYCLE__/{
        # to utf-8 cycle-digits
        gsub("__CYCLE__01__", "\xE2\x91\xA0");
        gsub("__CYCLE__02__", "\xE2\x91\xA1");
        gsub("__CYCLE__03__", "\xE2\x91\xA2");
        gsub("__CYCLE__04__", "\xE2\x91\xA3");
        gsub("__CYCLE__05__", "\xE2\x91\xA4");
        gsub("__CYCLE__06__", "\xE2\x91\xA5");
        gsub("__CYCLE__07__", "\xE2\x91\xA6");
        gsub("__CYCLE__08__", "\xE2\x91\xA7");
        gsub("__CYCLE__09__", "\xE2\x91\xA8");
        gsub("__CYCLE__10__", "\xE2\x91\xA9");
        gsub("__CYCLE__11__", "\xE2\x91\xAA");
        gsub("__CYCLE__12__", "\xE2\x91\xAB");
        gsub("__CYCLE__13__", "\xE2\x91\xAC");
        gsub("__CYCLE__14__", "\xE2\x91\xAD");
        gsub("__CYCLE__15__", "\xE2\x91\xAE");
        gsub("__CYCLE__16__", "\xE2\x91\xAF");
        gsub("__CYCLE__17__", "\xE2\x91\xB0");
        gsub("__CYCLE__18__", "\xE2\x91\xB1");
        gsub("__CYCLE__19__", "\xE2\x91\xB2");
        gsub("__CYCLE__20__", "\xE2\x91\xB3");
        gsub("__CYCLE__KM__", "\xE3\x8E\x9E");
    }
    {
        print;
    }' $in > $out
    mv $out $in
}

function euc_to_utf8()
{
    file $in | grep -q 'UTF-8' && return

    echo " .. conv to utf8"
    iconv -f EUC-JP -t UTF-8 $in > $out && mv $out $in || echo "ERROR: conv to utf8 failed $in"
}

remove_BOM
remove_CR
handle_cycle_phase1
euc_to_utf8
handle_cycle_phase2
