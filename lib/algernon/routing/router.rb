require "algernon/routing/finder"
require "algernon/routing/route"

module Algernon
  module Routing
    class Router
      include Algernon::Routing::Route
      attr_accessor :routes, :url_placeholders, :part_regex

      HTTP_VERBS = %w(get post put patch delete).freeze

      def initialize
        @routes = {}
        @url_placeholders = {}
        @part_regex = []
        http_verb_creator
      end

      def draw(&block)
        instance_eval(&block)
      end

      def has_routes?
        true unless routes.empty?
      end

      def get_match(http_verb, path)
        http_verb = http_verb.downcase
        routes[http_verb].detect do |route|
          route.check_path(path)
        end
      end

      def http_verb_creator
        self.class.class_eval do
          HTTP_VERBS.each do |http_verb|
            define_method(http_verb) do |path, to:|
              process_and_store_route(http_verb, path, to)
            end
          end
        end
      end

      def process_and_store_route(http_verb, path, to)
        regex_parts, url_placeholders = extract_regex_and_placeholders(path)
        path_regex = convert_regex_parts_to_path(regex_parts)
        route_object = Algernon::Routing::Finder.new(
          path_regex, to, url_placeholders
        )
        routes[http_verb.downcase.freeze] ||= []
        routes[http_verb.downcase] << route_object
      end

      def extract_regex_and_placeholders(path)
        path.path_format!

        @part_regex = []
        @url_placeholders = {}
        path.split("/").each_with_index do |path_part, index|
          store_part_and_placeholder(path_part, index)
        end

        [part_regex, url_placeholders]
      end

      def store_part_and_placeholder(path_part, index)
        if path_part.start_with?(":")
          url_placeholders[index] = path_part.delete(":").freeze
          part_regex << "[a-zA-Z0-9_]+"
        else
          part_regex << path_part
        end
      end

      def convert_regex_parts_to_path(regex_match)
        regex_string = "^" + regex_match.join("/") + "/*$"
        Regexp.new(regex_string)
      end
    end
  end
end
