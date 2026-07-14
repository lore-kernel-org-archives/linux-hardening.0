Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D92E2DFB
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005195; cv=none; b=N5MW4hQb5bRneCu12aN/dcJ62h+acKs8CBqdOF11mALqVGdRvQKBdKK73ydVzGcVUBDJaRXrmeZZ1PHWiBPbzND/Y8kNAzPU/bU7Qt5VaJwYRCvSbxrYMX3xlZbWS3lZl+rjYsg2qVK8MyKCW1VVBAsTETDciihVCJ7QGEPYT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005195; c=relaxed/simple;
	bh=v2LF2JjTn8nWjxUScg6pd9H3AntKK6RoIFy61MF5jl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YJRHtJrRTC0XZHhadpglRr01z2T/w/ee9IgJ6+SF5XofM9eIXletSbxFF6O9ro9iT9MjrkJNs13D8IYcW66JTti5s3juALtELQStJe+SmJWaeUipB/3g1VLMaJYuoGu117DH32sBDemvOMIXomDAyAYDHuGqFdokFfH7RFyxaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1HwWIGP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLM/aQaA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1HwWIGP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLM/aQaA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E387Dp3181798
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RX5ambPkVARTusLAr/sDZe
	qiMYsUAGeyyNWMuuDZqPg=; b=E1HwWIGP1TM0NCk63Yt0o8J4NOTDkhm4VS4Kyd
	JZyqpWZrnvnwt3GplHqZqVH+Zw6EzY2nOuh8yMw+aLxGbWQBikO4FmWNDi1iL3QW
	NnsBre8pc1o45PYoWo17/4umOWzQraNkwb++3ntrXDc+KIklPrswUXR+xPQgIimV
	eIxH2vrZt9JnLia3szp+axYGTZK+qdoe4662IWbdsbqr5jaQaPIS0ABwbFsSS3Od
	HcL/TOYwPztOz83KkQXSCsrWV8pr8Ovy777ZFBm2bmvZm6WjrRuVWzFQ4rlGnjxm
	8+moZ3LN+UsuxcTxusqqCQKdrXMKySbaKN2OkcC0fC6WuyJA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4quycn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab041eced3so3999437a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 21:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005191; x=1784609991; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RX5ambPkVARTusLAr/sDZeqiMYsUAGeyyNWMuuDZqPg=;
        b=TLM/aQaADku/5qtWnjbADZu/2IetSdvCXXjRlkFVlGBUWJRD8Z2zqvCYD/Kh8iIMwd
         3kigt3W/Tv4VR01cT+mzdRrFKeSoO4PEM6hSe4Nn/wp5uCkMycYfX+KF6Sm5I0gLkA/W
         qDsLf5XZBXdIC7j7S6VDvqDQwopqjGG8vOMsH8/q5MfercDbANZJrD/3qzQFN7S41wHe
         k4d23Tp3ZhDU9RrScRlOPGLw/YzOHGGrZCvjHfRLpyxNAYhJByOpYwHG+xwTR24ICcMR
         oJESXhm+BwwjMHAx+gOfKQCFr4ggZ2AP9KjuUX46S6MuDE0S4RVNFLtj126Xx8VnGR23
         LLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005191; x=1784609991;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RX5ambPkVARTusLAr/sDZeqiMYsUAGeyyNWMuuDZqPg=;
        b=svrqtXw87O5CjosLtazNbGbNfgJZ6sX/pI1XzJIbeulb0wi48OPG7WY+cl++kVU+kf
         17ALs3jO2NfGB2ru+sRqKciEqKNPgKVDgQjObP/gd/wzT1GFgpcyqPdy5+s+z2zv6HNt
         iKpVfSIcnuxZ8WTL2d4z/gfmGxu4JK9BH+b9olKFrYrRBIWvZBbJ72nu1EPmzJgmvh1U
         kLljCiF9TAf3PwmOD/W/qnKsC0CLZ4broohcNsWKaJIpoSGiM3o7mzZQVycQZwbVwx5H
         O/b0Dnb5SBDD4w02APkkoxoz9CWE/u+tDPRwMQDL9CHla3oEtvN+OU7N706G+8BHi7c1
         h3VA==
