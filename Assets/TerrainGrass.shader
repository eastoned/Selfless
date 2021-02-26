// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/TerrainEngine/Details/WavingDoublePass"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("Base (RGB) Alpha (A)", 2D) = "white" {}
		_WavingTint("Fade Color", Color) = (0.7019608,0.6,0.5019608,0)
		_WaveAndDistance("Wave and distance", Vector) = (12,3.6,1,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Grass"  "Queue" = "Geometry+200" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#include "TerrainEngine.cginc"
		#pragma surface surf Lambert keepalpha exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float3 ballpos;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult48 = (float4(( ( ase_worldPos.x - ballpos.x ) * -1.0 ) , 0.0 , ( ( ase_worldPos.z - ballpos.z ) * -1.0 ) , 0.0));
			float4 temp_cast_0 = (0.0).xxxx;
			float4 transform16 = mul(unity_ObjectToWorld,float4( ballpos , 0.0 ));
			float clampResult40 = clamp( (0.0 + (distance( transform16 , float4( ase_worldPos , 0.0 ) ) - 0.0) * (1.0 - 0.0) / (20.0 - 0.0)) , 0.0 , 1.0 );
			float4 lerpResult29 = lerp( appendResult48 , temp_cast_0 , clampResult40);
			float4 localWavingGrassVert1 = ( lerpResult29 );
			float In01 = 0;
			WavingGrassVert(v);
			v.vertex.xyz += localWavingGrassVert1.xyz * _SinTime.x;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_5_0 = ( i.vertexColor * tex2D( _MainTex, uv_MainTex ) );
			float grayscale57 = Luminance((temp_output_5_0).rgb);
			float3 temp_cast_0 = (grayscale57).xxx;
			o.Albedo = temp_cast_0;
			float temp_output_7_0 = (temp_output_5_0).a;
			o.Alpha = temp_output_7_0;
			clip( temp_output_7_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
417;75;1019;506;2194.043;-578.1329;1;False;False
Node;AmplifyShaderEditor.Vector3Node;19;-2325.644,306.366;Float;False;Global;ballpos;ball pos;4;0;Create;True;0;0;False;0;0,0,0;10.10267,12.88,-9.065548;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;16;-1989.561,51.8849;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;22;-2356.966,498.2551;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;51;-2078.69,883.8013;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1740.96,266.346;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1635.855,198.6252;Float;False;Constant;_maskingDist;maskingDist;4;0;Create;True;0;0;False;0;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-2006.914,716.707;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;21;-1662.462,64.04786;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;15;-942.3561,-350.1815;Float;False;745.3594;463.1875;;5;3;4;5;6;7;Coloring Grass;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1731.647,387.3683;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1877.097,827.6993;Float;False;Constant;_offset;offset;4;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;23;-1366.914,184.886;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-892.3561,-116.9941;Float;True;Property;_MainTex;Base (RGB) Alpha (A);1;0;Create;False;0;0;False;0;None;6a0ae1d7892333142aeb09585572202c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1630.768,780.4287;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;4;-852.9967,-300.1815;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-1617.02,908.5086;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-598.9968,-219.1816;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;40;-1132.048,275.1918;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;48;-1299.153,729.5338;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;6;-433.9969,-226.1816;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;14;-840.7857,365.3107;Float;False;474;205;;1;1;Calling internal Terrain setup function ;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;29;-1028.128,980.238;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;13;-1400.736,-444.6043;Float;False;305.2772;457.5596;;2;11;12;Turn Grass Globals into Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;12;-1345.459,-194.0447;Float;False;Property;_WaveAndDistance;Wave and distance;3;0;Fetch;False;0;0;True;0;12,3.6,1,1;12,3.6,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1528.739,571.1615;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-1350.736,-394.6043;Float;False;Property;_WavingTint;Fade Color;2;0;Fetch;False;0;0;True;0;0.7019608,0.6,0.5019608,0;0.7019608,0.6,0.5019608,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;45;-1740.864,542.2753;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;57;-122.9909,-203.2041;Float;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;36;-1953.352,411.962;Float;False;Constant;_Vector2;Vector 2;4;0;Create;True;0;0;False;0;0,10,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;28;-541.6689,1236.299;Float;False;Constant;_Color1;Color 1;4;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;20;-252.349,751.7742;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;7;-441.9969,-132.1816;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-605.4918,1025.343;Float;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;44;-1994.364,572.8803;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;1;-609.404,409.9487;Float;False;WavingGrassVert(v)@;1;True;1;True;In0;FLOAT;0;In;;Float;WavingGrassVert;False;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;87.68493,-220.8903;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;Hidden/TerrainEngine/Details/WavingDoublePass;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;200;True;Grass;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;1;Include;TerrainEngine.cginc;False;;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;19;0
WireConnection;51;0;22;3
WireConnection;51;1;19;3
WireConnection;49;0;22;1
WireConnection;49;1;19;1
WireConnection;21;0;16;0
WireConnection;21;1;22;0
WireConnection;23;0;21;0
WireConnection;23;1;41;0
WireConnection;23;2;43;0
WireConnection;23;3;41;0
WireConnection;23;4;42;0
WireConnection;50;0;49;0
WireConnection;50;1;47;0
WireConnection;52;0;51;0
WireConnection;52;1;47;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;40;0;23;0
WireConnection;40;1;41;0
WireConnection;40;2;42;0
WireConnection;48;0;50;0
WireConnection;48;2;52;0
WireConnection;6;0;5;0
WireConnection;29;0;48;0
WireConnection;29;1;41;0
WireConnection;29;2;40;0
WireConnection;46;0;45;0
WireConnection;45;0;36;3
WireConnection;45;1;44;2
WireConnection;57;0;6;0
WireConnection;20;0;27;0
WireConnection;20;1;28;0
WireConnection;20;2;40;0
WireConnection;7;0;5;0
WireConnection;1;0;29;0
WireConnection;0;0;57;0
WireConnection;0;9;7;0
WireConnection;0;10;7;0
WireConnection;0;11;1;0
ASEEND*/
//CHKSM=46636CAFCD61E11CDDC6A70749D77634A64DDB02