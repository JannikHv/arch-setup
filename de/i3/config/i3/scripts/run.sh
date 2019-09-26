#!/bin/sh

args="${@}"

termite --class="dialog" --exec="bash -c '${args}'"