X-Forwarded-Encrypted: i=1; AHgh+RpIx+7nLoe8oHtcyaF3SopZ07khdP6qpz+MrAwSFW+CCujz8XcRZWL7LQqglHCkQMw6O4RdW0iGQvs6s2CKD8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkwwBa4nhGXzvnQF1dtFTabrXK2GTJhVGJ9OnyRX2Ihmam9mO
	G3iP2atXkHzS7AeSiKfeL8GWZEjTgQUmwGcMQHKIuH23LPe/+wc98cDRhfjVQPfNY8l1UPr3Fas
	W3Fy4exJg6gV937ihi5gDQTa2Ig8d1LzyIsyAjTDtPoYpdkCTaDvXJ+rokRdqrSeqTACiyrE=
X-Gm-Gg: AfdE7ckf93kuWGLK3y7cEeyRB7V/ti1YXKDFr9bHuDRXURnzSw30XHXl1aRbm4X4mmA
	3bwE/8sg1MqtW2jOBzWQGgAVWh60aWTrowsprtjyU6TxeZ5HP/vj4LZhhIb2mTLMUtrlb68p4w/
	o+dhlO5mdQhAsh0Y/X1x3LgHZv03tv1X2Dwd9PeBfeExz35deQtR5oTU3+MEQzhTSC0f7MTPatx
	QRtW+JrkzjfOUzO4kvigHB5gWwT2e8GFVBSw2en/TihcBEKO3MjlXIOKMnqzwghn+KQYimUVf41
	SUEJHgL8dziLhqmKjIF2M7nKh0VehMiVcaI4RMv9JiK/Vn9eoXBPGx0S+ATVeXehwLSkUPzzV5g
	uErypTZjoEvFgJDR/0jjrQntlMlyCDb6qdecAwuBKTcjITD9q+g6G8YGNTQ==
X-Received: by 2002:a05:6a21:6da4:b0:3c0:9c19:6587 with SMTP id adf61e73a8af0-3c357650324mr1078582637.65.1784005190951;
        Mon, 13 Jul 2026 21:59:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da4:b0:3c0:9c19:6587 with SMTP id adf61e73a8af0-3c357650324mr1078550637.65.1784005190525;
        Mon, 13 Jul 2026 21:59:50 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm41874021eec.15.2026.07.13.21.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:59:50 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v9 0/7] clk: qcom: Add common clkref support and migrate
 Glymur and Mahua
Date: Mon, 13 Jul 2026 21:59:35 -0700
Message-Id: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjCVWoC/yXM3QpAQBCG4VvRHNtaSzZuRRJrMA787CAl925w+
 PT1vRcwekKGPLjA40FM8yTIwgDcUE89KmrFYLRJtY1itTn21eqxq4SJ0ojGNi4xtbYgp0UWOr9
 gUf7mvRnRbW8F7vsBJxayM3IAAAA=
