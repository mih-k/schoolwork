library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity adder is
	port (
		clock_50_mhz :in std_logic;
		en :in std_logic;
		data_registerfile : in std_logic_vector(7 downto 0);
		read_address: out std_logic_vector(2 downto 0);
		output : out std_logic_vector(11 downto 0));
end adder;

architecture arch of adder is
	type state_type is (a, b, c, d, e, f, g, h);
	signal cur_s, next_s : state_type;
begin
	process(data_registerfile, cur_s)
	begin
		case cur_s is
		when a =>
			next_s <= b;
		when b =>
			next_s <= c;
		when c =>
			next_s <= d;
		when d =>
			next_s <= e;
		when e =>
			next_s <= f;
		when f =>
			next_s <= g;
		when g =>
			next_s <= h;
		when h =>
			next_s <= h;
		end case;
	end process;
	process(clock_50_mhz)
		variable buf : unsigned(7 downto 0);
		variable int_buf: integer := 0;
		variable int_len, tmp : integer := 0;
		
		variable int_str : string(1 to 3);
	
		-- Decimal Values
		variable val0, val1, val2: integer := 0;
	begin
		if(rising_edge(clock_50_mhz)) then
			if(en = '0') then
				cur_s <= a;
				read_address <= "000";
			else 	
			
			cur_s <= next_s;
			
			case cur_s is
			when a =>
				buf := unsigned(data_registerfile);
				read_address <= "001";
			when b =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "010";
			when c =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "011";
			when d =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "100";
			when e =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "101";
			when f =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "110";
			when g =>
				buf := buf + unsigned(data_registerfile);
				read_address <= "111";
			when h =>
				buf := buf + unsigned(data_registerfile);
				int_buf := to_integer(buf);
				tmp := int_buf;
				
				-- First, we get the length of the integer
				
				for iter in 2 downto 1 loop
					exit when (tmp <= 0);
					tmp := tmp / 10;
					int_len := int_len + 1;
				end loop;
				
				-- Then, we do BCD
				
				if(int_len = 1) then
					
					output(11 downto 8) <= "0000";
					output(7 downto 4) <= "0000";
					output(3 downto 0) <= std_logic_vector(to_unsigned(int_buf, 4));
					
				elsif (int_len = 2) then
					
					val1 := (int_buf/10) mod 10;
					val0 := (int_buf mod 10);
					
					output(11 downto 8) <= "0000";
					output(7 downto 4) <= std_logic_vector(to_unsigned(val1, 4));
					output(3 downto 0) <= std_logic_vector(to_unsigned(val0, 4));
					
				elsif (int_len = 3) then
				
					val2 := (int_buf/100) mod 10;
					val1 := (int_buf/10) mod 10;
					val0 := (int_buf mod 10);
					
					output(11 downto 8) <= std_logic_vector(to_unsigned(val2, 4));
					output(7 downto 4) <= std_logic_vector(to_unsigned(val1, 4));
					output(3 downto 0) <= std_logic_vector(to_unsigned(val0, 4));
				end if;
				
				 report "Sum: " & integer'image(int_buf);
				
			end case;
			end if;
		end if;
	end process;

end arch;