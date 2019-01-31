package msearch;

public class Pairs<L,R> {
	private final L left;
	private final R right;
	
	public Pairs(L left, R right) {
		super();
		this.left = left;
		this.right = right;
	}
	public L getLeft() {
		return left;
	}
	public R getRight() {
		return right;
	}
	
	
}