X-Change-ID: 20260713-tcsr_qref_0714-0ee27bc42a07
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005189; l=5997;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=v2LF2JjTn8nWjxUScg6pd9H3AntKK6RoIFy61MF5jl0=;
 b=9IXHLRpuLRU5/jAga1ulgfzDd7QrKdgcHx382LayI4D/gaKrwZbkVMgZ3HYZwnTCb8rNKe/Ya
 xydyyjjC/RwBw1gYdVSj5lp9rDEUJPHPsJY87gOR3VL+A7WqwrWz+/P
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX2wLQF5epdJzH
 39aXwwlsv1W/vIfkQBDs5EByKWF/Z8APcOb6CVtJQushXaUqSkjWuJRy7svv6xYsrKBUIuZ5O1G
 vaeY9fs2liGYBoQg7KLC85H4Tnzfrr041+Po38hGvRYCk+42EVRCy6v6rQgjWPpD5IHCyZn6cpv
 /dtdI2B1DUeBsm1peDI4DmnSXqAH7iSFracaaVs5jfAO/Zg4kgB/Po9uNHVTeLV8465JY0eHhWa
 Thd+EVlMDc8zTLsMIwgfSblVA/1VcfkbKXmR/C3Ups7uw9Qfncp0uLQOcg2I9yqyRUlQKOAlGH7
 aw89MCDazlSi+PYyOPtKELZ8Frif/hZmVvTP88PgS5KUuCB2M6ljZXF2X+SDcTewHUVJUGgzM8y
 Dej6LAq4wvX7/SEr80muXfXW+1gPvZRBV8a9vgfftSDf0Z0qzkvzJO9cbn0KR2n3DcJ/BUDBODT
 VP55jIctnc0E/dAPXCA==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a55c247 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8
 a=VBF_zcjmYl_iqrD6TbIA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=xwnAI6pc5liRhupp6brZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 4tFFZmAbkRejupkVAGAnk8Y_sDuNEyjT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfXyTZ1pIvUakrd
 LpgC5OEEFNQ0zYDcl6FkiRF2cKD4baOHPcqUDBoi5EOzALoKrNCk+rmYl1hr8JMPMX2E25PPVWD
 PauZ1/hiFMaMPVCCx1Q+AUrIfYXfMUo=
X-Proofpoint-ORIG-GUID: 4tFFZmAbkRejupkVAGAnk8Y_sDuNEyjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140047

This series adds a common clkref_en implementation and converts glymur
and mahua to use it, along with the related binding and DTS updates.

The PCIe clkref clocks on Glymur and Mahua gate the QREF block which
provides reference clocks to the PCIe PHYs. QREF requires LDO supplies
and a reference voltage from the refgen block to operate. The refgen
block itself requires vdda-refgen_0p9 and vdda-refgen_1p2 LDOs to
function.

Previously, these QREF votes were done in PHY drivers. In earlier
discussion [1], the feedback was that this is the wrong ownership point:
those supplies are for the QREF controlled by clkref registers, not for
the PHY directly. Based on that feedback, this series keeps the
regulator handling with the clkref control path.

Another reason for this series is reuse. clkref_en registers may live in
different blocks across platforms (for example TCSR on Glymur, TLMM on
SM8750 [2]), while the behavior is the same. The common helper lets each
driver provide simple descriptors (name, offset, optional supplies) and
reuse shared registration and runtime logic.

Glymur and Mahua share the same QREF TX/RPT/RX component naming but
have different PCIe QREF topologies. Both are handled in tcsrcc-glymur.c
via match_data to select the correct descriptor table per compatible.

[1] https://lore.kernel.org/lkml/aEBfV2M-ZqDF7aRz@hovoldconsulting.com/
[2] https://lore.kernel.org/linux-arm-msm/20260202-topic-8750_tcsr-v1-0-cd7e6648c64f@oss.qualcomm.com/

Changes in v9:
  - Add reviewed-by tags, no code change.
  - Link to v8: https://lore.kernel.org/all/20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com/

Changes in v8:
  - Define refs with __counted_by(num_refs) and make provider a single allocation
  - Use mahua_tcsr_tx1_rpt012_rx2_regulators for PCIe6.
  - Link to v7: https://lore.kernel.org/all/20260702-tcsr_qref_0702-v7-0-776f2811b7af@oss.qualcomm.com/

