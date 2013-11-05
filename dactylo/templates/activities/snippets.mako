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
from dactylo import conv, texthelpers
%>


<%def name="activity_row(activity)" filter="trim">
                <tr>
                    <%self:object_cell value="${activity['actor']}"/>
                    <%self:object_cell value="${activity['verb']}"/>
                    <%self:object_cell value="${activity['object']}"/>
                    <%self:object_cell value="${activity.get('target')}"/>
                </tr>
</%def>


<%def name="object_cell(value)" filter="trim">
                    <td>
    % if value is not None:
        % if isinstance(value, basestring):
<%
            url, error = conv.make_input_to_url(full = True)(value, state = ctx)
%>\
            % if error is None:
                        <a href="${url}">${url}</a>
            % else:
                        ${value}
            % endif
        % else:
<%
            display_name = value.get('displayName')
%>\
            % if display_name is not None:
                        <h4>${display_name}</h4>
            % endif
<%
            description = value.get('description')
%>\
            % if description is not None:
                        ${texthelpers.clean_html(description) | n}
            % endif
<%
            image = value.get('image')
%>\
            % if image is not None:
                % if isinstance(image, basestring):
                        <img class="img-responsive" src="${image}">
                % else:
                        <img alt="${image.get('displayName') or u''}" class="img-responsive" src="${image['url']}">
                % endif
            % endif
        % endif
    % endif
                    </td>
</%def>

