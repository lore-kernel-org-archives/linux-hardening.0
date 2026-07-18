Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE62931C6;
	Sat, 18 Jul 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411560; cv=none; b=sP9JAHdRdOs0GhQnhxYyA64zpX/E9r+QJnqqwD+bxUX0cEcamAgsZUqrBZpWoop3WHmLN478CZXIYTPGUAMC8bnZHm4kLKGl9hJzjfiEcKmnqXypFVTlmTNioJfKsXiOE6q6x3c86WA3ykFdF2RKr02BUYcmeSzk279ppz7+kgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411560; c=relaxed/simple;
	bh=jE4vEmWhqDfDnAyeKBZeUXueuYyuLFzU0M2qXfPhGvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCEX0WkrOox8df1xMvM1Z/FgeyuWG7j31ldgR6cC+FN6EiIOVgsdaP8W4erB2/EQP+m9VylhvrYys903hwQ3e/7fJaoiba/j42CGfj0kbcKeRBXWuy186NnuoB6poxQuQ3d1guBqLoE6RodgTNg+A8Xj7gekhLZQS/hO8N2PiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YujYHtOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YujYHtOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE551F00A3A;
	Sat, 18 Jul 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411558;
	bh=lp4SazQGY6OnqYiO++L8vIaDIiazS2LuP5GWhLWSCMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YujYHtOCxmRpOy8QFdqyFHsHAqxxlf28YDSXfl9MxaEplTnF0B6gtkTYIAuBq1FbM
	 magGl0O1n+BUZIGJt2mnULkceBBK5F+vsBRrdiEHwuo+PhnOTSBbiDLN59gQggmcaI
	 WMln4vOzTRxYXUQUXrYuITr62ue4nD5XhdlUlVRh97MbLNpp/bDImJ8vKYH8yyh0cw
	 Clq1PI9k+1E0Mmf9aC6J/QtZYTNXt9LkyN1OcYUHBrxRvlqWNRZdPfkNMzCz0CDIuJ
	 ftPddR0Str88YU3aWExUkubvTJT5SDT/PuhSMNd6xJecIvcQuppktVyNVd26HliIxZ
	 FwsCjnsIx2U9w==
Date: Sat, 18 Jul 2026 16:52:34 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/7] clk: qcom: Add common clkref support and migrate
 Glymur and Mahua
Message-ID: <alv1Q0ZmGVdUTGCu@baldur>
References: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>

