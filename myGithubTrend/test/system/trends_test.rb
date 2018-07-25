require "application_system_test_case"

class TrendsTest < ApplicationSystemTestCase
  setup do
    @trend = trends(:one)
  end

  test "visiting the index" do
    visit trends_url
    assert_selector "h1", text: "Trends"
  end

  test "creating a Trend" do
    visit trends_url
    click_on "New Trend"

    fill_in "Description", with: @trend.description
    fill_in "Lang", with: @trend.lang
    fill_in "Name", with: @trend.name
    fill_in "Star Count", with: @trend.star_count
    fill_in "Url", with: @trend.url
    click_on "Create Trend"

    assert_text "Trend was successfully created"
    click_on "Back"
  end

  test "updating a Trend" do
    visit trends_url
    click_on "Edit", match: :first

    fill_in "Description", with: @trend.description
    fill_in "Lang", with: @trend.lang
    fill_in "Name", with: @trend.name
    fill_in "Star Count", with: @trend.star_count
    fill_in "Url", with: @trend.url
    click_on "Update Trend"

    assert_text "Trend was successfully updated"
    click_on "Back"
  end

  test "destroying a Trend" do
    visit trends_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trend was successfully destroyed"
  end
end
