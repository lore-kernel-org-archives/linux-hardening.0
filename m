Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A73939A2
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527848; cv=none; b=UOqnU6GnnprzruFdU1+Kounca/3Qdw2By7iauuz8ZGABAztp79FLR8a87NFvT6CzgIaoK6p+KEne486cM+sxS+x1i2nCZte13GbpWuuiB3AnDO7BwyEXuXx7xBK62aT4761ez1JSUX4uvukPsjTg2slE40IokvXGbBye7tzNIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527848; c=relaxed/simple;
	bh=4r6ZnfEi0zmrLqc+xZvfOpWYg9iGvvkUC1ZP2gGi/30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBjhWUofTe3RpvYwISzLfsDpSDU52Qcen5vnwrwxIxwxVPm0A2bz5FDw0xlfIiN96D11KZxjKKFjLcgflPipoHqeuK473WP7Sg6+K/5E2PBGs0D0sb0F04q/4tWhVsY+KPfzC82wWEGcGZKXu5sxtQ0yH20X6hk1ejTk3UD4HOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YgBEDqT/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A+gchvai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YgBEDqT/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A+gchvai"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsZef912274
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 06:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WzlsHGrcqxeLIakOgqDY5gST
	ZoRDT2RRBCdNI0h9mxg=; b=YgBEDqT/XCc2Zc8FILqre60V5ch6/eGWCiikgNWl
	Ls4Q9ddErUzATNs8eZZnqA/79MiEGBlACbxJvz5J+RJToPEAJ5qIt8E/BRFZdfp6
	5kGSk8VkPg18jOrUlrKwKaMbe1tXXxDlBrZ4X4gXIe2L08DtIuiqWgcByEaCT2Gt
	BZdT2bBnSqktFJTpugVLoi6rqfWDab/Q2YfX9FDvzJpu+8XfV1On/wy7SE9y+jKf
	oFoYwp5OKs3cFg9I0PD2CEIAVvH67jAwhfY2l73Oe8Gfvvt1QhY004Tx5sFXeEmp
	gw8Vb/5ICPVGCH4lqQHFFpfGBK5yQa+Z+1vC6R6l92KHRg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af4mcy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 06:10:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce14a21faso58089595ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784527839; x=1785132639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WzlsHGrcqxeLIakOgqDY5gSTZoRDT2RRBCdNI0h9mxg=;
        b=A+gchvailLd6UW6E5msJm6+dkn5v+6ttD6Cn1Umrf+Pph7fwQGkQsDUUvejEF1C4dg
         OLCBgSCRJf7q1GIXfcaYMnSBD52n3pILe7iOtxVa5ZTTP8pieJWA4xDe2FKpBrABblrO
         a5UaUQr9HxICPMN0dGOZXVyEB9diCi7y9ZZh7OXXUz15ISG/OpTr8Nj3jY35xeFyGhG4
         dlxd2nYody1NWRkwC1phWHN3kcTDQMhhW4wTwe1rmpIgaUn7QZ16Ld/JzDffquO8IWSZ
         Y596OKtipKNIUyfutRgLIWIKeK+ZeLAFgWclhXKLX237lwqho2XDnRjYCtRT9p99sk7h
         XLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784527839; x=1785132639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzlsHGrcqxeLIakOgqDY5gSTZoRDT2RRBCdNI0h9mxg=;
        b=Sic1G9i2vae05qHZTzlT03d5OOUf2vh6HUUUgYu0M2i4zaelepQkjuqi/cTa2huw3J
         sQpjWZCRKtkbBQg1WZ6tlPkIJuXphfy0TFiFVnPWwquOasxQhnEHdCkcm7TaCHtnqcxW
         AJynUv85CeLAApdIYTXXd9K8zrMxUNV2fEREpU4zRfkF2kM9Jb3mwnDg1J3puk+VKuN1
         QqR8eurQgAPZXYAyzps0LozULf42SjufGaTkAw6ULeGGwjzweGRwGhLqT/qIGJocN0XK
         ZSPfWL3kf/3sK24ifDjMVNlaDqhJvSRd3YqwNCY1gRJY5wwuc7YLvTxB3j2CJxxOAZUd
         F2aA==
