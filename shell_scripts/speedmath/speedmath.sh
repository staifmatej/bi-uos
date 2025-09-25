#!/bin/bash

RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
BOLD='\033[1m'
END_COLOR="\033[0m"

correct_answers=0
wrong_answers=0
timeout_answers=0
total_time=0
difficulty_level=0


show_help() {
	for item in "$@"; do
	    if [ "$item" == "-i" ] || [ "$item" == "--info" ] || [ "$item" == "--help" ] || [ "$item" == "-h" ]; then
	        print_help | less -R
	        exit 0
	    fi
	done
 }


print_header() {
      local title="SPEEDMATH(1)"
      local center="User Commands"
      local width=$(tput cols)

      local center_pos=$(( (width - ${#center}) / 2 ))
      local right_pos=$(( width - ${#title} ))

      printf "%s" "$title"
      printf "%*s" $(( center_pos - ${#title} )) ""
      printf "%s" "$center"
      printf "%*s" $(( right_pos - center_pos - ${#center} )) ""
      printf "%s\n" "$title"
      echo ""
  }

print_footer() {
      local left="1+1=11"
      local center=$(date +"%B %Y")  # Aktuálny mesiac a rok
      local right="SPEEDMATH(1)"
      local width=$(tput cols)

      # Vypočítaj pozície
      local center_pos=$(( (width - ${#center}) / 2 ))
      local right_pos=$(( width - ${#right} ))

      # Vypíš footer
      echo ""
      printf "%s" "$left"
      printf "%*s" $(( center_pos - ${#left} )) ""
      printf "%s" "$center"
      printf "%*s" $(( right_pos - center_pos - ${#center} )) ""
      printf "%s\n" "$right"
 }

print_help() {
	print_header
	
    echo -e "${BOLD}NAME${END_COLOR}"
	echo -e "       speedmath - mathematical speed training tool"
     	
	echo -e "DESCRIPTION:"

	echo -e "\tSpeedMath is a command-line tool for improving mental"	
	echo -e "\tcalculation speed through customizable arithmetic"
	echo -e "\texercises across multiple difficulty levels. It supports"
	echo -e "\tvarious operation types with configurable time limits"
	echo -e "\tand can be adapted for educational training beyond speed"
	echo -e "\tmathematics."
	

    echo -e "SYNOPSIS:"
    echo -e "\t${BOLD}speedmath${END_COLOR} [${BOLD}difficulty${END_COLOR}] [${BOLD}time${END_COLOR}] [${BOLD}count${END_COLOR}] [${BOLD}type_of_problem...${END_COLOR}]\n"
    
    echo -e "DIFFICULTY LEVELS:"
    echo -e "       ${BOLD}0${END_COLOR}    Beginner    range: <0;10>"
    echo -e "       ${BOLD}1${END_COLOR}    Easy        range: <-10;10>"
    echo -e "       ${BOLD}2${END_COLOR}    Medium      range: <-100;100>"
    echo -e "       ${BOLD}3${END_COLOR}    Hard        range: <-1000;1000>"
    echo -e "       ${BOLD}4${END_COLOR}    Extreme     range: <-50000;50000>"
    echo -e "       ${BOLD}5${END_COLOR}    Killer      range: (-inf;inf)\n"
    
    echo -e "TIME LIMIT:"
    echo -e "       ${BOLD}integer${END_COLOR}          Time limit per question in seconds"
    echo -e "       ${BOLD}inf${END_COLOR}              Infinite time (no time pressure)\n"
    
    echo -e "OPERATION TYPES:"
    echo -e "       ${BOLD}--add, -a${END_COLOR}        Addition problems (12 + 8 = ?)"
    echo -e "       ${BOLD}--sub, -s${END_COLOR}        Subtraction problems (85 - 37 = ?)"
    echo -e "       ${BOLD}--mul, -m${END_COLOR}        Multiplication problems (7 × 8 = ?)"
    echo -e "       ${BOLD}--div, -d${END_COLOR}        Division problems (144 ÷ 12 = ?)"
    echo -e "       ${BOLD}--per, -p${END_COLOR}        Percentage calculations (15% of 200 = ?)"
    echo -e "       ${BOLD}--pow, -w${END_COLOR}        Power/exponent problems (2³ = ?)"
    echo -e "       ${BOLD}--seq, -q${END_COLOR}        Number sequences (2, 4, 8, ?)"
    echo -e "       ${BOLD}--all${END_COLOR}            Mix of all available operation types\n"

	echo -e "COUNT:"
	echo -e "       ${BOLD}integer${END_COLOR}          Specific number of mathematical problems"
	echo -e "                        Options: 1-1000 or inf"

	echo -e "EXAMPLES:"
	echo -e "       speedmath 2 30 --add --sub    # Medium, 30s, add & sub"
	echo -e "       speedmath 4 inf --all         # Extreme, Inf, all types"
	echo -e "       speedmath 5 120 -a -s -d -p -w -q\n"

	echo -e "PROJECT INFO:"
	echo -e "       Educational project for BI-UOS course @ CTU FIT in Prague"
    echo -e "       ${BOLD}No LLM models were used - pure Bash learning exercise!!!${END_COLOR}\n"

	echo -e "AUTHOR:"
	echo -e "       Github: github.com/staifmatej"
	echo -e "       Written by Matej Staif @ CTU FIT in 2025\n"

	echo -e "REPORTING BUGS:"
	echo -e "       Report bugs via Github: github.com/staifmatej"

	print_footer
	}

error_handling() {
	echo -e $1
	echo -e "Run ${BOLD}speedmath --help${END_COLOR} for information about this command"
	exit 1
}

check_correct_arguments() {

	correct_arg_1=(0 1 2 3 4 5)
	correct_arg_4=("--add" "--sub" "--mul" "--div" "--per" "--pow" "--seq" "--all" "-a" "-s" "-m" "-d" "-p" "-w" "-q")
	
	# Check for correct number of arguments.
	if [[ $# -lt 4 ]]; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Too few arguments!"
		error_handling "$arg"
	fi

	# Check if arguments do not contain prohibited characters.
	 if echo "$*" | grep -q "[.,;&|$(){}<>*?!#':@+=%^~]"; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Arguments have prohibited characters!"
		error_handling "$arg"
	fi

	# Check correctness of first argument.
	found=false
	for arg1_item in "${correct_arg_1[@]}"; do
		if [ "$1" == "$arg1_item" ]; then
			found=true
			break
		fi
	done
	if [[ $found == false ]]; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect first argument! Invalid first argument is \"$1\"! "
		error_handling "$arg"
	fi

	# Check correctness of second argument.
	if [[ $2 -gt 10**6 ]]; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect second argument! For time greater than 1,000,000 use \"inf\" option instead!"
		error_handling "$arg"
	fi
	
	if [[ $2 != "inf" ]]; then
		if [[ $2 -lt 1 ]]; then
			arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect second argument! Time in seconds for each question must be greater than zero!"
			error_handling "$arg"
		fi
	fi

	# Check correctness of third argument.
	if [[ $3 -lt 0  ]]; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect third argument! 3rd argument must be greater than or equal to 1!"
		error_handling "$arg"
	fi

	if [[ $3 -gt 1000 ]]; then
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect third argument! Third argument must be smaller than 1000!"
		error_handling "$arg"
	fi

	# Check correctness of fourth arguments.
	counter=0
	for arg3_item in "$@"; do
		counter=$((counter + 1))
		if [[ $counter -ge 4 ]]; then
			found=false
			for arg3_item_corr in "${correct_arg_4[@]}"; do
				if [[ $arg3_item == $arg3_item_corr ]]; then
					found=true
					break
				fi
			done
			if [[ $found == false ]]; then
				arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect fourth argument!"
				error_handling "$arg"		
			fi
		fi
	done
	
}

generate_num_from_to() {
	min=0
	max=0
	if [[ $1 == 0 ]]; then
		min=0
		max=10
	elif [[ $1 == 1 ]]; then
		min=-10
		max=10 
	elif [[ $1 == 2 ]]; then
		min=-100
		max=100
	elif [[ $1 == 3 ]]; then
		min=-1000
		max=1000
	elif [[ $1 == 4 ]]; then
		min=-50000
		max=50000
	elif [[ $1 == 5 ]]; then
		max_const=$((10**6))
		min=$(($max_const*(-1)))
		max=$(($max_const))
	else
		arg="${BOLD}${RED}ERROR: ${END_COLOR}Incorrect third argument!"
		error_handling "$arg"	
	fi
	echo $((RANDOM % (max - min + 1) + min))
}

modify_time(){
	if [[ $1 == "inf" ]]; then
		echo -e "$((10**8))" # Yep, it will run for 3.17 years! :-)
	else
		echo -e "$1"
	fi
}

get_operations() {
	operations=()
	for arg in "${@:4}"; do  # Start from 4th argument
		case "$arg" in
			"--add"|"-a")
				operations+=("add")
				;;
			"--sub"|"-s")
				operations+=("sub")
				;;
			"--mul"|"-m")
				operations+=("mul")
				;;
			"--div"|"-d")
				operations+=("div")
				;;
			"--per"|"-p")
				operations+=("per")
				;;
			"--pow"|"-w")
				operations+=("pow")
				;;
			"--seq"|"-q")
				operations+=("seq")
				;;
			"--all")
				operations=("add" "sub" "mul" "div" "per" "pow" "seq")
				break
				;;
		esac
	done
}

generate_problem() {
	local op_type="$1"
	local difficulty="$2"

	case "$op_type" in
		"add")
			num1=$(generate_num_from_to "$difficulty")
			num2=$(generate_num_from_to "$difficulty")
			problem_text="$num1 + $num2"
			correct_answer=$((num1 + num2))
			;;
		"sub")
			num1=$(generate_num_from_to "$difficulty")
			num2=$(generate_num_from_to "$difficulty")
			problem_text="$num1 - $num2"
			correct_answer=$((num1 - num2))
			;;
		"mul")
			# For multiplication, use smaller numbers
			if [[ $difficulty -le 2 ]]; then
				num1=$((RANDOM % 13))
				num2=$((RANDOM % 13))
			else
				num1=$(generate_num_from_to "$difficulty")
				num2=$(generate_num_from_to "$difficulty")
			fi
			problem_text="$num1 × $num2"
			correct_answer=$((num1 * num2))
			;;
		"div")
			# For division, generate divisible numbers
			num2=$((RANDOM % 10 + 1))  # Divisor 1-10
			result=$((RANDOM % 20 + 1))  # Result 1-20
			num1=$((num2 * result))
			problem_text="$num1 ÷ $num2"
			correct_answer=$result
			;;
		"per")
			# Percentage problems: X% of Y
			percentage=$((RANDOM % 50 + 10))  # 10-59%
			base_num=$((RANDOM % 200 + 10))   # 10-209
			problem_text="$percentage% of $base_num"
			correct_answer=$((percentage * base_num / 100))
			;;
		"pow")
			# Power problems: X^Y where Y is small
			base=$((RANDOM % 10 + 2))  # 2-11
			exponent=$((RANDOM % 4 + 2))  # 2-5
			problem_text="$base^$exponent"
			correct_answer=$((base ** exponent))
			;;
		"seq")
			# Simple arithmetic sequence
			start=$((RANDOM % 10 + 1))
			diff=$((RANDOM % 5 + 1))
			term2=$((start + diff))
			term3=$((start + 2 * diff))
			next_term=$((start + 3 * diff))
			problem_text="$start, $term2, $term3, ?"
			correct_answer=$next_term
			;;
	esac
}

print_statistics() {
	local total_problems=$((correct_answers + wrong_answers + timeout_answers))

	echo ""
	echo -e "${BOLD}════════════════════════════════════════════════════════════${END_COLOR}"
	echo -e "${BOLD}                      GAME STATISTICS                       ${END_COLOR}"
	echo -e "${BOLD}════════════════════════════════════════════════════════════${END_COLOR}"
	echo ""
	printf "%-25s │ %-10s\n" "Metric" "Value"
	echo "──────────────────────────┼─────────────────────────────────"
	printf "%-25s │ %-10d\n" "Correct Answers" "$correct_answers"
	printf "%-25s │ %-10d\n" "Wrong Answers" "$wrong_answers"
	printf "%-25s │ %-10d\n" "Timeout (No Answer)" "$timeout_answers"
	printf "%-25s │ %-10d\n" "Total Problems" "$total_problems"
	printf "%-25s │ %-5d seconds\n" "Total Time Spent" "$total_time"
	printf "%-25s │ %-10d\n" "Difficulty Level" "$difficulty_level"
	echo "──────────────────────────┼─────────────────────────────────"

	# Calculate accuracy if problems were attempted
	if [[ $total_problems -gt 0 ]]; then
		local accuracy=$((correct_answers * 100 / total_problems))
		printf "%-25s │ %-5d %%\n" "Accuracy Rate" "$accuracy"
	fi

	# Calculate average time per problem
	if [[ $total_problems -gt 0 ]]; then
		local avg_time=$((total_time / total_problems))
		printf "%-25s │ %-5d seconds\n" "Average Time/Problem" "$avg_time"
	fi

	echo ""
	echo -e "${BOLD}════════════════════════════════════════════════════════════${END_COLOR}"
}

main() {
	show_help "$@"
	check_correct_arguments "$@"
	difficulty_level=$1  # Store difficulty level for statistics

	# Parse operations from arguments
	get_operations "$@"

	# Check if we have any operations
	if [[ ${#operations[@]} -eq 0 ]]; then
		echo -e "${BOLD}${RED}ERROR: ${END_COLOR}No valid operations specified!"
		exit 1
	fi

	time_limit=$(modify_time $2)

	# Trap Ctrl+C to show statistics before exit
	trap 'print_statistics; exit 0' INT

	if [[ $3 == "inf" ]]; then
		i=1
		while true; do
			echo -e "${BOLD}Problem $i:${END_COLOR}"

			# Select random operation from available operations
			selected_op=${operations[$((RANDOM % ${#operations[@]}))]}


			# Generate problem based on selected operation
			generate_problem "$selected_op" "$1"

			# Start timing
			start_time=$(date +%s)

			if read -t $time_limit -p "$problem_text = ? " answer; then
				end_time=$(date +%s)
				elapsed=$((end_time - start_time))
				total_time=$((total_time + elapsed))

				if [[ $answer =~ ^-?[0-9]+$ ]]; then
					if [[ $answer -eq $correct_answer ]]; then
						echo -e "${BOLD}Correct! Time: ${elapsed}s${END_COLOR}"
						correct_answers=$((correct_answers + 1))
					else
						echo -e "${BOLD}Wrong! Correct answer: $correct_answer. Time: ${elapsed}s${END_COLOR}"
						wrong_answers=$((wrong_answers + 1))
					fi
				else
					echo -e "${BOLD}Invalid input! Please enter a number. Correct answer: $correct_answer. Time: ${elapsed}s${END_COLOR}"
					wrong_answers=$((wrong_answers + 1))
				fi
			else
				echo -e "${BOLD}Time limit $time_limit seconds exceeded!${END_COLOR}"
				timeout_answers=$((timeout_answers + 1))
				total_time=$((total_time + time_limit))
			fi

			echo ""
			i=$((i + 1))
		done
	else
	    for i in $(seq 1 $3); do
			echo -e "${BOLD}Problem $i:${END_COLOR}"

			# Select random operation from available operations
			selected_op=${operations[$((RANDOM % ${#operations[@]}))]}


			# Generate problem based on selected operation
			generate_problem "$selected_op" "$1"

			# Start timing
			start_time=$(date +%s)

			if read -t $time_limit -p "$problem_text = ? " answer; then
				end_time=$(date +%s)
				elapsed=$((end_time - start_time))
				total_time=$((total_time + elapsed))

				if [[ $answer =~ ^-?[0-9]+$ ]]; then
					if [[ $answer -eq $correct_answer ]]; then
						echo -e "${BOLD}Correct! Time: ${elapsed}s${END_COLOR}"
						correct_answers=$((correct_answers + 1))
					else
						echo -e "${BOLD}Wrong! Correct answer: $correct_answer. Time: ${elapsed}s${END_COLOR}"
						wrong_answers=$((wrong_answers + 1))
					fi
				else
					echo -e "${BOLD}Invalid input! Please enter a number. Correct answer: $correct_answer. Time: ${elapsed}s${END_COLOR}"
					wrong_answers=$((wrong_answers + 1))
				fi
			else
				echo -e "${BOLD}Time limit $time_limit seconds exceeded!${END_COLOR}"
				timeout_answers=$((timeout_answers + 1))
				total_time=$((total_time + time_limit))
			fi

			echo ""
		done
	fi

	# Show statistics at the end of the game
	print_statistics
}

main "$@"


