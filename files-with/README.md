# files-with
Searches for regex ocurrence inside files. Basically it combines linux "find" and "grep" native tools creating a friendly interface easier to use to perfom just basic searches.

## Usage
CLI usage is:
```shell
files-with <regex_pattern> [options] [<directory>[ <directory>[ ...]]]
```
If no directory is given, the search will be performed in current directory.
If options is given, should be "--option=value" format as bellow:
```shell
files-with 'some regex pattern' --type=js --lines=1
```

### Options
List of defined options to customize the search:
 + type: should be the extension of file (MIME type) as example of '.js', '.html'
 + lines: should be a positive number. Default value is 0.
