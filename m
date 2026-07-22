Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A632FA14
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699943; cv=none; b=r06xtJB+V8Emg8uZ8cbqmPQ1QBcO0BTCMrpNV08LDqMYrwJKe7C7u9kpU20CRQKM8QXagafvNTQh7DZmrXnSHiaQ72KeZt2Z5XAsgeix7UskAqXmErwNOWYILabbgMRkVh9AS5g/0NbsNdDpWgE8LM27ggDXYEIqctS4K0L0p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699943; c=relaxed/simple;
	bh=FMRJ2dCxpLRqMq7VnS3Hat4bMz1Ui//AKEapRVwc5PY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LcR+rqqWYB5NZ935eZPDwwpPvJ3UjrGNoijdDzlmerflJn3HrcdfG0b19OHqJHZMHm0uc7jl9/jtfmwnlcqT58sBOxymHA+DFjnmTBDOqEcI2OhpIKFMMx/uBq0qgVMJlo8yj47yKNe9+/JwW6uxWdGdyJWOUOpwN27vqJ1nLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHZ2MLGD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kt5p1KHe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHZ2MLGD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kt5p1KHe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53goW3473627
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lHyaO1rr1jxitrI8f4XMNU
	N/LXcObIJB7mo8ne43U1I=; b=bHZ2MLGDOXTt+fMU1TC35KOvj5q0GlCwhdGami
	cdKbU2gxEfPXooOjLUb3/F4kRh28XjoZXhNjWR6c4o4N6yv9FfIFqRckJDqz1onx
	lMKKcwU90ulMfUzUgNhwcnBdTJB/N7pHV5HzNvM1IhDNzWe0QlR9HvTn6E8oyqyO
	5dcRk8oTpWbvSSQ4xC3O6RYv15n2FP/Qtpeo9pbgTp5WIupy7dX2qffO8Xn9HzCC
	WtHs/TlpKgPtbxhLJAAp/1/e2Kp+VySTEzLpArsyshZ5MRw25rNgpBxh3iW9E5gV
	t4sv91L/mrGk5huc/WicpAPeXugLakiIbqmv634NZaT4Hx2Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftfg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848568a6f62so20345263b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699940; x=1785304740; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lHyaO1rr1jxitrI8f4XMNUN/LXcObIJB7mo8ne43U1I=;
        b=Kt5p1KHerVuZ1i2/po5UDECMVUtPACANqlE3JPUK4HYrjCCUQb8rhH+aF78qAHewYL
         +wNwoBqr1xYNXMWAydDxriYR4K5M3GeQHPHRktz8Ch0mJ4fRusVAjzy4uGJpAAIdSf1I
         u3EHMsdP44zieyMEve8Jfz2ZaIrQtOLzdQVIt8Sr4BbfUT9uqSOotKgCwWcc+1y2dtOL
         DFeExyaidHnDRD9q9W9+g461QH/QiZE2+8/RJNFHS1gel4eJiGLK2CyXPlQUzZPU6sd4
         adLKSuGDriPt0dgkpP9suiD/Zw8HmtbjRRnQYrTeR2KVihY4dDNwd0RERYCh9G4XuY5e
         ewYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699940; x=1785304740;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lHyaO1rr1jxitrI8f4XMNUN/LXcObIJB7mo8ne43U1I=;
        b=CbQfRyMse8Luo6stPZ/R/5foxHHBZZ0rejlQIi5VSdm3sj/56sg7ExyDTdjXv1fayr
         sQtWhql0ntp0gZZ8FgoW4r8LJvwHJi9Bru38GWvIccMrmBS0hzkZ3jpKhXT2sKkJySc+
         m1V85C1ld01tXArrEkOdzF/5UXiW28SZ/9PXIioWvQSLPCdwuyhVkPg4DaFxnPk3bLg/
         CdJCiLNNZWqs0u7PyS+PM4+zPDA5jx/Os8v0Mqd5Rv7gq65Vrg4u+AH6DRme39KQMcn4
         otC47oT9Y9ZshNuBKHFsbvFAr6IlVbDNAzisQq6P7otw3OaKRLdOVocGI8IugxEu87Vm
         YLKA==
X-Forwarded-Encrypted: i=1; AHgh+RoUB6kqUHj2a62bJgHnuNFNeZVdvKxZCMqMNkSFWa658BXwfELO9v9uObeHGw3lcuye8jkZlPt5RsAYxhodCMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMk6NwtKM3GtcutTTKf3CkBZvZFrLufJ6WC0/nQUsPRYFwWDz
	PsdxgC7cH52i4L328VyOduT2barubq4eq4sqea3DVLP0uTGO5YCpkb7BWm+Bw7IAVRXtcd5Ue2J
	iNotEZk8yzMZu4phZNRkfPZDiZS8en4r0XDMRCD2ZO1363DrjQajGUgPLWXxg07yw0BumUIM=
