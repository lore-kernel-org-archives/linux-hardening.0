Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF04C652B
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005018; cv=none; b=C7HLHS/rRD4/Kp7PbImW5N5L37ryTJqMut56LQUhlxMqcCcWzQ0HUDpov4Aodoeh2A6oiKzX4oGfp3BVTBs09IP0miqGwGKu/FU6VyK5szpf8zS3FyYyoh0ZNW6vgkRNHC8XhYtOpdML5sUC7yZmPiqXtFnBoWSofQ6MCe9PTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005018; c=relaxed/simple;
	bh=KacuOzfLT7ghT0l8x9+HoH6R9vGKNBZqubpcPoF6wZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myOybtrXqeWb2r+qnm2RcnPeKvVvVixtIY6bgcVEWEeeU06oLS6DT0g9cC4gAD+AB2MvDAihA1A0onKmoFHvEvQorSBEraL09LTQjF/tYyx+P8jgV9JoZOM7K33XYY4RHXcoZaCdyZjH72Q2tqw+DP9P/L3pBWX5arJTrC+PXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YzetfMvC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dXdrlove; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YzetfMvC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXdrlove"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFA5HQ827697
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=; b=YzetfMvCDLkr84aE
	oqP0P6SZo5R+0l94iZbrflbieGX85MAMb7ART385gowz5J9vRLMWM2WUTgLF1TuP
	F+3Tk3Z8Mt7fDT3qNfXXhn+x4218tMCZVGOdaIAx3o/SRmQ17D18LJ2QzubB2bWN
	3EZqKicBnIuCdCNwxiQHnf1n5y6k5LeLnSU2MsU8nSzWgayN5BoJvIksSoJKWRRd
	JYx7vHPzb41MT0BBKdq7e4tyf01vNCGPDOann4mzUEAsVNdjn6etpW2ztpntVZFt
	sRH7JGcyt6zOVB59e9T63o+puGpOpOc5kSXfuRtpsjalufXKTaSILLg2gFi7LCAh
	50a2dA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gsqnw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso2517152241.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790005013; x=1790609813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=dXdrlovex6wYj7l0W8f0tJjAW8R0gbUHSRoYoPkqC7gOBhVh+kdJeuPfrCePfRRP1P
         ydYgm+JhWUAV1CYZhIlGTLlMLSBdg6LqGaVwDyWgeCi1VSQvMWqaUjO6IaWHyEwAtOWE
         PxZP2hQs1n0RajHq6JjC3NzeNCFWgaK+UsOTwqt5Nt+BtaJYQYkWzQiOrp1CPICAmIIk
         fBSt+wX4I0q8H/d6eXG0nW4d3FQA2IA554oKCRvxD1MPRNRUA6zNAsAR2z+QHfg6OoPO
         2HjhV5PlhmRQPpu9M5vplEvdrlqZfRfRaGwhyQDxG6ZLziS0VBrq0ufK5kWCtdPAEIRm
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005013; x=1790609813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=ZbhWrHK7DqUzGcodar4VuXnT7n2n9jk669QSd0pPmonjsCMhQRrwc2chVdM9zmCAA+
         vbheUQzAGN2O6vjJt2Q9MyT7eBBJhO4NRpYxcBGUxpy8sjM+IKT8m5oKSgWRIGyjh4Lf
         5QBaUdR37L0T+oxP+FgLT4t70xkw14/wmtm0w3XJMs6QqVbGfjTsNkTnebnkOsva/w2x
         pXeKn2YXCTq+e5qS0KQWbh2lT5Wzw1EPoxteBcw0rr5qGC9tgHBYDeyF+m7cU8K+czmB
         yV9wYNMaVmvEtMzZ6eVeRtMYHFdCot/IlXTw/U42GHjCRmwrjiivH1T8lP78XxoaKU0N
         LNOg==
X-Forwarded-Encrypted: i=1; AKwUvBxyW5xrECVo8RlXAiird+HUEmV6Ybd0pJXdWy/D0zEVIG+Vy+/keydRejE/Rg9PAw1T94MiR+set9KycyEC4Dk=@vger.kernel.org
X-Gm-Message-State: AFuF++nXqe0FJiG+U8RUlNOPawN2QJUKq6xQN/EJPfjQqE/EUw6Y4aVe
	veULg9ufQ8R9p8lcJ1sb4+yhX1FZm2casTd0Iy/43+Jp2ou0zuM7cumcRxkRyo+fHWscFsJFzIr
	1twoTclg7ZbaH/tswsY2XiE1TzVcGg7D2ZaX3Ijt9mTLJ4wcvBljePrW/7AZT5zb746p96Sk=
