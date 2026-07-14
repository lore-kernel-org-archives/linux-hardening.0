Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9522F7F15
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005199; cv=none; b=i/0C4k2wVa+jFK6EfUgHXt5tFz5vNXpf4P4yFhTGL8WXD/fHhzD1roz/Cu4XTYA3Wv5inlQs5fgHjVXDHWc2GzqaRove2Ejd9Pmyf74dXS927Qj4U0l4SriDEKunZwWy/EuKoKwTgFQMUXNtnneFNUHCaVp9Efx7RFwwdUCrNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005199; c=relaxed/simple;
	bh=pTlwddmTycyPkW9d/VBQWH4fm4KmS5IzwKf5KplpJzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5JAK8bTWTNY3AfaPNs7VfFnhCSqGn//vHRMQGdbEVe235ktTE7JYOpM0T/yFrk57EnnwxcPijxBQ9mkQY8h4XBRxWnGma+h5lPSKlJeJjCD3SpxRmBf7T6HuHCeCMmQhVHmqw42o2vTy/kxx7PYG8gdvezAzzP/bWJj72Eg/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GO3Pl79t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SbsnYJgT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GO3Pl79t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SbsnYJgT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E389qc3181875
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=; b=GO3Pl79tjLyiYtjv
	3ZobbgR/OEFi4Rt1bb3QKymkeNXKhEK9BKcVDCvZ4iaa1xpM6Oi527Naxa/HK4ki
	v0JFfnDa73rl4jtfS4QmlhmxkqvlrgLeZaR05/0P2vlxPobLgYg+Du1KHvHkEdqr
	EU1fcDfmSKhgksn9F1/8pdMJpFXL0bPw2LVMIgdtDzMkFtqc8QvlGY1lcOVb2NSz
	qmRks9kcorApy4aqSyOR8ceJiTHfVWpwUE0fFMRT40/5y5RqIJ1QJ9tM9+w0H0rW
	cXu1dToCUbNbPmYVFMON/9yrVuzguwIpuwecx2Bj2v+1sJ5j2dJFnDbE3RcPSLIo
	Unsd6Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4quyd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811ae55313so590436a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005195; x=1784609995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=;
        b=SbsnYJgThEWt8rsXRzFgq8nJ7Kna8xdAO/6jlxzNdf26m8Y5Hz4JTY9ewHOA+jd1aX
         PwV4Rg57ofK7qQkQNiKGxNs/1KAY8CzQ52o7LLZwXODhWLLkhbPJYi46PbVyEUrU6pga
         dUTUTgniCFTBnq6BSvpCfk9b0x3HHZRgzOaWCpADh8qqndSqPkvQJIRWmvmYTy7iFLj7
         jBQT+VYUCoYq1rWFEcxPFBFFXDjIsAzG+L2d42CU6sAX6qleoW8SmjTK5E2Cfmlv9fUw
         2JVoneGzr0AORK9YOUHompOG17IaNwit+sEMfPlKQvz1ZX9rDY/1OFRa8TzJnvmMW2BR
         mwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005195; x=1784609995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6+9CAb5oIeEq/75hDaTBkW/kIiBHy6/MLkP9kjZUqI=;
        b=sE/uZRuo8TdreyEpztp5cmZ89HIbnbwv9X7e9UNHu8S5Icf7sQ/dfIZOfySPxkRV02
         vjGwp5Bp5v6h6Zz6U6QwQm6C+l2Otu+rGJjrsPXmNNRWGEBJGLUUpgkaoUsvFerpaPcs
         +PMAwWwnAStOWWwRkOiz8XT8xdA5gUSOfmCm851kNnJ1AG2J/Bqr3uk9xGD1TI/qgFfE
         cSdSlEdgPhAMqaYjoWaiF+fNjBBiE9lcKCyQr8HupN7DWEdbmiQT8UJtzWxQLbGlku5N
         cPPio8kF9FNYrvuxJsC7ZMz12uc0VJ46XaYpf69gfaUUy4fV+nAh2cRGYMqxUeoe22EO
         AqFg==
X-Forwarded-Encrypted: i=1; AHgh+Rovh0meGx2tN11WJHIRR2IPaNt0qdPsZY2W2iCLIrNqs2KW1PxDZQYfAFjYo9oQMCrd78Ni7nZU7ucFlj2SNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgsBQ2O4Fj7zW329DvtqxwTj2Ku7N870+4VWncGtIZG3itYxU
	ilq5mw9RArQpWL93WhhwCpgk/wUhtiLTrBRcLJPAvF7R4pCW8Wlgk+9Kfitfjmk8vToVDdXNpOJ
	cAhXLAw7HDhesYvk6iTYhLcFF29KfWJB5ioeJLjcABe9icc4R8c0Ej0+pYUwBjqWpybPu1vI=