X-Forwarded-Encrypted: i=1; AHgh+RpBTr7B80gZASpqGLDXQcuN6hr+FSym6c2RFLWa7q6YLIvzfm0fFMajsZuzNHbFFXOdQNTaIw5nxJiFiStT+4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5kLT/79oX31rO6+3RNFLDGNzAf05Ru21pbm6D6TiGqDJbJzN
	+5KZ9xncG6dmJghcLZoWztk4K1y4sRTbYvMsiDE8MyqyAyjx3XgMeCilSP4tqy1nb4xZLGAQQNp
	lGNBZ2tjXPX3XtdRl3TPt+zfaC+T/9DkYx8E9Ppsuc4yq42q48I1s7jyp9e9UYt9qSMmcgE4=
X-Gm-Gg: AfdE7cn69tlgtVjFcPnOim74bpgEGAKsFmvVdYXdKuT8l1XaAxn0ZsocFKox2dvtAiW
	1+uJhMPeFNzOtYRdXPRevBambwmn0NfSiqZs45T2fyJ/RChZBIr6gBswRocif8fe5yLHHe6RjID
	/yaK5lR6y8vK/7xk2R9q8fsCA/8sJ/UxfaOziY6hEv1oX9/1ntjZDA1XmiHMbRGAUdYhCrpUzk4
	KgZ4YirwEzmw/7Usqh38QKtWkKe/8bVEmC1b/uWKuES/p7TEaq7JYGpRGtCpT9s0fjycZudabLU
	WQv52OHQmOvTC6ilBXBA9NWzH139rnYzrJbLU07gP6twPTEhOswFtsKF/w7Coeg9w01ze108DDW
	sXGxuO7/6H4jek15+xMYInONIiG3DA5oyAlAh/7H+9PsUPJw=
X-Received: by 2002:a17:902:ce0b:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2cf34878effmr134855765ad.7.1784527838734;
        Sun, 19 Jul 2026 23:10:38 -0700 (PDT)
X-Received: by 2002:a17:902:ce0b:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2cf34878effmr134855465ad.7.1784527838242;
        Sun, 19 Jul 2026 23:10:38 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9af5sm50597925ad.54.2026.07.19.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 23:10:37 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:10:35 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/7] clk: qcom: Add common clkref support and migrate
 Glymur and Mahua
Message-ID: <al272986PmAqT94J@hu-qianyu-lv.qualcomm.com>
References: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
 <alv1Q0ZmGVdUTGCu@baldur>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alv1Q0ZmGVdUTGCu@baldur>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX0YLUbPWdPK9X
 iD0SJevaCk3tFjRVq4J5rG6S92WNDO716t19Jlg0gc8hEhxOCyabiOsnn3DLRhRxMuLA43Fr7FF
 R3ndG/wQrJt+Ue/W0R9S0xW+nV4LumQ=
X-Proofpoint-GUID: iIIF8UEGYhHCqc2w__pPLGFk4gDC0u_5
X-Proofpoint-ORIG-GUID: iIIF8UEGYhHCqc2w__pPLGFk4gDC0u_5
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5dbbdf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8
 a=K50iL3YY-BjGgPklzYcA:9 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=xwnAI6pc5liRhupp6brZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX7ryddhvBTPgJ
 gjVszcufqiPsNBkIcGQ6aQWuzy8SrlH40ZrsaZKdvU7AscJ1M2KMVgzhYn1kFVP7HyP21zgKvDg
 oPxzhjwepjTQ9lDaCYGazCjpNJ+1OPrRx/WBZw8ZmqHqN3itaOqxKzOtB4gpWcFGzgJkTPdGNqa
 rXulI4xesjGcOwHaakmgXgjXG1EfMFiBks8LSWrJSlw56w6Svxt1KEmgtOpSTUPTxlAyfrk3tsL
 Ivc95jnyN6DnrbofSE+qm71e6SsXWbitu9V1FwY/n0UvOj+X546SdBKmH7KH+Ag287TtChOZMwk
 6eDc8iaDZVRxi/DqClPd6zIWMH0gHWs3szqYTm0/eg0KQboTTSvVMEBQoXSTEef/jHYf5GhKYsF
 r1AgEbSwk0nlvSMFI4IQRUtAUiTCGz9YQ/5Tob5Na6pSnYdN77UuA1LqndwS3ADq5hGQgF8W+xx
 rDI+bAoA0zJ/3136y0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200066

