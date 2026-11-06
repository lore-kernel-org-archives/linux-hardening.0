Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973355;
	b=mnDy6KyYLzUKHsiVIJ28pqO2tGFpJ2sPAErEkdYotyfmi/oLD/RXjK1c4GsIMwnpXRKi
	 nNBfHGXFxt0ER/nfoNZAAwoQlqOBij9BIAIL0dzQFa95BFlEJcv2sb+AnQmTdV2WFr9b8
	 b+JtLwEvC+d8VoNYP4DUCKBrEIjFuD9wonE5rKv6SsdDa2yIf6EGVSlLtIFhHGZfqp83/
	 josaFaSLijNbvx7qAlr7dXIXnUD5LZCksWKJmNcnD8zCtnchdxLICxHcA3r/5jos+YR+O
	 yihJipvqHh8qq8pzDHL/wXW77M95BjSc7mKHpkDCGxtDxBcsU56TXPT04ArXh0SbxfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
	b=FecP9yF4cHqbjaljZpxwlRRPfEuO6xkFINmXRDVNcBtvVsVAJEyfQxp2uZvA6ZSGb/t/
	 cpUfNqK5OVJl2F73q1ynY4EwKOMGsFXjnfMDsdp6N64tkJJrbZ5OlNAc/6ORBCC418+5x
	 3TTsSDisgql3wZFbV6UkYqI1WVQdeFBIAGKHzfpHZ3V4hmxqVmLnLrA5Xs1FqEAgKRnM1
	 lr8/HUPB6n1aWPylHjAnAVkvuKEyKLDXoKi+cq2Cy6cWNFixnE1UiYeMJ0T6kvwT6qUBT
	 gIi5FWr6uap3igX3HWJSyrCzuPj/O56z5KMpF6QYncxywlthCrwCp1V65TyGbwZ8rEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dyvZCes6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="M/fUQvmd";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99B6083605
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A99B6083605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dyvZCes6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M/fUQvmd
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoQTw3571235
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=; b=dyvZCes6NiGDy9LV
	nUkUVCjJMmXfm323NRoS1JsUVpuUzvl9IIm9NBvE8Hiz8T5hMLIfx5h/xxxg7Q0R
	pY2BwAAhJiN48FdCL8uA9uLulO22LtIkJol+K8HgXsIhmimsFKfUtdsoMCx4TapB
	/YPhMV0I4poiY5Q6eon8Oy8GEhwUoAqvROaaEiavncEeVdn0peOD4XevxC+WUpEs
	08ikHwCorLjGCa6Geltc30VsuA0MLAv7mZmD7nqXjmcRlbbC8yNt2u2WYJVwtLNm
	Cea9hRIJNWnegv78qXy13PyjUtzWkRXR8OeYeOs9Var6JVqvjvOnmV4wsD74/VAY
	FxgVmg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9jyk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d07a14a71cso594110137.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973352; x=1794578152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
        b=M/fUQvmdyMMOSWuozEROiD9HZycoYf6ajE8JXqMLdB0p2OMoabnym/CSFRuoKVUXDu
         j0riQG3I1RbQY8R/xmIB/QEjVq/Br1wE/Vy3+++cFGnOhVSoFXmUoxOHqCk8xQL5547c
         E4nsbJMtzVi3kznXOiaUs4BIuAFOS7qZqoAVssRULwBIYyUBRp7WmXxSr1sa4ssldKKV
         kGjtJ5YLdpzLStcUxVmlMPfGsTfXD3kd9eJqLlIlK1NTqTzMc8bvKFEf8Hd4mGHEk9Xr
         S8FRq6E0ggkDqCKQ52J+8rRMDY5XSo2rjO5pQougXMO5OhqXea/Gdx6z4oD3gTI/o6Oo
         71Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973352; x=1794578152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
        b=S6UJnWQVlr0QorlThtYdfHaVV8bagkT5foH6WwbZE5cgPhPPqwua2K28JTawFuZNRG
         MFkbgaNEFezxP0E2v+AxyyJOaEBwG/f1B9F0JtXVwsO6hHTWaByoZqbH95kiwff21XrR
         b+pSc0wQqlw1ARle+9tpQhtcxW/WbfJdJuOEDYbqMT/vgVndUsbuTah9n0CCOlyWifCw
         MqmHfG6+JW97BtEOmHnnIyznSUIsuhfpicKOSRamdGxEkKcPn/orwTWJRraARZpFD4Hf
         3wKIPGMTajrSJJBu8jKJ25OrGkzBtrCYXVaOuaBGayJfwWG6yDp4Y7zRmi2klOPRTljl
         Ktfg==
X-Forwarded-Encrypted: i=1; AKwUvBxQL96xD4NN0JAC5//A4S5viI7GB4E+lbjrFa68ivjwyB0qVBvZVfHTMmwd9rMIdjOX/FSixB9IeHf4HkP60nk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vaJpEEsosErrE+C4iWzNxqNKEIYYOW0XxPw627M/h3nkzwchn
	ayahB4gUW97Gk5D/gvGewopfWIa03PI9r3svyrdBMoztUw+Z9G0OseyOZ3xD2ogjcJcutwpPCGz
	ZEKm7txH4gkOaIMiT4z3X0nveEYsiuab3ifhVS6PkyeF8CrtnjLKP732Y2lhhlbKexkXf1UQ=
