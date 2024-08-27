require "json"

class Api::DiagnosticScreenerAnswersController < ApplicationController
    def get_diagnostic_screener
        diagnostic_screener = DiagnosticScreenerAnswer.get_diagnostic_screener()
        render json: diagnostic_screener
    end

    def create
        answers = params[:answers].map do |answer| 
            {
                value: answer[:value],
                question_id: answer[:question_id]
            }
        end
        DiagnosticScreenerAnswer.transaction do
            DiagnosticScreenerAnswer.create!(answers)
        end

        assessments = DiagnosticScreenerAnswer.get_assessments_based_on_scores(answers)
        render json: {
            results: assessments
        }
    end
end