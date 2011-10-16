# This is all a mess.
# dm-geokit makes a lot of assumptions. Doesn't work well outside simple cases.
# Monkey patches below at least get it working a bit with postgresql
module DataMapper
  module GeoKit

    module InstanceMethods
      module SingletonMethods # :nodoc:

        # dm-geokit breaks all these.
        def all(query = Undefined)
          !query || query.equal?(Undefined) ? super(query) : super(prepare_query(query))
        end

        def first(query = Undefined)
          query.equal?(Undefined) ? super(query) : super(prepare_query(query))
        end

        # Required dm-aggregates to work
        def count(query = Undefined)
          query.equal?(Undefined) ? super(query) : super(prepare_query(query))
        end

        private

        # Monkey Patch for this issue:
        # https://github.com/foysavas/dm-geokit/issues/1

        # Looks in the query for keys that are a DistanceOperator, then extracts the keys/values and turns them into conditions
        def prepare_query(query)
          return query unless query.is_a? Hash
          new_conds = query[:conditions]
          new_fields = query[:fields]
          query.each_pair do |k,v|
            next if not k.is_a?(DistanceOperator)
            field = k.target
            origin = v[:origin].is_a?(String) ? ::GeoKit::Geocoders::MultiGeocoder.geocode(v[:origin]) : v[:origin]
            distance = v[:distance]
            new_conds = expand_conditions(new_conds, "#{sphere_distance_sql(field, origin, distance.measurement)}", distance.to_f) if new_conds
            new_conds = apply_bounds_conditions(new_conds, field, bounds_from_distance(distance.to_f, origin, distance.measurement)) if new_conds
            new_fields = expand_fields(new_fields, field, "#{sphere_distance_sql(field, origin, distance.measurement)}") if new_fields
            query.delete(k)
          end
          query[:conditions] = new_conds if new_conds
          query[:fields] = new_fields if new_fields
          query
        end

        # Monkey Patch:
        # Remove backticks.
        # Spherical distance sql
        def sphere_distance_sql(field, origin, units)
          lat = deg2rad(origin.lat)
          lng = deg2rad(origin.lng)
          qualified_lat_column = "#{storage_name}.#{field}_lat"
          qualified_lng_column = "#{storage_name}.#{field}_lng"
          "(ACOS(least(1,COS(#{lat})*COS(#{lng})*COS(RADIANS(#{qualified_lat_column}))*COS(RADIANS(#{qualified_lng_column}))+COS(#{lat})*SIN(#{lng})*COS(RADIANS(#{qualified_lat_column}))*SIN(RADIANS(#{qualified_lng_column}))+SIN(#{lat})*SIN(RADIANS(#{qualified_lat_column}))))*#{units_sphere_multiplier(units)})"
        end


        # Monkey Patch:
        # Remove backticks.
       def apply_bounds_conditions(conditions, field, bounds)
          qualified_lat_column = "#{storage_name}.#{field}_lat"
          qualified_lng_column = "#{storage_name}.#{field}_lng"
          sw, ne = bounds.sw, bounds.ne
          lng_sql = bounds.crosses_meridian? ? "(#{qualified_lng_column}<=#{sw.lng} OR #{qualified_lng_column}>=#{ne.lng})" : "#{qualified_lng_column}>=#{sw.lng} AND #{qualified_lng_column}<=#{ne.lng}"
          bounds_sql = "#{qualified_lat_column}>=#{sw.lat} AND #{qualified_lat_column}<=#{ne.lat} AND #{lng_sql}"
          conditions[0] << " AND (#{bounds_sql})"
          conditions
        end

      end

    end
  end
end

DataMapper::Adapters::PostgresAdapter::SQL.module_eval do

  # MonkeyPatch
  # Based on the mysql patch here: https://github.com/foysavas/dm-geokit/issues/2
  def quote_name(name)
    if name.include? '('
      name
    else
      "\"#{name[0, self.class::IDENTIFIER_MAX_LENGTH].gsub('`', '``')}\""
    end
  end
end