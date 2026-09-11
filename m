Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081604BEE41
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163607; cv=none; b=sMqx00bl1mWMM19VIa5KldCoU0lXGsTuVFMLIDXeTuQfD7Gjp0kWGgvEUoeJ73DSoQVYPLw1eF24hpT8Dh6tEx5unetBSxbMzRSOzjxTybAIJfgGEiKokYIgG2laybF3FRwA5rBsKxLcv+xnAvEIs85Syetyh9q6WFjDleajzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163607; c=relaxed/simple;
	bh=QTAAvVo+D7Wnc9KGN3ZO+mOdZs3GkHWnL/npgBHGXy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc/yZlIjP9kwYwUZZ580Z+DyrkiMYH5bKY0rGo2p8aQndYwgHBaK1uHtDCaTX/DJub8UikipG0luTLB3xaB+UUcPoiM7TBfK48EkmX6DiS5mmQvvnwxOW9TFT+jM0q5sA5qsCMrMK6+kDaTlU8zdcUAuE2oJ2AdH3LICbTNgac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llWp0jX3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QxIYNrd4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llWp0jX3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QxIYNrd4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWVIe972048
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 21:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMv
	tXE1Mcqk=; b=llWp0jX3cIf3nmN3w040iOOyH2DoQUiIVWUMGPHD7xvNgEBWz6r
	8aBOFWXOIq60JMJ2+yUX/8tix8JIxcdVj/WdmWA3inMyc2MnYicr1a5bvnPr3kwg
	LmN5ra7vLGRHwLw3GGW6JBFusqyQOHn2nyztRMDDGdKTI3NGSOaHcMuuXpwU5Ap/
	ZJHjYftaYKaw9P6rOoQCUvTkuMuyZFjgYp8Xi8nC73ZIYwfDGqxRtLpBAZBSzuac
	bY2k4aFcVFSH2Pt28JBNgjgqu6EvXNOqQtlbkPJ2GJVrQXVCmg3cT68e92fYdZkJ
	xsWZ+UNNdO3RmaH6aG/RAKwUHkph1aavltg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22sf0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 21:53:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2521724a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789163604; x=1789768404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMvtXE1Mcqk=;
        b=QxIYNrd4DB/3cu3wJhqBG3UuVMFjN89TwxlHTKLO5tRNfPvRhAK4AAVuyRQTbBhtcu
         rQoyqutUPY69RGL7cWyodWiCVkAYBLab+No8JLzmILwnHr7CiSOot7kOqvv+CFyvaIrU
         FPL4t71SsKWlU3VNOANtgp4adLqrwnwbyMumG7PF9S2m4QQjSThKp2FPxoPXbIuqLxOF
         uptthC7ScYZ3Q65EYZVaKeNQFB0tzGzkX49y3DxuIbpRuPfNpTwQNYS20hZWs9JtngGn
         BTZdFezoZ/X0eRb+OO+S7GpB70ujHxhZ0QIGFu11z+J/cLuLILPvKaBwQPbiQg7fzU7o
         CgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163604; x=1789768404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMvtXE1Mcqk=;
        b=ZU8HdAp9b1KlSxgnGze0H21p6L6/fdtTX8QXm5/DEU3s0hf30F4uzNdX11dXBXfGeA
         +zUMjTO2y1XcvxOyK0A1L5R5MLXdjOEvfv4h6hKJolaVQSNb5z+YCVgO9359AjYNfrDF
         33FNADUytoSlc0WVj52SfVduoXwPanvx25J0YBOohxVcmJzpOBD8LWROOnw3w3yq3NRE
         NwPO8xIK1cA2TwnOex1qoAA5IaAj9xyU24MGWGlaoUg6eduZDuut8nE4G8uVUJKhbX83
         L8ipTwlFkWVVxDD1EtHxZSoiRDX7OAjJcQY31iWaF1GwDDKfasfgFtWY+W88gDdVBaYl
         8giQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBWQnKsr821WnrUj1tcRfjZzZgrF70FbI3ZeVAi2mOoxeKFqWt9PVRXC1AyhBglYUxGGqyaX8VqNyC0QDbyDw=@vger.kernel.org
X-Gm-Message-State: AFuF++mXkVQJLt0N3htY1drrojpZ/t+7nQP6MWO/KS/cbiI8Cy5Yu9h7
	vIG42yVMlJHsjxNKbK6N+Gbb0LjenE+fwW6DCbnpDUeNxjWYF6hOEcN3EiVVTfxo5DWB7x8BNsC
	ORMdXS1rcnRUWpstUH6hvLTnw+vBecyMHiQ8f6LDlFFdwC3Lyfsyu4MnSGwK2k8kA4476C5Y=
