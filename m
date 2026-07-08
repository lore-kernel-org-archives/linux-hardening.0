Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15E396B6F
	for <linux-hardening@vger.kernel.org>; Wed,  8 Jul 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504977; cv=none; b=SSqS+VKOPktjBCq1Ye0/VhcI6Z/j2BVh1A8u0++AxtnwGBVryz3Gaz2Nht6JHoeKJjy71T9+VZ/8bWE9OS6ujEjtsT1WI1jz5h/CKz/megtux2UXNUt/DTy0KirHW2ETVBKW3hlzOITiW6sLhF17nKA0xSTRJOEY/pnkfQpEOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504977; c=relaxed/simple;
	bh=Xv3av/rD+ldK9r9tj755nWcpZGWPEFEhsHdy0UkmLVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJgScEpe9dr0TTm2JCGchAFxTBS8XI7vUcZhyUwMaE2SqEiDHMJ4J+EhzN9aIzBESPhIh2lOiG2Hgzmkib5VeBHa0IGqovqQEU6Y6tEXN69uoya2KCF8SZuZ58FPvRQefzR3Gmc9Kdu/G32nFCPNJDY4/EMnUhBYQtDorpZ5ZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TP8pqTCb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkvUL80E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TP8pqTCb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkvUL80E"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688ABZA2222757
	for <linux-hardening@vger.kernel.org>; Wed, 8 Jul 2026 10:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=; b=TP8pqTCbtL2kAaHN
	NHix9DatpUHyOrGfi1rhWg0WRSA1QcmAYCDb0Sa72fiADWcZfodClzsRNsaollbH
	0bOxJJx1kmaYWajn9V5BudkWPHUhIZ1YqVE9r7olPv5e+kEmq6jEqub1yi6EvhIA
	m2n9TCqJEhq1Wi/twVeeAtw3t7jYSJxIE0nV+fBypKR7FTvEDoZ5te6LtnyNh7V8
	mOONkxRwhE6cFbu8tj/77XUlUPC1bUIq//0qZ8WwCVVNXE/dMmT2fTU9qJNuXtdd
	0cXZCzxHzDUlk/YDBYiRHdjcSSmiUQs4mOE/Xywxu+IAuQlv38cH1ESK2TpnAruO
	SNGxbw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssswb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 10:02:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37e24235ce1so1134882a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783504973; x=1784109773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=;
        b=HkvUL80EhmYuraxTkoIMoHiazscorCv+3dk91OBLB4ICT+rM9zKdW+XsfoGtpmNO6m
         WbMCA8ddcuHGp59sHUnYPbypQ8Pkh8qCKxVJUhrIsEGkdZ3k8FK2JIQiDfjzReON5zMp
         sqsSMGKcCgknjxQjEGTQ6QsUo9az6Qc6O5JF07gbsO1OLyah4Rsh/C74wEiLIWU71WSA
         i7Q02U6M/4EQ0xGZAiwyny+hlycjk8wq+2fb3ZgqAoKjpOkWPiY604EtexcrOTN+BAIo
         fhmX4XlTiJr8OKcttSAeG913pIDq+S9LzDelADmpWy5trTtBNtPrQQukkZMdfdxGCPxT
         FTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504973; x=1784109773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTDbhLDusd8RpoV9P1sSM4e1vQjmi4jllQGShEAZJQM=;
        b=h4DlNgTjToEYVe/sddJoFjlMpgNqyFFGwBvXG4NbIJiWVdeDRchjaJ32iEJXXaB4+P
         VQP4bDy7ZcYzNHixdbTdSTGEd7KiZH/s+ep17kO87vNYN34T8C/oGicFIkiuy0nPm5pn
         z1HraeUrdfhDYrdeTLv4NJP7n4j2WCm7FBEsXTpN1dIXSWIG9xNjql2k6FYqR+jZCnmJ
         QljMhR2m0b3IjN1o/DGR6gExqbO2+UZ5ZBMu0tbIszJujpe5yBYrtmkaAezGBHb63pZV
         4mqE6KZCrotNqj1apwyQzdQ+YCxgrHK/zwWaDPOOgmiLu/C7zbqoFf6hnGLaO5csAYjv
         BC7g==
