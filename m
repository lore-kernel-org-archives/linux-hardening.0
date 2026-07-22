Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F1331ECF
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699951; cv=none; b=BdBkbNp7cURx1wc7ZnUPwGgx/E4IZYVwqhUnynKLQze33Upt/w9O6scM33Rz/XQART/2gjvQscSE2c9xb6tCXrmgXPfgpmmJ5HYKTt+TOuVAirqxjhnjEiHPjiyr3plV1dQnJYb9zW1c8JW30yfkynrIGW9F0S+68TkRcGCopSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699951; c=relaxed/simple;
	bh=pTlwddmTycyPkW9d/VBQWH4fm4KmS5IzwKf5KplpJzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4cwegN3uOJsQFmpcRNWjNLt9fBBtcui+8bPqG3ABKCqyHhXQIEfhPKFmT1nS0FyG0TamIqo378tRdE+G8106Kv247xsARpcIQidC1LdoboP7Pq06cn5EIKzrMhedrUIKAqwURwzam+oIWbTJvKnMiZSE2RrY9k+iU8iSPV0kgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P90alrcA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7R5SVcf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P90alrcA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7R5SVcf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M54FMb853698
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=; b=P90alrcAK7/3ZqNT
	FwdczJv05vCbr0WLdlTmJBgiBfsnu1hriGzLMipqUnVqRsYklXJw0426G3M/E+Le
	eRbI0Fdt5EBNmpPZf3gvQIC181rYwho16bBM4bUfOnoVFm/aTCQ99KkrVo2Om6qc
	2vnzeMLpK8N091cDF8K/J0vnhWUev/k/zRpkKEfgFbZnAwlD+S/jgDjpAFqEI6KM
	HUp5Dd7zE05Qc2N6p6twyrXeiTkmq9Bj2SJ7icA1bX7gxZHTy6jLa8RMM2vzGJrD
	4y4U0RGNRfcWllIvtClLNtCQ6s/bJcvN2hprIpe0+z9BNHtF8cFVYXfdth5HzAWm
	2X2dPA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nsvmge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84240683a82so5511381b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699946; x=1785304746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=;
        b=E7R5SVcf2Y6AWAN2QJZUIRpfc6ZJ4j0SiMU2THzVkhGpc3axW1T3z5M+XICSpV152i
         LFedbmPfPZSwJ0Vd01gao7KHpQ+Q7i2EzrWzmuYfPDiC3T3UJHasFZieHhT7JBzLrPnp
         h/56u1N/79pFJ+fhNBo8g53ddEnJqkY2EQYKyUkijdo1uPKP8nTb7nDtL1vrVDEJmRma
         /AesqWT39P4iuJYOoNZydSowkaZzHbA0Lwqjyp6k3fI2Vy8sz4Jwyqv3Jvqqdw5Yg1hA
         P6vndtJ5zaIC20rzOLyKXf9DbCQHTWh4EhxYSUFdd91Vhh+4vPbrUk52Gf2gkfGEI50E
         2AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699946; x=1785304746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=;
        b=I2d5EawDq4feoJrg5fHo+z5kVCEDcvnsMR8FwuxmAEPI+02+IU6PweGADHXNesRpAI
         tlMajUh4TzASFvASDF/KiVJPW8tniMy1GsD9JIYH+Oge0tVfMnpcUhWGL54GidIAbWoy
         b3ux7+kL4uh+WHUfgNXVXk3cqOTTjYYuSnZiNfmSSTgFasUL3Qa5bKjkG32JQ4SyS6w6
         bDmXFvsJDMoTZAWJFHmsFWgcOW2fInVYZ4kv5nT+h3MPxjFA173sr1CvEsPjKLQRcFdS
         lgkhKngW+/lAJRdGr2elUc8YGcPotKWoT/hjjF+MbN/XEPgIdaJ3a4ceYhpN6CPmdOiX
         UtKg==
X-Forwarded-Encrypted: i=1; AHgh+RpUClgnpQYwjHGklrO4f30bhfJ+xla2wzWrga/QarEp/uQPV7AG49ARIIINCE8XEEqOqxAgrq4iWAR+kjhj/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsD+MmtTlbh/iHTXt6XES2BjL53hATQ20K/9sKhVCnbv7udzWD
	jc3N3DxR+kyvg3ESR4tXRQtzFXw785vlzFV5Pv9wXolntnWMAtu1pnhRepHKOj3lCULkoXDL5tC
	qg7r91mqVqPTNpEvSRlvjL6Mi97QHlyM/iZNwpY16wMhqSnm/9iEqFcxndeU+QXr6+8n3Fto=
