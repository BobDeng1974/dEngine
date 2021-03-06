precision mediump float; 

uniform mat4 modelViewProjectionMatrix;

#ifdef SHADO_MAPPING
	uniform mat4 lightPOVPVMMatrix;
	varying vec4 lightPOVPosition;
#endif

//Provided in model space
uniform vec3 lightPosition;

//Provided in model space
uniform vec3 cameraPosition;


attribute vec3 a_vertex; 
attribute vec3 a_normal; 
attribute vec2 a_texcoord0; 


varying vec3 lightVec; 
varying vec3 halfVec;
varying vec2 v_texcoord; 



#ifdef BUMP_MAPPING
	attribute vec3 a_tangent;
#else
	varying vec3 v_normal ;
#endif

void main(void) 
{
	vec3 tmpVec;
	
	#ifdef BUMP_MAPPING
		
		vec3 a_bitangent = cross(a_normal,a_tangent);
	
		tmpVec =  lightPosition - a_vertex  ;
	
		lightVec.x = dot(tmpVec, a_tangent);
		lightVec.y = dot(tmpVec, a_bitangent);
		lightVec.z = dot(tmpVec, a_normal);
		lightVec = normalize(lightVec);
	
		tmpVec = cameraPosition - a_vertex ;

	
		halfVec.x = dot(tmpVec, a_tangent);
		halfVec.y = dot(tmpVec, a_bitangent);
		halfVec.z = dot(tmpVec, a_normal);

		halfVec = normalize(halfVec);
	
		halfVec = (halfVec + lightVec) /2.0;

		halfVec = normalize(halfVec);
	
	#else
		v_normal = a_normal ;
		
		lightVec = lightPosition - a_vertex ;
		lightVec = normalize(lightVec);
		
		halfVec  = cameraPosition - a_vertex ;
		halfVec = (halfVec + lightVec) /2.0;
		halfVec = normalize(halfVec);
		
	#endif
	
   // Pass through texture coordinate 
   v_texcoord = a_texcoord0.xy; 
      
      // Transform output position 
   gl_Position =   modelViewProjectionMatrix*    vec4(a_vertex,1.0) ;
   
	#ifdef SHADO_MAPPING
		lightPOVPosition  = lightPOVPVMMatrix    *    vec4(a_vertex,1.0) ;
	#endif
}