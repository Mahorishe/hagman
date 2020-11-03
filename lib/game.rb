class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end
  #накопитель ошибок
  def errors
    @user_guesses - normalized_letters
  end
  #сделано ошибок
  def errors_made
    errors.length
  end
  #ошибок осталось
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def normalize_letter(letter)
    letter = "Е" if letter == "Ё"
    letter = "И" if letter == "Й"
    letter
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter)}
  end
  def letters_to_guess
    result = @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      else
        nil
      end
    end
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)

    normalized_letter = normalize_letter(letter)

    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
