#! /bin/bash -x

mkdir -p BUILD
export EDITOR="sed -i s/python-OrderedDict/python-ordereddict/"
([[ $1 ]] && PYTHON_BIN=$1) || PYTHON_BIN="python"

echo "building rpm for $PYTHON_BIN..."

for pypi in `grep -v "#" < pypi-list`
do
	version=`echo $pypi | awk -F':' '{print $2}'`
	basename=`echo $pypi | awk -F':' '{print $1}'`
	cd BUILD
	if [[ $version ]]; then	
		echo "Building latest $basename "
		fpm -e -t rpm -s python -a noarch $pypi --python-bin $PYTHON_BIN
		RETVAL=$?
	else
		echo "Building  $basename version $version "
		fpm -e -t rpm -s python -v $version -a noarch $basename --python-bin $PYTHON_BIN
		RETVAL=$?
	fi
	echo "Build of $basename returned with $RETVAL"
	[  $RETVAL -ne 0 ] && exit 1
	cd ../
done
if [ -d ARTIFACTS ]
then
    rm -rf ARTIFACTS
fi
mkdir ARTIFACTS
mv BUILD/*.rpm ARTIFACTS
rm -rf BUILD


