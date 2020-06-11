#!/bin/bash

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET_PER_GAME=1

declare -A gambling
declare -A sum

read -p "enter the percent at which the gambler can resign for the day " percent
read -p "enter the number of days " days

stakePercentage=$(( $percent*$STAKE_PER_DAY/100 ))
maxStake=$(( $STAKE_PER_DAY +$stakePercentage ))
minStake=$(( $STAKE_PER_DAY -$stakePercentage ))

function dailyPlay()
{
	cash=$STAKE_PER_DAY
        while [ $cash -gt $minStake ] && [ $cash -lt $maxStake ]
        do
        	winOrLose=$((RANDOM%2))

       	        if [ $winOrLose -eq $BET_PER_GAME ]
          	then
                	cash=$(( $cash+$BET_PER_GAME ))
                else
                        cash=$(( $cash-$BET_PER_GAME ))
                fi

	done
	cash=$(( $cash-$STAKE_PER_DAY ))
	echo $cash
}


function winLossDays()
{
	day=1
	totalProfit=0
	while [ $day -le $days ]
	do
		local dayProfit=0
		dayProfit=$(dailyPlay)
		gambling[$day]=$dayProfit
		totalProfit=$(( $totalProfit+$dayProfit ))
		sum[$day]=$totalProfit
		day=$(( $day+1 ))
	done
	echo $totalProfit

}

function luckyAndUnluckyDay()
{
	winLossDays
	#echo "For Luckiest Day"
	for element in ${!sum[*]}
	do
		echo $element " : " ${sum[$element]}
	done | sort -n -k3 | tail -1

	echo "For Unluckiest Day"
	for element in ${!sum[*]}
	do
		echo $element " : " ${sum[$element]}
	done | sort -n -k3 | head -1
}

function stopGamblingOrNot()
{
	stopGambling="false"
	winLossDays
	while [ $stopGambling == "false" ]
	do
		if [ $totalProfit -gt 0 ]
		then
			echo "Can play more games"
			break
		else
			stopGambling="true"
			echo "No profit, so stop gambling"
		fi
	done
}
luckyAndUnluckyDay
stopGamblingOrNot