X-Forwarded-Encrypted: i=1; AHgh+RqHID2LXX9X26Gwoa+iwze7J5ek2gpInto3yx2v4tgrZP+2aZPF1cQpbci5cyKZTkCY1a4VVCXchFT7AMif7N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xwC9T3NO56XFG4dyPIiLR7V15eRbn+MfJO+do5JLiabv18Q5
	Ai20x++tTtHCH/de7XkKCB6z4ZepbH5J5F0iA5f4557kmpW4w0uINQyBxqcD7Zpz5RvZeO1SXMN
	WiKzDlvbGskHJUgeBGYrzUDumOqH6q9ojDXAvpyvJtxZZkkIP7sDEsfruYIU1Vr6YdSyZrgM=
X-Gm-Gg: AfdE7cn05ZoqZWmJ0wyw3rN9a7/MG4YQXpV1HJmP/ueWJMJHXHbqTWtgOa0IligF3U+
	YTWPwx75hZLc54QqmOZGkUCDlTMamPmYmPDeBr+utvSEXFtL90gkCZQMhJjUwLHzit3DQJnF7vY
	Kx2nV1+D0qpSSITSWlx925mIiMPYXHiENTYnAlpca9YbjHHF5/uu5ovzJ7WrnMjAt5x1xLnepra
	wbCcipCF8eGARkZ7iogvmfozzVCPXXQlHGmI702sWAj06YoY7vFuOEgY1NRw15PwqockZQB3usZ
	ufjjXQW7kRtb33t9BDn50U6DF28BvrkV9TPsz/E2yqKEWm47JQbK00wTqKQJxjCop2mQppTHfpZ
	5YYPmLHRLmfHEIkYGEMAKb83D86ptHv9EpQ2DCIjR7yrP7n+kLZ5ANvFTUQ==
X-Received: by 2002:a17:90b:2883:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-389421ae226mr2037734a91.28.1783504973037;
        Wed, 08 Jul 2026 03:02:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2883:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-389421ae226mr2037659a91.28.1783504972419;
        Wed, 08 Jul 2026 03:02:52 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-389098609c9sm875741a91.13.2026.07.08.03.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:02:52 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 03:02:44 -0700
Subject: [PATCH v8 7/7] arm64: dts: qcom: mahua: Add QREF regulator
 supplies to TCSR
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-tcsr_qref_0708-v8-7-62c42b5fa269@oss.qualcomm.com>
References: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
In-Reply-To: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504962; l=2520;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=Xv3av/rD+ldK9r9tj755nWcpZGWPEFEhsHdy0UkmLVg=;
 b=ofDwDU6QY94LH8znEWl4KnkKrNyk5BkHR7B81ltOds3r2QDUqDMzE8/CWVIyYSY0xdAneq1uC
 U0aZcCdJp1JDv8dzenw4hdDLtsk/0QnW6iLOviEY4mRNsve7C19QmHU
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e204e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nz7bh4JJC2V4q-rTAcgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfX36MtdWEnOuzp
 U9XYZQGMCeV2/cmEGoYQ0XhlFeYDaX4Ok7fPIA0/LqlE+mar/v8LRtXs7FvqvC5UuLplp70EKdR
 sxiS8Xfi1NmAqOImidyoqjipaiALY+MjtkK8JQG+B1TBJ1mfhGYwOw9G+k3Ft/MeU2AvSs215Ll
 g8ee8urDtMcb9hV82d/BVGiYcRjiF/hiDtyFC0m+aeGSYptOeINsLhRdBjekAz24zUlQcvhsUw+
 uutVLonk6MZV4tyRoc+xPNUVNoUqaPlbFOrRR/j3Gc3N5rLCFn36pdQUSoDhQe81mzu2KZTK9td
 amv+UJNeOAXhhrGmes4LDq8T0cHiD7jIDylcB4qlwG4P3Kz/mXlzcNufnF6i4e+wvOKurowUPsC
 OtNe5V6aUg4/FzKqQ6xB3USNytnxxV2ghZehcReX7c4ixMk6bGiE4C8JjL6w/PalPSXfPypip0Y
 d9H74iuOiopYyfKwQzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfX6qSaW//6p2yf
 kvXafpidN5BpMzbiX17+eqr0p6QkdjTu+QlhufV79H0hdsPiVAGfD3pWU3K11wNwZMl+jPB5IJE
 N6KBMUNt4QH9OEKnH63suMMHvEXBxAM=
X-Proofpoint-GUID: CpWR1atSU2obsfcnKc0iqcvUgZjgykm1
X-Proofpoint-ORIG-GUID: CpWR1atSU2obsfcnKc0iqcvUgZjgykm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080097

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