On Sat, Jul 18, 2026 at 04:52:34PM -0500, Bjorn Andersson wrote:
> On Mon, Jul 13, 2026 at 09:59:35PM -0700, Qiang Yu wrote:
> > This series adds a common clkref_en implementation and converts glymur
> > and mahua to use it, along with the related binding and DTS updates.
> > 
> > The PCIe clkref clocks on Glymur and Mahua gate the QREF block which
> > provides reference clocks to the PCIe PHYs. QREF requires LDO supplies
> > and a reference voltage from the refgen block to operate. The refgen
> > block itself requires vdda-refgen_0p9 and vdda-refgen_1p2 LDOs to
> > function.
> > 
> > Previously, these QREF votes were done in PHY drivers. In earlier
> > discussion [1], the feedback was that this is the wrong ownership point:
> > those supplies are for the QREF controlled by clkref registers, not for
> > the PHY directly. Based on that feedback, this series keeps the
> > regulator handling with the clkref control path.
> > 
> > Another reason for this series is reuse. clkref_en registers may live in
> > different blocks across platforms (for example TCSR on Glymur, TLMM on
> > SM8750 [2]), while the behavior is the same. The common helper lets each
> > driver provide simple descriptors (name, offset, optional supplies) and
> > reuse shared registration and runtime logic.
> > 
> > Glymur and Mahua share the same QREF TX/RPT/RX component naming but
> > have different PCIe QREF topologies. Both are handled in tcsrcc-glymur.c
> > via match_data to select the correct descriptor table per compatible.
> > 
> > [1] https://lore.kernel.org/lkml/aEBfV2M-ZqDF7aRz@hovoldconsulting.com/
> > [2] https://lore.kernel.org/linux-arm-msm/20260202-topic-8750_tcsr-v1-0-cd7e6648c64f@oss.qualcomm.com/
> > 
> > Changes in v9:
> >   - Add reviewed-by tags, no code change.
> >   - Link to v8: https://lore.kernel.org/all/20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com/
> > 
> > Changes in v8:
> >   - Define refs with __counted_by(num_refs) and make provider a single allocation
> >   - Use mahua_tcsr_tx1_rpt012_rx2_regulators for PCIe6.
> >   - Link to v7: https://lore.kernel.org/all/20260702-tcsr_qref_0702-v7-0-776f2811b7af@oss.qualcomm.com/
> > 
> > Changes in v7:
> >   - Define compatible as an enum and add the per-compatible allOf/if/then block upfront for glymur. Reword commit msg for patch1
> >   - Drop Krzysztof's Reviewed-by since the patch changed substantially from what he reviewed.
> >   - Added a comment noting that on Mahua the REFGEN4 block is supplied by the vdda-refgen3-* regulators, and mentioned this in the commit message for patch2.
> >   - Change the descriptor array to an array of pointers (const struct qcom_clk_ref_desc * const *). Skip unpopulated indices with if (!desc)
> >   - Convert tcsr_cc_glymur_clk_descs[] and tcsr_cc_mahua_clk_descs[] to a pointer array.
> >   - Add regulator lists for clkref_en on Mahua.
> >   - Null-check device_get_match_data() result in probe.
> >   - Add rx0 regulator in mahua tcsr node
> >   - Squashed the former patch 8 (switch pcie5_phy ref clock to RPMH_CXO_CLK) into patch7, so Mahua PCIe probes at every commit.
> >  - Link to v6: https://lore.kernel.org/all/20260621-tcsr_qref_0622-v6-0-c939c22ded0c@oss.qualcomm.com/
> > 
> > Changes in v6:
> > - Split dt-bindings patch into two: one to move glymur-tcsr to its own
> >   binding file, and one to add mahua support
> > - Use regmap_set_bits()/regmap_clear_bits() instead of regmap_update_bits()
> >   in clk-ref.c
> > - Move clk_init_data from struct qcom_clk_ref to a stack variable in
> >   qcom_clk_ref_register()
> > - Add Co-developed-by/Reviewed-by tags from Konrad Dybcio
> > - Add missing regulator supplies for EDP and USB clkref_en on glymur
> > - Link to v5: https://patch.msgid.link/20260602-tcsr_qref_0527-v5-0-8ea174a59d7e@oss.qualcomm.com
> > 
> > Changes in v5:
> > - Return 0 if regmap_read fail
> > - Add a separate file for glymur-tcsr and mahua-tcsr
> > - Link to v4: https://patch.msgid.link/20260527-tcsr_qref_0527-v4-0-ded83866c9d9@oss.qualcomm.com
> > 
> > Changes in v4:
> > - Add mahua QREF support (binding, driver, DTS) to avoid dtb check error
> > - Override pcie5_phy ref clock to RPMH_CXO_CLK on mahua since
> >   TCSR_PCIE_1_CLKREF_EN is not available
> > - Rename regulator arrays to topology-based names and merge duplicates
> > - Remove else: false blocks from binding
> > - Sort supply properties alphabetically in binding and DTS
> > - Link to v3: https://lore.kernel.org/all/20260506-qref_vote_0506-v3-0-5ab71d2e6f16@oss.qualcomm.com/
> > 
> > Changes in v3:
> > - Fix dtb check error: allOf:0: 'then' is a dependency of 'if'.
> > - Link to v2: https://lore.kernel.org/all/20260420-vote_qref_in_tcsrcc-v2-0-589a23ae640a@oss.qualcomm.com/
> > 
> > Changes in v2:
> > - RFC tag dropped
> > - Changed back to additionalProperties: false
> > - Moved all Glymur supply properties into top-level properties so they are explicitly defined.
> > - Link to v1: https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > ---
> > Qiang Yu (7):
> >       dt-bindings: clock: qcom: Move glymur TCSR to own binding
> >       dt-bindings: clock: qcom,glymur-tcsr: Add mahua support
> >       clk: qcom: Add generic clkref_en support
> >       clk: qcom: tcsrcc-glymur: Add regulator supplies and migrate to clk_ref helper
> >       clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator support
> >       arm64: dts: qcom: glymur: Add QREF regulator supplies to TCSR
> >       arm64: dts: qcom: mahua: Add QREF regulator supplies to TCSR
> > 
> >  .../bindings/clock/qcom,glymur-tcsr.yaml           | 146 +++++++
> >  .../bindings/clock/qcom,sm8550-tcsr.yaml           |   2 -
> >  arch/arm64/boot/dts/qcom/glymur-crd.dts            |  20 +
> >  arch/arm64/boot/dts/qcom/mahua-crd.dts             |  16 +
> >  arch/arm64/boot/dts/qcom/mahua.dtsi                |  13 +
> >  drivers/clk/qcom/Makefile                          |   1 +
> >  drivers/clk/qcom/clk-ref.c                         | 205 +++++++++
> >  drivers/clk/qcom/tcsrcc-glymur.c                   | 471 +++++++++++----------
> >  include/linux/clk/qcom.h                           |  67 +++
> >  9 files changed, 704 insertions(+), 237 deletions(-)
> > ---
> > base-commit: 3da905eb243cad56200f09bb7eaa060537aed0cc
> 
> I was hoping to apply this series, but I don't have this commit and
> patch 4 ("migrate to clk_ref helper") doesn't apply to my tree.
> 
> What did you base this on? Why don't you test your changes on latest
> mainline or linux-next?
> 
> Please rebase and test on a relevant branch.

Sorry for the trouble, I based v9 on next-20260713, but I forgot to
drop this patch
https://lore.kernel.org/all/20260420133616.88740-2-krzysztof.kozlowski@oss.qualcomm.com/,
which is a dependency for another series I'm working on, before
running b4 prep -n.

I can git am v9 cleanly onto latest linux-next (next-20260717), but
I'm not sure if that's the branch you apply against. Could you
confirm which branch I should rebase onto, so I don't run into the
same issue again?

- Qiang Yu
