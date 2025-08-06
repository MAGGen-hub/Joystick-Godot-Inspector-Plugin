shader_type canvas_item;

#define LINE_CLR  vec4(0.216,0.231,0.259,1)
#define LINE_CLR2 vec4(0.216,0.231,0.259,1)

#define BACK_CLR  vec4(0.114,0.131,0.161,1)
#define SQUARE_CLR vec4(0.129,0.149,0.18,1)

uniform bool radial = false;
uniform float limit = 2.0;
uniform vec2 dot_pos = vec2(0,0);

vec4 draw(vec2 uv){
	const float line_size = 0.005;
	const float point_size = 0.02;

	float div2 = limit*2.;
	vec2 uv_f = fract((uv*div2));
	float line_size_div = line_size * div2;
	vec4 color = BACK_CLR;//vec4(0.129,0.149,0.18,1.0);
	//if (abs(uv.x)>0.485 || abs(uv.y)>0.485){
		//return BACK_CLR;
	//}
	if (radial){
		//if (dot(uv,uv) > 0.26){ // same to (uv.x^2 + uv.y^2) > 0.5^2
			//return BACK_CLR;
		//}else{
			//draw_cicle
			float fract_len = fract(length(uv*div2));
			if (fract_len<line_size_div || 1. - fract_len<line_size_div){ color = LINE_CLR; }
			//draw lines
			if (abs(uv.x)-abs(uv.y)<line_size*2. && abs(uv.y)-abs(uv.x)<line_size*2.){color = LINE_CLR;}
			if (uv.x<0.0075 && uv.x>-0.0075){ color += LINE_CLR; }
			if (uv.y<0.0075 && uv.y>-0.0075){ color += LINE_CLR; }
		//}
	}
	else{
		if (uv_f.x<line_size_div || 1.-uv_f.x<line_size_div){ color = LINE_CLR; }
		if (uv_f.y<line_size_div || 1.-uv_f.y<line_size_div){ color += LINE_CLR; }
	}
	//draw point
	vec2 actual_pos = dot_pos;// / div2;
	if (uv.x<actual_pos.x+point_size &&  uv.x>actual_pos.x-point_size &&
		uv.y<-actual_pos.y+point_size &&  uv.y>-actual_pos.y-point_size){
		color = vec4(1,1,1,1);
	}
	return color;
}

void fragment(){
	vec2 uv = UV-0.5;
	COLOR = draw(uv);
}
