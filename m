Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379B3C9897;
	Wed, 13 May 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713485; cv=none; b=U38x2SP+3amvFiXuciXWFhQuqb/6vZGJGULFidCClg6PW16uTmXI0Bg8rdN3RMWmtVpQJ4L2SjNvyMsyLsj2bt62xNUgu9ITZ9yAN/FvC0acy9DRvU0Zp8gKgXAA5m13ErqXrSJW8o4kG0dCCKMT2o1NstxMIHj8Wao10Zrt2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713485; c=relaxed/simple;
	bh=1NCqOweC+UK62RewVsRZJmMrxaZ1Ds/R8sTtQ78tUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe/ORqdn3px6cbkJXsGuX9qbWA0Hs6rWdd3HTdisPpZe54hfoqI4OOADHTMiW/y8b1AJmXV5JQeTq+ZiqV7K6ZfTH5unvTfHTZ41KHfw4/8u++irAyDYMJJ1WgZS8Uwx7lzFm+D6ydmkvjD+TWfpQLBSIEtAVsXC0gD6m7FfDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxGEMfLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxGEMfLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC899C2BCB8;
	Wed, 13 May 2026 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713485;
	bh=1NCqOweC+UK62RewVsRZJmMrxaZ1Ds/R8sTtQ78tUsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxGEMfLsm4v9Xu3yCSKa0H2Is1j0wcYV16m1h+VdgMBnVAwSXZMCqx7JhrPQr+7mt
	 XCc5oUBVJ7aTZ2vgWFuA0ObdGG3uX+ChenJbAtCZ69pNY7c4g0ZJbG/UvMUqzslk5Z
	 c/V33mTEXusHzPlGzOaB3PGU1p1kLwIS+ZKV1NQgsnJeV50ME6LvnX7yxZT1qUu4ll
	 pR7Ad+qw5FPk5rB8Tg8WeBy3JhCykE57Vx/r4/kZzIGWGwkZ87t1E9Z1BQxpHI2p1O
	 JVSW6ar5Qc1c0DyvelNI/POIurtJOBnOWCrdtPejS92ruv0pBcP3rferCwrO0An4/i
	 4NP4O5hii9u5Q==
Date: Wed, 13 May 2026 18:04:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-riscv@lists.infradead.org,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-hardening@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 05/22] dt-bindings: clock: Add StarFive JHB100
 System-0 clock and reset generator
Message-ID: <177871348127.2268038.7602334271090264888.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-6-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-6-changhuang.liang@starfivetech.com>


On Thu, 07 May 2026 22:36:15 -0700, Changhuang Liang wrote:
> Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
> JHB100 SoC.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 28 +++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

