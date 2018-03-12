#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2018, Tj Kellie <tjkellie@roninware.net>
#
# This file is not part of Ansible
#
# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_zip
version_added: "2.3"
short_description: zips files and archives on the Windows node
description:
- zips files and directories.
- Supports .zip files natively
- For non-Windows targets, use the M(archive) module instead.
requirements:
options:
  src:
    description:
      - File to be zipped (provide absolute path).
    required: true
  dest:
    description:
      - Destination of zip file (provide absolute path and extension). 
    required: true
  creates:
    description:
      - If this file or directory exists the specified src will not be extracted.
notes:
- This module is not really idempotent, it will create the archive every time, and report a change.
- For non-Windows targets, use the M(archive) module instead.
author:
- Tj Kellie 
'''

EXAMPLES = r'''

- name: zip a directory
  win_zip:
    src: C:\Users\Someuser\Logs
    dest: C:\Users\Someuser\OldLogs.zip
    creates: C:\Users\Someuser\OldLogs.zip

'''

RETURN = r'''
dest:
    description: The provided destination path
    returned: always
    type: string
    sample: C:\temp\TheArchive.zip
src:
    description: The provided source path
    returned: always
    type: string
    sample: C:\Logs\logsToZip\
'''
