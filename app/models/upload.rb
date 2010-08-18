require 'active_support/secure_random'
require 'zip/zipfilesystem'

class Upload < ActiveRecord::Base
	def self.unpack(source)
		directory='public'
		slug=ActiveSupport::SecureRandom.hex(3)
		path=FileUtils.mkdir_p "#{directory}/#{slug}"
		ext=File.extname(source.original_filename)
		tmppath=File.join(path,"#{slug}#{ext}")
		File.open(tmppath,'wb') { |f| f.write(source.read) }
		Zip::ZipFile.open(tmppath) { |zipfile| zipfile.each { |f|
			f_path=File.join(path,f.name)
			FileUtils.mkdir_p(File.dirname(f_path))
			zipfile.extract(f,f_path) unless File.exist?(f_path)
		}
		}
		Dir.foreach(path) do |item|
			if File.extname(item)=='.html' or File.extname(item)=='.htm'
				lines=[]
				tmppath=File.join(path,item)
				File.open(tmppath,'r'){|f| lines=f.readlines}
				lines=lines.inject([]){|l, line| l << line.gsub(/href=(["|'])([a-zA-Z0-9-_.\/]*)\1/,"href='#{slug}/\\2'")}
				lines=lines.inject([]){|l, line| l << line.gsub(/src=(["|'])([a-zA-Z0-9-_.\/]*)\1/,"src='#{slug}/\\2'")}
				lines=lines.inject([]){|l, line| l << line.gsub(/url\((["|'])([a-zA-Z0-9-_.\/]*)\1\)/,"url(\\1#{slug}/\\2\\1)")}
				File.open(tmppath,'w'){|f| f.write(lines) }
			end
		end
		return slug,ext
	end
	
	def self.save(upload)
		htmlfile=upload['htmlfield']
		directory='public'
		slug=ActiveSupport::SecureRandom.hex(3)
		path=FileUtils.mkdir_p "#{directory}/#{slug}"
		htmlpath=File.join(path, 'index.html')
		File.open(htmlpath,'wb') { |f| f.write(upload['htmlfield'].read) }
		Zip::ZipFile.open("#{path}/#{slug}.zip", Zip::ZipFile::CREATE) do |zipfile|
			zipfile.add(upload['htmlfield'].original_filename,htmlpath)
		end
		if !upload['cssfield'].blank?
			csspath=File.join(path,upload['cssfield'].original_filename)
			File.open(csspath,'wb') { |f| f.write(upload['cssfield'].read) }
			Zip::ZipFile.open("#{path}/#{slug}.zip", Zip::ZipFile::CREATE) do |zipfile|
				zipfile.add(upload['cssfield'].original_filename,csspath)
			end
			lines=[]
			File.open(htmlpath,'r'){|f| lines=f.readlines}
			lines=lines.inject([]){|l, line| l << line.gsub(/href=["|']([a-zA-Z0-9-_]*).css["|']/,"href='#{slug}/\\1.css'")}
			File.open(htmlpath,'w'){|f| f.write(lines) }
		end
		return slug,'.zip'
	end
end
