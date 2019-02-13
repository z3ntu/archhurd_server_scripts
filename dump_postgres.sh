#!/bin/bash

pg_dumpall -U postgres > ~/postgres_dump_$(date +"%Y%m%d").sql
