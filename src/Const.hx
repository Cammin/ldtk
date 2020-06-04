class Const {
	public static var APP_VERSION = "0.1";
	public static var FPS = 60;
	public static var SCALE = 1.0;
	public static var GRID = 16;

	static var _uniq = 0;
	public static var NEXT_UNIQ(get,never) : Int; static inline function get_NEXT_UNIQ() return _uniq++;
	public static var INFINITE = 999999;

	static var _inc = 0;
	public static var DP_MAIN = _inc++;
	public static var DP_UI = _inc++;
}
