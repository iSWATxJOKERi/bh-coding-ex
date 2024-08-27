class DiagnosticScreenerAnswer < ApplicationRecord
    validates :value, :question_id, presence: true
    validates :value, :inclusion => { :in => 0..4 }

    def self.get_diagnostic_screener
        path = Rails.root.to_s.split("/")
        path << "diagnostic_screener.json"
        file = File.open File.join(path)
        diagnostic_screener_data = JSON.load file
        diagnostic_screener_data
    end

    def self.get_assessments_based_on_scores(answers)
        domain_map = get_domain_map()
        formatted_domain_map = format_domain_mapping(domain_map)
        scores = get_total_score_for_each_domain(answers, formatted_domain_map)

        assessments = []
        if scores["depression"] >= 2 || scores["anxiety"] >= 2
            assessments << "PHQ-9"
        end
        if scores["mania"] >= 2
            assessments << "ASRM"
        end
        if scores["substance_use"] >= 1
            assessments << "ASSIST"
        end
        assessments
    end

    private

    def self.get_domain_map
        path = Rails.root.to_s.split("/")
        path << "domain_mapping.json"
        file = File.open File.join(path)
        domain_mapping_data = JSON.load file
        domain_mapping_data
    end

    def self.format_domain_mapping(domain_map)
        formatted_domain_map = {}
        domain_map.each do |domain|
            formatted_domain_map[domain["question_id"]] = domain
        end
        formatted_domain_map
    end

    def self.get_total_score_for_each_domain(answers, formatted_domain_map)
        total_scores = Hash.new(0)

        answers.each do |answer|
            q_id = answer[:question_id]
            total_scores[formatted_domain_map[q_id]["domain"]] += answer[:value]
        end
        total_scores
    end
end