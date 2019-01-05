#!/bin/bash

python2.7_install() {
    apt-get install -y python2.7 python-pip python-opencv python-pexpect python-pymysql python-vtkgdcm python-gdcm python-dicom libboost-all-dev aptitude cmake python-setproctitle
    pip install SimpleITK PyYAML numpy scikit-learn pandas scipy simplejson pynrrd six opencv-contrib-python pexpect sshtunnel paramiko xlrd xlwt scikit-image chardet
}

python2.7_install