X-Gm-Gg: AYBFou1g1jLNiIDZ2bQ85Khjz4fbr9JGZkAMcFaAWskLhq4rlTn0nd/A7Wy829W8JoX
	ADmRYUld/WijGXnS2paECKAxqZ2tRBey/0Nutf7UDieX/9zoZeBEok7rBZS5mF34VGfBUYb077+
	IrNHDqnYU/dGo+zdeuwa1EPJHLMhcrvEgjvmdtq4usvQYcc6qWg/jxO9TSNUr5iW0Oe3x5lwaVH
	JHaVVkG22OriorCBLmnTKUhvwdlCncC7T6NVXAjPyOYamPIk78/87QkpAJN1eBrvDCP0T4njP4Y
	seEPaO5gKLnJugjG7onMRTq8RCvSca/MSC6+wwvs15DoT+xw0YqLxVAJenl0r4Qawmv/UE8eHst
	rEHGd8VvndoRIEI0SquurwhBjLcBGlvpq2lZ4PfM9gRpGXh0uuw==
X-Received: by 2002:a17:90b:3850:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39d9c36187amr9706298a91.22.1789163603681;
        Fri, 11 Sep 2026 14:53:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3850:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39d9c36187amr9706262a91.22.1789163603274;
        Fri, 11 Sep 2026 14:53:23 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f739b5sm9100610eec.25.2026.09.11.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:53:22 -0700 (PDT)
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
        Li Ming <ming.li@zohomail.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: [RESEND PATCH] cxl/features: Ensure that count is set before access to end[] __counted_by()
Date: Fri, 11 Sep 2026 14:53:04 -0700
Message-ID: <20260911215304.1816467-1-ashok.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMxMCBTYWx0ZWRfXzwPHyrC6wcHb
 FyTKZtQi43Y+CWZ1+ZsCjKKnHFwWe7rNQkDY2gmq6JeLfdieB35FVhSz9e2cMHKgQuTq2izHTvf
 CWU0toVX094HKDPXNKmnbXPY3dQ2JeM5w52WeZ8m/SEGCZv3FpnZA8FMwYYOFzQ2CjUQ5FNzPJn
 aLlJ5kETnSq1t4R54JE4/ytMGM1Ryp+S2rX0wayii3cBox62kbMbPVb+Nyj8rN+bNaTO4ZfGs50
 TYGDUoJNwmB6Eu9E1zoU1Sh13RBkvF12YHB89gg/u3BFJcMMtgBN1QPCSGk6F37XY9TUkGy/Cck
 j7pS2oxDniJNPpCX5y1U6psQBssj5cDETm2IxdgBULAn1VeyB1NxhLZ3EBMLIrxRw8u9WCv3c8J
 i5DPFs2iLRGK9TNoxz62K+bSeFpxU+thlZvDXEQU3Wfe0p6z7rigp/KhyB9NOViNOkJnZudc62U
 xoXIpNT/LCRYi0ubhFA==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa47854 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=hVXjItmcbegfcmPrdh8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 9s5pPMhSjru9zJmGvmheC8tq53vWep7t
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMxMCBTYWx0ZWRfXy/hIZ5IvQ+pg
 4HO9rVXc0S1qaJVL4PblPOEzTYZYTlOS8PWAOia2fqvlyksz+QIDSW673pADbJaEhpOJoZTNvlm
 tismjnUeo6PhOPn6XOOheYEH0FHLDfw=
X-Proofpoint-GUID: 9s5pPMhSjru9zJmGvmheC8tq53vWep7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110310

get_supported_features() assigns entries->num_features only after the
memcpy() loop that fills entries->ent[] has already run. Since ent[]
is __counted_by(num_features), the compiler's bounds instrumentation
sees a 0-length array during that loop and FORTIFY_SOURCE trips on
the memcpy. Set @num_features right after allocation, before any
write into ent[], so the bound is correct for the whole lifetime of
the array.

This was found via a fortify panic:

 memcpy: detected buffer overflow: 384 byte write of buffer size 0
 WARNING: lib/string_helpers.c:1035 at __fortify_report+0x54/0xa0
 kernel BUG at lib/string_helpers.c:1043!
 Call trace:
  __fortify_panic+0x10/0x18
  get_supported_features.isra.0+0x4a0/0x4d0 [cxl_core]
  devm_cxl_setup_features+0x84/0x120 [cxl_core]
  cxl_pci_probe+0x254/0x5e0 [cxl_pci]

Same class of bug, same fix shape as commit 6c9d2e87df40
("cxl/fwctl: Fix __fortify_panic"), which fixed the analogous issue
in cxlctl_get_supported_features() but missed this one.

Fixes: f0e6a2329bf9 ("cxl: Add Get Supported Features command for kernel usage")
Signed-off-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
---
RESEND: Dropped the mailing lists (linux-cxl, linux-kernel) from Cc
by mistake on the first send. Resending with proper Cc.

 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ba6d2a5acb74..754fe5eb4b76 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -97,6 +97,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		kvmalloc_flex(*entries, ent, count);
 	if (!entries)
 		return NULL;
+	entries->num_features = count;
 
 	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
 		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
@@ -174,7 +175,6 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		start += num_entries;
 	} while (remain_feats);
 
-	entries->num_features = count;
 	entries->num_user_features = user_feats;
 
 	return no_free_ptr(entries);
-- 
2.43.0

