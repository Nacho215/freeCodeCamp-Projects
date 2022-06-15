#! /bin/bash

#PSQL command
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

#Welcome message
echo -e '\n~~~~~ MY SALON ~~~~~'

SERVICES_MENU(){
  #If this function is called with an argument
  if [[ $1 ]]
  then
    #Print it
    echo -e "\n$1"
  else
    #Else print the standard message
    echo -e '\nWelcome to My Salon, how can I help you?\n'
  fi

  # Get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services;")

  # Display available services
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  # Ask for a service
  read SERVICE_ID_SELECTED
  # if input is not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    # Send to services menu
    SERVICES_MENU "Please input a number."
  else
    # Find that service
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
    # If not available
    if [[ -z $SERVICE_NAME ]]
    then
      # Send to services menu
      SERVICES_MENU "I could not find that service. What would you like today?"
    else
      # Ask for the customer information
      ASK_CUSTOMER_INFO
    fi
  fi
}

ASK_CUSTOMER_INFO(){
  #Ask for a phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #Check if customer exists in database
  CUSTOMER=$($PSQL "SELECT customer_id, name, phone FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  #If dont exists
  if [[ -z $CUSTOMER ]]
  then
    #Ask for the customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    #Add customer to database
    ADD_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) values('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
    #If insert is successfull
    if [[ $ADD_CUSTOMER == "INSERT 0 1" ]]
    then
      #Appoint the service
      APPOINT_SERVICE
    fi
  else
    #Get the customer name for that phone
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")
    #If it is in the database, appoint the service
    APPOINT_SERVICE
  fi

}

APPOINT_SERVICE(){
  #Ask for a service time
  echo -e "\nWhat time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  #Get customer INFO
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  # If get successfully
  if [[ CUSTOMER_ID ]]
  then
    #Add appointment to database
    ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
    #If insert is successfull
    if [[ $ADD_APPOINTMENT == "INSERT 0 1" ]]
    then
      #Print message confirming the appointment
      echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

#Start with services menu
SERVICES_MENU