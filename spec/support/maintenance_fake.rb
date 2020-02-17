require "forwardable"

class ItemFake < Struct.new(:content, :category_name, :location_name); end

class MaintenanceFake
  extend Forwardable

  attr_reader :maintenance_number, :typing_i18n, :contact_number,
    :contact_time_text, :maintenance_items

  def_delegators :@double, :name, :unit_number

  def new
    @maintenance_number = "GG1234"
    @typing_i18n = "修繕（個別戶）"
    @contact_number = "0904098127"
    @contact_time_text = "上午時段 9:00-12:00"
    @double = OpenStruct.new(name: "Costa del Fronk", unit_number: "CDF00001")
    @maintenance_items = [
      ItemFake.new("Broken water heater", "水電", "其他"),
      ItemFake.new("Living room electrical outage", "水電", "客廳"),
    ]
  end
end
