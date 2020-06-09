#! /bin/bash/ -x

echo "WELCOME TO GAMBLING SIMULATION"

STAKE_PER_DAY=100
BET_PER_GAME=1
gain=0
totalProfit=0
stopGambling="false"
declare -A gambling
declare -A sum
read -p "enter the percent at which the gambler can resign for the day " percent

stakePercentage=$(( $percent*$STAKE_PER_DAY/100 ))
Max_Stake=$(( $STAKE_PER_DAY +$stakePercentage ))
Min_Stake=$(( $STAKE_PER_DAY -$stakePercentage ))

function dailyPlay()
{
	cash=$STAKE_PER_DAY

        while [ $cash -gt $Min_Stake ] && [ $cash -lt $Max_Stake ]
        do
        	winOrLose=$((RANDOM%2))

       	        if [ $winOrLose -eq 1 ]
          	then
                	cash=$(( $cash+$BET_PER_GAME ))
                        #echo "Cash is " $cash
                else
                        cash=$(( $cash-$BET_PER_GAME ))
                        #echo "Cash is " $cash
                fi

	done
	gain=$(($cash-100))
	echo $gain
}


function winLossDays()
{
	day=1
	while [ $day -lt 20 ]
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
	done | sort -n | tail -1

	echo "For Unluckiest Day"
	for element in ${!sum[*]}
	do
		echo $element " : " ${sum[$element]}
	done | sort -n | head -1
}

function stopGamblingOrNot()
{
	winLossDays
	while [ $stopGambling == "false" ]
	do
		if [ $totalProfit -gt 0 ]
		then
			profit=$(winLossDays)
			echo $profit
			stopGamblingOrNot
		fi

		if [ $totalProfit -le 0 ]
		then
			stopGambling="true"
			echo "No profit, so stop gambling"
			break
		fi
	done
}

stopGamblingOrNot
