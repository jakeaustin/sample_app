class Match < ActiveRecord::Base
	validates_presence_of :Lpic, :Rpic, :Ltitle, :Rtitle, :matchTitle 	
	VALID_PIC_REGEX = /(.*)\.jpg/i
	validates :Rpic, :Lpic, format: {with: VALID_PIC_REGEX}
	after_create :default_values
	def default_values
		self.Lvotes ||= 1
		self.Rvotes ||= 1
		self.approved ||= false
		self.save
	end
	

end
