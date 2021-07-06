# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebflowSync::Api, type: :service do
  describe '#get_all_items' do
    context 'when the collection contains more items than the limit',
            vcr: { cassette_name: 'webflow/api/get_items/all_items' } do
      fit 'returns all items' do
        client = WebflowSync::Api.new('6048c57f255aff50533565bf')

        items = client.get_all_items(collection_slug: 'documents', page_limit: 10)

        expect(items.count).to eq 21
      end
    end

    context 'when the collection is empty',
            vcr: { cassette_name: 'webflow/api/get_items/no_items' } do
      fit 'returns empty array' do
        client = WebflowSync::Api.new('6048c57f255aff50533565bf')

        items = client.get_all_items(collection_slug: 'subpages', page_limit: 10)

        expect(items).to be_empty
      end
    end
  end
end
