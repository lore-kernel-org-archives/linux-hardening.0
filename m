Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA34749C1;
	Tue, 28 Jul 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270513; cv=none; b=VMoDG+ec1XcqeudCAB59/ASxWWHoz6w1dTgetX8/gf6LzIaWLgWqFlMkpZ609YttWR1ePJKCe7YESQeuZOH/kikbZmxJQgO9lMCLyWlF8tkDEb/3M5WLetQVOHKnOlycCHOvA8unOvbOyjBgQCTR1mtaRqC8I+Fgx2F3hDy03y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270513; c=relaxed/simple;
	bh=mhSvMSnij2OE1VUpY5+jbWaST9nV3EpGv/9n4KohtXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBOpbMrLWgoVf8wU56yJKvV+KbDP0b/yIVhey2VLg0tDymK8h3uexaYpJyeszmid8b1hhlQIwsbVtDZBv5d5iRn/4eniw+2rwX4I1Ir5TsHWC3w1TOQ7c9i59ZVf2u0Zq7P7TH0mFtldg0JcUiR0EZ/BFrCk5xe1uHsh/8Au3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaqRrGDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaqRrGDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1121F00A3A;
	Tue, 28 Jul 2026 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785270511;
	bh=OABtXoJxFhtY59qDRI6twbfBJY8qSqezJc/hFL4jpns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaqRrGDToMquY+SgHvjSH47kCvkKxW2u0NsKv6TCTalySoRRUZ/V7ImodPkwOPv5F
	 ED5pUXxgxaD2RDSk2VzYgoDAOjc2zqlUsy9jOrDI1wAQ7o7Znl6/BJnzz124B9ZfLV
	 438xHd6/8OXlRqjQpap0PWzwRL3RRn47D9NgutC2Kf9MsVORD8wgNo9xfKLwDwUNXc
	 K67ix/84zuEILPsx0Y9LVAPZNZUzux8C/Y+xIlEDh/pqpCt8JSuv83NXasKPXYFU83
	 qoRgl4tzoxRodKmSqFH0zEHDglMQovyFyrWbbnTdhG+txyfAJ4Wc59JFU3lApHkOVx
	 xazwnDyDVYoug==
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
Date: Tue, 28 Jul 2026 15:28:24 -0500
Message-ID: <178527048948.46540.14969816748701954439.b4-ty@kernel.org>
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

[6/7] arm64: dts: qcom: glymur: Add QREF regulator supplies to TCSR
      commit: fc913a5ad811395be4daf2ca6fed8bcd9653916b
[7/7] arm64: dts: qcom: mahua: Add QREF regulator supplies to TCSR
      commit: 2947778fbc2e4cdf9b2f67f11854ebfa25194769

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