X-Gm-Gg: AR+sD12s8nKVswDm8KXFV6nxB1+mHGbHlIhiIfb/hlFZ4nhvsD0mtdAPEMFAT6cTSkm
	mvvbM8+/9tc2J8aBRWU4mak5b3UqU1ioMZoDGsuKDT71hE7ztvAd//bOYwoRHOuoDErVIcnchBV
	qn1K1/trX4khDBYpW15X1xajQM8FuYty5lLu2Y3+wbAb2p9kRLYtFINVheaAAa7XPUm7G4SF2+z
	mdvc/2z6YMLXFUcedYpPG8RxR+A+ZhzE2mWrZDzGqbYBIUqC/R2gMapE9+BSY3wAxWriJgRMP7S
	zRMVnBO1+RwEqDpu/MK8DkM8Sy2qifiY6PdfOJ1pKonSlmKsQ+sc2dzTZ+aKkeEhqaCBorsEPNt
	FmaLDo/k44I0rlXgjn3hf0iIeq29SgaZtdnmNDqtgT9hAYh4=
X-Received: by 2002:a05:6a00:420e:b0:84a:2fff:ced2 with SMTP id d2e1a72fcca58-84c294d1f79mr21747744b3a.35.1784699940203;
        Tue, 21 Jul 2026 22:59:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:420e:b0:84a:2fff:ced2 with SMTP id d2e1a72fcca58-84c294d1f79mr21747713b3a.35.1784699939675;
        Tue, 21 Jul 2026 22:58:59 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:58:59 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v10 0/7] clk: qcom: Add common clkref support and migrate
 Glymur and Mahua
Date: Tue, 21 Jul 2026 22:58:55 -0700
Message-Id: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9cYGoC/yXM3QpAQBCG4VvRHFO7Wyi3IsnuzjIO/MwgJfduc
 fh89b0XCDKhQJVcwHiQ0DxFaJUm4IZu6jEjHwcwyhSqNDrbnHC7MrafXPB50J1BbzXEz8IY6Py
 CdfNbdjui294I3PcDNzH/9nIAAAA=
X-Change-ID: 20260721-tcsr_qre_0721-cfd5f1a2edb1
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=6171;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=FMRJ2dCxpLRqMq7VnS3Hat4bMz1Ui//AKEapRVwc5PY=;
 b=1ml6Ikp8bjC293C43LBR1ygxttmrI+ozvKI3SEN0xKgcGfIyvHTeWuewoSs/Uu0uOwUmJeM7U
 OedTmRLLLljBOtf34TC6nXFKoR/N6ePXLuYGnF3GV/yPYRviW0p1BnY
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: fuv82Ck5L7_UAslqqnxFCQsL_ZQ8hViL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfXyxr3AiPfuVfQ
 4sifEIDxa0bbYEY7GQQSPcpgwyOGL5jhWUYBo3KkIzxCKn3HcxfCwCZOxrJ4FKUxRvD1HiVqsGr
 GpadLw8IyOIF2RRua5B/oJZ5GvYR/2BKT0bo2yKj4IZaAv6ntvWrLcY2mWdTvyo4mA7GKwpMHN/
 Z1X23TWQVN3zZM6N7EjfDHfq0raYz9Eeip8VTR22r7PaqIcmN21qmE2gmfqh8pzH31rZVwl4/W9
 zotPHhyi/x9ujYYM/1RUpV73HsBPgR5RLAQGBkM+OkSGWLHDCGhcMNkbdVMSqkedE/8ryxoKvLz
 5C8mwNbWPt4ygxbQ+xjiqjCtQHP3ZL8e9e2FgYMOq6K+7ozcl8cub9OL8Uxt7u7+Qnju//ezvin
 VTj05KNOJpPtCIxZxDAffnnUOi1XtKCoGlJ8s2ePvWCjF3CvQWI3dX/qm84fslNtRmiDBet0j3T
 iCnSiXUVtwpMQ6wbX6g==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a605c25 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8
 a=t_4-KwRf5v_2ilwofMIA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=xwnAI6pc5liRhupp6brZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: fuv82Ck5L7_UAslqqnxFCQsL_ZQ8hViL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX1BmdXJTW4KgX
 kvD9A/R+qA6AckylBzEWQ/hVNUsY+cALKVYGnxous3xJZRfrWsMZ7FI3bXxVGSHITyXqNIAXYFn
 Am2BD2JuL/pme9oMFdqFKgt2vKGNx3g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220053

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

Changes in v10:
  - Rebase on latest linux-next, no code changes.
  - Link to v9: https://lore.kernel.org/all/20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com/

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
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260721-tcsr_qre_0721-cfd5f1a2edb1

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

