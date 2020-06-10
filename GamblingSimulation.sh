#! /bin/bash/ -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=10
BET_PER_GAME=1

declare -A gambling
declare -A sum

read -p "enter the percent at which the gambler can resign for the day " percent
read -p "enter the number of days " days

stakePercentage=$(( $percent*$STAKE_PER_DAY/100 ))
Max_Stake=$(( $STAKE_PER_DAY +$stakePercentage ))
Min_Stake=$(( $STAKE_PER_DAY -$stakePercentage ))

function dailyPlay()
{
	cash=$STAKE_PER_DAY
	gain=0
        while [ $cash -gt $Min_Stake ] && [ $cash -lt $Max_Stake ]
        do
        	winOrLose=$((RANDOM%2))

       	        if [ $winOrLose -eq 1 ]
          	then
                	cash=$(( $cash+$BET_PER_GAME ))
                else
                        cash=$(( $cash-$BET_PER_GAME ))
                fi

	done
	gain=$(($cash-$STAKE_PER_DAY))
	echo $gain
}


function winLossDays()
{
	day=1
	totalProfit=0
	while [ $day -lt $days ]
	do
		dayProfit=0
		dayProfit=$(dailyPlay)
		gambling[$day]=$dayProfit
		day=$(( $day+1 ))
		totalProfit=$(( $totalProfit+$dayProfit ))
		sum[$day]=$totalProfit
	done

	echo "Total Profit : "$totalProfit
}

function luckyAndUnluckyDay()
{
	winLossDays
	echo "For Luckiest Day"
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
		else
			stopGambling="true"
			echo "No profit, so stop gambling"
		fi
	done
}
stopGamblingOrNot
