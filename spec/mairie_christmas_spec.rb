
require_relative '../lib/mairie_christmas'

describe "Mairie Christmas Program" do

  it "return an Array with Hashs of cities & our mails" do
    expect(the_program).to be_an(Array)
    expect(the_program).to include (Hash)
  end

  it "return cities name" do  
    expect(the_program).to include {"Ableiges"}
    expect(the_program).to include {"Domont"}
    expect(the_program).to include {"Wy-dit-joli-village"}
  end 

  it "return cities mails" do  
    expect(the_program).to include {"mairie.montlignon@wanadoo.fr"}
    expect(the_program).to include {"comsarcelles@yahoo.fr"}
    expect(the_program).to include {"mairie.de.noisy.sur.oise@wanadoo.fr"}
  end 

end