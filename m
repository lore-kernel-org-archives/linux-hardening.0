Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7C3E411D;
	Tue, 29 Sep 2026 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651737; cv=none; b=pbHM4iFjk/ifz0eiZ8pZVrASeLZNNgZoHEDcSDl/JI2ItPiba0QnqtPncpsRA3UZTQ4QbukSyyqKM0SR4Rihlrg6ffL8ylVvIvWhmY86mjPgvEW+yHOsoP4E//VOn71pKP4jYGNxWE0Vt4pD+lZzLE6v6Tb8R6MODRLfeY26b+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651737; c=relaxed/simple;
	bh=np9vO6J2bxXpWGssG0WK33Ur3TZ+Ir+qdiM0Uht86hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TepR6uawqS+0pOb/9RYU3eQMDXaxRvYshlkcMOT1fCX4y0YZnzfbko7ovEfzW+PeRHOik+9GPjGkpUU0UaRy53+JaKbW9mPaFy+seA4HlnPq2jBgwD3Xc1Xa4mll6sN4mf7kQ4IsBH/yWpEyel7dnyNYqhxY2IaG0XgyzyfsRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byOJTrv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byOJTrv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7871F000FF;
	Tue, 29 Sep 2026 03:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651733;
	bh=Be2zbFpD5boeeulkx4osulgmzziApB66Vu4BHM8PBfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=byOJTrv7B5j1lFA7BKKldSd0XiMCZ6UmxipKTxpjLR82RAKD0eN3RhHNmhx3VnwzE
	 bhp5QSuQ90ePEolAkV7oDSBCwHAPpiGzvp5H1dZcf8tDHL4jmSX+OHNu6PrYdlTyn0
	 /Savg9iwjDUkjXhRwQgQ3QqqzKeWHKkfDwW+NkNwzLDKx5Q/pDqw3otw+wLG/ECJEx
	 Xsl5RzyuAre7FQTIoAI+EJDMbKKpDi27/5lxds1tiB/2BVwj6zWvTtPXAV067ebayV
	 IzNA9/2g5MyvtLSgxk5UyUeuSPvrPAEU8wV09h4dm2N5vhb73/pjUd0uFDoDgdfX8o
	 QL1b1o0400TfQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/7] arm64: dts: qcom: Add 3 new devices
Date: Mon, 28 Sep 2026 22:14:35 -0500
Message-ID: <179065170953.2673486.9099361646406766357.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
References: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Aug 2026 14:26:59 +0200, Adam Skladowski wrote:
> Introduce support for 3 new devices:
> - Motorola Moto One based on MSM8953
> - LeEco Le2 based on MSM8976
> - Xiaomi Redmi 9T based on SM6115
> 
> Device trees besides enabling most of supported hardware also wires power to
> subsystems like MDSS even if those are not enabled to lower maintenance burden
> on out of tree forks.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: vendor-prefixes: Add LeEco
      commit: 1658af4d25bd3133d1b3403ccdda6214d40c0ebb
[2/7] dt-bindings: arm: qcom: Document Motorola Moto One
      commit: 51c5d61ba73bde54d7900276cb1c0e37d416adfb
[4/7] dt-bindings: arm: qcom: Document LeEco Le2
      commit: 147a652d5257cca0cda8a7ad5f4f69ed0eff4a2f
[6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
      commit: c2cec02793328f09dd80387d23d7a9562fd80f36

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
