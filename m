Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F533EB1B
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699952; cv=none; b=bq6j904VwbMFmfu5b7m8JbhGClaWaD9EB4Hsjyoa4Tze5SQXigdw5sP9JE/t3MvUfOfhguDOTjmIuwiCbslbswRczuGBrb05p1udIOhr2vEXkxNmGEsNZ4D1W47QwNEwEvUhJNIuQiif5UgSoPLlJxLXize22Wp8dg/brFHMjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699952; c=relaxed/simple;
	bh=9BxxmcrVybxTieypSLyf4ctSd8fHI9uE2WwM4etNwjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFG/OYh0jQwU190e2TNrtveeyKwbh5h1jTra5sGIBS7kxBVHsT0G3R+RyZ5KYq+6bteyDWCA65GczTg71bDYi1AANe9K2F2zwQVJhZvBixIAhuHk0Gr0Jy0hANfes6n1MuXKBoSCVD61pLcWZGYIWJBwggWrY7JFawVekOMUjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S7xuNXJE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwUguHqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S7xuNXJE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwUguHqv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M54YFb3474861
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO86e3p018RnHLJ2AvFSTUm2N11FNqXo/0u9fnwt8/U=; b=S7xuNXJEykiDw+Rk
	QyhRkL+okcDmpXnxrBFbo4jvy4KDtMHCkudZT6JGjbtv5cpTU+dKabOVHq5VjlO0
	xAOsWp3Up4hdVyaJt7emUZXjWDc252DlrwGZ+YG2SnRLOrNvI2MOvHipMG1AQezp
	FQsiq78scsC13agWCE1JvCehVQqKZaPw/2Uejy42Yg3JS43UK0J2QHIB07bT7y5P
	rHKBLZyGihXeXcCko9zk939/4oaCahTyN0eN7PHWQDtGDAQvSU4OXPBTvwRuPxLE
	URCYpgiSmfn4zZcEIAx2+U2JJcJ/fUrSS1aILpBc0GyYJZ8J5XVi4EX+4h2DqC+P
	anhkng==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftfhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8488ac68185so22463735b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699948; x=1785304748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO86e3p018RnHLJ2AvFSTUm2N11FNqXo/0u9fnwt8/U=;
        b=jwUguHqv/0uG16+TMGAUyqHysnNZmoq2OWF1nEHeqbdtP+vIu8QStG4Hj1FpuXdkB/
         coiIAjoz5JJoGqbzbxlA8DXq2Poku7EPhAnLzF27taKjbXQ6dRBcMOiixAb6eGfVeqsf
         oVEnai0ChgCxpykO5RYcABTKyfsL0yDvyUHW21+JNAsLiP79fcf6HdIAXxreRRFVUDTO
         g3A9zyOIWN4uh44+3UX8I0knwOgEX6WC2W0QgcO/JKenUlLkyi3HwFJDiUaohaMrpxFK
         0hTA4CF5juzA1XuCi9azI3mc59SFG9BClLLW1vsKSh+piyHuESWrAJIPKjs2qm8D3TJr
         eLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699948; x=1785304748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO86e3p018RnHLJ2AvFSTUm2N11FNqXo/0u9fnwt8/U=;
        b=OkiLr0b6G1S7k+iFmOPPrhlxRUgRAeTdcmnqSd94unrBfemslUg5yZ1QXWk1tGkfA1
         seCwzc1Rjq63aWho0AhH8MafhEJs+UG58r4qzVqdTT3gioNqTaF9SCKEwSuoUQvMaf9Q
         RvxuP8cJJa6NE7M+9BMQajZEQfn4Eb4ukqTqSBqX93j6zAe+zpkInUmW45vF498wuzpN
         J0TsdrFcB9yXbbsXCW7+Ked888oigCA4d4FoBpDc3T8/TrGKVRsm2uwxvH3qfoovXy0k
         gROq19KCvqEiTaWh2I5DIl6BEV3ytC80CgmWvVfEbJy7Et25Kr6AoC3qC0Xcj87Bmk0i
         ugjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWiLDhf5Z+5FZexTb+LfqOC2hCwc+5OO1GEEVFo2wDOzDN9uVnnN93CuEl+UpWmaqTsK+70PutUN2tSaCPfqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUPoNTKSRNFn0bXsA5Y/0rQLHQEjZPr5eG2BKjGevdXNoNOMw
	z6gwOQMUhplM7yu6kQCJ+XS0/DC6jup6jY2jqHEljgmf8K8Npy62zTW17wHGx4eGHRf6lR7zTep
	SVoVVnVB8Burdp4cgxwbUratlhhlUBnpv4ve/OTQqvbEa7J2r+Vwy2UaMiXr6ILP1Y/Txmnk=
