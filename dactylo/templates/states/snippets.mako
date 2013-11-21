## -*- coding: utf-8 -*-


## Dactylo -- A datasets activity streams logger
## By: Emmanuel Raviart <emmanuel@raviart.com>
##
## Copyright (C) 2013 Etalab
## http://github.com/etalab/dactylo
##
## This file is part of Dactylo.
##
## Dactylo is free software; you can redistribute it and/or modify
## it under the terms of the GNU Affero General Public License as
## published by the Free Software Foundation, either version 3 of the
## License, or (at your option) any later version.
##
## Dactylo is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


<%!
import json
%>


<%def name="states_div(states)" filter="trim">
                <div id="states">
<%
    datasets = states.get('datasets') or {}
%>\
    % if datasets:
                    <p class="lead">${u'Datasets: {0} - Total Quality: {1:.2f} - Average Quality: {2:.2f}'.format(
                        datasets['count'], datasets['weights'], datasets['weights'] / datasets['count'])}</p>
    % endif
                </div>
</%def>

