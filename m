Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABF35E929
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699956; cv=none; b=bigRxCR9c7lmMsHjPXwRUkY05Is+DDvD2mLAT7asJ5A5i3ElE2Kd4bLAJlDHqtNOc1aT89N7i/VFDIjkrCGI6578PXNcW0zgmWk91TYOhv15IuF4U5WqnMIrbYwum27B5SnYTmmHMAjGxq/4FMFWHCfltRRkpV+ZDXNNbKTWnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699956; c=relaxed/simple;
	bh=Xv3av/rD+ldK9r9tj755nWcpZGWPEFEhsHdy0UkmLVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeKhJoSyAi2ZBff878mMM4uCoQXlQrhrDLkUk6Didomfxsd1ymz/oxL+BsD0QZFODX6UlKXEKmHlXzitbRhAr7hdi/TBE1SePyum4I6JARJG5if0+1HGf1EQbZhYoG8oJHVGxQYylkZKy00s4pKS0UB7R6BQg4CPHRFeQVeclMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G1CKdxis; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BvXUsor1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1CKdxis";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BvXUsor1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53f7m4054962
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=; b=G1CKdxisiKL+hrHc
	m4RINRpr+e0rAo1RmMtx8we+wbFBtdbBMKUt7+g5IJXez12sdDnzt8AAlzyw4O9A
	chgcyuCGU+E6sOcT2MHATTsnfbByOIo4bdae705wQ4d/eeK4sFGmYHdPBbg7vbzQ
	DqAPvvu1Zznh0Zv8LllQHAlC5YfS0Gouf21NxHhSGdMs5+Ta27C1iJazu0ZKrigl
	sMQmClayxx/5bqL5lgdb9j3qKXdTyy0wRRgHY0ZYKZ50MzMu6QYIPlbar4nPIgqp
	l9uwlQhneIu9iIvR4U+FplNgb+CVck/eqEkIDympyI+uN+6mFFp9iIOH2oTcfkTi
	G+8MBA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdg8p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab041eced3so14946445a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699951; x=1785304751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=;
        b=BvXUsor1MtqyCdCJ9CPVSnwj6l2CYQXNzqX7lThqCnyJmAx+qP5GOsnrz7uIzO5/09
         ldGdI+Q6lfTPXjCTgj6e0oe/n/rkxHlaDxcGlanXgYlF6qCivCrhE84bM8/GmQY8gqlE
         R6qUHiIfv5+3G6KiTSaPzh+CU/pjxvfn2+MIzqbtiNK2/PYsqFByuCiNshujkEmzlnO6
         HvLez2H1c3cebuyrR5y0frxpGtg9qD6NUQUIIThtrqavnBqqd3Y/7DdLtxWPnCkQ9swv
         dA1Xtm9RDuYJgfdU6gOiWParBzS4OmUUtrbMy2CL0exV9KMxvC/CICOvOP4Rn3mUqpUN
         h8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699951; x=1785304751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=;
        b=E0Op5zIcbhT3MJCpg8xYrUZV6I73V/kdKH/xBA7S9vKqwR/qcV3B43/fzwG2e3nWwQ
         HoxP3UVV7QgjO2zlDc9ZxkDfac0VftmP43dtkmNtGM02WxP6Ouvr8XppgoXPF1/MZxMt
         VvETrc5CTjlZLy5omHlsKQFvAFxTjWRgN7B9OkT5VRJuMWwckoHdvXdiAeg/WuHW673D
         xt/3RbAz2LtyN5jHasXOL4q4gBr5AAS8DJ9wLHsT/wHCAPERNSGLzrqudkX/tV+XhbVX
         Mt2RoUgN/nro1sU6BDjPxiz/pzRYsKYd40PzVHpTmjidSbeegYDhQcPXkiwd8yYFmot2
         99gg==
