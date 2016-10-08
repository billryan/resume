# uncomment the # before $ to enable PDF update automatically
# see man latexmk for more info

## Usage
# latexmk -xelatex -gg -silent -pvc

## Mac OS X - Skim
$pdf_previewer = 'osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e "open theFile" -e "end tell"';
$pdf_update_method = 4;
$pdf_update_command = 'osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e "set theDocs to get documents whose path is thePath" -e "try" -e "if (count of theDocs) > 0 then revert theDocs" -e "end try" -e "open theFile" -e "end tell"';

## GNU/Linux - Evince

## Windows - Sumatra
