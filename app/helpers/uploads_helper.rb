require 'active_support/secure_random'

module UploadsHelper
	def self.save(upload)
		htmlfile=upload['htmlfield']
		directory='public'
		slug=ActiveSupport::SecureRandom.hex(3)
		path=FileUtils.mkdir_p "#{directory}/#{slug}"
		if !upload['cssfield'].blank?
			fullpath=File.join(path,upload['cssfile'].original_filename)
			File.open(fullpath,'wb') { |f| f.write(upload['cssfield'].read) }
		end
		fullpath=File.join(path, 'index.html')
		File.open(fullpath,'wb') { |f| f.write(upload['htmlfield'].read) }
		return slug
	end
end
