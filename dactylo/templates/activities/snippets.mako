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
from dactylo import texthelpers
%>


<%def name="activity_media_list_item(activity)" filter="trim">
<%
    actor = activity['actor']
    object = activity['object']
%>\
            <li class="media">
<%
    icon = actor.get('icon')
%>\
    % if icon is not None:
                <a class="pull-left" href="#">
                    <img class="media-object" src="${icon['url']}" alt="${icon.get('displayName') or u''}">
                </a>
    % endif
                <div class="media-body">
                    <h4 class="media-heading">${object['displayName']}</h4>
<%
    description = object.get('description')
%>\
    % if description is not None:
                    ${texthelpers.clean_html(description) | n}
    % endif
<%
    image = object.get('image')
%>\
    % if image is not None:
                    <img alt="${image.get('displayName') or u''}" class="img-responsive" src="${image['url']}">
    % endif
                </div>
            </li>
</%def>

