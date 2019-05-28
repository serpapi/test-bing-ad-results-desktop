describe "SerpApi Desktop JSON" do

  describe "Organic Results for apple.com" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=apple.com&source=test&engine=bing'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains ad results array" do
      expect(@json["ads"]).to be_an(Array)
    end

    describe "have first result" do

      before :all do
        @result = @json["ads"][0]
      end

      it "is first" do
        expect(@result["position"]).to be(1)
      end

      it "has top block position" do
        expect(@result["block_position"]).to match (/^(top|bottom)$/)
      end

      it "has a tracking link" do
        expect(@result["tracking_link"]).to start_with("https://www.bing.com/aclk?")
      end

      it "apple.com title" do
        expect(@result["title"]).to start_with("Apple")
      end

      it "apple.com displayed link" do
        expect(@result["displayed_link"]).to eql("https://www.apple.com")
      end

      it "has a description" do
        expect(@result["description"]).to_not be_empty
      end

      it "has expanded sitelinks" do
        expect(@result["sitelinks"]).to be_a(Hash)
        expect(@result["sitelinks"]["expanded"]).to be_a(Array)
        expect(@result["sitelinks"]["expanded"][0]["title"]).to_not be_empty
        expect(@result["sitelinks"]["expanded"][0]["tracking_link"]).to_not be_empty
        expect(@result["sitelinks"]["expanded"][0]["snippet"]).to_not be_empty
      end

    end

  end

end
