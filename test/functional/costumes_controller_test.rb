require 'test_helper'

class CostumesControllerTest < ActionController::TestCase
  setup do
    @costume = costumes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:costumes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create costume" do
    assert_difference('Costume.count') do
      post :create, costume: { availability: @costume.availability, name: @costume.name, price: @costume.price, type: @costume.type }
    end

    assert_redirected_to costume_path(assigns(:costume))
  end

  test "should show costume" do
    get :show, id: @costume
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @costume
    assert_response :success
  end

  test "should update costume" do
    put :update, id: @costume, costume: { availability: @costume.availability, name: @costume.name, price: @costume.price, type: @costume.type }
    assert_redirected_to costume_path(assigns(:costume))
  end

  test "should destroy costume" do
    assert_difference('Costume.count', -1) do
      delete :destroy, id: @costume
    end

    assert_redirected_to costumes_path
  end
end
