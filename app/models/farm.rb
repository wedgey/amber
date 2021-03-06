class Farm < ApplicationRecord
  belongs_to :user
  has_many :sub_farms, dependent: :destroy
  has_many :stock
  has_many :sub_farm_activities, through: :sub_farms

  validates :name, presence: true
  validates :user_id, presence: true
  validates :size, numericality: true

  def last_activities
    sub_farm_activities.order("activity_id, date DESC").select("DISTINCT ON(activity_id) *")
  end

  private

  def last_watered
    sub_farm_activities.order("activity_id, date DESC").select("DISTINCT ON(activity_id) *")
  end

  def last_fertilized
    sub_farm_activities.order("activity_id, date DESC").select("DISTINCT ON(activity_id) *")
  end

  def last_chemicalled
    sub_farm_activities.order("activity_id, date DESC").select("DISTINCT ON(activity_id) *")
  end

  # def last_watered
  #   @water_activity = sub_farm_activities.where(activity_id: 1).select("DISTINCT ON(sub_farm_id)*").order("sub_farm_id, date DESC")
  # end

  # def last_fertilized
  #   @fertilizer_activity = sub_farm_activities.where(activity_id: 2).select("DISTINCT ON(sub_farm_id)*").order("sub_farm_id, date DESC")
  # end

  # def last_chemicalled
  #   @chemical_activity = sub_farm_activities.where(activity_id: 3).select("DISTINCT ON(sub_farm_id)*").order("sub_farm_id, date DESC")
  # end
end
