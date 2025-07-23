class LoanMailer < ApplicationMailer
  def loan_confirmation(book_user)
    @book_user = book_user
    @book = book_user.book
    @user = book_user.user

    mail(to: @user.email, subject: 'Comprovante de empréstimo de livro')
  end
end
