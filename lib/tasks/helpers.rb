def track_progress(n,l, t)
  if l > 10
    if n % (l.to_f/20).round == 0
      puts "#{(n.to_f/l * 100).round} percent complete"
      puts "ET: #{(Time.now - t).round} seconds"
    end
  end
end
