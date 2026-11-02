Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634814;
	b=uW4fG+Gy/4Ju0q8VuVE7r3pzInQpa3njgIklrQBow3OaP50bFEFZGs6CPVFD2PCxSHYs
	 5zEOagMaOViFv37YNdUwJc92bNUWrybn17KidhQIS2c805lC7gt9BMoFJU40BX7ufnfps
	 yj2nk/SqTqZOZkaH88TRji0u8G7v4ZP0q8jDygR9cjDpy4FQZ7hn1f1S7eE+Pm4EuQ+jW
	 DOM4qgjl5XtkH3XhvPYNwki/9PnyzxD+BIkAfakCsZuju7hW5EAuG6GbEigVjsNw7cTZf
	 0gI/toBKJn5Ym18hd6YnhlhyG4UywBvRbP8Ci3G02KflxexJnpjEe7MMo5J0m10rNTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2Yqb8w77911HPId3dxP6CpINfJB91u8DEDhhhf4QlPo=;
	b=t1VPFQlFDSQ6/Q2Wmv+JX2ebPXrbr3A4giyDYPTLCovF7NR7q+g3aem/PEeqxj516DPy
	 jVNkzLKomc1jtdNSXazTtDAZVQzsWF4rxCbo9X4deiHcTX50cCkfKFQM0sM2R9j9mjJWN
	 HBFdL8W+bd7y6Ec+D1489AokwcqD7oekinVcvG1FnQIEPqr+jwDpsN0BU0VhE1T4tbh6s
	 12vlLjYRuuhgqlgspoGrBMjDEvPyOQo4Hd4I8ocTrVCju91y2/pwHsOEpxSLgWyCVXE/R
	 sqpGpIjxbWK09Ep7KxM2Pqu3fiVkNS59p7VBWne4htGhsdDYUJxoIstWcGZalQF/4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G+CObwbX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wcy6Ufrk;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204460B4248
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E204460B4248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G+CObwbX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wcy6Ufrk
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpBqh4033926
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Yqb8w77911HPId3dxP6CpINfJB91u8DEDhhhf4QlPo=; b=G+CObwbX/Gmg+pZ4
	fognyXMh0IC2dT0SEtBOqA3W5rLWfbUixeNS9VHb+YeFE6zdOuzltBj9CJT3qljG
	Mbxn69/NvckEtVEAEUO2kkgzYKZpEU0Kn7almUd8SSgVKMVICe/7IEhwCGSWe/8m
	mj62r7hQfvurb89H6G27Qg42J2ABelwBTrtz0wmPAyJZqOl+QE/Y4nefcTbtrS94
	DdRyPHFlUnDSvwScaNjfDRvrHCnH1DbJORSFHqBK3pT5hDnYfCfR48BT92VfvEpl
	j4AZu5yP7YBs0DIuX7N+1TfVlgzLzCrR5YguDrSMjIn4/8kcbUaHYoArTNyzttJC
	zOyeVg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe9ybn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c10b8abe29so2535870137.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634812; x=1794239612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Yqb8w77911HPId3dxP6CpINfJB91u8DEDhhhf4QlPo=;
        b=Wcy6Ufrkq+Y8ltAuJRUPYHqbcZlRyib+cZCa9vquHjVuSTGSbjie5a8kkJVezRbM3d
         xA/65zZT03Z/Bdq8WnDne9w3POonpbzgq2v8GgAR1v2V3y0N4ztQh2Hys7DQfh1rNaby
         n4gHT9HEtBrodrCgYRVgYyCQdlamAQqudS7syI3LP6H2BVM05BIkFvR7LIk7kE3khfuQ
         LoI92P42bgVMplpVvO6MdKUmQ5hAJft2qQ4K1woV8sbq4v2xflBHGVv+XGQPMlm5x88a
         IKC8JJNo4cSwTeVz9s8YhqINGc2wIeWnOxPS7k7FpE/q5HkjpDPKxIFmjR63p0hDs4v+
         KnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634812; x=1794239612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Yqb8w77911HPId3dxP6CpINfJB91u8DEDhhhf4QlPo=;
        b=cYPeYgRsgiFNV6Tzob1XT269lanCBRUE1uby1nxhD4Eduvr6LyxhvHJtTCgYy2q/9f
         zaL3d4TZV8vNIrasp2/OrdkCnENDXYu5081p1ZCmtLDr6UmNwiyzvteDnu88ZmYJwITq
         XOPp+tsYZ5DAIuDe88QpSkvl1vG957EUSjA+sSJnQybIzCvCyIyy5olmhBIhI/ngzD8l
         jS8j6f8nEaRzbNMWESr/DfuFKCBSa19ihzxRsfLmAuURKwwigXorl/Alb+AdxDplh9I6
         x3upmhsGpRWXgsBBGxzTQT8ghWw6Eluqih5Iz075W3xuE49xLh2vULEcnXGe/ogiRdkh
         ETGA==
X-Forwarded-Encrypted: i=1; AKwUvBwGEmZnNDnIzAlvitv8ssR9iWFN2CZfWd6b56ZwmPIw5GdGK4am2kaHjTxHN37Dnx4rhbcYbP+4+kDfKJGlvSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AZXsgLxZJTLavKCjSOAHyRKxyYjDkTpGF8hPsa/6kGPySxcmQ
	+u0+C18Zxi1tRK3St7khSZNA6lftEY4/SzvG5Oc8h9Fkb49+g3BxOqI54WDxC1OtAzaP8c7gvfV
	vicTz9FbY81pZx4tLpsaMxV3poDd/xqghi57mOka0ZCZVH3aTAWhloE5h5uEZj6wracHQx4Y=
