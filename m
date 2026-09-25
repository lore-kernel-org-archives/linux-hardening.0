Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E14854EB
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327412; cv=none; b=mX62Qeuod5cfZGZATdSzdWhIPAghrDtF/zhxM0HjPx67KZNUU+PxjpWNwcKIxLrK2xX5X5tEJ/eI36VQUUQtfKVo+scD9J3pwiWYTVD55Lr9tZ9A6j4ZRU1zeK0bhfrbuSz31plmC6y3uXRBjJ0xDaf7HqxLFNvzxSNSLoJEJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327412; c=relaxed/simple;
	bh=KacuOzfLT7ghT0l8x9+HoH6R9vGKNBZqubpcPoF6wZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtSiBeX6zZojSQwvQaoYuoahqUUavvmlUS/WgUfFs6Av60YcKudGg8UxafbRW4N3afYFkVQ24SOF3pFVE44LAm7gujd5bStT6+0HtkSAf94XFxXYmv5Kw1IUTCloibkve3pMgpQ1RufDqPvTfKQrksQ6R6yUlNiHE6VmXzRrWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OpYNDB9a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Poshcal5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpYNDB9a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Poshcal5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5Ij4Y600035
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=; b=OpYNDB9amq3IPPHA
	GQ9b3nwmdrCb4zGFzHx1gNfUp2OiDu8S7riLLmIHvcdmbQ+mshZqKed/EFYuUHU2
	MlsoF5fdW82rBuWPAIEAFVjwlxPDg4itM/cwBLLq47jDXZ+2bpqlsi9wD6QVVInO
	hvggE/E1Tk6tYF7258Bz8SFwPKe7R+zw0RVrVoBM0NTuMw5d9x8wa4Z+4jiqW4J3
	oS4Bx47q3Fd9njBrd9hCoB7htTSBM48ZvCyo9/izJRDZn2uCNdT564DMW35VliCX
	5RejgwsIxGIqd2fsaYdCCZQPjfGj6sqTdUHcQuZKe7EgrA3ilcbXjsmA7uO5Fopw
	nPM46g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvrnvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939a6937513so127937685a.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790327406; x=1790932206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=Poshcal5xM3X1Og/6lUs1gY3jbn3U88B8VJarKNX7BpZT3p7olKnbAbrpXsgKTS1sz
         bA6YEav8kcOZhKxiZW490JcdrlTaKqTxFh3Qd4UbrLPTGlyb6wwj8gHqYMg6r51Zezql
         5H/YscacXSas+CDL0yV+0xTXl8cEnJfeVd3FCuxBa3LA85/TvuOHPX89UtI/7rqPT24p
         kkHbT5QSoxmyJ0C8HmeD7Z+mQ21AeFtwi8DbKqWqOEzBwqieT6AN6dmQWKbfRQiKyHVo
         sQRZ0LBQIdqYnrXlwOcIqJv44+ds74LXpZ07ahwM0qXu7vn634GwKkJJutRmW2u0vHxl
         c5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327406; x=1790932206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=sXZZ6YcuNVMiOWl8wwi7HqL0+GMm/1Zx+e6t60BhXUI4Q7ur9Ep3hzoZiCNPSI1NOK
         3hRivXAGnbm5AMjwnvdHJN3x55JmMVD48Jmfh8Iw1DUK5dko2y1KMGGFAvAxAVDMp97s
         /f/hlOYVhzszAxmAoTqVGrlkDJpGc7G9WE+AwYTi5O+nRvEiA3OS3yYFtrNIAmGY2hd9
         Uzm2kERPuJxZizl3bFJTTZK8bFR+FmpUJOOTCcsOEWJdWJNS5cVhxC/yUpAvkvW8bP5c
         NJEyAKtnTH+IWbEi5jjXOgtwafcYDAUC55vJg3oe8CJhOZI96nnsHGycasphSMwDnGWk
         BlLw==
