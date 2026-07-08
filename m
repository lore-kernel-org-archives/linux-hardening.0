Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2E386559
	for <linux-hardening@vger.kernel.org>; Wed,  8 Jul 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504968; cv=none; b=a1XURbPohgzSp4X6shYqPwrjq7Uyb/TquCguKOOgTCC7Ze6BOiVZbNkeNIEUtbMZ0j6c8wov9kxiklI+ey8unjlOs5tFKPWv8Op/vJk4d7wsIUsbgEyAzf+vV4cAx+PBJ0uunYarKW50guLd5Tq05EFGKL8WC6ipf0n1o1ckLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504968; c=relaxed/simple;
	bh=kLPAtgBR2B9n0/tWDeaqoBhx/cWXwoNhZjVj+IFDhso=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6ettexf+ds1LpVCeuRW7MDtDkqIght5cAz4MOP5qgbECG29Hm+pMIwlFlyaWgktqB1uAWah0W6bZ31xE1zY/rggsoO47ihaE1S9UOtDAnHxeyZs/Q/OzUikfeLXGnsZiaviuu+sDHKrAFPoWKxXlWPEdPmORDOJhcgqxz+z3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nph7W2GH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayjFEeqz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nph7W2GH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayjFEeqz"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889HG02135713
	for <linux-hardening@vger.kernel.org>; Wed, 8 Jul 2026 10:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2r+hMVsWqtKsqmd4HAjb0p
	75kMs47h2LOovg2koAXzw=; b=Nph7W2GHCwmxZXjEzMtow348148coXiq5n68dL
	YwhLj7p1lx93+DcFLl1tjUa85PaRHg5TknrEaJfJ+8OIMRy+Pcn0RHJ7rti9m5Zr
	0GrwTvF6RR+q8FhTSgYX4nHftpV/rq23ZQdGqzArvLRJIwQWIq7nBfxqxAfR0j8F
	GuNwXDQUgn5lnOcOXSOLBK9EjOl29tfG/jkr90Dm3CgioOnwqA/WuHXcjJZjAd2x
	bInB2pou+427N+MXVImAm3xhQ9o2DRtH4T9+bhZ2rYRlAqZq90lbp3Gj9RQcByX1
	kun7yvCM4+mdeBZy4CoutFDUXUw5TxRgjEuuRpJXtWszY4EA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgtme8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 10:02:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38096521198so1097632a91.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783504964; x=1784109764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2r+hMVsWqtKsqmd4HAjb0p75kMs47h2LOovg2koAXzw=;
        b=ayjFEeqzbUnh9eLlBSNHRd8CVVVbln00Pt9FgS474WmODwckDoQcbS8FmBK5TWqAP8
         MYA40hfEAPh/CcwOtFZMpqAGAM7yWSjXH9NMBvma+FdCZvMMuXwboo4s+l7Zt+CER8a6
         H5Y3Xpqa3SFXaacmaQ9VD91J4ooDUAk0oaW9XcDSzqBP/dpwXyTdwuLy5v1HZPZ38pUb
         rGfqzl+Dd/eoCrV5Y1sTrHXxyBe9bixJFxhkC+MNS3TfCCuVngVnNTGB0v/jZN4sgoe6
         eeP53/5oeyGoivx6c4BKrTdqnHcrqTI+QK6HTrX+DqWtJ/beCepvRdivn84KN6rs4UTH
         w1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504964; x=1784109764;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2r+hMVsWqtKsqmd4HAjb0p75kMs47h2LOovg2koAXzw=;
        b=iu9jfoJm6QrjRDgkt46RUjH3aDEjw0BUBAxegE9m5W8ZSzmb5Q+J/73Vn3LvQWANi/
         Pq5RleiomsGOchHCI30JaeNXYiuRSpPZrlYv4iOcGKVc9cWUpVV7/QpfFI6NgfE/MG32
         BVJGGrwCD9FUAmm9/bUZxxmN5XNb7QJhJBP5AzrE21AZSbUhJAhXffRWfc0BmolA8AIg
         9U+QjKBQRjODLVgYSWwj1oOuiLxJYPzjhWBITt6RIAiQApVI9XElqdq8E+gMIUJSDiRY
         7kUFKw/McdZ/iPOAdR3tIqzpyy4Y++pvk9E5PNQvC3zPpp5kzyJ48bdZs16pOYnIgHsB
         PTeA==
X-Forwarded-Encrypted: i=1; AHgh+RqNc7g62HudQiD55biX/pdwnfLsecPSUjqxfg9Yhw7I3a25ukHqE0J3XTMdMQ88waViGdK3m/uWj4yMhpC8bcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMS0rDn0OeDPGo2QblmFLpqTEjQvsV/qO1O93byiPK9GH6y+ff
	jTg9lhwy10AF5BG7QENnlSIjXk2Gnhwho5FOYwqTX+IA7ewfeBrqNoLf261ZIC6gA+zhj1qIg0M
	tylPH1Yp6pid8vyA9m8481ferUpqqJQj/u9wgx/5rjkRPBkvnXHTuMNzcfqGm5LJ1Vgy/2o4=