X-Gm-Gg: AYBFou3AHOpTdAqQtrTwzKjkNg0FodrxgWjI7JojroKjQq0uDHi5sl+GhVmX/EzxGyj
	/SPUJs4Kv4Ra7ZMgs9SRVv5E53S/PIFxNGK00l7TlCe5McLmKfo6x2H5kdka0oh1RhLUABMv0hk
	iujZPJ0Afbbk+u1yqSxalryvyd7VLgzfD296JsRuYtkfhrccy9jPA8gwj2o8suxN6zbjTuFw/Xm
	BhJuo4hFaO6ybiRiRmLPOmlYxyPUScI3Fl92FqUufYgiYYf3kO450NuEO8Oe1PDYR2m5YiR8AHR
	b3xQSsE/Xffc38KW2p6C5ZgsDYZlgg5uILgbgGZQQ09I4w/Gc5jkO/OvdHd7sr7QzrBpcfKfYQW
	YdO9rpJ5kqd3HSyncrJ9xyBhOTGwO9U2YxZLMxfCATiQSBck2y2BOv2hhkGTy2eKIkF8mNnLwX8
	ErwE8X4EDkMvZ/T/ALM8Xz4Sv1ZnfuQ7YYR61/61f1eQOkzBSSMS+VlW+qXSz/0U11zMXLDlysO
	RoPiHvUFZmEppar6HNVJGe2Cgr9
X-Received: by 2002:a05:6102:3ec5:b0:7ce:6289:314 with SMTP id ada2fe7eead31-7d07269900fmr4433994137.14.1793634812060;
        Mon, 02 Nov 2026 07:53:32 -0800 (PST)
X-Received: by 2002:a05:6102:3ec5:b0:7ce:6289:314 with SMTP id ada2fe7eead31-7d07269900fmr4433972137.14.1793634811366;
        Mon, 02 Nov 2026 07:53:31 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:30 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:38 +0100
Subject: [PATCH v12 7/9] arm64: dts: qcom: agatti: Add OPE node
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
Message-Id: <20261102-camss-isp-ope-v12-7-702254689feb@oss.qualcomm.com>
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
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae8b1fd cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX4XGZujh2pJen
 x7+bEyulV0DxjU2qtV9OSqpqs0T65Y9mRCQz3wDfc3KGekISqAQymge6WYVKt2CVPAvju7QgNV4
 vF0T7VCtDsMBmnfy5ILIrWW9hbAAtTQ+8EGhSuEmFdZiwUw4Ml/VavJ+qkXzcspswZNvVmxffBh
 DPTFfUFexY+uWKpNpoqnK819nhhK9f6jiKgd9xKL5bK+aMtE6MIEmo7jrY6IPR6KeLOatsIbeSy
 9UWZQd6oe+udefCoz2zckemzVY5DiGvAn5ALMb6ogkd0rthJzcH7kpIr4wG2/fpvqiH1LAW4TWu
 PtzU31GQdlAovbiD6l71Uhy1BT6lO1IiQce3Mp5BYdIfTvqvihx+PP3zZECrWRpgVGds2qyO8k1
 LGheqZpdI3lj9lnO6kED8Q5NqCrgTjVDZ5XnSdXyvPqTeOqyyuZ9ylySeRDWbEHDVgHNYd/ZZ5m
 lombvsTbYyS/QQ24oUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX2qX5Sg4Gx1Eg
 hg1IB274ZstT05RNxrINVi02NC2jQ3S5ZqCw0VC0tFdmfwGzXR1JjX9CpHwgTt5cIezfh6I2PjI
 mCrSgPqQoCiWuLWub+9I4CxM7sOJyow=
X-Proofpoint-ORIG-GUID: phRTfQgXhkEb43Za47PT1_5F7votWtIb
X-Proofpoint-GUID: phRTfQgXhkEb43Za47PT1_5F7votWtIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

Add the Offline Processing Engine (OPE) device tree node for the
Agatti platform (QCM2290). The node describes the six register
regions (cdm, top, qos, pipeline, bus_read, bus_write), clocks,
interrupt, interconnects, IOMMU mappings, and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Agatti boards.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 32d185d0526ffe109d83fe92d9c54f21bedbbcfd..dacb551fef530b73ca5265eb6aca39b807e82382 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -2026,6 +2026,83 @@ port@1 {
 			};
 		};
 
+		isp_ope: isp@5c42000 {
+			compatible = "qcom,qcm2290-camss-ope";
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
+			interrupts = <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>;
+
+			interconnects = <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+			interconnect-names = "config",
+					     "data";
+
+			iommus = <&apps_smmu 0x800 0x0>,
+				 <&apps_smmu 0x820 0x0>,
+				 <&apps_smmu 0x840 0x0>;
+
+			operating-points-v2 = <&ope_opp_table>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+					<&rpmpd QCM2290_VDDCX>;
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
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,qcm2290-mdss";
 			reg = <0x0 0x05e00000 0x0 0x1000>;

-- 
2.34.1

