get '/' do
	@lowscore_biz = Inspection.where("score < ?", 50)
	erb :index
end