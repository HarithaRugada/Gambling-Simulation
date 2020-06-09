#! /bin/bash/ -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET_PER_GAME=1

winOrLose=$((RANDOM%2))

if [ $winOrLose -eq 1 ]
then
	echo "Won the Bet"
else
	echo "Lost the Bet"
fi
