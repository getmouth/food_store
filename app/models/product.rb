class Product < ApplicationRecord
    belongs_to :city
    has_many :line_items

    before_destroy :ensure_not_referenced_by_line_item

    validates :name, presence: true
    validates :description, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a GIF, JPG or PNG format'
    }
    validates :category, inclusion: {
        in: %w(Vegetables Meats Fish Fruits),
        message: '%{value} is not a valid category'
    }

    private

    def ensure_not_referenced_by_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
end
