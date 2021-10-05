#!/bin/bash
set -e

package=psycopg2-binary
version=2.9.1
yum_packages="postgresql-libs postgresql-devel"

source build-generic.sh
