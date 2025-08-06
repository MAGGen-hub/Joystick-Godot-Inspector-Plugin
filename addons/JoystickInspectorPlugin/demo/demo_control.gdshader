shader_type canvas_item;

uniform vec3 off = vec3(0,0,0);

bool is_in_circle(vec2 uv,vec2 circle_pos, float rad){
	vec2 c_pos = uv - circle_pos;
	if (dot(c_pos,c_pos) < rad*rad){ return true; }
	return false;
}
#define eye_pos vec2(-0.168,0.011)
#define eye_rad 0.072
void fragment() {
	vec2 uv = UV - 0.5;
	if (is_in_circle(uv, eye_pos,eye_rad)||
		is_in_circle(uv, eye_pos*vec2(-1,1),eye_rad)){
		COLOR = vec4(1);
		vec2 pos2 = off.xy/100.*6.-vec2(eye_pos.x,-eye_pos.y);
		if (is_in_circle(uv*sign(vec2(uv.x,1)),pos2,eye_rad*2./3.)){
			COLOR = vec4(0.255,0.251,0.259,1);
		}
	}
}
