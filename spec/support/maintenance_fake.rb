require "ostruct"

class ItemFake < Struct.new(:content, :category_name, :location_name); end

class MaintenanceFake
  attr_reader :maintenance_number, :typing_i18n, :contact_number,
    :contact_time_text, :maintenance_items, :maintenance_fields, :double,
    :redmine_project_id, :redmine_tracker_id

  ASSOCIATIONS = %i(property unit user).freeze
  ASSOCIATIONS.each { |ass| alias_method ass, :double }

  def initialize
    @maintenance_number = "GG1234"
    @typing_i18n = "修繕（個別戶）"
    @contact_number = "0904098127"
    @contact_time_text = "上午時段 9:00-12:00"
    @double = OpenStruct.new(name: "Costa del Fronk", unit_number: "CDF00001")
    @maintenance_items = [
      ItemFake.new("Broken water heater", "水電", "其他"),
      ItemFake.new("Living room electrical outage", "水電", "客廳"),
    ]
    @maintenance_fields = {
      maintenance_number: "修繕案件單號",
      maintenance_typing: "案件類別",
      property_name: "建案名稱",
      unit_number: "房屋編號",
      user_name: "顧客名稱",
    }
    @redmine_project_id = "s-maintenance"
    @redmine_tracker_id = "修繕單"
  end
end