X-Forwarded-Encrypted: i=1; AKwUvBzjeOSxrgbzlwernZjK601oV478QTJe3EwqIII0CoemKZeab8mjAnm53GBZyx0krtn5OIZHAVDT8qYmb/txPoU=@vger.kernel.org
X-Gm-Message-State: AFuF++klAHXweSNP0Az894B2CwoxNdBItbT06rtFG7oBEK0UKC9zGOA2
	f0qryG9iENSr/XJxqR7AhaIt5n5NiKQXgnBBIXQmFsSaAQRHfzHsEWgeAcLBrB9WCsWbnLgfBFT
	IatU8kGYf/Dfdeilrox4OxtO2WX/hz64H81ANQqR1T7ots2vXeD2PZtlMXCEId4x7p4Udz7U=
X-Gm-Gg: AYBFou3cc+wpkH59e8cOsh2xW4xIc1zH7y6ojbbcPr2IeNmfGNstMc4UXRC/76r7gPe
	Zhl7+jKozz2QDQ8f/8+5Tqke9BNsgaasl97L0N7oHwb3mMCVjSdfNKgfGWbOifJ6TTx6gWUJC1e
	R+in5PDeNCKMBO4e0zF9NosAuurnipuPNKG9ZjH2BBrEpdvjcLONrkOb2+HAJc8YywKvL865cJg
	eY9RshLJRaS5Yh0wY3KcbAPIW/JsKLdoIUtyOZYsJOhCMy6sxGduJqH1XGd6h7zB8cn9qfvuZty
	hQJGV/GqBy2xKVI49KPST3ZTCd3em2Mc9NFpc1cb/ubMtaGkFnot4a2mMFJYayz/yKhTmBHt5Sr
	Ml6VyqaCg8NiB2JwqWPMYNJELx1emlWPkyKmxC3Dxd7RQfWfkbxaDtMnWVJh44Ln5OGFc4y26Hc
	zC5ZRdabvIWrmGc/DMXNXOmrZUlZfVbcEcMh6suZMPQaTqtxp4y3Q=
X-Received: by 2002:a05:620a:4495:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93c43b86612mr335563685a.4.1790327406361;
        Fri, 25 Sep 2026 02:10:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4495:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93c43b86612mr335559785a.4.1790327405903;
        Fri, 25 Sep 2026 02:10:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm5269890f8f.9.2026.09.25.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:10:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:09:55 +0200
Subject: [PATCH v10 8/9] arm64: dts: qcom: shikra: Add OPE node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-camss-isp-ope-v10-8-2622411034cb@oss.qualcomm.com>
References: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
In-Reply-To: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
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
X-Proofpoint-GUID: qbD5HuYiK0duRlB5LQTK3ZSkvgGPQEPo
X-Proofpoint-ORIG-GUID: qbD5HuYiK0duRlB5LQTK3ZSkvgGPQEPo
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab63a6e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX9PViTosmMaeH
 2dDnkT6mWVxYTOpwl+He23qjcVTrZhAiK48oy8bwIAMgdH6i7n4TfDXiGB2XSLhm/+TRqoFARYI
 adpCz4J2PeG90Q5HL+MUIpgsKvN4GoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX2MiW7PmYeIci
 Wm+gYu+8ah6/fXnIK8eBDiAwK7JMaVAp1vUKvkeKSlw04e9ACByPllXDcvnc6KxI1WTh5bRiLkr
 3lo+dJGJyGrYkQSyJOw+N7YCQd4MveIEZOovyQ0Eu209oBDhEwU4OGy+5uxLDdp6DutCCTRyp4p
 XJZT7ULymUBTtINpDHfpUQHfioIsElxjYhe/VROb+Sp4VYBGPL35Q9D5u0CDOHIAumuAmmk85jI
 sGpHr+YiBco9ULDZx4OtE0hkwHECtu5kSWO0cmHFrsxii+jPG33zwKZrcL7/oaiDz1O9g+LEBg4
 c/z3Fo4l6yj0jmZm8ox678+7HXetf6S9PuyX3zT/+HDi/OQzXDZUrYI8V7Gz6isWu+MXD1Qz9xL
 zhcHDD4prkZ8Swrlg5+w1QorvS3yGAQbrCDRcMTf2fjKf8zZojGiQkj6qbpNVa94foW7DJXOYI4
 7rtzKVHr55BU2EANDjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250036

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

