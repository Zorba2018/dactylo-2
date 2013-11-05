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
import collections
import json

from dactylo import model, texthelpers, urls
%>


<%inherit file="/site.mako"/>


<%def name="breadcrumb_content()" filter="trim">
            <%parent:breadcrumb_content/>
            <li><a href="${urls.get_url(ctx, 'admin')}">${_(u"Admin")}</a></li>
            <li><a href="${model.Activity.get_admin_class_url(ctx)}">${_(u"Activities")}</a></li>
            <li class="active">${activity.get_title(ctx)}</li>
</%def>


<%def name="container_content()" filter="trim">
        <h2>${activity.get_title(ctx)}</h2>
        <%self:view_fields/>
        <div class="btn-toolbar">
##            <a class="btn btn-default" href="${urls.get_url(ctx, 'api', 1, 'activities', activity.slug)}">${_(u'JSON')}</a>
            <a class="btn btn-default" href="${urls.get_url(ctx, 'api', 1, 'activities', activity._id)}">${_(u'JSON')}</a>
            <a class="btn btn-default" href="${activity.get_admin_url(ctx, 'edit')}">${_(u'Edit')}</a>
            <a class="btn btn-danger"  href="${activity.get_admin_url(ctx, 'delete')}"><span class="glyphicon glyphicon-trash"></span> ${_('Delete')}</a>
        </div>
</%def>


<%def name="title_content()" filter="trim">
${activity.get_title(ctx)} - ${parent.title_content()}
</%def>


<%def name="view_fields()" filter="trim">
        <div class="row">
            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("ID"))}</b></div>
            <div class="col-sm-10">${activity._id}</div>
        </div>
        <div class="value">
            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("ID"))}</b></div>
            <pre class="col-sm-10 break-word">${json.dumps(activity.value,
                encoding = 'utf-8', ensure_ascii = False, indent = 2)}</pre>
        </div>
##        <div class="row">
##            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("Title"))}</b></div>
##            <div class="col-sm-10">${activity.title}</div>
##        </div>
##<%
##    value = activity.description
##%>\
##    % if value is not None:
##        <div class="row">
##            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("Description"))}</b></div>
##            <div class="col-sm-10">
##                <ul class="nav nav-tabs">
##                    <li class="active"><a data-toggle="tab" href="#description-view">${_(u"View")}</a></li>
##                    <li><a data-toggle="tab" href="#description-source">${_(u"Source")}</a></li>
##                </ul>
##                <div class="tab-content">
##                    <div class="active tab-pane" id="description-view">
##                        ${texthelpers.clean_html(value) | n}
##                    </div>
##                    <div class="tab-pane" id="description-source">
##                        <pre class="break-word">${value}</pre>
##                    </div>
##                </div>
##            </div>
##        </div>
##    % endif
<%
    value = activity.updated
%>\
    % if value is not None:
        <div class="row">
            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("Updated"))}</b></div>
            <div class="col-sm-10">${value}</div>
        </div>
    % endif
<%
    value = activity.published
%>\
    % if value is not None:
        <div class="row">
            <div class="col-sm-2 text-right"><b>${_(u'{0}:').format(_("Published"))}</b></div>
            <div class="col-sm-10">${value}</div>
        </div>
    % endif
</%def>

