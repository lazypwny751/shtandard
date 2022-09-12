# shtandard
Simple standard bourne again shell library collection.

# Installation
```
git clone https://github.com/lazypwny751/shtandard.git
cd shtandard
sudo make install
```

# Usage
```
requiresh: there is 4 options:
	requiresh --path, -p
		it shows library path directories of requiresh.

	requiresh --version, -v
		it shows current version of requiresh.

	requiresh --help, -h
		it shows this helper text.

	requiresh <lib> <lib>..
		you can source that libraries using with directly 
		typing by names and there is no needed filename extension ('.sh')
		if the file couldn't be sourced then the program will be return
		non-zero exit code, also you can set the exit type 'exit' to 'return'
		with define a variable called by ${REQUIRESH_RETURN} to non-null value.

abi benim ştandart kütüphanelerim bu.
	--Shtandard Kazım.
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
