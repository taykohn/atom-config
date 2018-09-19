# atom-config

Allows immediate customization for newly installed Atom instances.

## setup
To set up Atom, simply run the atom-config.sh executable from any directory

The default location of Atom's configuration is stored in ~/.atom  
atom-config.sh replaces the following CoffeeScript files in .atom with those in this repo:

+ config.cson
+ keymap.cson
+ snippets.cson

it then installs the packages listed in packages.txt.

## fork & customize

This project is my own customization.  
To make this your own, simply replace the contents of any of the .cson files with those you prefer.

If you'd like to keep your custom style consistent across your different devices, you can add your style.less file to the project.  
Make sure you add the file to the command in copy\_config\_files() in atom-config.sh.

In order to choose which packages you want installed, list these in packages.txt.