X-Gm-Gg: AR+sD10dXvzV13rOALmAE1OdNTMFTnVpr1MmhGytD00I4VqXYl65MIE9LPr5nW4rwDV
	vqD43IANiyHsCIV/h1j9rA5a2k77HZRAEoH12PCXCBuJEqWP3v3TmwhnlKMkgRUwDFI9yJt/RQQ
	nD5GyqeT1ziGLaEgC6q/JAXhlElUSjCqX5tTgglVTAPDT1Cgu+Z5mtHbvkC7vf4flLybrjSnIUh
	DxbOW3uWTXCeEcGZoD4t4t+gllLrnyCCfAJRD+hO7e4WBt6zWKFx5SaTmJuIk8b2YsnNKWWxChi
	S5IltCOuLNUY4J3BIQ2wxSsUhbBaIgNCFNag15zboYtwW3BzPkrNtkvPgLdky2frrR6oGB8y94g
	MvElXtmSqFDQDVhx31NtecqKcPYVBt/tusYQk5aDaxSeg7L4=
X-Received: by 2002:a05:6a00:1f04:b0:845:dcc8:9da with SMTP id d2e1a72fcca58-84e16292032mr2435435b3a.22.1784699946067;
        Tue, 21 Jul 2026 22:59:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f04:b0:845:dcc8:9da with SMTP id d2e1a72fcca58-84e16292032mr2435411b3a.22.1784699945563;
        Tue, 21 Jul 2026 22:59:05 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:59:04 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:58:59 -0700
Subject: [PATCH v10 4/7] clk: qcom: tcsrcc-glymur: Add regulator supplies
 and migrate to clk_ref helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-tcsr_qre_0721-v10-4-d2fa68c63b78@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=13220;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=pTlwddmTycyPkW9d/VBQWH4fm4KmS5IzwKf5KplpJzc=;
 b=MeWQzBuCx9IKN+yKyOO4deANL7VVbBWooOLyBCEFcJP3sS13RyJfga/CSixtjyLLSWYSjxWpJ
 A1/1dvWro29CB0yRfL7/XLlXGDAxJ9VbkFm/OixkMJzsmcHqAjk7oh6
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: OuG-CoSDFDLkx4xwTSHvTsPkqpABlevN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX9yG2o/jbY8EC
 UPUoy3UmOHpesU+NH7StZ1Vzt5NTpq/lFaksxw41zgaoIZPZQobIWi8uWlXZbvj9OndpUAR/nqe
 C68vExgWAreG4VwF5jJHhf3zt3jH+8c=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a605c2a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QwI6o0JXcUMaZQCC76IA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: OuG-CoSDFDLkx4xwTSHvTsPkqpABlevN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfXzGtHQ3HJCeK0
 85MyN9SBM2CQSMijr9tSiZxmbThY1biaxoKB7gtAm106AKJSJGHKmIX+KL0LjocA0PDs/DMHURr
 Zsw4HXrI7o0zr2JumcWSyd7R72NFkDyaWggUpnwThhwJhtcWuVjwniUILKJyOH7j99nwkKmisSB
 ckCnNH+xq1ZJxsjEn04tyf9MlPdq6WKpp8yF0ROeMJ98p9IK9pbuigSHnlnzz8njZgX6OIsAzp9
 CFr90h8z9txmSuPuE88ehQ8bMJHatK6ixOvQGdvl4pShZmfk3zE1Ua6hE/6XPVnZfrJQ8jtOQy3
 hjqIwKhysDe2E+O5PWzGq/GU2GnfCgvd0ottf2kJVVNyfnwcP0j8+tAXN2GmeuCJq/DerzRa9Zm
 qRlNEXNiT1U0wgC/EhsMV+oBiglSzL1Bf5eQDU9NEgVF2Ooy7ZZVI6ZPSSc/U0sTPJgtSXgDR+F
 Eel40BqmMyGzCTuJShQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220053

Replace local clk_branch-based clkref definitions with descriptor-based
registration via qcom_clk_ref_probe().

This keeps the glymur driver focused on clock metadata and reuses common
runtime logic for regulator handling, enable/disable sequencing, and OF
provider wiring.

Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/clk/qcom/tcsrcc-glymur.c | 361 +++++++++++++--------------------------
 1 file changed, 116 insertions(+), 245 deletions(-)

diff --git a/drivers/clk/qcom/tcsrcc-glymur.c b/drivers/clk/qcom/tcsrcc-glymur.c
index b44fccb795c6..e0b545258ba4 100644
--- a/drivers/clk/qcom/tcsrcc-glymur.c
+++ b/drivers/clk/qcom/tcsrcc-glymur.c
@@ -4,276 +4,145 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clk/qcom.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,glymur-tcsr.h>
 
