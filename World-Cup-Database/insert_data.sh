#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#Clear the tables
echo $($PSQL "TRUNCATE TABLE games, teams;")

#Read the csv
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS;
do
  #Avoid reading the first line (column names)
  if [[ $YEAR != 'year' ]]
  then
    #---TEAMS---

    #Check if WINNER team is already in the table teams
    WINNER_CHECK_RESULT=$($PSQL "SELECT name FROM teams WHERE name = '$WINNER';")
    #If is not in the table teams
    if [[ -z $WINNER_CHECK_RESULT ]]
    then
      #Insert into the table teams
      WINNER_INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      #If insert is done correctly
      if [[ $WINNER_CHECK_RESULT=="INSERT 0 1" ]]
      then
        #Print a message
        echo "$WINNER added to table 'teams'"
      fi
    fi
    #Check if OPPONENT team is already in the table teams
    OPPONENT_CHECK_RESULT=$($PSQL "SELECT name FROM teams WHERE name = '$OPPONENT';")
    #If is not in the table teams
    if [[ -z $OPPONENT_CHECK_RESULT ]]
    then
      #Insert into the table teams
      OPPONENT_INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      #If insert is done correctly
      if [[ $OPPONENT_CHECK_RESULT=="INSERT 0 1" ]]
      then
        #Print a message
        echo "$OPPONENT added to table 'teams'"
      fi
    fi
    
    #---GAMES---
    #Get the Winner Team ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    #Get the Opponent Team ID
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    #Insert into the table games
    GAME_INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) \
    VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
    #If insert is done correctly
    if [[ $GAME_INSERT_RESULT=="INSERT 0 1" ]]
    then
      #Print a message
      echo "Game: $YEAR $ROUND [$WINNER ($WINNER_GOALS) - ($OPPONENT_GOALS) $OPPONENT] added to table 'games'"
    fi
  fi
done