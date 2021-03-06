library IEEE;
use IEEE.std_logic_1164.all;

entity shift_reg is
port(	clk: 			in std_logic;
		reset:	 		in std_logic;
		enable: 		in std_logic;
		shift_in:		in std_logic;
		reg_set:		in std_logic;
		reg_write: 		in std_logic_vector (7 downto 0);
		output: 		out std_logic_vector (7 downto 0)
	);
end shift_reg;

architecture structural of shift_reg is

	signal reg_shift,shifted_reg: std_logic_vector (7 downto 0);

begin

	shifted_reg(7 downto 1) <= reg_shift(6 downto 0);
	shifted_reg(0) <= shift_in;
	
	process(clk,reg_set,reset)
	begin
	if(reset = '1') then
		reg_shift <= (others => '0');
	else
		if(reg_set = '1') then
			reg_shift <= reg_write;
		else
			if(rising_edge(clk)) then
				if(enable = '1') then
					reg_shift <= shifted_reg;
				else
					reg_shift <= reg_shift;
				end if;
			end if;
		end if;
	end if;
	end process;

	output <= reg_shift;
	
end structural;





