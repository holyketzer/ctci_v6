module SparseSimilarity
  # Time=O(d^2 * n) Mem=O(d * n) where d - count of docs, n - average size of doc
  def solve_a(docs_by_id)
    docs_by_id = docs_by_id.map { |id, doc| [id, Set.new(doc)] }.to_h
    keys = docs_by_id.keys

    res = []

    keys.size.times do |i|
      key1 = keys[i]
      doc1 = docs_by_id[key1]
      ((i + 1)..(keys.size - 1)).each do |j|
        key2 = keys[j]
        doc2 = docs_by_id[key2]

        similarity = get_similarity(doc1, doc2)
        # puts "#{similarity} for #{key1}=#{doc1} #{key2}=#{doc2}"
        if similarity > 0
          res << [key1, key2, similarity]
        end
      end
    end

    res
  end

  def get_similarity(doc1, doc2)
    (doc1 & doc2).size / (doc1 | doc2).size.to_f
  end

  def solve_b(docs_by_id)
    docs_by_terms = Hash.new { |hash, key| hash[key] = Set.new }

    docs_by_id.each do |id, doc|
      doc.each do |term|
        docs_by_terms[term] << id
      end
    end

    related_docs = Hash.new { |hash, key| hash[key] = SortedSet.new }

    docs_by_terms.each do |term, docs|
      docs = docs.to_a
      docs.size.times do |i|
        ((i + 1)..(docs.size - 1)).each do |j|
          if i > j
            i, j = j, i
          end

          related_docs[docs[i]] << docs[j]
        end
      end
    end

    res = []

    related_docs.each do |key1, keys|
      keys.each do |key2|
        doc1 = docs_by_id[key1]
        doc2 = docs_by_id[key2]

        similarity = get_similarity(doc1, doc2)
        # puts "#{similarity} for #{key1}=#{doc1} #{key2}=#{doc2}"
        if similarity > 0
          res << [key1, key2, similarity]
        end
      end
    end

    res
  end

  def solve_c(docs_by_id)
    docs_by_terms = Hash.new { |hash, key| hash[key] = Set.new }

    docs_by_id.each do |id, doc|
      doc.each do |term|
        docs_by_terms[term] << id
      end
    end

    related_docs = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = 0 } }

    docs_by_terms.each do |term, docs|
      docs = docs.to_a
      docs.size.times do |i|
        ((i + 1)..(docs.size - 1)).each do |j|
          if i > j
            i, j = j, i
          end

          related_docs[docs[i]][docs[j]] += 1
        end
      end
    end

    res = []

    related_docs.each do |key1, docs|
      docs.sort_by { |k, _| k }.each do |key2, intersections_count|
        doc1 = docs_by_id[key1]
        doc2 = docs_by_id[key2]

        similarity = intersections_count / (doc1.size + doc2.size - intersections_count).to_f
        # puts "#{similarity} for #{key1}=#{doc1} #{key2}=#{doc2}"
        if similarity > 0
          res << [key1, key2, similarity]
        end
      end
    end

    res
  end

  RSpec.describe 'SparseSimilarity' do
    include SparseSimilarity

    %i(a b c).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", docs_by_id) }

        context 'book example' do
          let(:docs_by_id) do
            {
              13 => [14, 15, 100, 9, 3],
              16 => [32, 1, 9, 3, 5],
              19 => [15, 29, 2, 6, 8, 7],
              24 => [7, 10],
            }
          end

          it do
            is_expected.to eq [
              [13, 16, 0.25],
              [13, 19, 0.1],
              [19, 24, 0.14285714285714285],
            ]
          end
        end

        context 'more sparse example' do
          let(:docs_by_id) do
            {
              1 => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
              2 => [10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
              3 => [20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
              4 => [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
              5 => [40, 41, 42, 43, 44, 45, 46, 47, 48, 49],
              6 => [50, 51, 52, 53, 54, 55, 56, 57, 58, 59],
              7 => [60, 61, 62, 63, 64, 65, 66, 67, 68, 69],
              8 => [70, 71, 72, 73, 74, 75, 76, 77, 78, 79],
              9 => [80, 81, 82, 83, 84, 85, 86, 87, 88, 89],
              10 => [90, 91, 92, 93, 94, 95, 96, 97, 98, 99],
              11 => [100, 101, 102, 103, 104, 105, 106, 107, 108, 109],
              12 => [110, 111, 112, 113, 114, 115, 116, 117, 118, 119],
              13 => [120, 121, 122, 123, 124, 125, 126, 127, 128, 129],
              14 => [130, 131, 132, 133, 134, 135, 136, 137, 138, 139],
              15 => [140, 141, 142, 143, 144, 145, 146, 147, 148, 149],
              16 => [150, 151, 152, 153, 154, 155, 156, 157, 158, 159],
              17 => [160, 161, 162, 163, 164, 165, 166, 167, 168, 169],
              18 => [170, 171, 172, 173, 174, 175, 176, 177, 178, 179],
              19 => [180, 181, 182, 183, 184, 185, 186, 187, 188, 189],
              20 => [190, 191, 192, 193, 194, 195, 196, 197, 198, 199],
              21 => [200, 201, 202, 203, 204, 205, 206, 207, 208, 209],
              22 => [210, 211, 212, 213, 214, 215, 216, 217, 218, 219],
              23 => [220, 221, 222, 223, 224, 225, 226, 227, 228, 229],
              24 => [230, 231, 232, 233, 234, 235, 236, 237, 238, 239],
              25 => [240, 241, 242, 243, 244, 245, 246, 247, 248, 249],
              26 => [250, 251, 252, 253, 254, 255, 256, 257, 258, 259],
              27 => [260, 261, 262, 263, 264, 265, 266, 267, 268, 269],
              28 => [270, 271, 272, 273, 274, 275, 276, 277, 278, 279],
              29 => [280, 281, 282, 283, 284, 285, 286, 287, 288, 289],
              30 => [290, 291, 292, 293, 294, 295, 296, 297, 298, 299],
              31 => [300, 301, 302, 303, 304, 305, 306, 307, 308, 309],
              32 => [310, 311, 312, 313, 314, 315, 316, 317, 318, 319],
              33 => [320, 321, 322, 323, 324, 325, 326, 327, 328, 329],
              34 => [330, 331, 332, 333, 334, 335, 336, 337, 338, 339],
              35 => [340, 341, 342, 343, 344, 345, 346, 347, 348, 349],
              36 => [350, 351, 352, 353, 354, 355, 356, 357, 358, 359],
              37 => [360, 361, 362, 363, 364, 365, 366, 367, 368, 369],
              38 => [370, 371, 372, 373, 374, 375, 376, 377, 378, 379],
              39 => [380, 381, 382, 383, 384, 385, 386, 387, 388, 389],
              40 => [390, 391, 392, 393, 394, 395, 396, 397, 398, 399],
              41 => [400, 401, 402, 403, 404, 405, 406, 407, 408, 409],
              42 => [410, 411, 412, 413, 414, 415, 416, 417, 418, 419],
              43 => [420, 421, 422, 423, 424, 425, 426, 427, 428, 429],
              44 => [430, 431, 432, 433, 434, 435, 436, 437, 438, 439],
              45 => [440, 441, 442, 443, 444, 445, 446, 447, 448, 449],
              46 => [450, 451, 452, 453, 454, 455, 456, 457, 458, 459],
              47 => [460, 461, 462, 463, 464, 465, 466, 467, 468, 469],
              48 => [470, 471, 472, 473, 474, 475, 476, 477, 478, 479],
              49 => [480, 481, 482, 483, 484, 485, 486, 487, 488, 489],
              50 => [490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 1],
            }
          end

          it do
            is_expected.to eq [
              [1, 50, 0.05],
            ]
          end
        end
      end
    end
  end
end