X-Gm-Gg: AYBFou0Ff7SFwHo5Q4UvC+z2AALlv1lKeqBHk6ENjBVmfE2zJC/ylNCj+OZkQRmpOFa
	+56LDQZ+twVraSBOgEPaSdOLuNhlXdpOAVisMXjsd2QDhbAMob6oM4Uhe5BgnQKSm3eCrO8dWGV
	lRa12GZ7WTy9vtI5sJw8dvM365CwlVZ5cv4lpWlULLp8+lGIWTiKSpQ87kKedtWuMGPNR9f8tEY
	sRNA4KL7LYIKQtmcPA5VnIKm0CCgZirLix8ddi5pdphW7Fddboss0BnPj/RLYSoUgwZDYX6vl29
	T6Vo/sN9u/vyATUJsrVjU+kRIrNFNbQ40gPrRnj9vv+gL0cbn1s+8JSVj/S1DphKh3XXB3gUFgY
	HHIiE3ttp0I4s/Tih0BPxJzv/C6OwyfwTPxjtfmSynsf674ErJlg8mSndWjPWf6fNxOIuY+bYmU
	fnSb5Lw+yCXS8S3PF+fR81B0SN6QoideZ0fChzIUTm5ZcpPmFgiy3llvEKSAvrrMTmvhekf6D0K
	0sYLkqYWGG8PPFmHs2rc2dGe7g+
X-Received: by 2002:a67:e712:0:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d2a1700630mr1387930137.36.1793973352447;
        Fri, 06 Nov 2026 05:55:52 -0800 (PST)
X-Received: by 2002:a67:e712:0:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d2a1700630mr1387915137.36.1793973351926;
        Fri, 06 Nov 2026 05:55:51 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:48 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:24 +0100
Subject: [PATCH v14 8/9] arm64: dts: qcom: shikra: Add OPE node
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-camss-isp-ope-v14-8-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: NSRmLVOMGCLOYSQtclrsTHPA-imtbWxh
X-Proofpoint-GUID: NSRmLVOMGCLOYSQtclrsTHPA-imtbWxh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX5wAHbWMsE0uu
 bFuheMBtCI9/An9N7DE23yMIOUq6NbQpJv2dQBVkEAxDxW8TG4KDqMqbohYuXv/4rVlYCQu/OOe
 CXqCMmqA48ZC5xM/9qbdKUmx1aDvuGo=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aeddc69 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX/7jMFUCbHj/O
 Z6OBl46HXBDZGtFXaADYE8Kk6B6Jy/MB24riZl62uJuQA8zR6hKDNCE2wlHhfRe8Qe4mmjBSy5v
 kASNMD3VHLu8bq4ERBYJgcD56FY0pat0eC3wuS22OIYY7kozM35uUoVyW8iLtaJtGi8VB6oSLlK
 YFHvRIjJpZaIrH5Bd4qHlenywQbGbE203NJVcJcV2R85UvS/f/eM4eV3CaYATT5Gpz2U+9p+InZ
 237lSv6eEhQDUOMNiMlEVU3o+/o/JfEFVKNi+DhkLtdK9mDuYyTmejGo1L13hus0dsK/71+cdEN
 NkXCnLYijm1/IboaNb6uXxkG3QcEnCjDp2jdVXmv2N0jRsgHwPY38/yj38qIMVjT51Ofljlc1wm
 yxCPlXYnKUu5c/90cnDwll2xa8SPLoHx30Wuvp3ltwEDKaKzzoXG9T/E76RyFI5oBmv25zzReoA
 5lEg4iBCGFMr5/Hb8Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add the Offline Processing Engine (OPE) device tree node for Shikra.
The node describes the six register regions (cdm, top, qos, pipeline,
bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Shikra boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> #Shikra CQM
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2623e139196f6398c57b616879a37f84b83d59ac..b95ad1e61b9b4ecd29a1b7b7fb0c2c52ce31a967 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2357,6 +2357,83 @@ cci_i2c1: i2c-bus@1 {
 			};
 		};
 
+		isp_ope: isp@5c42000 {
+			compatible = "qcom,shikra-camss-ope", "qcom,qcm2290-camss-ope";
+
+			reg = <0x0 0x5c42000 0x0 0x400>,
+			      <0x0 0x5c42400 0x0 0x200>,
+			      <0x0 0x5c42600 0x0 0x200>,
+			      <0x0 0x5c42800 0x0 0x4400>,
+			      <0x0 0x5c46c00 0x0 0x190>,
+			      <0x0 0x5c46d90 0x0 0xa00>;
+			reg-names = "cdm",
+				    "top",
+				    "qos",
+				    "pipeline",
+				    "bus_read",
+				    "bus_write";
+
+			clocks = <&gcc GCC_CAMSS_AXI_CLK>,
+				 <&gcc GCC_CAMSS_OPE_CLK>,
+				 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
+				 <&gcc GCC_CAMSS_NRT_AXI_CLK>,
+				 <&gcc GCC_CAMSS_TOP_AHB_CLK>;
+			clock-names = "axi",
+				      "core",
+				      "iface",
+				      "nrt",
+				      "top";
+
+			interrupts = <GIC_SPI 209 IRQ_TYPE_EDGE_RISING 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "config",
+					     "data";
+
+			iommus = <&apps_smmu 0x600 0x0>,
+				 <&apps_smmu 0x620 0x0>,
+				 <&apps_smmu 0x640 0x0>;
+
+			operating-points-v2 = <&ope_opp_table>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+					<&rpmpd RPMPD_VDDCX>;
+			power-domain-names = "camss",
+					     "cx";
+
+			ope_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmpd_opp_min_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-266600000 {
+					opp-hz = /bits/ 64 <266600000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+
+				opp-465000000 {
+					opp-hz = /bits/ 64 <465000000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+
+				opp-580000000 {
+					opp-hz = /bits/ 64 <580000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					turbo-mode;
+				};
+			};
+		};
+
 		remoteproc_mpss: remoteproc@6080000 {
 			compatible = "qcom,shikra-mpss-pas";
 			reg = <0x0 0x06080000 0x0 0x100>;

-- 
2.34.1

