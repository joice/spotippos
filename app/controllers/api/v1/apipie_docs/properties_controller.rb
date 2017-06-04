module Api
  module V1
    module ApipieDocs
      # Defines apipie doc to properties controller
      module PropertiesController
        def apipie_index
          api :GET, 'properties', 'List all properties'
          api_version '1.0'
          formats ['json']
          description 'Retrieve a list of properties in JSON'
          param :q, Hash, desc: 'Query params for search', required: false do
          end
        end

        def apipie_show
          api :GET, 'properties/:id', 'Show property by a valid id'
          api_version '1.0'
          param :id, String, desc: 'Property ID', required: true
          formats ['json']
        end

        def apipie_create
          api :POST, 'property', 'Creates a property'
          api_version '1.0'
          formats ['json']
          description 'Creates a property with valid attributes'
          param :property, Hash, required: true do
            param :title, String, desc: 'Title of property advertisement', required: true
            param :price, Integer, desc: 'The price of property', required: true
            param :x, [0..1400], desc: 'Coordinate for the point where the property is located on the x-axis of map', required: true
            param :y, [0..1000], desc: 'Coordinate for the point where the property is located on the y-axis of map', required: true
            param :beds, [1..5], desc: 'Number of quantity of beds in the property', required: true
            param :baths, [1..4], desc: 'Number of quantity of baths in the property', required: true
            param :square_meters, [20..240], desc: 'Measured in square meters of property', required: true
          end
        end

        def apipie_update
          api :PATCH, 'properties/:id', 'Updates a property'
          api_version '1.0'
          formats ['json']
          description 'Updates a property with valid attributes'
          param :property, Hash, required: true do
            param :title, String, desc: 'Title of advertisement'
            param :price, Integer, desc: 'The price of property'
            param :x, Integer, desc: 'Coordinate for the point where the property is located on the x-axis of map'
            param :y, Integer, desc: 'Coordinate for the point where the property is located on the y-axis of map'
            param :beds, Integer, desc: 'Number of quantity of beds in the property'
            param :baths, Integer, desc: 'Number of quantity of baths in the property'
            param :square_meters, Integer, desc: 'Measured in square meters of property'
          end
        end

        def apipie_destroy
          api :DELETE, 'properties/:id', 'Deletes a property'
          api_version '1.0'
          formats ['json']
          description 'Deletes a property'
          param :id, String, desc: 'Property ID', required: true
        end
      end
    end
  end
end
