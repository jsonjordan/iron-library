
desc 'Grab info from new api and update old books'
task update_old_books_to_new_api_data: :environment do
    updated_count = 0
    Book.find_each do |book|
        puts "#{book.title}"
        gb = GetBook.new(book.isbn)
        if !gb.update
            puts "#{book.title} could not be updated with info from new"
        else
            updated_count += 1
        end
    end
    puts "#{updated_count} books have been updated."
end