# frozen_string_literal: true

NOT_FOUND_RESPONSE = { status: '404',
                       source: { pointer: 'data/attributes/id' },
                       title: 'Record not found',
                       detail: 'The record was not found based on the ID' }.freeze

AUTHORIZATION_ERROR_RESPONSE = { status: '403',
                                 source: { pointer: '/headers/authorization' },
                                 title: 'Not authorized',
                                 detail: 'Forbidden access for this resource.' }.freeze
