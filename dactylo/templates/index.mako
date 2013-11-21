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

import pymongo

from dactylo import model, texthelpers, urls
%>


<%inherit file="site.mako"/>
<%namespace name="activities_snippets" file="activities/snippets.mako"/>
<%namespace name="states_snippets" file="states/snippets.mako"/>


<%def name="activities_table()" filter="trim">
        <%states_snippets:states_div states="${states}"/>
        <table class="table table-bordered table-condensed table-striped">
            <thead>
                <tr>
                    <th>${_(u"Actor")}</th>
                    <th>${_(u"Verb")}</th>
                    <th>${_(u"Object")}</th>
                    <th>${_(u"Target")}</th>
                </tr>
            </thead>
            <tbody id="activities">
    % for activity in activities:
                <%activities_snippets:activity_row activity="${activity}"/>
    % endfor
            </tbody>
        </table>
</%def>


<%def name="breadcrumb()" filter="trim">
</%def>


<%def name="container_content()" filter="trim">
##        <div class="page-header">
##            <h1><%self:brand/></h1>
##        </div>
        <%self:activities_table/>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script>
function startWebSocket() {
    var websocketUrl = ${urls.get_full_url(ctx, 'api', 1, 'websocket').replace('http', 'ws', 1) | n, js};
    var ws;
    if (window.WebSocket) {
        ws = new WebSocket(websocketUrl);
    } else if (window.MozWebSocket) {
        ws = MozWebSocket(websocketUrl);
    } else {
        console.log('WebSocket Not Supported');
        return;
    }

    window.onbeforeunload = function (e) {
        ws.close(1000, 'Left the room');

        if(!e) {
            e = window.event;
        }
        e.stopPropagation();
        e.preventDefault();
    };

    ws.onclose = function(evt) {
        // Try to reconnect in 5 seconds.
        setTimeout(startWebSocket, 5000);
    };

    ws.onmessage = function (evt) {
        data = $.parseJSON(evt.data);
        var action = data.action;
        if (action == 'activity') {
            $('#activities').prepend(data.block);
        } else if (action == 'states') {
            $('#states').html(data.block);
        }
    };

##    ws.onopen = function() {
##        ws.send("Entered the room");
##    };
}


$(function () {
    startWebSocket();
});
    </script>
</%def>