X-Forwarded-Encrypted: i=1; AHgh+RpmBMhwl9jCRtvoMeabNuKa//edEd1+85F3lhnUJOwtEcNNiZwaT6rtszVcfQZd7KUVo+oclt+1nE7a7Ao66b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oyatpS3Lp+pf+McE/mcvwUx2hnCSby7N/iOZhB9NZUMOWG6H
	83xGFRK6EJbRTNt7xLD57AprJa7UkvHHIdsTZ7Ta8vfEjjVy7Fuy6Lk2jl7a+wyWC3NFeQGg9pM
	forwA3WMFiukbS0gGcqQPpl08hi90OoCvpeqYwXtwZroPXk8Nh6HIWKiIlrdMK/bYpfKAvM8=
X-Gm-Gg: AR+sD12DvrqHMq+FxNSN360vSaj32MxZHFint+wyL07fV6YDkmNK00XfdGQCAfDY1eI
	cuvLhv+J5CTMOy1nErInMzllb9SR/zM46SQh60/JdnbMXPu0ygdh9929r0MdZSY+iG6LzA6a4x8
	NJJBVDUfLIzmbF/T5XJRabJBt67rZH9GBBLwivz7/IRRDtK2FgX062VpwdonWI2Zzt14IaV4Wxw
	TA6Iog1vF5RpHnx0J/1K1BUbyNPS6eL8yKosSzNQncGxX7RYRwab1DLR7P2sW+tPVr1ixT/29Zb
	VVzThb04TgjoMPl3LgNRP2ruK1/d4KcCHW1S1bJgzx74LHiaZc5Skik6GUpF17/tL7aNCi8awSC
	K6FBAKm/PieYxqQurOqHkcRZNHU1A49BXISL9NrD+5b0Yd8g=
X-Received: by 2002:a05:6a20:9f09:b0:3c4:3a74:4472 with SMTP id adf61e73a8af0-3c43a744598mr47851637.63.1784699950886;
        Tue, 21 Jul 2026 22:59:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f09:b0:3c4:3a74:4472 with SMTP id adf61e73a8af0-3c43a744598mr47827637.63.1784699950462;
        Tue, 21 Jul 2026 22:59:10 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:59:09 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:59:02 -0700
Subject: [PATCH v10 7/7] arm64: dts: qcom: mahua: Add QREF regulator
 supplies to TCSR
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-tcsr_qre_0721-v10-7-d2fa68c63b78@oss.qualcomm.com>
References: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
In-Reply-To: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=2520;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=Xv3av/rD+ldK9r9tj755nWcpZGWPEFEhsHdy0UkmLVg=;
 b=hz5YehAoMMF4p2iIQJZNi4W8maV2v5p2C2a0IpUmfJ/+bSYvlT3kXFuYCRWSTy66ACy8JIHYy
 0uNh6PKfOjuBY2RDDBiKrIp2TUN2efM4P7funKKfjHit4tKuUn+uHT6
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX8Uhy1NvAG8Fc
 7YTU15+iI3vu14+FDZTmTrjsGjLTqK7WgnBQKlmM0BmI0ulWAtVXxsCfzxUnB+nSNXwRRwFkuHT
 diOxDiZhaZCjaEpx1QkjaiVTBG2/6V2YyUAG3uwflVb3nfFjbA/yrtrekTsIDhg1E7MI2HsPRof
 DMuwW8Tag++E425tpwTrlrPa5VDvIxNAFCOjuVLYpk+yI8FDY5L7ZNXXj9Rick07xiXGYtP2ax6
 Bbclj6zGx2eumCKwGNOPh6+Aw0C4P+8kqkqyChUb1ykCB3XgmwDEJrE97ULHd2BA/VviEMFHlb4
 rtUlxxwgUuWNF0DSqTJwKKHUfkMqGIsCwn3cfWVby+dPNGWeCzaLQalyAn3cnbMls7M1yae/Lhq
 MdUvaEwWWQI1q+pypL702JjDphvm9JOAzG0+KTZUeU44H+x4DtkS72P5NTaN/Nnish3KoTt7+Xh
 ED1/YpKYwf+GtWP4f0w==