X-Gm-Gg: AR+sD10HiUMVLgo2xwpm8YJCrre+bVXaSGP8mbriQC43HJBIbVmXhT/IcEeYx4DySj2
	S+sottj1s4kSoiAvhMYFnlhSNBMn+6rapqnM7RB/QUfJki0Ykfp0hYiIwYAIHVDUVnwq+NVQcoz
	1GNWoJfTzU+0llEZA/OanRNbebeIwpJM4qsy5D6dMbgPAOHiTSbBWkRFSbhzvpint+D8UAh1l4C
	gebrwIFO4x6+bJeWucE2mtnpm3E8He4CJd/BAo2K+tyam/IssixxRFSYXJYQdlXCzgTKjGuuEF8
	7vqHrmnqgwYL6sACzD5M9HZNFjW8aJpQKTmmx3t9GFCbxhOXEi5hhMw7MmP5ZNZ7l3HhQC4TQer
	Ab8HUG9Cst3iHEqVdquuaAwq+dcHbTlZs0whcMin1DArylfU=
X-Received: by 2002:a05:6a00:238b:b0:848:5540:2371 with SMTP id d2e1a72fcca58-84c294d5605mr23782216b3a.75.1784699947673;
        Tue, 21 Jul 2026 22:59:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:238b:b0:848:5540:2371 with SMTP id d2e1a72fcca58-84c294d5605mr23782206b3a.75.1784699947281;
        Tue, 21 Jul 2026 22:59:07 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:59:06 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:59:00 -0700
Subject: [PATCH v10 5/7] clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-tcsr_qre_0721-v10-5-d2fa68c63b78@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=6484;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=9BxxmcrVybxTieypSLyf4ctSd8fHI9uE2WwM4etNwjk=;
 b=YuwVsxvzb2m5H1QPQTxStxo5ax/iI5vmOSshPyS/Qb5oBf1FtdR5DpcBDmXVH/nBSFm4q+bt3
 Xt9thlq4WsGDH3Cnv6W5KeJISCqhbqT7uExgUX/QOVS2sqeKfyMr7Hu
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: pyIHZegJEYfMku2ObNdc6vqJ63_Qw07r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX1tPpUBzF6BR2
 uScUMdQidv+liimqOWU/J4hmynEIe+p5kLXvLz9fqvV2tJN0bqSBW2vKmHCd9JHn6mKYZvBskgX
 XixCkJGGqfbe8PS5iaVRGkPSyUEdqknzK0Qh2TSmBIudaud0wS5FqwhkDC8CNcZTnDk63ZOhMAH
 kbi3mT29PIlTuJLOx5F7zwpSZPNHxfbyu2LWF8b7QfXbI/HPFNgahZiTMuZ0+hk1cMLEkL0XqxI
 L57F4n3/vx+rdJ911w6Q5MHB92IYghyisPRCyAwzXF3uSNpZUoO2+zLFQH/m8Mxogmk9k6wJ/uC
 KPcVKubm0aDfvzZeaQN7RNpggPkTaY2C4QhylImn19OH+F7fLjGMwc26caxF289Zas453XiRd7r
 R3zFenujmp7MkG+6nIvuDSPZt3oVfGVS135fO8+vyCz5QtYwKOR0e2UwpJdzFXxKr/0iydcj+9/
 hYSQm+suyDOocWQ5crg==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a605c2c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9Ojz-Py7MuQnRvcrkDsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: pyIHZegJEYfMku2ObNdc6vqJ63_Qw07r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX14f4B0kq9ZeF
 9wcolSLeyj2Y2qfdMwn6Qb/s2bTEjReN+svDAgBQfdSnB4wRHDvlAaBG1XURxcuWQRn+iYVGaZP
 fALdquXhFfPjLkob5vn0AG8hkg+eI8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220053

Mahua is based on Glymur but uses a different QREF topology, requiring
distinct regulator lists and clock descriptors for its PCIe clock
references.

Add mahua-specific regulator arrays and clk descriptor table, and use
match_data to select the correct descriptor table per compatible string at
probe time.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/clk/qcom/tcsrcc-glymur.c | 136 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/tcsrcc-glymur.c b/drivers/clk/qcom/tcsrcc-glymur.c
index e0b545258ba4..1791e23739ed 100644
--- a/drivers/clk/qcom/tcsrcc-glymur.c
+++ b/drivers/clk/qcom/tcsrcc-glymur.c
@@ -12,6 +12,11 @@
 
 #include <dt-bindings/clock/qcom,glymur-tcsr.h>
 
+struct tcsrcc_glymur_data {
+	const struct qcom_clk_ref_desc * const *descs;
+	size_t num_descs;
+};
+
 static const char * const glymur_tcsr_tx0_rx5_regulators[] = {
 	"vdda-refgen3-0p9",
 	"vdda-refgen3-1p2",
@@ -56,6 +61,43 @@ static const char * const glymur_tcsr_tx1_rpt34_rx4_regulators[] = {
 	"vdda-qrefrx4-0p9",
 };
 
+static const char * const mahua_tcsr_tx1_rpt01_rx1_regulators[] = {
+	"vdda-refgen3-0p9",
+	"vdda-refgen3-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrpt1-0p9",
+	"vdda-qrefrx1-0p9",
+};
+
+static const char * const mahua_tcsr_tx1_rpt012_rx2_regulators[] = {
+	"vdda-refgen3-0p9",
+	"vdda-refgen3-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrpt1-0p9",
+	"vdda-qrefrpt2-0p9",
+	"vdda-qrefrx2-0p9",
+};
+
+static const char * const mahua_tcsr_tx1_rpt0_rx0_regulators[] = {
+	"vdda-refgen3-0p9",
+	"vdda-refgen3-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrx0-0p9",
+};
+
+static const char * const mahua_tcsr_tx1_rpt345_rx3_regulators[] = {
+	"vdda-refgen3-0p9",
+	"vdda-refgen3-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt3-0p9",
+	"vdda-qrefrpt4-0p9",
+	"vdda-qrefrpt5-0p9",
+	"vdda-qrefrx3-0p9",
+};
+
 static const struct regmap_config tcsr_cc_glymur_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -145,17 +187,105 @@ static const struct qcom_clk_ref_desc * const tcsr_cc_glymur_clk_descs[] = {
 	},
 };
 
