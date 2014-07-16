require 'test_helper'

class VidsControllerTest < ActionController::TestCase
  setup do
    @vid = vids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vid" do
    assert_difference('Vid.count') do
      post :create, vid: { eat_t: @vid.eat_t }
    end

    assert_redirected_to vid_path(assigns(:vid))
  end

  test "should show vid" do
    get :show, id: @vid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vid
    assert_response :success
  end

  test "should update vid" do
    patch :update, id: @vid, vid: { eat_t: @vid.eat_t }
    assert_redirected_to vid_path(assigns(:vid))
  end

  test "should destroy vid" do
    assert_difference('Vid.count', -1) do
      delete :destroy, id: @vid
    end

    assert_redirected_to vids_path
  end
end
