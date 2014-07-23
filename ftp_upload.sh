#!/bin/bash
#
# ncftp file upload
#

##
# date sequence
##
DAYSEQ=`/bin/date +%Y%m%d -d '0 day ago'`

##
# file check
##
if [ -e /data/path/backup_"$DAYSEQ".sql ]
then
     /usr/local/bin/ncftpput -m -R -f /path/.ncftp_properties /ftp_server_upload_path/$DAYSEQ /data/path/backup_"$DAYSEQ".sql
    # upload logging
    /path/logger.sh NCFTP_UPLOAD $?
fi