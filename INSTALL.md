# Linux

	sudo apt-get install make gcc bison git python
	pip install pillow
	git clone https://github.com/CelestialAmber/TetrisNESDisasm
	cd TetrisNESDisasm
	git submodule update --init

To build `tetris.nes`:

	make


# OS X

In **Terminal**, run:
	
	pip install pillow
	git clone https://github.com/CelestialAmber/TetrisNESDisasm
	cd TetrisNESDisasm
	git submodule update --init

	
To build `tetris.nes`:

	make

# Windows

Download [**Cygwin**](http://cygwin.com/install.html): **setup-x86_64.exe** for 64-bit Windows, **setup-x86.exe** for 32-bit.

Run setup and leave the default settings. At "Select Packages", choose to install the following:

- `make`
- `git`
- `gcc-core`
- `python`



In the **Cygwin terminal**, enter these commands:

	pip install pillow
	git clone https://github.com/CelestialAmber/TetrisNESDisasm
	cd TetrisNESDisasm
	git submodule update --init

To build `tetris.nes`:

	make
