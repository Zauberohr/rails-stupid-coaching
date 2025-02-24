class QuestionsController < ApplicationController
  def ask
  end

  def answer
    @question = params[:question].strip.downcase # Leerzeichen entfernen & Kleinschreibung erzwingen

    # Exakte oder fast exakte Matches
    exact_matches = {
      /wer.*bruder/i => 'Otto natürlich!',
      /wer.*kind/i => 'Otto ist dein Lieblingskind!',
      /waidmannsheil/i => 'Waidmannsdank!',
      /wer.*liebling/i => 'Otto, ganz klar!',
      /schalke/i => 'Nur der S04!',
      /tu wien/i => 'Otto hat dort Architektur studiert!',
      /kunst|zauberohr/i => 'Otto macht lustige Zeichnungen unter dem Namen Zauberohr!',
      /pr|neues handeln/i => 'Otto arbeitet in PR bei neues handeln.',
      /treibhaus|agentur/i => 'Otto war beim Treibhaus AgencyCampus.',
      /jll|sirius/i => 'Otto hat bei Sirius Facilities und JLL gearbeitet.',
      /militär|bundeswehr/i => 'Otto war in der Aufklärung bei der Bundeswehr.',
      /hochzeit|fotograf/i => 'Otto hat als Hochzeitsfotograf gearbeitet.',
      /le wagon|webentwicklung/i => 'Otto macht gerade den Web Development Kurs bei Le Wagon.',
      /wer.*otto/i => 'Otto ist ein kreativer Kopf mit Humor!'
    }

    # Falls ein exakter oder ähnlicher Match gefunden wird
    exact_matches.each do |pattern, response|
      if @question.match(pattern)
        @answer = response
        return
      end
    end

    # Falls einzelne Wörter aus der Frage ein Thema treffen
    word_matches = {
      ['otto', 'bruder'] => 'Otto ist dein Bruder!',
      ['otto', 'kind'] => 'Otto ist dein Lieblingskind!',
      ['otto', 'kunst'] => 'Otto macht Kunst als Zauberohr!',
      ['otto', 'pr'] => 'Otto arbeitet in PR!',
      ['otto', 'web'] => 'Otto lernt Webentwicklung bei Le Wagon!',
      ['otto', 'fotograf'] => 'Otto war mal Hochzeitsfotograf!',
      ['otto', 'bundeswehr'] => 'Otto war in der Aufklärung bei der Bundeswehr!',
      ['otto', 'schalke'] => 'Otto ist ein S04-Fan!',
      ['otto', 'treibhaus'] => 'Otto war bei Treibhaus AgencyCampus!',
      ['otto', 'neues handeln'] => 'Otto arbeitet bei neues handeln!',
      ['otto', 'architektur'] => 'Otto hat Architektur an der TU Wien studiert!'
    }

    word_matches.each do |keywords, response|
      if keywords.any? { |word| @question.include?(word) }
        @answer = response
        return
      end
    end

    # Standardantworten, wenn nichts zutrifft
    if @question.end_with?('?')
      @answer = "Silly question, get dressed and go to work!"
    else
      @answer = "I don't care, get dressed and go to work!"
    end
  end
end