X-Proofpoint-GUID: 3KKu3cRnMIMQVHIz26T3QlXHH4AvilZ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX8LhbYL3SVygB
 VlQnyhVYvv5T9r022vigq1qjikg5o6sk/CIHMy4+krKcCalErGaGOQmQ8eTAYWAvjivLzJC8juu
 ATcCU6kf4UskWzd6ga/iLN2FHX7E9d0=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a605c2f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nz7bh4JJC2V4q-rTAcgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 3KKu3cRnMIMQVHIz26T3QlXHH4AvilZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220053

Mahua has a different QREF topology from Glymur. Override the TCSR
compatible to qcom,mahua-tcsr in mahua.dtsi, and wire up the required
LDO supplies on the CRD board.

Unlike the other PCIe controllers, PCIe5 PHY on Mahua gets its refclk
from the CXO0 pad directly and requires no QREF clkref_en voting. Hence,
point its ref clock at RPMH_CXO_CLK.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/mahua-crd.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/mahua.dtsi    | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/mahua-crd.dts b/arch/arm64/boot/dts/qcom/mahua-crd.dts
index 9c8244e892dd..fa5229064b10 100644
--- a/arch/arm64/boot/dts/qcom/mahua-crd.dts
+++ b/arch/arm64/boot/dts/qcom/mahua-crd.dts
@@ -19,3 +19,19 @@ / {
 	model = "Qualcomm Technologies, Inc. Mahua CRD";
 	compatible = "qcom,mahua-crd", "qcom,mahua";
 };
+
+&tcsr {
+	vdda-qrefrpt0-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrpt1-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrpt2-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrpt3-0p9-supply = <&vreg_l1f_e1_0p82>;
+	vdda-qrefrpt4-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qrefrpt5-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qrefrx0-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrx1-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrx2-0p9-supply = <&vreg_l2f_e1_0p83>;
+	vdda-qrefrx3-0p9-supply = <&vreg_l2h_e0_0p72>;
+	vdda-qreftx1-0p9-supply = <&vreg_l1f_e1_0p82>;
+	vdda-refgen3-0p9-supply = <&vreg_l1f_e1_0p82>;
+	vdda-refgen3-1p2-supply = <&vreg_l4f_e1_1p08>;
+};
diff --git a/arch/arm64/boot/dts/qcom/mahua.dtsi b/arch/arm64/boot/dts/qcom/mahua.dtsi
index 22822b6b2e8b..e6c059708912 100644
--- a/arch/arm64/boot/dts/qcom/mahua.dtsi
+++ b/arch/arm64/boot/dts/qcom/mahua.dtsi
@@ -115,6 +115,15 @@ &oobm_ss_noc {
 	compatible = "qcom,mahua-oobm-ss-noc", "qcom,glymur-oobm-ss-noc";
 };
 
+&pcie5_phy {
+	clocks = <&gcc GCC_PCIE_PHY_5_AUX_CLK>,
+		 <&gcc GCC_PCIE_5_CFG_AHB_CLK>,
+		 <&rpmhcc RPMH_CXO_CLK>,
+		 <&gcc GCC_PCIE_5_PHY_RCHNG_CLK>,
+		 <&gcc GCC_PCIE_5_PIPE_CLK>,
+		 <&gcc GCC_PCIE_5_PIPE_DIV2_CLK>;
+};
+
 &pcie_east_anoc {
 	compatible = "qcom,mahua-pcie-east-anoc", "qcom,glymur-pcie-east-anoc";
 };
@@ -286,6 +295,10 @@ gpuss-4-critical {
 	};
 };
 
+&tcsr {
+	compatible = "qcom,mahua-tcsr", "syscon";
+};
+
 &tlmm {
 	compatible = "qcom,mahua-tlmm";
 };

-- 
2.34.1

