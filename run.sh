#!/bin/bash

set -e -o pipefail

function die() {
  echo >&2 "$@"
  exit 1
}

test -n "$BUCKET_NAME" || die "Please set BUCKET_NAME environment variable"
test -n "$ACCESS_KEY" -a -n "$SECRET_KEY" || die "Please set ACCESS_KEY and SECRET_KEY environment variables"

test -d noarch && createrepo noarch || :
test -d x86_64 && createrepo x86_64 || :

echo Executing in $(pwd)
s3cmd --config=/.s3cfg --access_key="$ACCESS_KEY" --secret_key="$SECRET_KEY" sync . s3://${BUCKET_NAME}/
