.. --------------------- GNU General Public License 3.0 --------------------- ..
..                                                                            ..
.. Copyright (C) 2017─2022 fox0430                                            ..
..                                                                            ..
.. This program is free software: you can redistribute it and/or modify       ..
.. it under the terms of the GNU General Public License as published by       ..
.. the Free Software Foundation, either version 3 of the License, or          ..
.. (at your option) any later version.                                        ..
..                                                                            ..
.. This program is distributed in the hope that it will be useful,            ..
.. but WITHOUT ANY WARRANTY; without even the implied warranty of             ..
.. MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              ..
.. GNU General Public License for more details.                               ..
..                                                                            ..
.. You should have received a copy of the GNU General Public License          ..
.. along with this program.  If not, see <https://www.gnu.org/licenses/>.     ..
..                                                                            ..
.. -------------------------------------------------------------------------- ..

.. -------------------------------------------------------------------------- ..
..
.. _Keep a Changelog: https://keepachangelog.com/en/1.0.0/
..
.. _#1468: https://github.com/fox0430/moe/pull/1468
.. _#1469: https://github.com/fox0430/moe/pull/1469
.. _#1470: https://github.com/fox0430/moe/pull/1470
.. _#1472: https://github.com/fox0430/moe/pull/1472
.. _#1473: https://github.com/fox0430/moe/pull/1473
.. _#1474: https://github.com/fox0430/moe/pull/1474
.. _#1475: https://github.com/fox0430/moe/pull/1475
.. _#1476: https://github.com/fox0430/moe/pull/1476
.. _#1477: https://github.com/fox0430/moe/pull/1477
.. _#1478: https://github.com/fox0430/moe/pull/1478
.. _#1479: https://github.com/fox0430/moe/pull/1479
.. _#1480: https://github.com/fox0430/moe/pull/1480
.. _#1481: https://github.com/fox0430/moe/pull/1481
.. _#1484: https://github.com/fox0430/moe/pull/1484
.. _#1485: https://github.com/fox0430/moe/pull/1485
.. _#1486: https://github.com/fox0430/moe/pull/1486
.. _#1487: https://github.com/fox0430/moe/pull/1487
.. _#1488: https://github.com/fox0430/moe/pull/1488
.. _#1489: https://github.com/fox0430/moe/pull/1489
.. _#1491: https://github.com/fox0430/moe/pull/1491
.. _#1493: https://github.com/fox0430/moe/pull/1493
.. _#1494: https://github.com/fox0430/moe/pull/1494
.. _#1496: https://github.com/fox0430/moe/pull/1496
.. _#1497: https://github.com/fox0430/moe/pull/1497
.. _#1498: https://github.com/fox0430/moe/pull/1498
.. _#1499: https://github.com/fox0430/moe/pull/1499
.. _#1500: https://github.com/fox0430/moe/pull/1500
.. _#1501: https://github.com/fox0430/moe/pull/1501
.. _#1502: https://github.com/fox0430/moe/pull/1502
.. _#1503: https://github.com/fox0430/moe/pull/1503
.. _#1505: https://github.com/fox0430/moe/pull/1505
.. _#1506: https://github.com/fox0430/moe/pull/1506
.. _#1507: https://github.com/fox0430/moe/pull/1507
.. _#1508: https://github.com/fox0430/moe/pull/1508
.. _#1509: https://github.com/fox0430/moe/pull/1509
..
.. -------------------------------------------------------------------------- ..

Changelog
=========

All notable changes to this project are documented in this file.  The format is
based on `Keep a Changelog`_.

Unreleased
----------

Added
.....

- `#1468`_ syntax highlighting:  Nim pragmas

- `#1473`_ auto-completion for language keywords

- `#1475`_ sort auto-completion suggestion by count of usage

- `#1476`_ path auto-completion

- `#1477`_ syntax highlighting:  Nim standard libraries

- `#1480`_ log support

- `#1489`_ support live reloading for open files

- `#1505`_ disable automatic backups by default

Changed
.......

- `#1470`_ refactoring

- `#1481`_ refactoring:  style

- `#1501`_ update README

- `#1503`_ update README

- `#1506`_ path for automatic backups

- `#1507`_ update CI

- `#1508`_ dependency version:  ``unicodedb`` v0.11.1

- `#1509`_ refactoring:  settings logic

Deprecated
..........

Fixed
.....

- `#1469`_ warning concerning imported but unused module ``strformat``

- `#1472`_ import instructions

- `#1474`_ compiler options

- `#1478`_ various typos

- `#1484`_ automatically disable clipboard functionality if no clipboard tools
  are available

- `#1485`_ automatically skip clipboard tests if no clipboard tools are
  available

- `#1488`_ CI triggers

- `#1491`_ crash on auto-indentation in some cases

- `#1493`_ missing visual mode after yanking lines

- `#1494`_ QuickRun

- `#1496`_ menu margins in configuration mode

- `#1498`_ suggestion logic in execution mode

- `#1499`_ VS Code themes

- `#1500`_ build error with Nim development version

Removed
.......

- `#1479`_ obsolete ``defer``

- `#1486`_ Japanese comments

- `#1487`_ website

- `#1497`_ Japanese comments

- `#1502`_ Japanese commit message

Security
........

.. -------------------------------------------------------------------------- ..
