#!/usr/bin/env bash

#
# Copyright (C) 2019 Saalim Quadri (danascape)
#
# SPDX-License-Identifier: Apache-2.0 license
#

# Set Variables
# Scripts Path
CI_PATH="$HOME/stormCI"

# Organization URL
ORG_URL="https://github.com/stormbreaker-project"

# Repositories
REPOS="
	linux-kernel-mainline
	linux-asus-X00P-3.18
	linux-asus-X00P-4.9
	linux-asus-X01AD
	linux-nothing-spacewar
	linux-oneplus-billie
	linux-xiaomi-msm8953
	"

# Remove previous ids
rm -rf $CI_PATH/commit-id/*

generate_commit_ids()
{
	for repo in $REPOS; do
		COMMIT_ID=$(git ls-remote $ORG_URL/$repo | head -1 | cut -f -1)
		echo "$COMMIT_ID" >> $CI_PATH/commit-id/$repo-id
	done
}

result_commit_ids()
{
	git add commit-id/
	git commit -sm "[CI]: Generate/Update Commit IDs."
}

# Generate/Update Commit IDs.
generate_commit_ids

# Create Commit of Updated IDs.
result_commit_ids
