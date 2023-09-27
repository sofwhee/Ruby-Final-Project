require './lib/Square.rb'

describe Square do
  let(:square_tester) { Square.new(["a", "1"]) }

  describe '#childrenify' do
    context 'when called on a square and given another square' do

      let(:parent) { Square.new(["a", "1"]) }
      let(:child) { Square.new(["b", "2"]) }

      it 'adds parent to square"s "parent" attribute' do
        expect { child.childrenify(parent) }.to change { child.parent }.to eq(parent)
      end

      it 'adds child to parents "children" attribute' do
        child.childrenify(parent)
        expect(parent.children[0].data).to eq(child.data)
      end
    end
  end

  describe '#collect_all_parents' do
    
    let(:top_parent) { Square.new(["c", "3"]) }
    let(:mid_parent) { Square.new(["b", "2"]) }
    let(:bot_parent) { Square.new(["a", "1"]) }

    let(:parents) { [bot_parent, mid_parent, top_parent] }

    let(:test_child) { Square.new(["a", "3"]) }

    before do
      test_child.parent = bot_parent
      bot_parent.parent = mid_parent
      mid_parent.parent = top_parent
    end
    
    context 'when has parents [["a", "1"], ["b", "2"], ["c", "3"]]' do
      it 'returns them' do
        expect(test_child.collect_all_parents).to eq(parents)
      end
    end

    context 'when no parents' do
      it 'returns list with nil' do
        expect(top_parent.collect_all_parents).to eq([])
      end
    end
  end

  describe '#has_parent?' do
    context 'when has parent ["a", "1"]' do

      let(:parent_1) { Square.new(["a", "1"]) }
      let(:child) { Square.new(["b", "2"]) }

      before do
        child.childrenify(parent_1)
      end

      context 'and checking for ["a", "1"]' do
        it 'returns true' do
          expect(child.has_parent?(parent_1.data)).to be true
        end
      end

      context 'and checking for ["b", "2"]' do
        it 'returns false' do
          expect(child.has_parent?(["b", "2"])).to be false
        end
      end
    end
  end
  
end