# encoding: utf-8

require 'spec_helper'

describe "ImagePages" do

  subject { page }

  describe "add image page" do
    before { visit add_image_path }

    it { should have_selector('h1', text: 'Загрузка изображения') }
    it { should have_selector('title', text: full_title('Загрузка изображения')) }
  end
end
