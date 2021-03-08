#!/usr/bin/env bash

clear

echo "welcome to the Grimsby Veg Market!"
echo

function menu(){
echo "---------------Veg Market------------------"
echo "--------------------|----------------------"
echo "--1--£0.40 p/k------|---------Tomatos------"
echo "--2--£0.45 p/k------|---------Cabbage------"
echo "--3--£0.24 p/k------|---------Onions-------"
echo "--4--£0.28 p/k------|---------Carrots------"
echo "--5--£0.19 p/k------|---------Turnips------"
echo "--6--£2.00 p/k------|---------Avocado------"
echo "--------------------|----------------------"
echo 
echo 
echo 
}

#amount of items in bag
item_counter=0

#total for bill
total=0

#string to be added to for ordering
order=""

#list for the bill
order_list=()

#boolean to run main loop if shopping
shopping=true

#price list for variables
Tomato=40
Cabbage=45
Onion=24
Carrot=28
Turnip=19
Avocado=200

#Customer details
name=""
phoneNumber=""


function getDetails(){
  read -r -p "What is your name?" name
  echo
  read -r -p "What is your phone number?" phoneNumber
  echo

}




#order function
function addToBasket(){
echo
echo -n "What Vegtable would you like enter code would you like?: "
read vegCode
echo

echo -n "How many would you like?: "
read amount
echo

case $vegCode in
1)
echo "You have added" $((amount)) "Tomatoes to your basket"
echo
value=$((Tomato * amount))
float_convertion "$value"
order_list+=("$((amount)) Tomatoe(s) $final_bill")
$((item_counter+=1))
;;
2)
echo "You have added" $((amount)) "Cabbages to your basket"
echo
value=$((Cabbage * amount))
float_convertion "$value"
order_list+=("$((amount)) Cabbage(s) $final_bill")
$((item_counter+=1))
;;
3)
echo "You have added" $((amount)) "Onions to your basket"
echo
value=$((Onion * amount))
float_convertion "$value"
order_list+=("$((amount)) Onion(s) $final_bill")
$((item_counter+=1))
;;
4)
echo "You have added" $((amount)) "Carrots to your basket"
echo
value=$((Carrot * amount))
float_convertion "$value"
order_list+=("$((amount)) Carrot(s) $final_bill")
$((item_counter+=1))
;;
5)
echo "You have added" $((amount)) "Turnips to your basket"
echo
value=$((Turnip * amount))
float_convertion "$value"
order_list+=("$((amount)) Turnip(s) $final_bill")
$((item_counter+=1))
;;
6)
echo "You have added" $((amount)) "Avaocados to your basket"
echo
value=$((Avocado * amount))
float_convertion "$value"
order_list+=("$((amount)) Avaocado(s) $final_bill")
$((item_counter+=1))
;;
*)
echo "you have entered an invalid entry"
echo
;;
esac
}

#function to convert int money into string £XX.XX format
function float_convertion(){
            
            length_of_total=${#1}   

            pennys=${1:(-2)}  

            dollars=${1:0:length_of_total-2}

            type="£"

            dot="."

            final_bill=$type$dollars$dot$pennys

}

#function for printing bill
function printbill(){
echo "-----------------Reciept-------------------"
echo "--------------------|----------------------"
printf " %20s %10s\n" "Customer name :" $name 
printf " %20s %10s\n" "PhoneNumber :" $phoneNumber
echo "-------------------------------------------"

#printf for deploying the table 
    divider===============================
    divider=$divider$divider

    header="\n %22s\n"
    format=" %8s %15s %10s\n"

    width=43

    printf "$header" "Order"

    printf "%$width.${width}s\n" "$divider"

    for val in "${order_list[@]}";
    do
      printf "$format" \
      $val    

done

#print out total
echo "-------------------------------------------"
printf " %20s %10s\n" "Total :" $final_bill
echo "--------------------|----------------------"

}


#----------------------main code--------------------- 


#prints menu
menu

#gets user details
getDetails

#main loop for running program
while [ $shopping == true ]
do
       read -r -p "Would you like to buy something?" order


        if [ "$order" = "Yes" ] || [ "$order" = "yes" ] || [ "$order" = "Y" ] || [ "$order" = "y" ]
        then

            addToBasket
            total=`expr $total + $value`
            

        else
            float_convertion "$total"
            echo 
            echo " Thankyou for shopping with Grimsby Market!"
            echo
            printbill
            shopping=false
            exit
        fi

done




