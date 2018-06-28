class Article < ApplicationRecord
  enum status: {open: 0, close: 10}
end
