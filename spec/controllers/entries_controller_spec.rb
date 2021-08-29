RSpec.describe EntriesController, type: :controller do
  it "response status 200" do
    expect(response.status).to eq(200)
  end
  it "redirect_to entries page" do
    post :create, params: { entry: {date: '2019-04-15', start_time: '10:00', finish_time: '17:00'} }
    expect(response).to redirect_to entries_path
  end
end