library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity casetofon_top is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        BTN    : in  STD_LOGIC_VECTOR (4 downto 0);
        LED    : out STD_LOGIC_VECTOR (2 downto 0)
    );
end casetofon_top;

architecture Behavioral of casetofon_top is
    signal P_int, R_int, F_int : STD_LOGIC;
begin
    LED(0) <= P_int;
    LED(1) <= R_int;
    LED(2) <= F_int;

    controller_inst: entity work.casetofon_ctrl
        port map (
            clk   => clk,
            reset => reset,
            PL    => BTN(0),
            RE    => BTN(1),
            FF    => BTN(2),
            ST    => BTN(3),
            M     => BTN(4),
            P     => P_int,
            R     => R_int,
            F     => F_int
        );
end Behavioral;
