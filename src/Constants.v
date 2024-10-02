// This file will contain all the constants we made for the game.

// Grid constants
parameter TILE_SIZE         = 32;
parameter X_TOTAL_TILE      = 20;
parameter Y_TOTAL_TILE      = 15;

// Scoring contant
parameter c_SCORE_INI       = 0;

// Player constants
parameter c_X_BASE_POSITION = 320;
parameter c_Y_BASE_POSITION = 384;

// VGA constants
parameter H_VISIBLE_AREA    = 640;
parameter H_FRONT_PORCH     = 16;                                                           // Unvisible Area
parameter H_SYNC_PULSE      = 96;                                                           // Unvisible Area
parameter H_BACK_PORCH      = 48;                                                           // Unvisible Area
parameter H_TOTAL           = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

parameter V_VISIBLE_AREA    = 480;
parameter V_FRONT_PORCH     = 10;
parameter V_SYNC_PULSE      = 2;
parameter V_BACK_PORCH      = 33;
parameter V_TOTAL           = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

// Clock constaints 
parameter c_DEBOUNCE_LIMIT  = 250000;

parameter COUNT_LIMIT       = 12500000;