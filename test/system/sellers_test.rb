require "application_system_test_case"

class SellersTest < ApplicationSystemTestCase
  setup do
    @seller = sellers(:one)
  end

  test "visiting the index" do
    visit sellers_url
    assert_selector "h1", text: "Sellers"
  end

  test "should create seller" do
    visit sellers_url
    click_on "New seller"

    fill_in "Cardrfid", with: @seller.cardRFID
    fill_in "Cargo", with: @seller.cargo
    fill_in "Contador", with: @seller.contador
    fill_in "Nome", with: @seller.nome
    fill_in "Status", with: @seller.status
    click_on "Create Seller"

    assert_text "Seller was successfully created"
    click_on "Back"
  end

  test "should update Seller" do
    visit seller_url(@seller)
    click_on "Edit this seller", match: :first

    fill_in "Cardrfid", with: @seller.cardRFID
    fill_in "Cargo", with: @seller.cargo
    fill_in "Contador", with: @seller.contador
    fill_in "Nome", with: @seller.nome
    fill_in "Status", with: @seller.status
    click_on "Update Seller"

    assert_text "Seller was successfully updated"
    click_on "Back"
  end

  test "should destroy Seller" do
    visit seller_url(@seller)
    click_on "Destroy this seller", match: :first

    assert_text "Seller was successfully destroyed"
  end
end
