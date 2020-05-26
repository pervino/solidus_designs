module Spree
  module Designs
    module VirtualProof
      class LiquidPixels

        LIQUID_PIXEL_URL = "https://personalwine.liquifire.com/personalwine"

        DEFAULTS = {
            ext: "png"
        }

        def initialize(product, design, options = {})
          @product = product
          @design = design
          @options = DEFAULTS.merge options
        end

        def url
          return nil unless @design

          render_url = LIQUID_PIXEL_URL
          render_url += "?set=#{sku_param}"
          render_url += "&set=#{type_param}"
          # if fill_param != 'blank'
          #   render_url += "&set=#{fill_param}"
          # end
          render_url += "&set=#{size_param}"
          render_url += "&set=#{design_url_param}"
          render_url += "&call=#{chain_param}"
          render_url += "&sink=#{sink_param}"
          render_url
        end

        private

        def sku_param
          "SKU[#{@product.sku.gsub(/-VAR-.*/, '')}]"
        end

        def size_param
          if @options && @options.has_key?(:size)
            "SIZE[#{@options[:size]}]"
          else
            "SIZE[FULL]"
          end
        end

        def type_param
          "TYPE[#{@design.medium}]"
        end

        # def fill_param
        #   if @design.fill == ''
        #     'blank'
        #   else 
        #     "FILL[#{@design.fill}]"
        #   end
        # end

        def design_url_param
          "DESIGN_URL[#{@design.rendering.url(:large)}]"
        end

        def sink_param
          "format[#{@options[:ext]}]"
        end

        def chain_param
          "url[file:product-preview.chain]"
        end
      end
    end
  end
end