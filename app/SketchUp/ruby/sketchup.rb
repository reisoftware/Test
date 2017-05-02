
#炸开模型
mod = Sketchup.active_model
space = "\t"
def deal_space (num)
	
	i = 1
	sp = ''
	while i<=num   do 
		sp = "#{sp}#{space}"
	end 
	return sp
end

File.open("d:/sketchup.lua","w+") do |file|
	entities = mod.entities
	count = entities.count
	file.puts "sketchupInformation ={"
	file.puts "#{space}count =#{count}"
	file.puts "}"
	entities.each  do |entity|
		typename = entity.typename
		if typename  == 'Edge' then
		elsif typename  == 'Face' then
			file.puts "Face{"		
				file.puts "#{space}loops  = {"
				loops  = entity.loops 
				loops .each  do |loop|
				# file.puts "#{space}#{space}{"
				file.puts "#{space}#{space}{"
				file.puts "#{space}#{space}#{space}isouter = '#{ loop.outer? }';"
				loop_vertrixs = loop.vertices
				loop_vertrixs .each  do |vertrix|
					file.puts "#{space}#{space}#{space}{key = '#{vertrix}',pt = '#{vertrix.position}',};"
				end
				file.puts "#{space}#{space}};"
			end
			file.puts "#{space}},"
			file.puts "};"
		else 
			puts "=====#{typename}"	
		end	
	end
end

