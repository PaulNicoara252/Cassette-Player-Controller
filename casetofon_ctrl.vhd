library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity casetofon_ctrl is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        PL    : in  STD_LOGIC;
        RE    : in  STD_LOGIC;
        FF    : in  STD_LOGIC;
        ST    : in  STD_LOGIC;
        M     : in  STD_LOGIC;
        P     : out STD_LOGIC;
        R     : out STD_LOGIC;
        F     : out STD_LOGIC
    );
end casetofon_ctrl;

architecture Behavioral of casetofon_ctrl is
    type state_type is (STOP, PLAY, REWIND, FAST_FORWARD, WAIT_REWIND, WAIT_FF);
    signal current_state : state_type := STOP;
    signal next_state    : state_type;
begin

    -- Stare curentă
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= STOP;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Tranziții și ieșiri
    process(current_state, PL, RE, FF, ST, M)
    begin
        P <= '0';
        R <= '0';
        F <= '0';

        case current_state is
            when STOP =>
                if ST = '1' then
                    next_state <= STOP;
                elsif PL = '1' then
                    next_state <= PLAY;
                else
                    next_state <= STOP;
                end if;

            when PLAY =>
                if ST = '1' then
                    next_state <= STOP;
                elsif RE = '1' then
                    next_state <= REWIND;
                elsif FF = '1' then
                    next_state <= FAST_FORWARD;
                else
                    next_state <= PLAY;
                end if;
                P <= '1';

            when REWIND =>
                if ST = '1' then
                    next_state <= STOP;
                elsif RE = '0' then
                    next_state <= WAIT_REWIND;
                else
                    next_state <= REWIND;
                end if;
                R <= '1';

            when FAST_FORWARD =>
                if ST = '1' then
                    next_state <= STOP;
                elsif FF = '0' then
                    next_state <= WAIT_FF;
                else
                    next_state <= FAST_FORWARD;
                end if;
                F <= '1';

            when WAIT_REWIND =>
                if ST = '1' then
                    next_state <= STOP;
                elsif M = '0' then
                    next_state <= PLAY;
                else
                    next_state <= WAIT_REWIND;
                end if;
                R <= '1';

            when WAIT_FF =>
                if ST = '1' then
                    next_state <= STOP;
                elsif M = '0' then
                    next_state <= PLAY;
                else
                    next_state <= WAIT_FF;
                end if;
                F <= '1';

            when others =>
                next_state <= STOP;
        end case;
    end process;

end Behavioral;
