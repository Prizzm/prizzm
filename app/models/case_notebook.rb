class CaseNotebook
  include Mongoid::Document

  field :case_id
  embeds_many :notes

  def case
    Case.find self.case_id
  end
end


class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :case_notebook

  field :body, type: String
  field :solution, type: Boolean

  def case
    case_notebook.case
  end 

  def solution?
    'solution' unless self.solution.nil?
  end
end