X-Gm-Gg: AfdE7clZYqNQRfKzgdmNa6w/qd6zgnzryN5a9UGjZ5MffTiSO3SHBoqGBM/hHb2QUJA
	MREpuSoEpuEuJW2HgtThn9LCbn14zf6g4ND7Xb7jX+rmshrNkqmMLe+Ipcn8cub813J/gSQce/3
	4uMqOyPgU0HnfDRo82fFYYaXNGS1VVVgh1SY3yJoKZ+9E/QAhpmXW2vKRFZOV09vMunNU48rZ4e
	0461ksvN/w+Ch/RZOsuE46pYnsctEe8GMoCaj7i6W8VqQoWpHe+wZbTFRQaX7cum0MUJ1711/oE
	qnfcekEbAFEyJ24t5UvJdBPm8Quv1Yqrc4iq5Uzo1mWl784ZPCkFOJFgfwYor1WxsjfTubzUfl/
	TN6mQjM8QypBKaatPAI2N4TL/wKxWgvxplti+aGlHhKIlobuRXn8TFKFZSQ==
X-Received: by 2002:a17:90b:2e8e:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38942b81d57mr1877698a91.34.1783504963959;
        Wed, 08 Jul 2026 03:02:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8e:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38942b81d57mr1877653a91.34.1783504963481;
        Wed, 08 Jul 2026 03:02:43 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-389098609c9sm875741a91.13.2026.07.08.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:02:43 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v8 0/7] clk: qcom: Add common clkref support and migrate
 Glymur and Mahua
Date: Wed, 08 Jul 2026 03:02:37 -0700
Message-Id: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0gTmoC/yXMyw5AMBCF4VeRWZM0SFteRURoB2Ph0kEk4t1VL
 b+cnP8GRkfIUEY3ODyJaZk9dByBGdt5wISsN6QilUIJneyGXbM57JvArBBWGqmsyhX40+oXukK
 wqn/z0U1o9q8Cz/MCPAUuYnIAAAA=
X-Change-ID: 20260708-tcsr_qref_0708-390d6c67d747
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504962; l=5886;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=kLPAtgBR2B9n0/tWDeaqoBhx/cWXwoNhZjVj+IFDhso=;
 b=+lwYvNIQtslePr+gUJPGEnJhsdN9NSKeWNKwFj+A1H1IiBmVRaYP1lHkwZwe3A4o2ubPAGqH9
 HUBWEikOQSODJceOcNYxWQJJasHP9ziG968hdlla+kQfCHuixxyDerB
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: CBqd4tzEXX18GNzfhJLgON5mwhZheVig
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4e2045 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8
 a=VBF_zcjmYl_iqrD6TbIA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=xwnAI6pc5liRhupp6brZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: CBqd4tzEXX18GNzfhJLgON5mwhZheVig
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfX6prCB/uhE7DN
 SoJub9PWpgNvXay/gT89QXa1NG7S1Abq33MQ6ZGFuZZoCs0Do5/fmDXq66IVkRcmRRRqjvJkPYm
 YBFy7PCRyMXSC9Ymd+nH2dA1GTT72kM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfXzNcqNZSeGmBd
 DKnHmdjV52QrAmj0CsQ1WuB8X8jMKh51Y/zA1Vse52GO0k7imHj1DNTXoqwEDvprXNS+HK5Tg8/
 V3XfsgfkQ6P1xZHsRQ8XsDUmEyDwV70mPCgeALqVLu7qlQeJeRuchxjJBr1xaim3468Zfqmae7v
 KJUtbCk8fp8JSTNVwspTI60ULPIF46hFvH4hVwMtPKC/RPpzJ6XjvkIe0dMgLLe8UBMN+i2RTfb
 H1Kw0Q9ZfTPXP5FVnIKMBBSWoRbqeSvBejSiRebw+HwFHxci1Cg/1Tl6/LVAT/lF9gAj9b6E3Pf
 FfTsNKf8XqV69+ijosOS3a6g/0mjHQl7qdtbFQyLA9oYlaQ9ljKGMOunVu/T54WVjxr1GmKGnQL
 jCLVspXo5xzN6Ts6fE004Dw9rcoSjo3bbtxhESF7j41YTlw6XrqBNDdCYWhycW2QRqVCDbVYbsc
 STNlBI7nTkOYbd2n+XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080096

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
base-commit: 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
change-id: 20260708-tcsr_qref_0708-390d6c67d747

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