-#include "clk-alpha-pll.h"
-#include "clk-branch.h"
-#include "clk-pll.h"
-#include "clk-rcg.h"
-#include "clk-regmap.h"
-#include "clk-regmap-divider.h"
-#include "clk-regmap-mux.h"
-#include "common.h"
-#include "gdsc.h"
-#include "reset.h"
-
-enum {
-	DT_BI_TCXO_PAD,
+static const char * const glymur_tcsr_tx0_rx5_regulators[] = {
+	"vdda-refgen3-0p9",
+	"vdda-refgen3-1p2",
+	"vdda-qrefrx5-0p9",
+	"vdda-qreftx0-0p9",
+	"vdda-qreftx0-1p2",
 };
 
-static struct clk_branch tcsr_edp_clkref_en = {
-	.halt_reg = 0x60,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x60,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_edp_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
+static const char * const glymur_tcsr_tx1_rpt0_rx0_regulators[] = {
+	"vdda-refgen4-0p9",
+	"vdda-refgen4-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrx0-0p9",
 };
 
-static struct clk_branch tcsr_pcie_1_clkref_en = {
-	.halt_reg = 0x48,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x48,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_pcie_1_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
+static const char * const glymur_tcsr_tx1_rpt01_rx1_regulators[] = {
+	"vdda-refgen4-0p9",
+	"vdda-refgen4-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrpt1-0p9",
+	"vdda-qrefrx1-0p9",
 };
 
-static struct clk_branch tcsr_pcie_2_clkref_en = {
-	.halt_reg = 0x4c,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x4c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_pcie_2_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
+static const char * const glymur_tcsr_tx1_rpt012_rx2_regulators[] = {
+	"vdda-refgen4-0p9",
+	"vdda-refgen4-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt0-0p9",
+	"vdda-qrefrpt1-0p9",
+	"vdda-qrefrpt2-0p9",
+	"vdda-qrefrx2-0p9",
 };
 
-static struct clk_branch tcsr_pcie_3_clkref_en = {
-	.halt_reg = 0x54,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x54,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_pcie_3_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
+static const char * const glymur_tcsr_tx1_rpt34_rx4_regulators[] = {
+	"vdda-refgen4-0p9",
+	"vdda-refgen4-1p2",
+	"vdda-qreftx1-0p9",
+	"vdda-qrefrpt3-0p9",
+	"vdda-qrefrpt4-0p9",
+	"vdda-qrefrx4-0p9",
 };
 
-static struct clk_branch tcsr_pcie_4_clkref_en = {
-	.halt_reg = 0x58,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x58,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_pcie_4_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
+static const struct regmap_config tcsr_cc_glymur_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x94,
+	.fast_io = true,
 };
 
-static struct clk_branch tcsr_usb2_1_clkref_en = {
-	.halt_reg = 0x6c,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x6c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb2_1_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+static const struct qcom_clk_ref_desc * const tcsr_cc_glymur_clk_descs[] = {
+	[TCSR_EDP_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_edp_clkref_en",
+		.offset = 0x60,
+		.regulator_names = glymur_tcsr_tx1_rpt0_rx0_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt0_rx0_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb2_2_clkref_en = {
-	.halt_reg = 0x70,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x70,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb2_2_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_PCIE_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_1_clkref_en",
+		.offset = 0x48,
+		.regulator_names = glymur_tcsr_tx0_rx5_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx0_rx5_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb2_3_clkref_en = {
-	.halt_reg = 0x74,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x74,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb2_3_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_PCIE_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_2_clkref_en",
+		.offset = 0x4c,
+		.regulator_names = glymur_tcsr_tx1_rpt012_rx2_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt012_rx2_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb2_4_clkref_en = {
-	.halt_reg = 0x88,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x88,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb2_4_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_PCIE_3_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_3_clkref_en",
+		.offset = 0x54,
+		.regulator_names = glymur_tcsr_tx1_rpt01_rx1_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt01_rx1_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb3_0_clkref_en = {
-	.halt_reg = 0x64,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x64,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb3_0_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_PCIE_4_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_pcie_4_clkref_en",
+		.offset = 0x58,
+		.regulator_names = glymur_tcsr_tx1_rpt012_rx2_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt012_rx2_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb3_1_clkref_en = {
-	.halt_reg = 0x68,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x68,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb3_1_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_USB2_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_1_clkref_en",
+		.offset = 0x6c,
+		.regulator_names = glymur_tcsr_tx1_rpt34_rx4_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt34_rx4_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb4_1_clkref_en = {
-	.halt_reg = 0x44,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x44,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb4_1_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_USB2_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_2_clkref_en",
+		.offset = 0x70,
+		.regulator_names = glymur_tcsr_tx1_rpt01_rx1_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt01_rx1_regulators),
 	},
-};
-
-static struct clk_branch tcsr_usb4_2_clkref_en = {
-	.halt_reg = 0x5c,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x5c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "tcsr_usb4_2_clkref_en",
-			.parent_data = &(const struct clk_parent_data){
-				.index = DT_BI_TCXO_PAD,
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
+	[TCSR_USB2_3_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_3_clkref_en",
+		.offset = 0x74,
+		.regulator_names = glymur_tcsr_tx1_rpt34_rx4_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt34_rx4_regulators),
+	},
+	[TCSR_USB2_4_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb2_4_clkref_en",
+		.offset = 0x88,
+		.regulator_names = glymur_tcsr_tx1_rpt34_rx4_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt34_rx4_regulators),
+	},
+	[TCSR_USB3_0_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb3_0_clkref_en",
+		.offset = 0x64,
+		.regulator_names = glymur_tcsr_tx1_rpt34_rx4_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt34_rx4_regulators),
+	},
+	[TCSR_USB3_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb3_1_clkref_en",
+		.offset = 0x68,
+		.regulator_names = glymur_tcsr_tx1_rpt34_rx4_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt34_rx4_regulators),
+	},
+	[TCSR_USB4_1_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb4_1_clkref_en",
+		.offset = 0x44,
+		.regulator_names = glymur_tcsr_tx0_rx5_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx0_rx5_regulators),
+	},
+	[TCSR_USB4_2_CLKREF_EN] = &(const struct qcom_clk_ref_desc) {
+		.name = "tcsr_usb4_2_clkref_en",
+		.offset = 0x5c,
+		.regulator_names = glymur_tcsr_tx1_rpt01_rx1_regulators,
+		.num_regulators = ARRAY_SIZE(glymur_tcsr_tx1_rpt01_rx1_regulators),
 	},
-};
-
-static struct clk_regmap *tcsr_cc_glymur_clocks[] = {
-	[TCSR_EDP_CLKREF_EN] = &tcsr_edp_clkref_en.clkr,
-	[TCSR_PCIE_1_CLKREF_EN] = &tcsr_pcie_1_clkref_en.clkr,
-	[TCSR_PCIE_2_CLKREF_EN] = &tcsr_pcie_2_clkref_en.clkr,
-	[TCSR_PCIE_3_CLKREF_EN] = &tcsr_pcie_3_clkref_en.clkr,
-	[TCSR_PCIE_4_CLKREF_EN] = &tcsr_pcie_4_clkref_en.clkr,
-	[TCSR_USB2_1_CLKREF_EN] = &tcsr_usb2_1_clkref_en.clkr,
-	[TCSR_USB2_2_CLKREF_EN] = &tcsr_usb2_2_clkref_en.clkr,
-	[TCSR_USB2_3_CLKREF_EN] = &tcsr_usb2_3_clkref_en.clkr,
-	[TCSR_USB2_4_CLKREF_EN] = &tcsr_usb2_4_clkref_en.clkr,
-	[TCSR_USB3_0_CLKREF_EN] = &tcsr_usb3_0_clkref_en.clkr,
-	[TCSR_USB3_1_CLKREF_EN] = &tcsr_usb3_1_clkref_en.clkr,
-	[TCSR_USB4_1_CLKREF_EN] = &tcsr_usb4_1_clkref_en.clkr,
-	[TCSR_USB4_2_CLKREF_EN] = &tcsr_usb4_2_clkref_en.clkr,
-};
-
-static const struct regmap_config tcsr_cc_glymur_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x94,
-	.fast_io = true,
-};
-
-static const struct qcom_cc_desc tcsr_cc_glymur_desc = {
-	.config = &tcsr_cc_glymur_regmap_config,
-	.clks = tcsr_cc_glymur_clocks,
-	.num_clks = ARRAY_SIZE(tcsr_cc_glymur_clocks),
 };
 
 static const struct of_device_id tcsr_cc_glymur_match_table[] = {
@@ -284,7 +153,9 @@ MODULE_DEVICE_TABLE(of, tcsr_cc_glymur_match_table);
 
 static int tcsr_cc_glymur_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &tcsr_cc_glymur_desc);
+	return qcom_clk_ref_probe(pdev, &tcsr_cc_glymur_regmap_config,
+				  tcsr_cc_glymur_clk_descs,
+				  ARRAY_SIZE(tcsr_cc_glymur_clk_descs));
 }
 
 static struct platform_driver tcsr_cc_glymur_driver = {

-- 
2.34.1

