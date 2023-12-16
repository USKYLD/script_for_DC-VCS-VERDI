if {[file exist $RTL_PATH]} {
    echo "File $RTL_PATH already exist"
} else {
    file mkdir   $RTL_PATH
    echo "Creating $$RTL_PATH !!!"
}

if {[file exist $CONFIG_PATH]} {
    echo "File $CONFIG_PATH already exist"
} else {
    file mkdir $CONFIG_PATH
    echo "Creating $CONFIG_PATH !!!"
}

if {[file exist $SCRIPT_PATH]} {
    echo "File $SCRIPT_PATH already exist"
} else {
    file mkdir $SCRIPT_PATH
    echo "Creating $SCRIPT_PATH !!!"
}

if {[file exist $UNMAPPED_PATH]} {
    echo "File $UNMAPPED_PATH already exist"
} else {
    file mkdir  $UNMAPPED_PATH
    echo "Creating $UNMAPPED_PATH !!!"
}
if {[file exist $MAPPED_PATH]} {
    echo "File $MAPPED_PATH already exist"
} else {
    file mkdir  $MAPPED_PATH
    echo "Creating $MAPPED_PATH !!!"
}
if {[file exist $REPORT_PATH]} {
    echo "File $REPORT_PATH already exist"
} else {
    file mkdir  $REPORT_PATH
    echo "Creating $REPORT_PATH !!!"
}
if {[file exist $WORK_PATH]} {
    echo "File $WORK_PATH already exist"
} else {
    file mkdir $WORK_PATH
    echo "Creating $WORK_PATH !!!"
}
