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


"""Conversion functions"""


from biryani1.baseconv import *
from biryani1.bsonconv import *
from biryani1.datetimeconv import *
from biryani1.objectconv import *
from biryani1.jsonconv import *
from biryani1.states import default_state, State


def account_to_object(value, state = None):
    if value is None:
        return value, None
    if state is None:
        state = default_state
    return dict(
        description = value.get('description'),
        email = value.get('email'),
        displayName = value.get('full_name') or value.get('email'),
#        image = value.get('image_url'),
        ), None


def dataset_to_object(value, state = None):
    if value is None:
        return value, None
    if state is None:
        state = default_state
    return dict(
        description = value.get('notes'),
        displayName = value.get('title'),
        ), None


input_to_token = cleanup_line


input_to_words = pipe(
    input_to_slug,
    function(lambda slug: sorted(set(slug.split(u'-')))),
    empty_to_none,
    )


#json_to_item_attributes = pipe(
#    test_isinstance(dict),
#    struct(
#        dict(
#            id = pipe(
#                input_to_token,
#                not_none,
#                ),
#            ),
#        default = noop,  # TODO
#        ),
#    rename_item('id', '_id'),
#    )


def method(method_name, *args, **kwargs):
    def method_converter(value, state = None):
        if value is None:
            return value, None
        return getattr(value, method_name)(state or default_state, *args, **kwargs)
    return method_converter


def related_link_to_object(value, state = None):
    if value is None:
        return value, None
    if state is None:
        state = default_state
    return dict(
        description = value.get('description'),
        displayName = value.get('title'),
        image = value.get('image_url'),
        url = value.get('url'),
        ), None


specific_activity_to_activity = pipe(
    function(lambda activity: activity.value),
    test_isinstance(dict),
    struct(
        dict(
            actor = account_to_object,
            object = related_link_to_object,
            target = dataset_to_object,
            verb = pipe(
                test_isinstance(basestring),
                not_none,
                ),
            ),
        ),
    )
