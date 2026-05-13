Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC03CB8E2;
	Wed, 13 May 2026 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713687; cv=none; b=pkkdHt8il5GlHvP0O8d1eqUfZtJ6uC1LTxp6CW3VtOR9psRBlMibtYR3ppUgP0MZPnexfMNfgX6wlWN0+SwmpTiL2aJVSZZFuuyuLhkIYtYtzIfwn2bQApKXXZeW1Qy3fW6O21mohA1VLhJSSzf/9mU7WxUT+eVBoVeVJr8zzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713687; c=relaxed/simple;
	bh=YOx5S+WMlC2TiFkDOXGAXO69J0hp9pP8PzJFV3ILM6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3e0BDU8GqTXdFU6ri7JfM6iwQVW9ZqZdM0DZcgVIsdrFWdhWZqMNBcMvdGqnb93GwFx0XWiK+GqKJ9L1yrObyhLtWDaCkkk1KxqKnQmVnuR8i//bGXNTZE+mYQzxbsXZl/AQ1RTIaART1EzdrgvOG4wLCSeHjEOBF9Ne4ZfYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXLc7dTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXLc7dTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA98C19425;
	Wed, 13 May 2026 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713686;
	bh=YOx5S+WMlC2TiFkDOXGAXO69J0hp9pP8PzJFV3ILM6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXLc7dTSbKXJC1jjz6deJLApBQj3vUvPUCCdX992sxhcVK+u2hxmG42CAL21gfEpB
	 vxJr1MkHpnloYFmsVHAra/jmlWTQHHYVwKh9C4Rr+O9MnQjU5YhhWqP2OS0TbGqMtz
	 61abOa61pSryxXjkgRtwFzFHN/V+sXvWLso536Ee37I0YeD2vlvaHux/sOsYL5ombS
	 X2vORTBVZ8bfsbj7bO2M/wCsYQQIljDdE/sJ3BiUXGvLu4ZycRxdPSAPbmWULfaNC8
	 8CvYgJ0uGaaimwfkkE6LNFfNfjvVY9unKJlMXEZgm5NT81IMZJqXTHAfD6yj1j/X+c
	 2ZKDmCftR2AvQ==
Date: Wed, 13 May 2026 18:07:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-clk@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 09/22] dt-bindings: clock: Add StarFive JHB100
 System-2 clock and reset generator
Message-ID: <177871367651.2277166.1596733708637773220.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-10-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-10-changhuang.liang@starfivetech.com>


On Thu, 07 May 2026 22:36:19 -0700, Changhuang Liang wrote:
> Add bindings for the System-2 clocks and reset generator (SYS2CRG) on
> JHB100 SoC.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-sys2crg.yaml        | 64 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 33 ++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 25 ++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

