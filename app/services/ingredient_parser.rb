class IngredientParser
  CONFIG = YAML.load_file(Rails.root.join('config', 'units.yml'))
  KNOWN_UNITS = CONFIG['units'].map(&:downcase).uniq

  # This range includes:
  # U+00BC (¼), U+00BD (½), U+00BE (¾)
  # and U+2150 through U+2189 cover a variety of fraction forms (⅐, ⅑, ⅒, ⅓, ⅔, etc.)
  NUMERIC_PART = '(?:\d+(?:\.\d+)?|(?:\.\d+)|\d+\s*\d/\d|[\u00BC-\u00BE\u2150-\u2189])'
  QUANTITY_REGEX = /^((?:#{NUMERIC_PART}(?:\s+#{NUMERIC_PART})*))/

  def self.parse(line)
    return [nil, line] if line.blank?

    # remove parenthesis
    line = line.gsub(/[()]/, '')
  
    # Remove trailing descriptions, e.g. ", cubed"
    line = line.sub(/,\s.*$/, '').strip

    # Match the combined quantity (which may include multiple parts)
    quantity_match = line.match(QUANTITY_REGEX)
    unless quantity_match
      return [nil, line]
    end

    quantity_str = quantity_match[1].strip
    rest = line.sub(quantity_str, '').strip

    # Split the remainder and check for a known unit
    words = rest.split
    unit = nil
    if words.any? && KNOWN_UNITS.include?(words.first.downcase)
      unit = words.shift
    end

    # The rest is the ingredient name
    name = words.join(' ')

    # Combine quantity and unit
    full_quantity = [quantity_str, unit].compact.join(' ')
    [full_quantity, name.strip]
  end
end
