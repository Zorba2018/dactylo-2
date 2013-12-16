#! /usr/bin/env python
# -*- coding: utf-8 -*-


# Dactylo -- A datasets activity streams logger
# By: Emmanuel Raviart <emmanuel@raviart.com>
#
# Copyright (C) 2013 Etalab
# http://github.com/etalab/dactylo
#
# This file is part of Dactylo.
#
# Dactylo is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Dactylo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


"""Web application that displays the activities logged by various bots"""


try:
    from setuptools import setup, find_packages
except ImportError:
    from ez_setup import use_setuptools
    use_setuptools()
    from setuptools import setup, find_packages


classifiers = """\
Development Status :: 2 - Pre-Alpha
Environment :: Web Environment
Intended Audience :: Information Technology
License :: OSI Approved :: GNU Affero General Public License v3
Operating System :: POSIX
Programming Language :: Python
Topic :: Scientific/Engineering :: Information Analysis
Topic :: Sociology
Topic :: Internet :: WWW/HTTP :: WSGI :: Server
"""

doc_lines = __doc__.split('\n')


setup(
    name = 'dactylo',
    version = '0.1dev',

    author = 'Emmanuel Raviart',
    author_email = 'emmanuel@raviart.com',
    classifiers = [classifier for classifier in classifiers.split('\n') if classifier],
    description = doc_lines[0],
    keywords = 'activity dataset logger opendata stream',
    license = 'http://www.fsf.org/licensing/licenses/agpl-3.0.html',
    long_description = '\n'.join(doc_lines[2:]),
    url = 'http://github.com/etalab/dactylo',

    data_files = [
        ('share/locale/fr/LC_MESSAGES', ['dactylo/i18n/fr/LC_MESSAGES/dactylo.mo']),
        ],
    entry_points = {
        'distutils.commands': 'build_assets = dactylo.commands:BuildAssets',
        'paste.app_factory': 'main = dactylo.application:make_app',
        },
    include_package_data = True,
    install_requires = [
        'Biryani1 >= 0.9dev',
        'bleach >= 1.2',
        'Mako >= 0.7',
        'PyYAML',
        'pymongo >= 2.2',
        'requests >= 1.2',
        'webassets >= 0.8',
        'WebError >= 0.10',
        'WebOb >= 1.1',
        "ws4py >= 0.3.2",
        ],
    message_extractors = {'dactylo': [
        ('**.py', 'python', None),
        ('templates/**.mako', 'mako', {'input_encoding': 'utf-8'}),
        ('static/**', 'ignore', None)]},
#    package_data = {'dactylo': ['i18n/*/LC_MESSAGES/*.mo']},
    packages = find_packages(),
    paster_plugins = ['PasteScript'],
    setup_requires = ['PasteScript >= 1.6.3'],
    zip_safe = False,
    )
