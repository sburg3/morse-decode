library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
	port(	clock_25 : in std_logic;
			horiz_sync, vert_sync, video_on, pixel_clock : out std_logic;
			red, green, blue : out std_logic_vector(9 downto 0);
			char_addr : in std_logic_vector(5 downto 0);
			letter, word, word_shift : in std_logic
	);
end vga_controller;

architecture a of vga_controller is

component vga_sync is
	port(	Clock_25Mhz : IN STD_LOGIC;
			horiz_sync_out, vert_sync_out, video_on, pixel_clock : OUT STD_LOGIC;
			pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
end component;

component char_rom is
	port(	clock : IN STD_LOGIC;
			character_address : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			font_row, font_col : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			rom_mux_output : OUT STD_LOGIC
	);
end component;

component altsyncram0 is
	port(	clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			rdaddress	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
			wraddress	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q			: OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
	);
end component;

signal pixel_row_int : std_logic_vector(9 downto 0) := "0000000000";
signal pixel_col_int : std_logic_vector(9 downto 0) := "0000000000";
signal rom_pixel_val : std_logic := '0';

signal vga_char_row : unsigned(5 downto 0) := "000000";
signal vga_char_col : unsigned(5 downto 0) := "000000";

signal ram_write_addr : unsigned(10 downto 0) := "00000000000";
signal ram_read_addr : unsigned(10 downto 0) := "00000000000";

signal ram_char_addr_out : std_logic_vector(5 downto 0) := "000000";
signal ram_char_addr_in : std_logic_vector(5 downto 0) := "000000";

signal update_write_addr : std_logic := '0';

begin

vga1 : vga_sync
	port map(
		Clock_25Mhz => clock_25,
		horiz_sync_out => horiz_sync,
		vert_sync_out => vert_sync,
		video_on => video_on,
		pixel_clock => pixel_clock,
		pixel_row => pixel_row_int,
		pixel_column => pixel_col_int
	);
	
char1 : char_rom
	port map(
		clock => clock_25,
		character_address => ram_char_addr_out,
		font_row => pixel_row_int(3 downto 1),
		font_col => pixel_col_int(3 downto 1),
		rom_mux_output => rom_pixel_val
	);

alt1 : altsyncram0
	port map(
		clock => not clock_25,
		data => ram_char_addr_in,
		rdaddress => std_logic_vector(ram_read_addr),
		wraddress => std_logic_vector(ram_write_addr),
		wren => update_write_addr,
		q => ram_char_addr_out
	);

red <= "1111111111" when rom_pixel_val = '1' else "0000000000";
green <= "1111111111" when rom_pixel_val = '1' else "0000000000";
blue <= "1111111111" when rom_pixel_val = '1' else "0000000000";

vga_char_row <= unsigned(pixel_row_int(9 downto 4));
vga_char_col <= unsigned(pixel_col_int(9 downto 4));

ram_read_addr <= resize(vga_char_row * 40 + vga_char_col, 11);

update_write_addr <= letter or (word xor (not word_shift));

--ram_char_addr_in <= "000000" when word = '1' else char_addr;

process(clock_25)
begin
	if rising_edge(clock_25) then
		if letter = '1' then
			ram_char_addr_in <= char_addr;
		elsif word = '1' and word_shift = '1' then
			ram_char_addr_in <= char_addr;
		elsif word = '1' and word_shift = '0' then
			ram_char_addr_in <= "000000";
		else
			ram_char_addr_in <= "000000";
		end if;
	end if;
end process;

process(update_write_addr)
begin
	if rising_edge(update_write_addr) then
		ram_write_addr <= ram_write_addr + 1;
		if ram_write_addr > 1200 then
			ram_write_addr <= "00000000000";
		end if;
	end if;
end process;
end a;