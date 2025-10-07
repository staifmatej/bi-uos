# Notes

A shell is a program that provides a user interface to interact with the operating system – allowing you to run commands, execute programs, and write scripts.

The first shell ever created was the Thompson shell in 1971 at Bell Labs for Unix. The Bourne shell (sh) came later, in 1977, also at Bell Labs, and became the basis for most modern Unix shells, including Bash.

**⚠️ Warning:** This documentation was written specifically for Linux OS, particularly tested on Debian and Ubuntu. For example, on macOS, some commands function slightly differently due to BSD vs. GNU implementations, even though they have the exact same names.

## Concepts

### Relative vs. Absolute Paths

**Absolute path** starts from the root of the file system (on Unix/Linux/macOS starts with `/`, on Windows with `C:\`).

Examples of absolute paths:
- `/Users/staifmat/Desktop/file.txt`
- `/home/user/documents/notes.md`
- `/var/log/system.log`

**Relative path** is relative to your current working directory.

Examples of relative paths:
- `documents/file.txt` (file.txt inside documents folder)
- `../parent-folder/file.txt` (go up one folder, then into parent-folder)
- `./current-folder/file.txt` (in current folder, then into current-folder)

Special symbols:
- `.` = current directory
- `..` = parent directory
- `~` = user's home directory

### Tilde (`~`) Home Directory Shortcut

**What it does:** `~` is a shortcut that represents your home directory path.

On Linux/Ubuntu: `~` expands to `/home/username`  
On macOS: `~` expands to `/Users/username`
```bash
# These are equivalent:
cd ~
cd /home/staifmat

# You can use ~ in any path:
cd ~/Desktop              # go to /home/staifmat/Desktop
ls ~/Documents            # list files in /home/staifmat/Documents
touch ~/test.txt          # create file in /home/staifmat/test.txt

# Verify what ~ means:
echo ~                    # prints: /home/staifmat

## Special operators

### `;`
Command separator. Runs commands one after another.
```bash
ls; pwd; date
```

### `|`
A pipe (|) processes data from left to right,. Takes output from one command and uses it as input for the next.
```bash
ls -la | grep ".txt"
```

### `&`
Runs command in background.
```bash
python script.py &
```

### `>`
Redirects output to a file (overwrites existing content).
```bash
ls > files.txt
```

### `>>`
Appends output to the end of an existing file (adds to its current content).
```bash
echo "new line" >> files.txt
```

## Commands

### `ls`

**What it does:** lists the contents of a directory – files and folders.

```bash
ls
```

**Most common arguments:**<br>
-l → long format (details about files: permissions, owner, size, date)<br>
-a → all (shows hidden files, starting with a dot, e.g., .DS_Store)<br>
-h → human-readable (file sizes in KB, MB, GB; often combined with -l)<br>
-R → recursive (also shows contents of subdirectories)<br>
-t → sort by modification time (orders by last change)<br>
-r → reverse (reverses the sorting order)<br>
-S → sort by size (orders by file size)<br>
```bash
(base) ➜  bi-uos git:(main) ls
README.md     notes         shell_scripts
(base) ➜  bi-uos git:(main) 
```
### `cd`

**What it does:** changes your current directory (moves you to a different folder).

```bash
cd /Users/staifmat/Documents  # absolute path
cd documents                  # relative path
cd ..                         # go up one level
cd ~                          # go to home directory
cd -                          # go to previous directory
```

### `grep`

**What it does:** searches for text patterns in files or input.

**Common uses:**
- Search in files: `grep "text" filename.txt`
- Search recursively: `grep -r "pattern" folder/`
- Case-insensitive search: `grep -i "TEXT" file.txt`
- Show line numbers: `grep -n "pattern" file.txt`

```bash
grep "error" log.txt          # find "error" in log.txt
ls -la | grep ".txt"          # find .txt files in current directory
grep -r "function" src/       # search for "function" in src folder
```

### `pwd`

**What it does:** prints your current working directory (shows where you are).

```bash
pwd
# Output: /Users/staifmat/Desktop/bi-uos
```

### `awk`

**What it does:** processes and analyzes text files, especially useful for working with columns of data.

```bash
awk '{print $1}' file.txt     # print first column
awk '{print $2, $4}' data.txt # print 2nd and 4th columns
awk '/pattern/ {print}' file  # print lines containing "pattern"
```

**Practical examples with files:**

```bash
# Example file: employees.csv
# Name,Age,Department,Salary
# John,28,IT,5000
# Sarah,35,HR,4500
# Mike,42,Finance,6000

# Extract just names (first column)
awk -F',' '{print $1}' employees.csv
# Output: Name, John, Sarah, Mike

# Print name and salary (columns 1 and 4)
awk -F',' '{print $1, $4}' employees.csv
# Output: Name Salary, John 5000, Sarah 4500, Mike 6000

# Find employees in IT department
awk -F',' '/IT/ {print $1, $4}' employees.csv
# Output: John 5000

# Calculate total salary (skip header)
awk -F',' 'NR>1 {sum+=$4} END {print "Total:", sum}' employees.csv
# Output: Total: 15500

# Find employees older than 30
awk -F',' 'NR>1 && $2>30 {print $1, "is", $2, "years old"}' employees.csv
# Output: Sarah is 35 years old, Mike is 42 years old
```

-F',' - This tells awk how to split fields (field separator)<br>
-NR - current line number<br>
-NF - number of fields in current line<br>
-END - execute after processing all lines<br>

**Common options:**
- `-F','` - set field separator to comma (for CSV files)
- `NR` - current line number
- `NF` - number of fields in current line
- `END` - execute after processing all lines

### `date`

**What it does:** displays or sets the current date and time.

```bash
date                         # current date and time
date +%Y-%m-%d               # format: 2024-03-15
date +%H:%M                  # format: 14:30
```

### `man`

**What it does:** shows the manual page for commands (help documentation).

```bash
man ls                       # show manual for ls command
man grep                     # show manual for grep command
```

### `less`

**What it does:** displays file content page by page (useful for large files).

```bash
less large_file.txt          # view file with pagination (pagination == stránkování)
# Use arrow keys to navigate, 'q' to quit
```

### `id`

**What it does:** shows user and group information for current user.

```bash
id                           # shows your user ID and group IDs
```

### `mv`

**What it does:** moves files/folders OR renames them.

**Moving files:**
```bash
mv file.txt documents/       # move file.txt to documents folder
mv folder1/ folder2/         # move folder1 inside folder2
```

**Renaming files:**
```bash
mv oldname.txt newname.txt   # rename file
mv old_folder new_folder     # rename folder
```

### `wc`

**What it does:** It shows the count of lines, words and characters.

**Counting lines/rows (-l)**
```bash
wc -l soubor.txt            # it write the number of rows (lines). -l stands for lines. 
echo -e "a\nb\nc" | wc -l   # 3
```
**Counting words (-w)**
```bash
wc -w soubor.txt                   #  it write the number of words. -w stands for words.
echo "hello world test" | wc -w    # 3
```
**Counting characters (-c or -m)**
```bash
wc -m soubor.txt          # number of the multibyte characters (better for UTF-8)
wc -c soubor.txt          # number of the characters/bytes
echo "čeština" | wc -m    # 10 (bytes) ('č' and 'š' have both 2 bytes)
echo "čeština" | wc -c    # 8 (characters) (count č' and 'š' as 1 byte characters)

```

### `tr`

**What it does:** transforms or deletes characters.

**Substitution of the characters**
```bash
echo "hello" | tr 'e' 'a'      # hello → hallo
echo "hello" | tr 'lo' 'xy'    # hello → hexyy
```
**Deletion of the characters (-d)**
```bash
echo "hello123world" | tr -d '0-9'     # helloworld
echo "a b c d" | tr -d ' '             # abcd
```
**Compression of repeating characters (-s)**
```bash
echo "hello    world" | tr -s ' '      # hello world
echo "aaabbbccc" | tr -s 'abc'         # abc
```

**Working with ranges**

```bash
echo "abc123" | tr 'a-z' 'A-Z'       # ABC123
echo "hello" | tr 'a-z' '0-9'        # 74;;>
```

### `declare`

**What it does:** `declare` defines variable types and properties in bash shell.

**most common use of a `declare`**
```bash
declare -i cislo=10        # integer variable (for arithmetic)
declare -r konstanta="abc" # readonly variable (cannot be modified)
declare -x export_var="hi" # exported variable (available to child processes)
declare -a pole=(1 2 3)    # array variable
```
**with `declare -i` or without `declare -i`:**
```bash
# WITHOUT declare -i
cislo=10              # save as STRING "10"
cislo=cislo+5         # result: STRING "cislo+5" 
echo $cislo           # prints: cislo+5

cislo=10              # save as STRING "10"
cislo=$(($cislo+5))   # result: INTEGER 15
echo $cislo           # prints: 15

# WITH declare -i
declare -i cislo=10   # save as INTEGER 10
cislo=cislo+5         # result: INTEGER 15
echo $cislo           # prints: 15
```

### `sleep`

**What is does:** `sleep` pauses execution for a specified amount of time.
```bash
sleep 5      # pause for 5 seconds (5000 miliseconds)
sleep 10m    # pause for 10 minutes  
sleep 2h     # pause for 2 hours
sleep 1000   # pause for 1000 seconds

# miliseconds
sleep 0.1    # pause for 100 miliseconds
sleep 0.001  # pause for 1 miliseconds 
```
```bash
# usleep for microseconds
usleep 1000  # pause for 1000 microseconds 
```

### `fgrep`

**What it does:** `fgrep` searches for exact text.

```bash
# Use for searching exact string in file.
fgrep "hello" file.txt    # searches for exact text "hello"

# Use for searching exact string with input from ls command.
ls -la | fgrep "staifmat"
```

### `getent`

**What it does:** `getent` shows entries from system administrative databases.
```bash
getent passwd root         # specific users
getent passwd              # show all users
```
 
### `printf` & `echo`

**What `printf` does:** `printf` prints text similar to `echo`.

**Different between `printf`, `echo` and `echo -e`:**

1. `echo` and `echo -e` → always add `\n` on the end.<br>
   `printf` → never add anything automatic.
2. `echo -e` → only escape sequence (`\n`, `\t`).<br>
   `printf` → escape sequence + formating specificators (`%s`, `%d`, `%f`, etc.).

**Basic `printf` formatting**
```bash
printf "Name: %s, Age: %d, Score: %.2f\n" "Alice" 25 87.456
# Output: Name: Alice, Age: 25, Score: 87.46
```

**Basic `echo` formatting**
```bash
echo -e "hello\n\tworld"      # print:
                              # hello
                              #     world (with tab and newline)
echo "hello\n\tworld"         # print: hello\n\tworld
```











