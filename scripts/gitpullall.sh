#!/usr/bin/env sh

main ()
{
	for DIR in "$PWD"/*
	do
		cd "$DIR"
		git pull
		cd -
	done
}

main