On Mon, Jul 13, 2026 at 09:59:35PM -0700, Qiang Yu wrote:
> This series adds a common clkref_en implementation and converts glymur
> and mahua to use it, along with the related binding and DTS updates.
> 
> The PCIe clkref clocks on Glymur and Mahua gate the QREF block which
> provides reference clocks to the PCIe PHYs. QREF requires LDO supplies
> and a reference voltage from the refgen block to operate. The refgen
> block itself requires vdda-refgen_0p9 and vdda-refgen_1p2 LDOs to
> function.
> 
> Previously, these QREF votes were done in PHY drivers. In earlier
> discussion [1], the feedback was that this is the wrong ownership point:
> those supplies are for the QREF controlled by clkref registers, not for
> the PHY directly. Based on that feedback, this series keeps the
> regulator handling with the clkref control path.
> 
> Another reason for this series is reuse. clkref_en registers may live in
> different blocks across platforms (for example TCSR on Glymur, TLMM on
> SM8750 [2]), while the behavior is the same. The common helper lets each
> driver provide simple descriptors (name, offset, optional supplies) and
> reuse shared registration and runtime logic.
> 
> Glymur and Mahua share the same QREF TX/RPT/RX component naming but
> have different PCIe QREF topologies. Both are handled in tcsrcc-glymur.c
> via match_data to select the correct descriptor table per compatible.
> 
> [1] https://lore.kernel.org/lkml/aEBfV2M-ZqDF7aRz@hovoldconsulting.com/
> [2] https://lore.kernel.org/linux-arm-msm/20260202-topic-8750_tcsr-v1-0-cd7e6648c64f@oss.qualcomm.com/
> 
> Changes in v9:
>   - Add reviewed-by tags, no code change.
>   - Link to v8: https://lore.kernel.org/all/20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com/
> 
> Changes in v8:
>   - Define refs with __counted_by(num_refs) and make provider a single allocation
>   - Use mahua_tcsr_tx1_rpt012_rx2_regulators for PCIe6.
>   - Link to v7: https://lore.kernel.org/all/20260702-tcsr_qref_0702-v7-0-776f2811b7af@oss.qualcomm.com/
> 
> Changes in v7:
>   - Define compatible as an enum and add the per-compatible allOf/if/then block upfront for glymur. Reword commit msg for patch1
>   - Drop Krzysztof's Reviewed-by since the patch changed substantially from what he reviewed.
>   - Added a comment noting that on Mahua the REFGEN4 block is supplied by the vdda-refgen3-* regulators, and mentioned this in the commit message for patch2.
>   - Change the descriptor array to an array of pointers (const struct qcom_clk_ref_desc * const *). Skip unpopulated indices with if (!desc)
>   - Convert tcsr_cc_glymur_clk_descs[] and tcsr_cc_mahua_clk_descs[] to a pointer array.
>   - Add regulator lists for clkref_en on Mahua.
>   - Null-check device_get_match_data() result in probe.
>   - Add rx0 regulator in mahua tcsr node
>   - Squashed the former patch 8 (switch pcie5_phy ref clock to RPMH_CXO_CLK) into patch7, so Mahua PCIe probes at every commit.
>  - Link to v6: https://lore.kernel.org/all/20260621-tcsr_qref_0622-v6-0-c939c22ded0c@oss.qualcomm.com/
> 
> Changes in v6:
> - Split dt-bindings patch into two: one to move glymur-tcsr to its own
>   binding file, and one to add mahua support
> - Use regmap_set_bits()/regmap_clear_bits() instead of regmap_update_bits()
>   in clk-ref.c
> - Move clk_init_data from struct qcom_clk_ref to a stack variable in
>   qcom_clk_ref_register()
> - Add Co-developed-by/Reviewed-by tags from Konrad Dybcio
> - Add missing regulator supplies for EDP and USB clkref_en on glymur
> - Link to v5: https://patch.msgid.link/20260602-tcsr_qref_0527-v5-0-8ea174a59d7e@oss.qualcomm.com
> 
> Changes in v5:
> - Return 0 if regmap_read fail
> - Add a separate file for glymur-tcsr and mahua-tcsr
> - Link to v4: https://patch.msgid.link/20260527-tcsr_qref_0527-v4-0-ded83866c9d9@oss.qualcomm.com
> 
> Changes in v4:
> - Add mahua QREF support (binding, driver, DTS) to avoid dtb check error
> - Override pcie5_phy ref clock to RPMH_CXO_CLK on mahua since
>   TCSR_PCIE_1_CLKREF_EN is not available
> - Rename regulator arrays to topology-based names and merge duplicates
> - Remove else: false blocks from binding
> - Sort supply properties alphabetically in binding and DTS
> - Link to v3: https://lore.kernel.org/all/20260506-qref_vote_0506-v3-0-5ab71d2e6f16@oss.qualcomm.com/
> 
> Changes in v3:
> - Fix dtb check error: allOf:0: 'then' is a dependency of 'if'.
> - Link to v2: https://lore.kernel.org/all/20260420-vote_qref_in_tcsrcc-v2-0-589a23ae640a@oss.qualcomm.com/
> 
> Changes in v2:
> - RFC tag dropped
> - Changed back to additionalProperties: false
> - Moved all Glymur supply properties into top-level properties so they are explicitly defined.
> - Link to v1: https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
> Qiang Yu (7):
>       dt-bindings: clock: qcom: Move glymur TCSR to own binding
>       dt-bindings: clock: qcom,glymur-tcsr: Add mahua support
>       clk: qcom: Add generic clkref_en support
>       clk: qcom: tcsrcc-glymur: Add regulator supplies and migrate to clk_ref helper
>       clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator support
>       arm64: dts: qcom: glymur: Add QREF regulator supplies to TCSR
>       arm64: dts: qcom: mahua: Add QREF regulator supplies to TCSR
> 
>  .../bindings/clock/qcom,glymur-tcsr.yaml           | 146 +++++++
>  .../bindings/clock/qcom,sm8550-tcsr.yaml           |   2 -
>  arch/arm64/boot/dts/qcom/glymur-crd.dts            |  20 +
>  arch/arm64/boot/dts/qcom/mahua-crd.dts             |  16 +
>  arch/arm64/boot/dts/qcom/mahua.dtsi                |  13 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/clk-ref.c                         | 205 +++++++++
>  drivers/clk/qcom/tcsrcc-glymur.c                   | 471 +++++++++++----------
>  include/linux/clk/qcom.h                           |  67 +++
>  9 files changed, 704 insertions(+), 237 deletions(-)
> ---
> base-commit: 3da905eb243cad56200f09bb7eaa060537aed0cc

I was hoping to apply this series, but I don't have this commit and
patch 4 ("migrate to clk_ref helper") doesn't apply to my tree.

What did you base this on? Why don't you test your changes on latest
mainline or linux-next?

Please rebase and test on a relevant branch.

Regards,
Bjorn

> change-id: 20260713-tcsr_qref_0714-0ee27bc42a07
> 
> Best regards,
> --  
> Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
