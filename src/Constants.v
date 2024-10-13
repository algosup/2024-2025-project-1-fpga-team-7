// This file will contain all the constants we made for the game.

// Grid constants
parameter TILE_SIZE                     = 6'd32;
parameter X_TOTAL_TILE                  = 5'd20;
parameter Y_TOTAL_TILE                  = 4'd15;

// Scoring contant
parameter C_SCORE_INI                   = 1'b1;

// Player constants
parameter C_X_BASE_POSITION             = 9'd320;
parameter C_Y_BASE_POSITION             = 9'd384;

// States machine
parameter IDLE                          = 1'b0;
parameter RUNNING                       = 1'b1;


// Obstacles constants
parameter C_X_BASE_CAR_POSITION         = 1'b0;
parameter C_X_REVERSE_BASE_CAR_POSITION = 608;
parameter C_Y_BASE_CAR_POSITION         = 11;
parameter C_BASE_CAR_SPEED              = 390625;
parameter C_LINE_4_Y                    = 320;
parameter C_LINE_3_Y                    = 256;
parameter C_LINE_2_Y                    = 192;
parameter C_LINE_1_Y                    = 128;
parameter C_NB_CARS                     = 4;

// VGA constants
parameter H_VISIBLE_AREA                = 640;
parameter H_FRONT_PORCH                 = 16;                                                           // Unvisible Area
parameter H_SYNC_PULSE                  = 96;                                                           // Unvisible Area
parameter H_BACK_PORCH                  = 48;                                                           // Unvisible Area
parameter H_TOTAL                       = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

parameter V_VISIBLE_AREA                = 480;
parameter V_FRONT_PORCH                 = 10;
parameter V_SYNC_PULSE                  = 2;
parameter V_BACK_PORCH                  = 33;
parameter V_TOTAL                       = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

// Clock constaints 
parameter C_DEBOUNCE_LIMIT              = 250000;

parameter COUNT_LIMIT                   = 3125000;

parameter NUM_BITS                      = 4;