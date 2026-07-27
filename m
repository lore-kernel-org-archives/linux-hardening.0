Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7457211466;
	Mon, 27 Jul 2026 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122554; cv=none; b=uGSO63cl4jQuZ5DQ9RKWTgsL8LB28RegDXRdbaSthJYcKcfR6u0cLBm7Q+VBfN5Cl2+3y97q0voac2tfwhCYxR5UNSFDK5KkdG9KN6JZs5+j9Mx111bvvGJgwxAg5wI4qC40HG5jDLn4l5AK23RSpMXFlhqAVU4cWHEbxbOe5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122554; c=relaxed/simple;
	bh=8KP4PiBBrRw09s2s62tuo65phqxK1mrxdRNer1iI8zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlrITfjYRNX6PtibV0WYqQrOmi/nWVoO2uFZud9uEBLzr4EGCSNPz6BUqeYUIqZP33JtZ3jxxrgBNL5RLks+c9jupywrrTxK6ApuqgIJraXaZB5CLbasSzJQSSzXL7viPMhX/oThpmzp0aM+kvnL42Br5SUHBacYuXRxUq5hmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1M5A/vL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1M5A/vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0971F000E9;
	Mon, 27 Jul 2026 03:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122553;
	bh=qV4h87/d1gnm+h3+HNsQ5x+Ju2OIOg1VuEoL6D5+CGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1M5A/vLCTdwIa8x8fIK0MsKBsYcUh+ivYwptg4o/7DeNHH/mDLg3zRjX1o3CPfhS
	 +oXfSspCrBolzfwpNYx0A0vZP0J76doKsNI+t3IcCLCgrsw8ECsNAa9VwILDhBvuLF
	 WMQeedvpjdp7ETpu7sFsr7a1hZTq/Y3W5QGJROzqtehNKbQpAqceWxCJPvFbXqr6XZ
	 DQoCYF6ptL4BbD1qHnkzyQGfcE15LgYeLvHufnmC2/6Oy7nsOL/dbAXZrm19jiCGO6
	 CsJ/+wC2etp8X3w1DVLrto0xRkKffSDOT78Qa8ZZ3YNyrC7L5fmarCk3747V58zVUU
	 8R8pdNX3eag3g==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v10 0/7] clk: qcom: Add common clkref support and migrate Glymur and Mahua
Date: Sun, 26 Jul 2026 22:22:28 -0500
Message-ID: <178512251610.15997.11111449058382808559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
References: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 21 Jul 2026 22:58:55 -0700, Qiang Yu wrote:
> This series adds a common clkref_en implementation and converts glymur
> and mahua to use it, along with the related binding and DTS updates.
> 
> The PCIe clkref clocks on Glymur and Mahua gate the QREF block which
> provides reference clocks to the PCIe PHYs. QREF requires LDO supplies
> and a reference voltage from the refgen block to operate. The refgen
> block itself requires vdda-refgen_0p9 and vdda-refgen_1p2 LDOs to
> function.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: clock: qcom: Move glymur TCSR to own binding
      commit: f9cbc4bddb636dd9d446bfba31f58fbceaf09424
[2/7] dt-bindings: clock: qcom,glymur-tcsr: Add mahua support
      commit: 0998cf30b0e0d02dbcdfc1f989b745137b21f682
[3/7] clk: qcom: Add generic clkref_en support
      commit: 22c70e5732005356a4bc2601e7dcf878aab101e0
[4/7] clk: qcom: tcsrcc-glymur: Add regulator supplies and migrate to clk_ref helper
      commit: 0753091abc4b480abf76cb40c10fffe2764bfcf7
[5/7] clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator support
      commit: 0f87ded5f8398182fbac232f0f287d45baa10d6a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
