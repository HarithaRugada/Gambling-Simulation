#! /bin/bash/ -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET_PER_GAME=1

read -p "enter the percent at which the gambler can resign for the day " percent

Max_Stake=$(( $STAKE_PER_DAY +($percent*$STAKE_PER_DAY/100) ))
Min_Stake=$(( $STAKE_PER_DAY -($percent*$STAKE_PER_DAY/100) ))

function dailyPlay()
{
	cash=$STAKE_PER_DAY

	while [ $cash -gt $Min_Stake ] && [ $cash -lt $Max_Stake ]
	do
		winOrLose=$((RANDOM%2))
		if [ $winOrLose -eq 1 ]
		then
			cash=$(( $cash+$BET_PER_GAME ))
			echo "Cash is " $cash
		else
			cash=$(( $cash-$BET_PER_GAME ))
			echo "Cash is " $cash
		fi
	done
	echo "Final Cash is " $cash
}

dailyPlay