X-Gm-Gg: AfdE7claegcvW0OsdvuAam4SO1xr9wOFiMwmH/roKPLdbyxGGrFCPsUMvyNVh2bI8MF
	LjEGkGUjN7B4+VuW6DKvkBjOkuEhoDlnfL+zzRSdBRTuhyK2uKk4mMS0V0u6xi2clMA2UbVH/kZ
	nh6T4ZphCYJOceMD48G81ODestEz2bQ1UtOvxVxJjxikupuxbPiYM6b5IBQZTVjkqZp9aS4ThSs
	bRCCTYtNPlt8Mdd78HjPvSAizy1QQFC8jD5TTI1Spt9LscYvFUleLi40uUqPYxNpyoiJiTsDa9F
	M2tC8ekEYUlkgSLUOmofS0MZpiSz3P/drddyXAHwovpbiQfOmR7u4Nv+rwCHhGN2/gWhh4RE78n
	L7Osc7jePqdx8KEFcixYpAAUuDw4SjIJ42i17dgnHqwiQrPZ2cfNO8apXiQ==
X-Received: by 2002:a17:90b:5583:b0:387:e0db:bc35 with SMTP id 98e67ed59e1d1-38dc7bc71d1mr9815727a91.43.1784005195365;
        Mon, 13 Jul 2026 21:59:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5583:b0:387:e0db:bc35 with SMTP id 98e67ed59e1d1-38dc7bc71d1mr9815703a91.43.1784005194673;
        Mon, 13 Jul 2026 21:59:54 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm41874021eec.15.2026.07.13.21.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:59:54 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 21:59:39 -0700
Subject: [PATCH v9 4/7] clk: qcom: tcsrcc-glymur: Add regulator supplies
 and migrate to clk_ref helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-tcsr_qref_0714-v9-4-373670ab15f9@oss.qualcomm.com>
References: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
In-Reply-To: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005189; l=13220;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=pTlwddmTycyPkW9d/VBQWH4fm4KmS5IzwKf5KplpJzc=;
 b=htNSlp076TtyNY83DPY5pK1fkC3dZBWldZPL3LEXon5O5Nvng1x0xtWPEeWpv8Gbzi/mCe1zv
 mTKZHws9JFBDA4Vmxa5Mb8Y95HrbhKW8u3vrgeSnMUpEWJREVHYUr7H
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX93+Jxj4nowO3
 8rb/OOP79vf66EKlrxulPy00M6Bz3+S2hFpuAXy+IvdA/CfVjSD68GhHVjTFYo5znEnNUzApY9w
 Q5m0jBMy7/XSibrmnnVSLwXizNjOkZfii4GUrLCCDm0P0gK0awrOLOGdK6NHuMwDfAGldDBjORa
 IUSrpI6lJnsp9kLTFsyr4/EQWeII+CecwFU59qKzExYc/U4ABJHgleqXkvZUofZyPiTwqIVEiKI
 f53bosB4dWnG5OMrzhAwX3BoVoIa0cHwl7z71vtFp9cb75F1Q5oS8uljr9LMH5buf72iPGAY89O
 n+llpdqGGdA9fjtl0za4NqUynPY2OIMwFZYjXQJzVZhO2MmQ3ZG3ohk0/9mnwsW4sjsg28UVHqp
 RHTytlii3Dl2auJRm6vENP1U3Zx3uNDw0jf2kC4nnJy5XhRbxdnwRAEd1YwnMJDxtXUgVZ20MzY
 DWISR8jQXzDygsyv1Kw==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a55c24c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QwI6o0JXcUMaZQCC76IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: DgYj17QFu3_1pkyqdGSXmdiFIU5VXpwi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX03MzkVmm0u+l
 AMpGNznL3rgx/vNIOFcZk76BMO2H1D6NFD5Pgv03kF7GcI2P86J6YLUITdhn6taW3csZus+ZiFZ
 NKgjLrwpgSdBErgcVmX26+hOO65nO6A=
X-Proofpoint-ORIG-GUID: DgYj17QFu3_1pkyqdGSXmdiFIU5VXpwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140047

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

