shader_type canvas_item;
// Ultra-thin organic molecules — pure black on white, 明日方舟 aesthetic

mat3 rot_x(float a){float s=sin(a),c=cos(a);return mat3(vec3(1,0,0),vec3(0,c,-s),vec3(0,s,c));}
mat3 rot_y(float a){float s=sin(a),c=cos(a);return mat3(vec3(c,0,s),vec3(0,1,0),vec3(-s,0,c));}
mat3 rot_z(float a){float s=sin(a),c=cos(a);return mat3(vec3(c,-s,0),vec3(s,c,0),vec3(0,0,1));}

float hash(float n){return fract(sin(n)*43758.5453);}

float sd_sphere(vec3 p,float r){return length(p)-r;}
float sd_stick(vec3 p,vec3 a,vec3 b,float r){
	vec3 ab=b-a,ap=p-a;
	float t=clamp(dot(ap,ab)/dot(ab,ab),0.0,1.0);
	return length(p-(a+t*ab))-r;
}

// ── Ultra-thin molecules ──
// Balls only slightly bigger than sticks

float sdf_benzene(vec3 p){
	float d=1e10;
	for(int i=0;i<6;i++){
		float a=6.2832*float(i)/6.0;
		vec3 pos=vec3(cos(a),sin(a),0.0);
		d=min(d,sd_sphere(p-pos,0.045));
		float a2=6.2832*float((i+1)%6)/6.0;
		d=min(d,sd_stick(p,pos,vec3(cos(a2),sin(a2),0.0),0.012));
	}
	return d;
}

float sdf_pentagon(vec3 p){
	float d=1e10; float s=0.75;
	for(int i=0;i<5;i++){
		float a=6.2832*float(i)/5.0;
		vec3 pos=vec3(cos(a)*s,sin(a)*s,0.0);
		d=min(d,sd_sphere(p-pos,0.04));
		float a2=6.2832*float((i+1)%5)/5.0;
		d=min(d,sd_stick(p,pos,vec3(cos(a2)*s,sin(a2)*s,0.0),0.01));
	}
	return d;
}

float sdf_chain(vec3 p){
	float d=1e10;
	vec3 prev=vec3(0);
	for(int i=0;i<6;i++){
		vec3 cur=vec3(float(i)*0.6-1.5,sin(float(i)*1.9)*0.3,0.0);
		d=min(d,sd_sphere(p-cur,0.035));
		if(i>0)d=min(d,sd_stick(p,prev,cur,0.01));
		prev=cur;
	}
	return d;
}

float sdf_branch(vec3 p){
	float d=sd_sphere(p,0.05);
	for(int i=0;i<3;i++){
		float a=6.2832*float(i)/3.0;
		vec3 mid=vec3(cos(a)*0.7,sin(a)*0.7,0.0);
		vec3 end=vec3(cos(a)*1.3,sin(a)*1.3,0.0);
		d=min(d,sd_sphere(p-mid,0.035));
		d=min(d,sd_sphere(p-end,0.03));
		d=min(d,sd_stick(p,vec3(0),mid,0.008));
		d=min(d,sd_stick(p,mid,end,0.008));
	}
	return d;
}

float sdf_small(vec3 p){
	float d=1e10;
	for(int i=0;i<3;i++){
		vec3 pos=vec3(cos(6.2832*float(i)/3.0)*0.5,sin(6.2832*float(i)/3.0)*0.5,0.0);
		d=min(d,sd_sphere(p-pos,0.03));
		if(i>0)d=min(d,sd_stick(p,vec3(cos(6.2832*float(i-1)/3.0)*0.5,sin(6.2832*float(i-1)/3.0)*0.5,0.0),pos,0.008));
	}
	return d;
}

float sdf_mol(vec3 p,int t){
	if(t==0)return sdf_benzene(p);if(t==1)return sdf_pentagon(p);
	if(t==2)return sdf_chain(p);if(t==3)return sdf_branch(p);return sdf_small(p);
}

// ── Scene ──
float scene_sdf(vec3 p){
	float d=1e10;float t=TIME*0.2;
	for(int i=0;i<12;i++){
		float fi=float(i);
		float h0=hash(fi*3.71),h1=hash(fi*7.13),h2=hash(fi*11.37),h3=hash(fi*13.91),h4=hash(fi*17.53);
		float base_x=(h0-0.5)*16.0;
		float ox=sin(t*(0.5+h2*0.6)+fi*2.1)*(2.0+h3*2.5);
		float oz=cos(t*(0.35+h4*0.4)+fi*3.3)*(1.5+h1*2.0);
		float sp=0.4+h1*0.5,ph=h0*6.2832;
		float y=mod(t*sp+ph,1.0)*20.0-9.0;
		float fade=smoothstep(-9.0,-6.0,y)*smoothstep(9.0,6.0,y);
		float sc=(0.55+h2*0.5)*fade;
		if(sc<0.01)continue;
		vec3 pos=vec3(base_x+ox,y,oz);
		float rs=0.2+h3*0.4;
		mat3 rot=rot_z(t*rs*0.5+fi*1.7)*rot_x(t*rs*0.8+fi*2.3)*rot_y(t*rs*0.6+h1*6.0);
		vec3 q=rot*(p-pos)/sc;
		d=min(d,sdf_mol(q,int(h4*5.0))*sc);
	}
	return d;
}

vec3 norm(vec3 p){
	vec2 e=vec2(0.003,0);return normalize(vec3(scene_sdf(p+e.xyy)-scene_sdf(p-e.xyy),scene_sdf(p+e.yxy)-scene_sdf(p-e.yxy),scene_sdf(p+e.yyx)-scene_sdf(p-e.yyx)));
}

void fragment(){
	vec2 uv=UV*2.0-1.0;
	vec3 ro=vec3(0,0,10),rd=normalize(vec3(uv,-2.8));
	// Camera sway
	ro=rot_x(sin(TIME*0.06)*0.04)*ro;rd=rot_x(sin(TIME*0.06)*0.04)*rd;

	float t=0.5;bool hit=false;float ht=30.0;
	for(int i=0;i<48;i++){
		vec3 p=ro+rd*t;float d=scene_sdf(p);
		if(d<0.003){hit=true;ht=t;break;}
		if(t>30.0)break;t+=max(d,0.01);
	}

	vec3 col=vec3(1.0);
	if(hit){
		vec3 p=ro+rd*ht,n=norm(p);
		float diff=max(dot(n,normalize(vec3(1,1.5,1))),0.0)*0.5+0.5;
		col=vec3(diff*0.15); // near-black with subtle shading
		// Specular dot
		vec3 h=normalize(vec3(1,1.5,1)-rd);
		col+=vec3(pow(max(dot(n,h),0.0),48.0)*0.3);
	}
	// No vignette — pure white background

	COLOR=vec4(clamp(col,vec3(0),vec3(1)),1.0);
}
