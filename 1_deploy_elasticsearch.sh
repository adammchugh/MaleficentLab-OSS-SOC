#!/bin/bash

for i in "$@"
do
case $i in
    -h=*|--host=*)
    ESHOST="${i#*=}"
    shift # past argument=value
    ;;
    -n=*|--nodes=*)
    ESNODES="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

ESHOSTS=$(echo $ESNODES | tr "," "\n")
