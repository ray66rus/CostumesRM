# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  pictureable_id     :integer
#  pictureable_type   :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'spec_helper'

describe Picture do
  pending "add some examples to (or delete) #{__FILE__}"
end
