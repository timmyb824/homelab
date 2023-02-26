#!/bin/bash
echo 3 > /proc/sys/vm/drop_caches

echo $'\ncache dropped successfully'