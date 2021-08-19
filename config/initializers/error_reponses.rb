# frozen_string_literal: true

NOT_FOUND_RESPONSE = { status: '404',
                       source: { pointer: 'data/attributes/id' },
                       title: 'Record not found',
                       detail: 'The record was not found based on the ID' }.freeze
