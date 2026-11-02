Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634816;
	b=kEIARaPzoX6W5G179HYoEtgli+5Edk9oGLDR6eLlKb1Eja2j/4eN5TtfN6l1xmVYN/0U
	 jEjCJwuo4IO3KpgcFF+/xlNgLO/M1AWozn0iuJbMZT5XocEbqIWq0yQdd5wGHAsOrwSi1
	 mKUSNvGcUAfB8NAHZ6mS9JKdMaANy/Air4VBN/Sat4EXW9j/1f9EmR7eU/JgolstG9iXa
	 PBl1eTYUcFnOqR30QaB4o26akL147MjQVoqg7PWOc7hbgOXlalD2QDtHaaU9wQyBzbBvu
	 X07a5RgmmesojmGn9NhAXw0ItGUYNXg0DXD8414FSyOHsjr7fMY4lNlLQswM+NfKU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/DSZu+jbu0jZeeLie9bN2MaVWrbMxbYdgLjXWmOrZjk=;
	b=t4B+9OTxK3B1hqu7VGkYJsz+PzMtbmPfiOG+lmF8M7xkQPovIgw1TZWP0UXvSpu7lhdD
	 Ule8kCWQXbd+c9lBHD9hB0u1vX6QDxMuON421ApiJqKOcDoHftbX3fS3NxbcwvI6/O8Fr
	 Pdt7td+gU/TdJftrKGBM6bfXAQj5xJKRO8o6SwJyp6IaOEX463Uka2eEyjxb0Ut/4uXrK
	 Z32bz3F1abLHE47D1giF+gkBCxXMT57Z3MyN/pW6eFjAnPzeb6Mo1/Yrrwg0i7CWgi0ws
	 uA5xYkP61BgYEXSX+h7jeK1kuZf53AqsJ6DRSsu14bF9S6dGyE0jWdK2hITOgqcHGHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="lvZUvyh/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VRElx68b;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726260B426D
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8726260B426D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lvZUvyh/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VRElx68b
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpSM3846155
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/DSZu+jbu0jZeeLie9bN2MaVWrbMxbYdgLjXWmOrZjk=; b=lvZUvyh/4y5sbOXg
	zTDlK/T81S2vA2XvHRTKpYgzmJNOxFk8WmQjV//HFH07iH30e36PEgrzYHni4ieL
	R/z8DgNyJqOiNzjqePLBeIXv1HBZp7drIrcJItLfoWkEwvakS6hU6aqj7K7G4qnu
	6YIdJAybxD/vs6VST/oAe8IlO21U8JRLe5b2EwvSWaAZlYjzIpbwLqRtey5r6rdQ
	ezpBsYODYWbhzWT8P51CTKTedoZRmG3cXWqxY9UBCsPw4pcgX+LExFvs4VxT1lTA
	Wu4keEGUwEPa/T2epOv4v1KoSEnmyktEYyVm5EhgXMAmwuyvu3BM5CPm+jxJYxF0
	g2QIkQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1tg59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc48fbca26so496117137.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634814; x=1794239614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DSZu+jbu0jZeeLie9bN2MaVWrbMxbYdgLjXWmOrZjk=;
        b=VRElx68b2ro3YuLyW3vcW/wMsbk9Skc8D2JYROIFf71AzaD4JztdTzK0fVG8B7IdSY
         qqM4PH/3lU99LmHZtllQc171TiB4zLffUpiXdxPJSMQeF7cl5LMTVaWk7vLzrwb/dzQR
         9iIy52tNV0WO9kB4BSe4fMLskU5XCtsMFtqNPfQ8WDeD/9WIdYDjkAi4G4p9FWj/vgu8
         73GFlWviaPQ3Gxjr3n5h+pvrRAmCch6fhQxLhiP9egukpi65rfrgf3Z0z2oU6ZT+wSBO
         c3slcWZ2B+eobKIckzCh12w4It5FLwV3GeGQx7IblWuZJwN4kJYpY+kW3kzP2jzORQfA
         30xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634814; x=1794239614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DSZu+jbu0jZeeLie9bN2MaVWrbMxbYdgLjXWmOrZjk=;
        b=z8N+VXn7pQXkrVxUimbGLBZUSo7QtF0RLakoDJ1gL2VFh7Qg/EQ8pRUnkegWAv0PLD
         pqH0YzTC9tKONDa1Lp3wE6q5AHkYXlMKESWzBlgz7LuRp32gpQ83CNXBvykxmQFvvmdK
         Lq9Da1Rt7B9hrne3aOa0VX3FgoYDuVVMxorRFffjKY23AVbdm/WrLzHMtwbZrx2sNAzw
         WbavYGIlx0aeC+O/8Amxe0jGrBikZBNsgsTJVOtySFUr/gudBGu/fsTCpKgNwtEVVuz1
         CB7TRVHCcZ0SgdLrZAivKccXsFklHmXZwO1v879aP02QbLZPm9St7XaI79/R5fuIQn7P
         sm0A==
