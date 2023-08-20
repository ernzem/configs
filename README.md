Personal configuration files. 
Requires Dotbot tool: https://github.com/anishathalye/dotbot
Dotbot integration info: https://github.com/anishathalye/dotbot

## TODO

 - [ ] VSCode scripts that installs extensions from text file.
 ```bash
# To retrieve a list of installed vs code extensions
code --list-extensions >> ~/.cfg/code/vs_code_extensions_list.txt

 # To install VSCode extensions:
 cat ~/.cfg/code/vs_code_extensions_list.txt | xargs -n 1 code --install-extension
 ```
