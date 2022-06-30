#!/usr/bin/env bash

INPUT_DELAY=0.2
GRID_SIZE=20

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_blue=$(tput setaf 4)
color_normal=$(tput sgr0)

fruit_coord="1,1"
x=$((GRID_SIZE/2))
snake_coords=("$x,$x" "$x,$((x+1))" "$x,$((x+2))")


#--------------------------------------------------------------
# functions
#--------------------------------------------------------------
coord_is_wall_hori() {
  local i="$1"
  local j="$2"
  if [ "$i" == 0 ] || [ "$i" == "$((GRID_SIZE-1))" ]; then
    return 0
  else
    return 1
  fi
}

coord_is_wall_vert() {
  local i="$1"
  local j="$2"
  if [ "$j" == 0 ] || [ "$j" == "$((GRID_SIZE-1))" ]; then
    return 0
  else
    return 1
  fi
}

coord_is_wall() {
  local i="$1"
  local j="$2"
  if coord_is_wall_hori $i $j || coord_is_wall_vert $i $j; then
    return 0
  else
    return 1
  fi
}

coord_is_in_snake() {
  local i="$1"
  local j="$2"
  for c in ${snake_coords[@]}; do
    [ "$i,$j" == "$c" ] && return 0
  done
  return 1
}

print_grid() {
  local str=""
  for (( i = 0; i < $GRID_SIZE; i++ )); do
    for (( j = 0; j < $GRID_SIZE; j++ )); do
      # wall
      if coord_is_wall_hori $i $j; then
        str+="${color_red}_"
      elif coord_is_wall_vert $i $j; then
        str+="${color_red}|"
      elif [ "$i,$j" == "$fruit_coord" ]; then
        str+="${color_yellow}O"
      elif coord_is_in_snake $i $j; then
        if [ "$i,$j" == "${snake_coords[-1]}" ]; then
          str+="${color_green}@"
        else
          str+="${color_green}*"
        fi
      else
        str+=" "
      fi
      str+="$color_normal"
    done
    str+="\n"
  done
  tput cup 0 0
  printf "$str"
}

create_named_pipe() {
  local pipe
  pipe=$(mktemp --dry-run)
  if [[ ! -p $pipe ]]; then
    mkfifo $pipe
  fi
  echo $pipe
}

get_key_pressed() {
  local escape_char=$(printf "\u1b")
  read -rsn1 -t $INPUT_DELAY mode # get 1 character
  if [[ $mode == $escape_char ]]; then
    read -rsn2 mode # read 2 more chars
  fi
  case $mode in
    '[A') echo UP ;;
    '[B') echo DOWN ;;
    '[D') echo LEFT ;;
    '[C') echo RIGHT ;;
    *) echo "" ;;
  esac
}

set_new_fruit() {
  local x
  local y
  x=$(($RANDOM % GRID_SIZE))
  y=$(($RANDOM % GRID_SIZE))
  while coord_is_in_snake $x $y || coord_is_wall $x $y; do
    x=$(($RANDOM % GRID_SIZE))
    y=$(($RANDOM % GRID_SIZE))
  done
  fruit_coord="$x,$y"
}

next_state() {
  local direction="$1"
  local dx=0
  local dy=0
  case $direction in
    UP)
      dx=-1
      ;;
    DOWN)
      dx=1
      ;;
    LEFT)
      dy=-1
      ;;
    RIGHT)
      dy=1
      ;;
  esac

  # compute new head
  head_coord="${snake_coords[-1]}"
  x="$(echo $head_coord | sed 's/,.*//')"
  y="$(echo $head_coord | sed 's/.*,//')"
  new_x=$((x+dx))
  new_y=$((y+dy))
  new_head_coord="$new_x,$new_y"
  if coord_is_in_snake $new_x $new_y || coord_is_wall $new_x $new_y; then
    echo "YOU LOSE"
    exit 1
  fi

  # update snake
  snake_coords+=($new_head_coord)
  if [ "$new_x,$new_y" == "$fruit_coord" ]; then
    set_new_fruit
  else
    snake_coords=("${snake_coords[@]:1}")
  fi
}

main_loop() {
  tput clear
  tput civis # invisible cursor
  set_new_fruit
  while read direction < $direction_pipe; do
    next_state $direction
    print_grid
  done&
}


#--------------------------------------------------------------
# execution
#--------------------------------------------------------------
export direction_pipe="$(create_named_pipe)"
trap "rm -f $direction_pipe" EXIT

main_loop&

# key press handling
direction=RIGHT
while true; do
  key="$(get_key_pressed)"
  [ "$key" != "" ] && direction="$key"
  echo "$direction" > $direction_pipe
done
