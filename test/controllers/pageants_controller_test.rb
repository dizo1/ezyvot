require 'test_helper'

class PageantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pageant = pageants(:one)
  end

  test "should get index" do
    get pageants_url
    assert_response :success
  end

  test "should get new" do
    get new_pageant_url
    assert_response :success
  end

  test "should create pageant" do
    assert_difference('Pageant.count') do
      post pageants_url, params: { pageant: { category: @pageant.category, description: @pageant.description, enddate: @pageant.enddate, image: @pageant.image, name: @pageant.name, startdate: @pageant.startdate, time_zone: @pageant.time_zone } }
    end

    assert_redirected_to pageant_url(Pageant.last)
  end

  test "should show pageant" do
    get pageant_url(@pageant)
    assert_response :success
  end

  test "should get edit" do
    get edit_pageant_url(@pageant)
    assert_response :success
  end

  test "should update pageant" do
    patch pageant_url(@pageant), params: { pageant: { category: @pageant.category, description: @pageant.description, enddate: @pageant.enddate, image: @pageant.image, name: @pageant.name, startdate: @pageant.startdate, time_zone: @pageant.time_zone } }
    assert_redirected_to pageant_url(@pageant)
  end

  test "should destroy pageant" do
    assert_difference('Pageant.count', -1) do
      delete pageant_url(@pageant)
    end

    assert_redirected_to pageants_url
  end
end
