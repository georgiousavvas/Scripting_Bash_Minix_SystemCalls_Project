#!/bin/bash
#ΣΑΒΒΑΣ ΓΕΩΡΓΙΟΥ 1040803



#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# First Assignment of Operating Systems tool.sh 
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^




#./tool.sh   
#if i just call the program it shows my AM 

if [ $# -eq 0 ] 
then
	echo "1040803"
fi 



#i will place the rest of the code in this if so i will take and check parameters not in a particular order
#and all the combination

while [ $# -ne 0 ]
do
	#place all command line arguements in an array
	argv=("$@")
	
	#case for each command line arguement
	case $1 in
		
		-f)
				
			#./tool.sh -f <file> -id <id>
			#given an id , it searches and prints that persons name , surname and birthday , ignores lines starting with #		
			if [ "${argv[2]}" = "-id" ] && [ -n "${argv[1]}" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				
				awk  -F"|" -v id="${argv[3]}" '$1==id && /^[^#]/ {print $3 ,$2 , $5}' "${argv[1]}"	

			break
		

			#./tool.sh -f <file> --edit <id> <column> <value>
			#given an id , it replaces the value in the column given by the user through the command line as arguments
			elif [ "${argv[2]}" = "--edit" ] && [ -n "${argv[3]}" ] && [ -n "${argv[4]}" ] && [ -n "${argv[5]}" ] && [ -z "${argv[6]}" ]
			then
				#the coloumn number arguement should be between 2 and 9 so it doesnt change the id or doesnt get out of bounds
				if [ "${argv[4]}" -lt "9" ] && [ "${argv[4]}" -gt "1" ]
				then
					 awk -F"|"  -v uid="${argv[3]}" -v column="${argv[4]}" -v value="${argv[5]}" '$1==uid  && /^[^#]/ { OFS=FS; $(column)=value  }' "${argv[1]}" 
					break
				fi			
			break		

		
			#./tool.sh -f <F> --born-until <A> --born-since <B>
			#given 2 dates through the command line , it searches for records with birthdays between those dates
			elif [ "${argv[2]}" = "--born-until" ] &&[ "${argv[4]}" = "--born-since" ] && [ -n "${argv[3]}" ] && [ -n "${argv[5]}" ] && [ -z "${argv[6]}" ]			
			then
				awk -F"|" -v until="${argv[3]}" -v since="${argv[5]}" '$5<=until && $5>=since && /^[^#]/ {print $0 }' "${argv[1]}"
			break

			

			#./tool.sh -f <F> --born-since <A> --born-until <B>
			#given 2 dates through the command line , it searches for records with birthdays between those dates
			elif [ "${argv[4]}" = "--born-until" ] && [ "${argv[2]}" = "--born-since" ] && [ -n "${argv[3]}" ] && [ -n "${argv[5]}" ] && [ -z "${argv[6]}" ]			
			then
				awk -F"|" -v until="${argv[5]}" -v since="${argv[3]}" '$5<=until && $5>=since && /^[^#]/ {print $0 }' "${argv[1]}"
			break

			#./tool.sh -f <F> --born-until <A>
			#given a date through the command line , it searches for records that their birthdays are before that date
			elif [ "${argv[2]}" = "--born-until" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				awk -F"|" -v until="${argv[3]}" '$5<=until && /^[^#]/ {print $0 }' "${argv[1]}"
			break

			#./tool.sh -f <F> --born-since <A>
			#given a date through the command line , it searches for records that their birthdays are before that date
			elif [ "${argv[2]}" = "--born-since" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				awk -F"|" -v since="${argv[3]}" '$5>=since && /^[^#]/ {print $0 }' "${argv[1]}"
			break

			#./tool.sh -f <file> 
			#Option to show the data inside the file, ignoring the comments		
			elif [ $# -eq 2 ] && [ -n "${argv[1]}" ] && [ -z "${argv[2]}" ]
			then 
				awk -F"|" '/^[^#]/ {print $0 }' "${argv[1]}"
			break
		
			#./tool.sh -f <file> --firstnames
			#option to show all firstnames in alphabetical order , ignoring line that start with #
			elif [ "${argv[2]}" = "--firstnames" ] && [ -n "${argv[1]}" ] && [ -z "${argv[3]}" ]
			then
				awk -F"|" 'NF>1 && /^[^#]/ {print $3 }' "${argv[1]}" | sort | uniq
				break

			#./tool.sh -f <file> --lastnames
			#option to show all lasttnames in alphabetical order , ignoring lines that start with #
			elif [ "${argv[2]}" = "--lastnames" ] && [ -n "${argv[1]}" ] && [ -z "${argv[3]}" ]
			then
				 awk -F"|" 'NF>1 && /^[^#]/ {print $2 }' "${argv[1]}" | sort | uniq
				break

			#./tool.sh -f <file> --browsers
			#this command , searches the given file for all the browsers that the records use and the number of the occurences
			#example : Chrome 128
			#	   Safari 30
			#	   Firefox 29
			# i used the match function and i stored the occurences inside an array
			elif [ "${argv[2]}" = "--browsers" ] && [ -n "${argv[1]}" ] && [ -z "${argv[3]}" ]
			then
				awk -F"|" 'NF>1 && /^[^#]/ {print $8}' "${argv[1]}" | sort | uniq -c | awk -F" " '{OFS=FS ; print $2 ,$3, $1}' | sed -r 's/ {2}/ /g'	 
			break 

			else
				#in case the input by the user is not correct
			break
			fi
		;;
		
			
		#./tool.sh --firstnames -f <file>
		#option to show all firstnames in alphabetical order
		--firstnames)
			if [ "${argv[1]}" = "-f" ] && [ -n "${argv[2]}" ] && [ -z "${argv[3]}" ]
			then			
				 awk -F"|" 'NF>1 && /^[^#]/ {print $3 }' "${argv[2]}" | sort | uniq
				break
			fi
			break	
			;;

		#./tool.sh --lastnames -f <file>
		#option to show all lastnames in alphabetical order
		--lastnames)
			
			if [ "${argv[1]}" = "-f" ] && [ -n "${argv[2]}" ] && [ -z "${argv[3]}" ]
			then
				 awk -F"|" 'NF>1 &&  /^[^#]/ {print $2 }' "${argv[2]}" | sort | uniq
				break
			fi
			break
		;;

		#./tool.sh --browsers -f <file>
		#this command , searches the given file for all the browsers that the records use and the number of the occurences
		#example : Chrome 128
		#	   Safari 30
		#	   Firefox 29
		# i used the match function and i stored the occurences inside an array
		--browsers)
			if [ "${argv[1]}" = "-f" ] && [ -n "${argv[2]}" ] && [ -z "${argv[3]}" ]
			then
				awk -F"|" 'NF>1 && /^[^#]/ {print $8}' "${argv[2]}" | sort | uniq -c | awk -F" " '{OFS=FS ; print $2 ,$3, $1}' | sed -r 's/ {2}/ /g'	 
			break
			fi
		break		
		;;
		

		
		#./tool.sh --born-since <A> --born-until <B> -f <file>
		#given 2 dates through the command line , it searches for records with birthdays between those dates
		--born-since)
			if [ "${argv[2]}" = "--born-until" ] && [ "${argv[4]}" = "-f" ] && [ -n "${argv[3]}" ] && [ -n "${argv[5]}" ] && [ -n "${argv[1]}" ] 				&& [ -z "${argv[6]}" ]		
			then
				awk -F"|" -v until="${argv[3]}" -v since="${argv[1]}" '$5<=until && $5>=since && /^[^#]/ {print $0 }' "${argv[5]}"
			break
		
			#./tool.sh --born-since <A> -f <file>
			#given a date it searches for records that their birthdays are after that date
			elif [ -n "${argv[1]}" ] && [ "${argv[2]}" = "-f" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				awk -F"|" -v since="${argv[1]}" '$5>=since && /^[^#]/ {print $0 }' "${argv[3]}"
			fi

		break		
		;;

		#./tool.sh --born-until <A> --born-since <B> -f <file>
		#given 2 dates through the command line , it searches for records with birthdays between those dates		
		--born-until)
			if [ "${argv[2]}" = "--born-since" ] && [ "${argv[4]}" = "-f" ] && [ -n "${argv[3]}" ] && [ -n "${argv[5]}" ] && [ -n "${argv[1]}" ] 				&& [ -z "${argv[6]}" ]			
			then
				awk -F"|" -v until="${argv[1]}" -v since="${argv[3]}" '$5<=until && $5>=since && /^[^#]/ {print $0 }' "${argv[5]}"
			break

			#./tool.sh --born-until <A> -f <file>
			#given a date it searches for records that their birthdays are before that date
			elif [ -n "${argv[1]}" ] && [ "${argv[2]}" = "-f" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				awk -F"|" -v until="${argv[1]}" '$5<=until && /^[^#]/ {print $0 }' "${argv[3]}"

			fi


		break		
		;;
		

		#./tool.sh -id <id> -f <file>
		#given an id through the command line , it searches for records that have the same id and prints the record		
		-id)
			if [ "${argv[2]}" = "-f" ] && [ -n "${argv[1]}" ] && [ -n "${argv[3]}" ] && [ -z "${argv[4]}" ]
			then
				
				awk  -F"|" -v id="${argv[1]}" '$1==id  && /^[^#]/ {print $3 ,$2 , $5}' "${argv[3]}"	

			break
			fi	
		;;	

		#./tool.sh --edit <id> <coloumn> <value> -f <file>
		#given an id , it replaces the value in the column given by the user through the command line as arguments	
		--edit)
			if [ "${argv[4]}" = "-f" ] && [ -n "${argv[1]}" ] && [ -n "${argv[2]}" ] && [ -n "${argv[3]}" ] && [ -n "${argv[5]}" ] && [ -z 				"${argv[6]}" ]
			then
				if [ "${argv[2]}" -lt "9" ] && [ "${argv[2]}" -gt "1" ]
				then
					awk -F"|" -v uid="${argv[1]}" -v column="${argv[2]}" -v value="${argv[3]}" '
					OFS=FS
					{if($1==uid) { $(column)=value ;print$0 }}' "${argv[5]}" >  random | scp random  , "${argv[5]}"
					break
				fi
			fi			
			break			

		;;

		#the default for any other option so it cant go in an endless loop
		*)
		break
		;;	
			
	esac 


done

exit 0
