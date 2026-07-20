Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5A3FDBE7;
	Mon, 20 Jul 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547810; cv=none; b=KvAxuNMWMvNtrEvJxgcTEJHQmgOJz4hXfJTaRYHhMasnAFa4eXTCWtsJWJUGGHwE7xhFhyJpyN/+5AsQR9A0pZozUUEY6Bz+ZEQf3q/2h9K7RCMSweKQGD7o6GxdYvRHxDtOjE8p8F4Db+9DYvAzkaP3kB2334iLCLr6G+uRrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547810; c=relaxed/simple;
	bh=W6JRfOaTjOH/psjdJJNvEN+KaLZy6BySTLkUfOX8cgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NTp/raoNbCmNiOEahf37Z+gG7wterKMCwi5wUeWCse9mNncepbfa6AAI6zAf3Gjuc5TVt0lKsTWKXhTfLQUu0406g2sJXUKTbrSkgbZOKuj6Sryy0REZ1Ah+X7WBidepQAclvc4SOZMt7YSXuwV1N9SOX6lfCWODEqnLUzbgHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpOsEiDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpOsEiDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CADF1F00ACA;
	Mon, 20 Jul 2026 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547808;
	bh=jksvQuGJlzz+/4Aqk8TfN68mdO4WqGHnmBV95K91OZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bpOsEiDaIbN7OGiv7cjPKKtUgu3rNub1z904ya8JeruJorGiRPMGeDDKD6d7Tk+P7
	 vJDN7t3OBmirceI+A4PIpZ3QglMM4mdNi+PGbIVBRhEksV0bh5YrqswA/P9XyEzpux
	 ef3An1rVopb/HTeRyUd468oziyI8Thc6MyeS+pDV83j5TDVaa1YKgXIvf051b+uXyb
	 cHMshVPtFsRjmY8UBpaefAy+vdC1ztg0oSCMdAM4xUtv3UiV8UFY7srerA1VYuGJcB
	 DEVJmCjutGKYT6LZ4Qjz+5/FLhj3IrirnXpI5C2lOgNVyoTFrI7F3OHbX1zEjzt4fY
	 ficoVttbv6OJQ==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Alex Elder <elder@riscstar.com>, Ze Huang <huang.ze@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@kernel.org>
In-Reply-To: <20260703021024.495433-1-inochiama@gmail.com>
References: <20260703021024.495433-1-inochiama@gmail.com>
Subject: Re: [PATCH v2 0/2] riscv: spacemit: Add K3 PCIe/USB comb phy
 support
Message-Id: <178454780165.1388616.1849106686224680549.b4-ty@kernel.org>
Date: Mon, 20 Jul 2026 17:13:21 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 03 Jul 2026 10:10:21 +0800, Inochi Amaoto wrote:
> The PCIe/USB comb phy on K3 is a big phy that contains multiple
> standalone phys for each PCIe and USB controllers. This phy is
> required to configure a syscon device for mux configuration and
> calibration.
> 
> Changed from v1:
> patch 1:
> 1. Add extra description for "#phy-cells" and "spacemit,apmu"
> patch 2:
> 1. Fix multiple spelling errors and copy-paste errors.
> 2. Make some magic number as meaningful macros.
> 3. Remove USB3 set_speed() callback as it is not needed.
> 4. Fix the wrong land data config and mask.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy support
      commit: 013004374b4da621e292408112413b103dd28b03
[2/2] phy: spacemit: Add USB3/PCIe comb PHY driver for Spacemit K3
      commit: 7a099760ea63ced7b194852b7dbbdcd951585f15

Best regards,
-- 
~Vinod


