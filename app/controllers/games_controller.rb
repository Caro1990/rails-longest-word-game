require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    charset = Array('A'..'Z') + Array('A'..'Z')
    return @letters = Array.new(Random.new.rand(2..15)) { charset.sample }
  end

  def score
    @randomletters = params[:letter]
    @word = params[:word]
    @score = 0
    mot = @word.upcase.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word.to_s}"
    usera = open(url).read
    user = JSON.parse(usera)
    if user['found'] == false
      @score = 0
      @message = 'the given word is not an english one'
    elsif mot.all? { |letter| mot.count(letter) > @randomletters.count(letter) }
      @score = 0
      @message = 'The given word is not in the grid'
    elsif
      @score = @score + 1
      @message = 'Good job!'
    end
  end
end
