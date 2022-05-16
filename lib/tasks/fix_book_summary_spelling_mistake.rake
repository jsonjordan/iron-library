
desc 'Fix spelling error is default book summary'
task fix_book_summary_spelling_mistake: :environment do
    Book.find_each do |book|
        if book.summary.include?('avaliabe')
            book.summary.gsub("avaliabe", "available")
            
            if book.save
                puts "#{book.title} has been updated!"
            else
            end
        end
    end
end