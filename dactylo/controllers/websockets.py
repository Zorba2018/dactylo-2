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


"""Controllers for websockets"""


import webob
import ws4py.server.wsgiutils
import ws4py.websocket

from .. import model, urls


class WebSocketEmitter(ws4py.websocket.WebSocket):
    def closed(self, code, reason = None):
        try:
            model.websocket_clients.remove(self)
        except ValueError:
            # Client is missing from list.
            pass

    def opened(self):
        model.websocket_clients.append(self)

websocket_emitter_app = ws4py.server.wsgiutils.WebSocketWSGIApplication(handler_cls = WebSocketEmitter)


def api1_listen(environ, start_response):
    req = webob.Request(environ)
#    ctx = contexts.Ctx(req)
#    headers = wsgihelpers.handle_cross_origin_resource_sharing(ctx)

    assert req.method == 'GET'
#    params = req.GET
#    inputs = dict(
#        first_key = params.get('first_key'),
#        keys = params.get('keys'),
#        limit = params.get('limit'),
#        values = params.get('values'),
#        )

    return websocket_emitter_app(environ, start_response)


def route_api1_class(environ, start_response):
    router = urls.make_router(
        ('GET', '^/?$', api1_listen),
        )
    return router(environ, start_response)
