require_relative '../lib/dark_trader'

describe "dark trader crypto" do

    it "return an Array with Hash into" do
      expect(crypto(scrapper)).to be_an(Array)
      expect(crypto(scrapper)).to include (Hash)
    end
  
    it "return the name of crypto" do  
      expect(crypto(scrapper)).to include {"BTC"}
      expect(crypto(scrapper)).to include {"USDT"}
      expect(crypto(scrapper)).to include {"BNB"}
    end 
  
end