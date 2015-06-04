class ContactForm < MailForm::Base
  attribute :body, :validate => true
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :name, :validate => true
  attribute :subject, :validate => true

  def headers
    {
      :subject => subject,
      :to => "mar.rie.cra@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
