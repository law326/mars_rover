# Mars Rover

Mars Rover is a robot that follows commands and move around Mars.

Here are the rules:

- The world should be modelled as a grid with size m x n
- Each robot has a position (x, y), and an orientation (N, E, S, W)
- Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate right by 90 degrees (R)
- If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and orientation is recorded
- Going from x->x+1 is in the easterly direction,and y->y+1 is in the northerly direction. i.e. (0, 0) represents the south-west corner of the grid

## Setup

You will need to have following installed before start running the application:
  - Ruby 2.6.x

## Install Dependencies

Go to project folder and run following command to install dependencies

```
> bundle install
```

## Launch Mars Mission

Update your Mars mission commands in `rover_commands/mars_rover_commands.txt` and run following command in your terminal:

```
> ruby mars_rover.rb
```

Result should be displayed on your terminal.


## Run Unit Tests

You can run all the unit tests by following command:

```
> bundle exec rspec spec
```
