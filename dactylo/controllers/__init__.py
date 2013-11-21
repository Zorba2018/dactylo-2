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


"""Root controllers"""


import collections
import logging

import pymongo

from .. import contexts, conv, model, paginations, templates, urls, wsgihelpers
from . import accounts, activities, sessions, states, websockets


log = logging.getLogger(__name__)
router = None


@wsgihelpers.wsgify
def index(req):
    ctx = contexts.Ctx(req)

    cursor = model.Activity.find(as_class = collections.OrderedDict)
    pager = paginations.Pager(item_count = cursor.count(), page_number = 1)
    cursor.sort([('updated', pymongo.DESCENDING)])
    generic_activities = conv.check(conv.uniform_sequence(
        conv.specific_activity_to_activity,
        ))(cursor.skip(pager.first_item_index or 0).limit(pager.page_size), state = ctx)
    return templates.render(ctx, '/index.mako', activities = generic_activities, states = model.states)


def make_router():
    """Return a WSGI application that searches requests to controllers """
    global router
    router = urls.make_router(
        ('GET', '^/?$', index),

        (None, '^/admin/accounts(?=/|$)', accounts.route_admin_class),
        (None, '^/admin/activities(?=/|$)', activities.route_admin_class),
        (None, '^/admin/sessions(?=/|$)', sessions.route_admin_class),
        (None, '^/api/1/accounts(?=/|$)', accounts.route_api1_class),
        (None, '^/api/1/activities(?=/|$)', activities.route_api1_class),
        (None, '^/api/1/states(?=/|$)', states.route_api1_class),
        (None, '^/api/1/websocket(?=/|$)', websockets.route_api1_class),
        ('POST', '^/login/?$', accounts.login),
        ('POST', '^/logout/?$', accounts.logout),
        )
    return router
