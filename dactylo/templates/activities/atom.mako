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
from dactylo import conf, model, texthelpers, urls
%>


<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
    <title>${conf['realm']}</title>
    <id>${urls.get_full_url(ctx, 'api', '1', 'activities', **urls.relative_query(inputs))}</id>
    <link href="${model.Activity.get_admin_class_full_url(ctx) if data['target'] is None \
            else model.Activity.get_class_back_url(ctx) if data['target'] == 'back' \
            else model.Activity.get_class_front_url(ctx)}"/>
    <link href="${urls.get_full_url(ctx, 'api', '1', 'activities', **urls.relative_query(inputs))}" rel="self"/>
##    <author>
##        <name>${_('Etalab')}</name>
##        <email>${conf['openfisca.email']}</email>
##        <uri>${conf['openfisca.url']}</uri>
##    </author>
##    % for tag in (tags or []):
##          <category term="${tag}"/>
##    % endfor
    <generator uri="http://github.com/etalab/dactylo">dactylo</generator>
    <rights>
        This feed is licensed under the Open Licence ${'<http://www.data.gouv.fr/Licence-Ouverte-Open-Licence>'}.
    </rights>
<%
    activities = list(cursor)
    updated = max(
        activity.updated
        for activity in activities
        )
%>\
    <updated>${updated}</updated>
    % for activity in activities:
    <entry>
        <title>${activity.title}</title>
        <id>${activity.get_admin_full_url(ctx)}</id>
        <link href="${activity.get_admin_full_url(ctx) if data['target'] is None \
                else activity.get_back_url(ctx) if data['target'] == 'back' \
                else activity.get_front_url(ctx)}"/>
        <published>${activity.published}</published>
        <updated>${activity.updated}</updated>
        % if activity.description:
        <summary type="html">
            ${texthelpers.clean_html(activity.description)}
        </summary>
        % endif
    </entry>
    % endfor
</feed>