+static const struct qcom_clk_ref_desc * const tcsr_cc_mahua_clk_descs[] = {
+	[TCSR_EDP_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_edp_clkref_en",
+		.offset = 0x60,
+		.regulator_names = mahua_tcsr_tx1_rpt0_rx0_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt0_rx0_regulators),
+	},
+	[TCSR_PCIE_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_2_clkref_en",
+		.offset = 0x4c,
+		.regulator_names = mahua_tcsr_tx1_rpt01_rx1_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt01_rx1_regulators),
+	},
+	[TCSR_PCIE_3_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_3_clkref_en",
+		.offset = 0x54,
+		.regulator_names = mahua_tcsr_tx1_rpt012_rx2_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt012_rx2_regulators),
+	},
+	[TCSR_PCIE_4_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_4_clkref_en",
+		.offset = 0x58,
+		.regulator_names = mahua_tcsr_tx1_rpt012_rx2_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt012_rx2_regulators),
+	},
+	[TCSR_USB2_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_1_clkref_en",
+		.offset = 0x6c,
+		.regulator_names = mahua_tcsr_tx1_rpt345_rx3_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt345_rx3_regulators),
+	},
+	[TCSR_USB2_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_2_clkref_en",
+		.offset = 0x70,
+		.regulator_names = mahua_tcsr_tx1_rpt345_rx3_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt345_rx3_regulators),
+	},
+	[TCSR_USB2_3_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_3_clkref_en",
+		.offset = 0x74,
+		.regulator_names = mahua_tcsr_tx1_rpt345_rx3_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt345_rx3_regulators),
+	},
+	[TCSR_USB2_4_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_4_clkref_en",
+		.offset = 0x88,
+		.regulator_names = mahua_tcsr_tx1_rpt0_rx0_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt0_rx0_regulators),
+	},
+	[TCSR_USB3_0_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb3_0_clkref_en",
+		.offset = 0x64,
+		.regulator_names = mahua_tcsr_tx1_rpt345_rx3_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt345_rx3_regulators),
+	},
+	[TCSR_USB3_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb3_1_clkref_en",
+		.offset = 0x68,
+		.regulator_names = mahua_tcsr_tx1_rpt345_rx3_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt345_rx3_regulators),
+	},
+	[TCSR_USB4_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb4_1_clkref_en",
+		.offset = 0x44,
+	},
+	[TCSR_USB4_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb4_2_clkref_en",
+		.offset = 0x5c,
+		.regulator_names = mahua_tcsr_tx1_rpt01_rx1_regulators,
+		.num_regulators = ARRAY_SIZE(mahua_tcsr_tx1_rpt01_rx1_regulators),
+	},
+};
+
+static const struct tcsrcc_glymur_data tcsr_cc_glymur_data = {
+	.descs     = tcsr_cc_glymur_clk_descs,
+	.num_descs = ARRAY_SIZE(tcsr_cc_glymur_clk_descs),
+};
+
+static const struct tcsrcc_glymur_data tcsr_cc_mahua_data = {
+	.descs     = tcsr_cc_mahua_clk_descs,
+	.num_descs = ARRAY_SIZE(tcsr_cc_mahua_clk_descs),
+};
+
 static const struct of_device_id tcsr_cc_glymur_match_table[] = {
-	{ .compatible = "qcom,glymur-tcsr" },
+	{ .compatible = "qcom,glymur-tcsr", .data = &tcsr_cc_glymur_data },
+	{ .compatible = "qcom,mahua-tcsr",  .data = &tcsr_cc_mahua_data  },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tcsr_cc_glymur_match_table);
 
 static int tcsr_cc_glymur_probe(struct platform_device *pdev)
 {
+	const struct tcsrcc_glymur_data *data = device_get_match_data(&pdev->dev);
+
+	if (!data)
+		return -ENODEV;
+
 	return qcom_clk_ref_probe(pdev, &tcsr_cc_glymur_regmap_config,
-				  tcsr_cc_glymur_clk_descs,
-				  ARRAY_SIZE(tcsr_cc_glymur_clk_descs));
+				  data->descs, data->num_descs);
 }
 
 static struct platform_driver tcsr_cc_glymur_driver = {

-- 
2.34.1

