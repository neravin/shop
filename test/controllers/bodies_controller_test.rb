require 'test_helper'

class BodiesControllerTest < ActionController::TestCase
  setup do
    @body = bodies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bodies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create body" do
    assert_difference('Bodie.count') do
      post :create, body: { age: @body.age, bol: @body.bol, fat: @body.fat, kind_sport: @body.kind_sport, objective: @body.objective, pol: @body.pol }
    end

    assert_redirected_to body_path(assigns(:body))
  end

  test "should show body" do
    get :show, id: @body
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @body
    assert_response :success
  end

  test "should update body" do
    patch :update, id: @body, body: { age: @body.age, bol: @body.bol, fat: @body.fat, kind_sport: @body.kind_sport, objective: @body.objective, pol: @body.pol }
    assert_redirected_to body_path(assigns(:body))
  end

  test "should destroy body" do
    assert_difference('Bodie.count', -1) do
      delete :destroy, id: @body
    end

    assert_redirected_to bodies_path
  end
end
