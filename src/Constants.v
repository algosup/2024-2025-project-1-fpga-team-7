// This file will contain all the constants to ensure the proper functioning of the game.

// Grid constants
parameter TILE_SIZE             = 32;
parameter X_TOTAL_TILE          = 20;
parameter Y_TOTAL_TILE          = 15;

// Scoring contant
parameter C_SCORE_INI           = 1;

// Player constants
parameter C_X_BASE_POSITION     = 320;
parameter C_Y_BASE_POSITION     = 416;

// States machine
parameter IDLE                  = 0;
parameter RUNNING               = 1;

// Obstacles constants
parameter C_Y_BASE_CAR_POSITION         = 11;
parameter C_BASE_CAR_SPEED              = 390625;
parameter C_LINE_6_Y                    = 352;
parameter C_LINE_5_Y                    = 320;
parameter C_LINE_4_Y                    = 288;
parameter C_LINE_3_Y                    = 160;
parameter C_LINE_2_Y                    = 128;
parameter C_LINE_1_Y                    = 96;

// VGA constants
parameter H_VISIBLE_AREA        = 640;
parameter H_FRONT_PORCH         = 16;                                                           // Unvisible Area
parameter H_SYNC_PULSE          = 96;                                                           // Unvisible Area
parameter H_BACK_PORCH          = 48;                                                           // Unvisible Area
parameter H_TOTAL               = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

parameter V_VISIBLE_AREA        = 480;
parameter V_FRONT_PORCH         = 10;
parameter V_SYNC_PULSE          = 2;
parameter V_BACK_PORCH          = 33;
parameter V_TOTAL               = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

// Clock constaints 
parameter C_DEBOUNCE_LIMIT      = 8000;

parameter COUNT_LIMIT           = 3125000;

parameter NUM_BITS              = 4;                                                             // LFSR parameter