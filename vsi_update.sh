#!/bin/bash

if `hash vivado 2>/dev/null` && [[ `vivado -version` =~ Vivado\ v([^[:space:]]+) ]]; then
	VIVADO_VERSION=${BASH_REMATCH[1]}
fi

VIVADO_VERSION=2017.1_sdx

if [[ -n $VSI_INSTALL ]]; then
	VSI_PATH=$VSI_INSTALL
elif [[ `type -P vsi` =~ (.+?)\/host\/.* ]]; then
	VSI_PATH=${BASH_REMATCH[1]}
fi

if [ -z $VIVADO_VERSION ]; then
	printf "No vivado executable found in PATH. Make sure that settings64.sh script is sourced."
	exit
fi

if [ -z $VSI_PATH ]; then
	printf "Cannot determine VSI_INSTALL location. Either set VSI_INSTALL or add vsi executable to path."
	exit
fi

if [ -n $VSI_PATH ] && [ -f $VSI_PATH/install_source ]; then
	SOURCE=$(<$VSI_PATH/install_source)
fi


echo "Getting latest Visual System Integrator for Vivado ${VIVADO_VERSION}"

VSI_RELEASE=`wget -qO- https://systemviewinc.com/release.json`

# echo $VSI_RELEASE

VSI_LATEST_PY="import sys, json;
j = json.loads('${VSI_RELEASE}')
if '${VIVADO_VERSION/./__}' in j:
	print j['${VIVADO_VERSION/./__}']['latest']
elif '${VIVADO_VERSION/./__}' in j['versions']:
	print j[j['versions']['${VIVADO_VERSION/./__}']]['latest']
"

VSI_LATEST=`python -c "${VSI_LATEST_PY}"`

if [[ $VSI_LATEST = $SOURCE ]]; then
	echo "No Update required. Visual System Integrator is uptodate"
	exit 0
else
	echo "A new version is Visual System Integrator is available"
	# echo "Latest: $VSI_LATEST"
	if (shopt -s nullglob dotglob; f=(${VSI_PATH}/*); ((${#f[@]}))); then
		PREV_VER=${VSI_PATH}/../PREVIOUS
		if [[ -n $SOURCE ]] && [[ $SOURCE =~ systemview_vsi_(.+).tar.bz2 ]]; then
			PREV_VER=${BASH_REMATCH[1]}
			mv ${VSI_PATH} ${VSI_PATH}/../${PREV_VER}
		fi
	fi
	mkdir -p ${VSI_PATH} && cd ${VSI_PATH} && wget -O- ${VSI_LATEST} | tar xj && echo ${VSI_LATEST} > install_source && [[ ${VSI_LATEST} =~ systemview_vsi_(.+).tar.bz2 ]]
	echo "Visual System Integrator updated to ${BASH_REMATCH[1]}"
fi
