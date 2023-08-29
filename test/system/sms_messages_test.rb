require "application_system_test_case"

class SmsMessagesTest < ApplicationSystemTestCase
  setup do
    @sms_message = sms_messages(:one)
  end

  test "visiting the index" do
    visit sms_messages_url
    assert_selector "h1", text: "Sms messages"
  end

  test "should create sms message" do
    visit sms_messages_url
    click_on "New sms message"

    fill_in "Smsbody", with: @sms_message.smsbody
    click_on "Create Sms message"

    assert_text "Sms message was successfully created"
    click_on "Back"
  end

  test "should update Sms message" do
    visit sms_message_url(@sms_message)
    click_on "Edit this sms message", match: :first

    fill_in "Smsbody", with: @sms_message.smsbody
    click_on "Update Sms message"

    assert_text "Sms message was successfully updated"
    click_on "Back"
  end

  test "should destroy Sms message" do
    visit sms_message_url(@sms_message)
    click_on "Destroy this sms message", match: :first

    assert_text "Sms message was successfully destroyed"
  end
end
