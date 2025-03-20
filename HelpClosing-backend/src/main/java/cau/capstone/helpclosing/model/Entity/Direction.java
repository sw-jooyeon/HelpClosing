package cau.capstone.helpclosing.model.Entity;

import lombok.Getter;

@Getter
public enum Direction {
    NORTH(0.0),
    WEST(270.0),
    SOUTH(180.0),
    EAST(90.0),
    NORTHWEST(315.0),
    SOUTHWEST(225.0),
    SOUTHEAST(135.0),
    NORTHEAST(45.0);

    private final double bearing;

    Direction(double bearing){
        this.bearing = bearing;
    }
}
