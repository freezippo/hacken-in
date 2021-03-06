require 'spec_helper'

describe EventsController, type: :controller do
  it "should redirect to calendar if there are no single events" do
    event = FactoryBot.create(:simple)
    get :show, id: event.id
    expect(response).to redirect_to(:calendar)
  end

  it "should redirect to the best fitting single event" do
    event = FactoryBot.create(:simple)
    single_event = FactoryBot.create(:single_event, event: event)

    expect(Event).to receive(:find).with(event.id.to_s).and_return(event)
    expect(event).to receive(:closest_single_event).and_return(single_event)

    get :show, id: event.id
    expect(response).to redirect_to(event_single_event_path(event, single_event))
  end
end
