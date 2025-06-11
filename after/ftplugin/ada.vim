set makeprg=alr\ build\ 2>&1\ \\\|\ grep\ 'adb:'\ \\\|\ sed\ -e\ 's\\\|^\\\|src/\\\|'\ \\\|\ sed\ -e\ 's\\\|(style)\\\|warning:\\\|'"
