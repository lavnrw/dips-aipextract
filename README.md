# dips-aipextract

A script that extracts content from AIPs created by the [DiPS digital
preservation solution][dips].

AIPs in DiPS are just tar containers holding content files + metadata. As such,
they can be unpacked with standard tools like the `tar` command. However, since
files are renamed based on UUIDs during ingest and their original names are
preserved only in the metadata contained in an XML file in the AIP,
reconstructing the original file names and directory hierarchy from an unpacked
AIP tar container is a little tedious. This tool automates the tedious part of
re-renaming the files based on their metadata.

## Installation

Just Python without any additional libraries is required. For installation on a
Linux system you may use the provided [Makefile](Makefile). Otherwise just run
the [aipextract](aipextract) Python script.

## Usage

Consider an AIP with the following content as displayed by the `tar` command:

~~~console
$ tar -tf aip.tar
6ad85e97-00e3-4857-b572-6c60d6342e91.jpg
DIPSARCH.xml
e41e7d5b-d12d-491a-ad1a-d78fad3f88fe.jpg
f7a71535-4034-4a5b-a594-0ff7a1f2ef61.jpg
~~~

Here's the same AIP content listed by the `aipextract` tool:

~~~console
$ aipextract --list aip.tar
File:  aip.tar
IEID:  f84ca968-bd32-4587-9411-77b6c527d533
AIPID: 89e08399-314b-4c98-8aea-a1bc1cc18c7f

  File:     01.jpg
  Location: Daten/a
  IID:      6ad85e97-00e3-4857-b572-6c60d6342e91
  OID:      f5e14bdd-42c1-44e2-b72f-0df768bf9712

  File:     02.jpg
  Location: Daten/a
  IID:      f7a71535-4034-4a5b-a594-0ff7a1f2ef61
  OID:      974ba0dc-3ba0-4db9-a099-2715e2a6ede7

  File:     03.jpg
  Location: Daten/b
  IID:      e41e7d5b-d12d-491a-ad1a-d78fad3f88fe
  OID:      26c8c714-b821-4303-8e47-2751df45359e
~~~

Note that nothing has been extracted yet. Go ahead and extract the AIP, by
default restoring the original file names:

~~~console
$ aipextract aip.tar
~~~

This unpacks the AIP in the following way:

~~~console
f84ca968-bd32-4587-9411-77b6c527d533      # IEID
└── 89e08399-314b-4c98-8aea-a1bc1cc18c7f  # AIPID
   └── Daten                              # original file/directory names
      ├── a
      │  ├── 01.jpg
      │  └── 02.jpg
      └── b
         └── 03.jpg
~~~

Additional options are available:

~~~console
$ aipextract --help
usage: aipextract [-h] [-l] [-d DEST] [-n | -i | -o] [files ...]

Extract files from a DIPS AIP/DIP

positional arguments:
  files                 AIP/DIP files (tar/zip)

options:
  -h, --help            show this help message and exit
  -l, --list            don't extract, only list AIP content
  -d DEST, --dest DEST  destination directory (default ./IEID/AIPID/)
  -n, --name            rename files by original file name and location
                        (default)
  -i, --iid             rename files by Item ID instead of file name
  -o, --oid             rename files by Object ID instead of file name
~~~

[dips]: https://digitalpreservationsolution.de