X-Forwarded-Encrypted: i=1; AKwUvBzJe4Ec5rTKsR86ZGj68MzGMz6Bv6SWknmGQeaVYRtifhjKuSmkue1lWo2CMAI2M+0cKdsM1paVF06x01eRQ1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/47bJuYev8pRnjLKm4yHeyioJum9VxyA6D0Rxx5/7WsaBKwKL0
	lf0ylRxCZb7lky1hHKuZ/SXVes/INoNSzOElb5WXLmU5er9KpW9ahAQ8DCXhvMl5Euuidk0HfKN
	GZQ0q+rFWkrFGaIrNE48pQaxpctnA2aR9Cmg10t9vbRdoi5nFiTNsiiDbeQlM+NWd8/I3m3E=
X-Gm-Gg: AYBFou3LMcICu1LtaINSi0qbVL40P2FCBgLuGxcVST03tb+sah5SKdn63mg1rbGoMwz
	I3IOYdZ1Bk5suJ8a9z36aHLrg+Ngf6hb+Fm7IElGR7DZ6cxE6qD0+2CDYu5CKgoqjRbEd/QZuuw
	XR6SMG925611GwLtzZXwAnjVEahUtUXTokTuuj/pcnSegx2qxsE1WSo7OZRhfRRPpIXgo7MiDNO
	44mjJdT5KK630bhp5aLXfIREB+uTsSwRu0mgXb8IgB9+9jzFyG+LRdK841CuvLnkTKoK1XhrSa9
	85rOofjzy1uOIWpE7EqAP6DfY9t3pkrtaI6Buh5kF9nXcPBXjYQ97IUYu+6CkJEgFlUNRgixH6/
	sUqUfo4UwMXCeBFGO0fPexvQZ9Yw6Kk8+ucigOjhmXvcqJfzDcAZe0Xp78inuZKGmDE/f+6YcSo
	1ywudJ7XON7c8mRNFReHbff3bATRnirO6EU33NA0kyxNiyyitF7rWJ3/f/REPwOl9IcsY76ZcvO
	RP6Rc5fPfdBL25KBBHL5hLMmbU7
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id ada2fe7eead31-7d0725cefa6mr4035697137.10.1793634813802;
        Mon, 02 Nov 2026 07:53:33 -0800 (PST)
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id ada2fe7eead31-7d0725cefa6mr4035677137.10.1793634813226;
        Mon, 02 Nov 2026 07:53:33 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:32 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:39 +0100
Subject: [PATCH v12 8/9] arm64: dts: qcom: shikra: Add OPE node
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
Message-Id: <20261102-camss-isp-ope-v12-8-702254689feb@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
In-Reply-To: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: hFhCWhOqnvUvT5G_esOICJzE6_9ZIPcc
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8b1fe cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX6xh4j3DiiHYx
 8Y8HipZBt3a/EQQ5lh2qvDoSSqfcfZvUMdSvrlLhQ/laPCY1H8KxPdCqat5K7ZfGOhWkOnBN78k
 ABRqDaS9+jbui8cysI1BMaZhYgJiRsVyNTYAYPWrEMJY5TKuQa25WVTN5xFZzmlZxL7UJvab4Jr
 hSaVHRrEo+9WUCLDdYt4eSHFNyADSw9UjAy8wZxQUmo3FGXg1lROuLsEwwiMDX1W0nM3I0EmlgF
 jMJFEqoSI/jjDVU0UgSnF1Vnpoz/yizubgk2747G+nTMh6+IkRu3MPhAFdStVzQHH6F208fbme8
 23KVJP2FCFsfWkU6Qp3BSQQV/fO5mBpdKFnYjMoc+zQ7ZVQigzaASY94N5kDJ8sIkF8QeP4y8uv
 ekoUkjwPAde3QvQHyGA9bf7RxDO0x0GrUvshid6gI93367rTXIWnF99SdV/blvWc++tk3spK3w+
 hPMYMM2T56SrYWmRD0Q==
X-Proofpoint-GUID: hFhCWhOqnvUvT5G_esOICJzE6_9ZIPcc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX9xvHSrhd3+b4
 +WAAA1VpEdNLyT2cRcbl3AEim9S2XXXivLJSBetHSIxkox6Ios/ca0S/smAevGOglNjb5lYT6YO
 jK/NqNuyXGGDpdSha7xVTX4chYu7lBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add the Offline Processing Engine (OPE) device tree node for Shikra.
The node describes the six register regions (cdm, top, qos, pipeline,
bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Shikra boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
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

