--=============================================================================
--  Project      : FPGA Digital Design
--  File         : test1.vhd
--  Author       : Luis David Barahona Valdivieso
--  Organization : UTEC L414 (Lab de Sistemas Embebidos)
--  Date         : 2026-03-12
--  Version      : 1.0
--
--  Description  :
--  Example design for FPGA board.
--  This module demonstrates:
--      1) Direct mapping of switches to LEDs
--      2) Multiplexing control for a 4-digit seven-segment display
--      3) Button-controlled character display on the seven-segment display
--
--  Functional behavior:
--      - Switches (sw) are directly mapped to LEDs (led).
--      - A refresh counter multiplexes the four 7-segment digits.
--      - Pressing buttons displays a character on the display:
--
--            btnU → U
--            btnD → d
--            btnR → r
--            btnL → L
--            btnC → C
--
--      - If no button is pressed, the display remains OFF.
--
--  Target Device :
--      FPGA board compatible with Vivado (Artix-7 / Zynq / Spartan families)
--
--  Notes :
--      Clock input expected: 100 MHz
--      Seven-segment display assumed active-low
--
--=============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test1 is
    Port (
        clk   : in  STD_LOGIC;                      -- 100 MHz
        sw    : in  STD_LOGIC_VECTOR (15 downto 0);  -- Switches
        led   : out STD_LOGIC_VECTOR (15 downto 0);  -- LEDs

        btnU  : in  STD_LOGIC;
        btnD  : in  STD_LOGIC;
        btnL  : in  STD_LOGIC;
        btnR  : in  STD_LOGIC;
        btnC  : in  STD_LOGIC;

        seg   : out STD_LOGIC_VECTOR (6 downto 0);   -- a b c d e f g
        an    : out STD_LOGIC_VECTOR (3 downto 0)    -- anodos
    );
end test1;

architecture Behavioral of test1 is

    signal refresh_cnt : unsigned(15 downto 0) := (others => '0');
    signal digit_sel   : unsigned(1 downto 0);
    signal seg_char    : STD_LOGIC_VECTOR(6 downto 0);

begin

    ------------------------------------------------------------------
    -- 1) SWITCHES → LEDS (1 a 1)
    ------------------------------------------------------------------
    led <= sw;

    ------------------------------------------------------------------
    -- 2) REFRESH COUNTER PARA MULTIPLEXADO
    ------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            refresh_cnt <= refresh_cnt + 1;
        end if;
    end process;

    digit_sel <= refresh_cnt(15 downto 14);

    ------------------------------------------------------------------
    -- 3) SELECCIÓN DE DÍGITO (ANODOS)
    ------------------------------------------------------------------
    process(digit_sel)
    begin
        case digit_sel is
            when "00" => an <= "1110";
            when "01" => an <= "1101";
            when "10" => an <= "1011";
            when others => an <= "0111";
        end case;
    end process;

    ------------------------------------------------------------------
    -- 4) DECODIFICADOR DE LETRAS POR PULSADOR
    ------------------------------------------------------------------
    process(btnU, btnD, btnL, btnR, btnC)
    begin
        if btnU = '1' then
            seg_char <= "1000001"; -- U
        elsif btnD = '1' then
            seg_char <= "0100001"; -- d
        elsif btnR = '1' then
            seg_char <= "0101111"; -- r
        elsif btnL = '1' then
            seg_char <= "1110001"; -- L
        elsif btnC = '1' then
            seg_char <= "0110001"; -- C
        else
            seg_char <= "1111111"; -- apagado
        end if;
    end process;

    ------------------------------------------------------------------
    -- 5) MISMA LETRA EN LOS 4 DÍGITOS
    ------------------------------------------------------------------
    seg <= seg_char;

end Behavioral;
