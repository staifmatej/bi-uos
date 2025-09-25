# Notes

A shell is a program that provides a user interface to interact with the operating system – allowing you to run commands, execute programs, and write scripts.

The first shell ever created was the Thompson shell in 1971 at Bell Labs for Unix. The Bourne shell (sh) came later, in 1977, also at Bell Labs, and became the basis for most modern Unix shells, including Bash.

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

## Special operators

**`;`** - Command separator. Runs commands one after another.
```bash
ls; pwd; date
```

**`|`** - Pipe. Takes output from one command and uses it as input for the next.
```bash
ls -la | grep ".txt"
```

**`&`** - Runs command in background.
```bash
python script.py &
```

**`>`** - Redirects output to a file (overwrites existing content).
```bash
ls > files.txt
```

**`>>`** - Appends output to the end of an existing file (adds to its current content).
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
less large_file.txt          # view file with pagination
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




