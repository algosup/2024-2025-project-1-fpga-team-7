parameter TILE_SIZE      = 32;
parameter X_TOTAL_TILE   = 20;
parameter Y_TOTAL_TILE   = 15;

parameter c_X_BASE_POSITION = 320;
parameter c_Y_BASE_POSITION = 384;

parameter H_VISIBLE_AREA = 640;
parameter H_FRONT_PORCH  = 18;
parameter H_SYNC_PULSE   = 92;
parameter H_BACK_PORCH   = 50;
parameter H_TOTAL        = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

parameter V_VISIBLE_AREA = 480;
parameter V_FRONT_PORCH  = 10;
parameter V_SYNC_PULSE   = 12;
parameter V_BACK_PORCH   = 33;
parameter V_TOTAL        = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

parameter c_DEBOUNCE_LIMIT = 250000;

parameter COUNT_LIMIT = 1250000;