venv27:
	virtualenv venv27 -p python2.7
	venv27/bin/pip install pypi2rpm

venv26:
	virtualenv venv26 -p python2.6
	venv26/bin/pip install pypi2rpm

build: venv27 venv26
	source venv26/bin/activate
	pypi2rpm.py psycopg2
	deactivate
	source venv27/bin/activate
	pypi2rpm.py psycopg2
	deactivate
