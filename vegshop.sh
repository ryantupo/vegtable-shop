#!/usr/bin/env bash

clear

echo "     welcome to the Grimsby Veg Market!"
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

#get customer data
function getDetails(){
    read -r -p "What is your Name?" name
    echo
    
    while [ "$name" = "" ] || [ "$name" = " " ]
    do
        echo "You didnt enter a Name try again"
        echo
        read -r -p "What is your Name? " name
        echo
    done
    
    read -r -p "What is your phoneNumber? " phoneNumber
    
    while :; do
        if [[ $phoneNumber =~ \+?(0|[1-9]\d*)$ ]];then
            break
        else
            echo
            echo "Invalid amount please enter a valid digit"
            echo
            read -r -p "What is your phoneNumber? " phoneNumber
            echo
        fi
    done
    
}




#order function
function addToBasket(){
    
    echo
    echo -n "What Vegtable would you like, enter vegatable code [1-6] ?: "
    read vegCode
    
    #while loops to validate user entry and make sure is valid
    while :; do
        if [[ $vegCode =~ [1-6] && $vegCode -gt 0 ]];then
            break
        else
            
            echo
            echo "Invalid entry please enter a number between [1-6]"
            echo
            echo -n "What Vegtable would you like, enter vegatable code [1-6] ?: "
            read vegCode
            
            
        fi
    done
    
    echo
    echo -n "How many (KG) would you like?: "
    echo
    read amount
    while [ $((amount)) -le 1 ]
    do
        echo "The kg of veg has to be above 1kg"
        echo
        echo -n "How many (KG) would you like?: "
        read amount
        echo
    done
    
    while :; do
        if [[ $amount =~ \+?(0|[1-9]\d*)$ ]];then
            break
        else
            echo
            echo "Invalid amount please enter a valid digit"
            echo
            
            
            echo -n "How many (KG) would you like?: "
            read amount
            echo
            
            
            
            
        fi
    done
    
    
    
    
    case $vegCode in
        1)
            echo "You have added" $((amount)) "KG of Tomatoes to your basket"
            echo
            value=$((Tomato * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Tomatoe(s) $final_bill")
            item_counter=$((++item_counter))
        ;;
        2)
            echo "You have added" $((amount)) "KG of Cabbages to your basket"
            echo
            value=$((Cabbage * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Cabbage(s) $final_bill")
            item_counter=$((++item_counter))
        ;;
        3)
            echo "You have added" $((amount)) "KG of Onions to your basket"
            echo
            value=$((Onion * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Onion(s) $final_bill")
            item_counter=$((++item_counter))
        ;;
        4)
            echo "You have added" $((amount)) "KG of Carrots to your basket"
            echo
            value=$((Carrot * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Carrot(s) $final_bill")
            item_counter=$((++item_counter))
        ;;
        5)
            echo "You have added" $((amount)) "KG of Turnips to your basket"
            echo
            value=$((Turnip * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Turnip(s) $final_bill")
            item_counter=$((++item_counter))
        ;;
        6)
            echo "You have added" $((amount)) "KG of Avaocados to your basket"
            echo
            value=$((Avocado * amount))
            float_convertion "$value"
            order_list+=("$((amount)) Avaocado(s) $final_bill")
            item_counter=$((++item_counter))
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
    
    if [ $length_of_total -gt 0 ]
    then
        pennys=${1:(-2)}
        
        dollars=${1:0:length_of_total-2}
        
        type="£"
        
        dot="."
        
        final_bill=$type$dollars$dot$pennys
    else
        printf "%s \n" "Invalid Entry"
        exit
        
    fi
}

#function for printing bill
function printbill(){
    
    echo "-----------------Reciept-------------------"
    echo "--------------------|----------------------"
    printf " %18s %10s \n" $(date '+%Y-%m-%d %H:%M:%S')
    printf " %20s %.20s\n" "Customer name :" $name
    printf " %20s %.11s\n" "PhoneNumber :" $phoneNumber
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
    read -r -p "Would you like to buy something?(Buy/Checkout/Quit)" order
    
    if [ "$order" = "Q" ] || [ "$order" = "q" ] || [ "$order" = "Quit" ] || [ "$order" = "QUIT" ] || [ "$order" = "quit" ]
    then
        float_convertion "$total"
        echo
        echo " Thankyou for shopping with Grimsby Market!"
        echo
        shopping=false
        exit
        
        
        
    elif [ "$order" = "B" ] || [ "$order" = "b" ] || [ "$order" = "Buy" ] || [ "$order" = "buy" ]
    then
        
        addToBasket
        total=`expr $total + $value`
        
    elif  [ "$order" = "C" ] || [ "$order" = "c" ] || [ "$order" = "Checkout" ] || [ "$order" = "CHECKOUT" ] || [ "$order" = "checkout" ]
    then
        float_convertion "$total"
        echo
        echo
        printbill
        
    else
        echo
        echo "Sorry $order is an invalid entry Please Try Again "
        echo
        
        
    fi
    
done
