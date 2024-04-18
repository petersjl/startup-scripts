if status is-interactive
	# Add the personal bin to path if it exists
	if [ -d "$HOME/bin" ] 
		set PATH "$HOME/bin:$PATH"
	end

	# If this is in WSL, change some things
	if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]
		set BROWSER wslview
	end

	# Add custom keybinds
	bind \b backward-kill-word

	# Commands to run in interactive sessions can go here
	function prof
		vim ~/.config/fish/config.fish
	end

	function funcdel
		set -l fun_name $argv[1]
		set -l fun_file ~/.config/fish/functions/{$fun_name}.fish

		functions --erase $fun_name
		if test -e $fun_file
			rm $fun_file
		end
	end

	function cdd
		cd ../$argv[1]
	end

	function cdh
		cd ~/$argv[1]
	end

	function reload
		source ~/.config/fish/config.fish
	end

	function reloadall
		set -l fundir ~/.config/fish/personal_functions

		# Load the functions from the "personal_functions" folder
		if test -d $fundir
			echo the folder exists
			for file in $fundir/*.fish
				echo running $file
				fish {$file}
			end
		end
	end

	function cx
		chmod +x $argv[1]
	end
	
	# APT aliases
	function sai
		sudo apt-get install $argv[1]
	end
	function saiy
		sudo apt-get install -y $argv[1]
	end
	function sau
		sudo apt-get update
	end


end
