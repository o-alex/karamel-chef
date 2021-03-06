#!/bin/bash

#these variables are used together with 'sed' so please make sure to escape all / characters
GITHUB="hopshadoop\/hopsworks-chef"
BRANCH="master"

#CLUSTER_SUFIX will be used as the three last digits for all the vm forwarded ports.
#Make sure that different clusters working on the same machine have different suffixes
CLUSTER_SUFFIX=100
#domain of the machine where the cluster vm is being spin up
CLUSTER_DOMAIN="bbc1.sics.se"
#email used to register with hopssite
CLUSTER_EMAIL="delahs@gmail.com"
#source for war/ear packages
SOURCE_CODE="http:\/\/snurran.sics.se\/hops\/dela"
#Company and Unit combination has to be unique for each cluster registered with a specific hopssite instance
CLUSTER_COMPANY="hopsworks"
CLUSTER_UNIT="hs"