Changes in v7:
  - Define compatible as an enum and add the per-compatible allOf/if/then block upfront for glymur. Reword commit msg for patch1
  - Drop Krzysztof's Reviewed-by since the patch changed substantially from what he reviewed.
  - Added a comment noting that on Mahua the REFGEN4 block is supplied by the vdda-refgen3-* regulators, and mentioned this in the commit message for patch2.
  - Change the descriptor array to an array of pointers (const struct qcom_clk_ref_desc * const *). Skip unpopulated indices with if (!desc)
  - Convert tcsr_cc_glymur_clk_descs[] and tcsr_cc_mahua_clk_descs[] to a pointer array.
  - Add regulator lists for clkref_en on Mahua.
  - Null-check device_get_match_data() result in probe.
  - Add rx0 regulator in mahua tcsr node
  - Squashed the former patch 8 (switch pcie5_phy ref clock to RPMH_CXO_CLK) into patch7, so Mahua PCIe probes at every commit.
 - Link to v6: https://lore.kernel.org/all/20260621-tcsr_qref_0622-v6-0-c939c22ded0c@oss.qualcomm.com/

Changes in v6:
- Split dt-bindings patch into two: one to move glymur-tcsr to its own
  binding file, and one to add mahua support
- Use regmap_set_bits()/regmap_clear_bits() instead of regmap_update_bits()
  in clk-ref.c
- Move clk_init_data from struct qcom_clk_ref to a stack variable in
  qcom_clk_ref_register()
- Add Co-developed-by/Reviewed-by tags from Konrad Dybcio
- Add missing regulator supplies for EDP and USB clkref_en on glymur
- Link to v5: https://patch.msgid.link/20260602-tcsr_qref_0527-v5-0-8ea174a59d7e@oss.qualcomm.com

Changes in v5:
- Return 0 if regmap_read fail
- Add a separate file for glymur-tcsr and mahua-tcsr
- Link to v4: https://patch.msgid.link/20260527-tcsr_qref_0527-v4-0-ded83866c9d9@oss.qualcomm.com

Changes in v4:
- Add mahua QREF support (binding, driver, DTS) to avoid dtb check error
- Override pcie5_phy ref clock to RPMH_CXO_CLK on mahua since
  TCSR_PCIE_1_CLKREF_EN is not available
- Rename regulator arrays to topology-based names and merge duplicates
- Remove else: false blocks from binding
- Sort supply properties alphabetically in binding and DTS
- Link to v3: https://lore.kernel.org/all/20260506-qref_vote_0506-v3-0-5ab71d2e6f16@oss.qualcomm.com/

Changes in v3:
- Fix dtb check error: allOf:0: 'then' is a dependency of 'if'.
- Link to v2: https://lore.kernel.org/all/20260420-vote_qref_in_tcsrcc-v2-0-589a23ae640a@oss.qualcomm.com/

Changes in v2:
- RFC tag dropped
- Changed back to additionalProperties: false
- Moved all Glymur supply properties into top-level properties so they are explicitly defined.
- Link to v1: https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Qiang Yu (7):
      dt-bindings: clock: qcom: Move glymur TCSR to own binding
      dt-bindings: clock: qcom,glymur-tcsr: Add mahua support
      clk: qcom: Add generic clkref_en support
      clk: qcom: tcsrcc-glymur: Add regulator supplies and migrate to clk_ref helper
      clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator support
      arm64: dts: qcom: glymur: Add QREF regulator supplies to TCSR
      arm64: dts: qcom: mahua: Add QREF regulator supplies to TCSR

 .../bindings/clock/qcom,glymur-tcsr.yaml           | 146 +++++++
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |   2 -
 arch/arm64/boot/dts/qcom/glymur-crd.dts            |  20 +
 arch/arm64/boot/dts/qcom/mahua-crd.dts             |  16 +
 arch/arm64/boot/dts/qcom/mahua.dtsi                |  13 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-ref.c                         | 205 +++++++++
 drivers/clk/qcom/tcsrcc-glymur.c                   | 471 +++++++++++----------
 include/linux/clk/qcom.h                           |  67 +++
 9 files changed, 704 insertions(+), 237 deletions(-)
---
base-commit: 3da905eb243cad56200f09bb7eaa060537aed0cc
change-id: 20260713-tcsr_qref_0714-0ee27bc42a07

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