X-Gm-Gg: AYBFou3H2atWeM1rSfpoYm7wbsIm4q6DxvRlJiS/BSqGWSW24NST+8WOkAzlQVoDZFR
	RcYoDuHF9h4ebCfnycWx0QTZ8IsE8vJIeEQmar6RfWA4/iKceGAd10UBpQjnTGNcjGqiyGlpJqy
	0IH83nizeehIAN8ORC/t0DGncCpmA6wpYO6v1sibJMND5X3VCl6NsBnxXchCrST0ES2YRbyyETT
	EeLV70fbpnAjg5khByyw1aOFUr0H4i5o9cU5a9q1df4wAKt0PoUT4BYEmZwQCac+kaDTlPCrt8R
	G+ciMk3hQ8zLEoEFTogO95Ys6eBoW8v6BxtbPFogX4KQ1A1cZ4zhVPhTUkRxCZGj79U0VVHtMzl
	RKVaBTgLlSrXmiIvxy8tZVLgebVN1VQGlNxJhU2RKuUmGPQyc2I/uv4hB8vHOQmGALKlmXpix8S
	90t3WRxCEhcV+3rquzL7e/PeqHpcAqYHAyWUJWo6x1b493cJIyuVo=
X-Received: by 2002:a05:6102:1624:b0:7a2:3feb:9c55 with SMTP id ada2fe7eead31-7a55b74983bmr5853984137.12.1790005012818;
        Mon, 21 Sep 2026 08:36:52 -0700 (PDT)
X-Received: by 2002:a05:6102:1624:b0:7a2:3feb:9c55 with SMTP id ada2fe7eead31-7a55b74983bmr5853945137.12.1790005012400;
        Mon, 21 Sep 2026 08:36:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm231054065e9.9.2026.09.21.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:36:28 +0200
Subject: [PATCH v8 8/9] arm64: dts: qcom: shikra: Add OPE node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-camss-isp-ope-v8-8-dd1c86a3c8a0@oss.qualcomm.com>
References: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
In-Reply-To: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 8lsTu4rrEK4EdhL17tcwp9t7X22QZxI7
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab14f15 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXwiD1qqQ27Hsq
 wS0/bSW4lpCjVCo+Jg0/iMoPQ+OffBjFjDQFZHta43XTZ178qR7KQoGW1QXCJI7wZPG2Ae9zE0f
 p++bv9/2a0nyoqLRgkbpGNY0EsXzHBgNKlYFd5JPXu2pmefkwmMyDedNSwg7FVT9OUwi+XJO/Eo
 +TKkbUo0CFDtF0vWAJUcLoZrxe3Wh0H6sEX+Pr7cAa4iCYkDopCVFapm7JW8Q5Y0tTKRYd2P3yZ
 jJZBrnvwcorUOlngmhX45JSq5nZYH3Rc28nqTOaxZSEZSolFvEjL0MWwCLgC/G+cGntT8dkzNGk
 bbx4FjHIRAgI1wDOBbbAWNA91Pt5Mli4NypXfSRg8O+QfTKSXq1dhoRlPTddbKeErXJZN1/YXwm
 XB+PVtuZd6sR4bGNcH0FiBRceVQmopZ+Ef+w0cJVHxynj2JSGkU6YPVcwZLYWOmysN7oZskJBVr
 VpCBj5O8pt+uDzJKCag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX1XYJLO5XLmxm
 AfI/5VHUPfR7PiA3GsPKpWdmacTjhkAjvsLrmdr9rLcUICshaAXoo0Xyx3ng/uhouub0g49tGvt
 kLAzWPBAbmltBRSVRIpfah3f8BC2oJ8=
X-Proofpoint-ORIG-GUID: 8lsTu4rrEK4EdhL17tcwp9t7X22QZxI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

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
index 92d22e3b6931cf49f213d1807f78fc1a261f290d..5adc28e9aa64508366e6c7fdad191a152b8cb6dc 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1828,6 +1828,83 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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

