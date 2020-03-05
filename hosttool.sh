#!/bin/bash

scriptPath=$(cd $(dirname $0); pwd)

update()
{
    cd ${scriptPath}/bhosts;git pull;
    cd ${scriptPath}/hosts; git pull;
    cd ${scriptPath}/AD-hosts; git pull;
    cd ${scriptPath}/yhosts; git pull;

    echo "" > ${scriptPath}/merge/hosts
    cat ${scriptPath}/hosts/hosts-files/hosts >> ${scriptPath}/merge/hosts
    cat ${scriptPath}/AD-hosts/system/etc/hosts >> ${scriptPath}/merge/hosts
    cat ${scriptPath}/bhosts/hosts >> ${scriptPath}/merge/hosts
    cat ${scriptPath}/yhosts/hosts >> ${scriptPath}/merge/hosts
    
    cd /etc
    sudo rm hosts
    sudo ln -s ${scriptPath}/merge/hosts
}

install()
{
    cd ${scriptPath}
    git clone https://github.com/E7KMbb/AD-hosts.git
    git clone https://github.com/googlehosts/hosts
    git clone git@github.com:uniking/bhosts.git
    git clone https://github.com/vokins/yhosts.git
    
    cd ${scriptPath}
    mkdir merge
    update
}

run()
{
    if [ $1 == "install" ]
        then install
    elif [ $1 == "update" ]
	then update
    fi
}

if [ $# -eq 1 ]
then run $1
else
    echo -e "hosttool install\nhosttool update"
fi
