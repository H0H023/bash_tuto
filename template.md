

#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    perl
    zip unzip
    exuberant-ctags
    mutt
    libxml-atom-perl
    postgresql-9.6
    libdbd-pgsql
    curl
    wget
    libwww-curl-perl
EOF
)

echo installing the nice-to-have pre-requisites
echo you have 5 seconds to proceed ...
echo or
echo hit Ctrl+C to quit
echo -e "\n"
sleep 6

sudo apt-get install -y tig

Explanation:

    set -eu -o pipefail command:
    Command elements 	Explanation
    set 	Modify how the shell environment operates
    -u 	If a variable does not exist, report the error and stop (e.g., unbound variable)
    -e 	Terminate whenever an error occurs (e.g., command not found)
    -o pipefail 	If a sub-command fails, the entire pipeline command fails, terminating the script (e.g., command not found)

    If this script encounters any errors, it will fail and exit.

    Ref: https://www.tutorialdocs.com/article/set-command-in-bash.html

    sudo -n true command:
    Command elements 	Explanation
    sudo 	Run as superuser
    -n 	Non-interactive. Prevents sudo from prompting for a password. If one is required, sudo displays an error message and exits
    true 	Builtin command that returns a successful (zero) exit status

    Run as a superuser and do not ask for a password. Exit status as successful.

    Ref: https://linux.die.net/man/8/sudo, https://linux.die.net/abs-guide/internal.html

    test $? -eq 0 || exit 1 "you should have sudo privilege to run this script" command:
    Command elements 	Explanation
    test 	Takes an expression as an argument, evaluates it as '0' (true) or '1' (false), and returns the result to the bash variable $?
    $? 	A variable used to find the return value as the exit status of the last executed command
    -eq 	equals
    0 	Value result is true
    || 	Logical "OR" is a Boolean operator. It can execute commands or shell functions based on the exit status of another command
    exit 	Exits the shell with a status of N. If N is unspecified, it uses the exit code of the last executed command
    1 	Value result is false and used here as an argument to the exit command to use as an exit code
    "you should have sudo privilege to run this script" 	If the exit code is false, print this message to the terminal

    Test the last variable's exit code and see if it equals '0'. If not, exit with an error and print a given message to the terminal.

    Ref: https://linuxhint.com/bash-test-command/, http://tldp.org/LDP/abs/html/exit-status.html#EXSREF, https://bash.cyberciti.biz/guide/Logical_OR, https://linuxize.com/post/bash-exit/

    echo installing the must-have pre-requisites command:
    Command elements 	Explanation
    echo 	Builtin command used to print information or messages to the terminal
    installing the must-have pre-requisites 	Message to print to the terminal

    Tell the user that it is going to install some pre-requisite packages before installing the actual program.

    Ref: https://linuxhint.com/bash_echo/

    while read -r p ; command:
    Command elements 	Explanation
    while 	Create a while-loop, i.e. perform a given set of commands ad infinitum as long as the given condition evaluates to true
    read 	Read a line from the standard input and store it in a variable
    -r 	Option passed to read command that avoids the backslash escapes from being interpreted
    p 	Arbitrary variable for read to store captured input. Here it represents each package to be installed
    ; 	Control operator AND. Proceed to the next command and execute it regardless of the exit status of the previous command (execute even if the previous command fails)

    Read a given file line by line forever or until receiving a value of "false," then continue onto the proceeding command.

    Ref: https://linuxize.com/post/bash-while-loop/, http://linuxcommand.org/lc3_man_pages/readh.html, https://linuxhint.com/while_read_line_bash/, https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_04_09

    do sudo apt-get install -y $p ; command:
    Command elements 	Explanation
    do 	Reserved word used to delimit the sequence of commands which follow. i.e., start
    apt-get 	Tool used by the Debian APT (Advanced Package Tool) package manager
    install 	A command used to install packages
    -y 	Long-form is --yes. assume "yes" on all query prompts
    $p 	Used to call the arbitrary variable p from read and use it as standard input

    Install the list of packages as a superuser without prompting for confirmation to install.

    Ref: https://itsfoss.com/apt-get-linux-guide/

    done < <(cat << "EOF" <list of packages> EOF) command:
    Command elements 	Explanation
    done 	Reserved word used to delimit the sequence of commands which precede. i.e., stop
    < 	Redirection to the standard input
    cat 	Concatenate. used for viewing, creating, and appending files
    << 	Redirection that reads input from the current source until encountering a delimiter and then using those lines as the standard input for a command
    EOF 	End of File delimiter
    cat << EOF-EOF 	This will read, then print everything enclosed within the EOF block
    <(list) 	Obtain the output of the list; parentheses indicate that the list will execute in a subshell environment

    Read the list of packages and gather them as standard input. Redirect it to the read command, which captures it as the p variable, and then sends it to the $p variable, which allows it to get executed by the install command, and when it reaches the EOF delimiter, redirect the output to done effectively ending the while read loop.

    Ref: https://linuxhint.com/cat-command-bash/, https://linuxhint.com/what-is-cat-eof-bash-script/

The following four echo messages are self-explanatory:

    echo installing the nice-to-have pre-requisites
    echo you have 5 seconds to proceed ...
    echo or
    echo hit Ctrl+C to quit

however, the next one is not.

    echo -e "\n" command:
    Command elements 	Explanation
    -e 	Enable the function of backslash characters
    \n 	Backslash escaped sequence for new line

    This command creates a newline.

    sleep 6 command:
    Command elements 	Explanation
    sleep 	Delay the execution of a bash script, typically for N seconds, unless using an option to indicate longer lengths of time

    Delay the execution of the following command for 6 seconds.

    Ref: https://linuxhandbook.com/bash-sleep/

    sudo apt-get install -y tig command:

    Install the tig package with the Debian apt-get tool while running the installation as a superuser, and do not prompt for confirmation.

General references:

    https://www.computerhope.com/unix/ubash.htm
    https://man7.org/linux/man-pages/man1/bash.1.html

