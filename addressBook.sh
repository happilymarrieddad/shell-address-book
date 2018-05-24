#!/bin/bash

loc="."
filename="addresses"

mode=1
selection=""

addAddress() {
	clear
	echo -en "Name: "
	read name
	echo -en "Address: "
	read address
	echo -en "City: "
	read city
	echo -en "State: "
	read state
	echo -en "Postal/Zip: "
	read postal

	line="$name:$address:$city:$state:$postal"
	echo "Saving:"
	echo "Name: $name"
	echo "Address: $address"
	echo "City: $city"
	echo "State: $state"
	echo "Postal/Zip: $postal"
	echo ""

	echo "Saving..."
	echo "$line" >> "$loc/$filename"
	echo "Saved successfully!"
	echo ""
}

deleteAddress() {
	clear
	displayAddresses

	echo -en "Selection: "
	read selection
	sed -i "${selection}d" "$loc/$filename"
}

displayAddresses() {
	clear
	echo "Here is a list of all the addresses"
	echo ""

	index=1
	while IFS='' read -r line || [ -n "$line" ]; do
		
		name=`awk -F: '{ print $1 }' <<< $line`
		address=`awk -F: '{ print $2 }' <<< $line`
		city=`awk -F: '{ print $3 }' <<< $line`
		state=`awk -F: '{ print $4 }' <<< $line`
		postal=`awk -F: '{ print $5 }' <<< $line`

		echo ""
		echo "$index)"
		echo "Name: $name"
		echo "Address: $address"
		echo "City: $city"
		echo "State: $state"
		echo "Postal/Zip: $postal"

		let "index++"

	done < "$loc/$filename"

	echo ""
}

mainmenu() {
	echo ""
	echo "Welcome to Address Book program!"
	echo ""
	echo "Please select an option from below"
	echo ""
	echo "1) Add address"
	echo "2) Delete address"
	echo "3) Display all addresses"
	echo ""
	echo "4) Quit"
	echo ""
	echo -en "Selection: "
	read selection
	
	case $selection in

		1)
			addAddress
			;;

		2)
			deleteAddress
			;;

		3)
			displayAddresses
			;;

		4)
			echo "See you next time!"
			exit 0
			;;

		*)
			clear
			echo "Invalid selection: '$selection'. Please try again."
			;;

	esac
}


verifyStructure() {
	if [ ! -f $loc/$filename ]; then
		touch $loc/$filename
	fi
}

main() {
	verifyStructure

	while [ "$mode" -ne "0" ]
	do
		case $mode in

			1)
				mainmenu
				;;

			*)
				echo "Unknown mode '$mode'"
				exit 0
				;;

		esac
	done
}

main