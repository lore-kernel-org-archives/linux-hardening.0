Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591152BEC34;
	Sat,  4 Apr 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775302491; cv=none; b=OZDXHoHRJjTzR/THkVBO0x/NvYfAf8yIdkyOq0NhsZ1yCgppB5O+MVt5cKI7VNQciwQPA8VVeeWae1vNh8mKR/L5JquqCHyt+EZtV6ZtOvi/3Ym2cEFrujpdlN6BmVGZaupg7PtxDN0gs8BR4r8QzpzjguoYsACgr/8iKMBghtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775302491; c=relaxed/simple;
	bh=Ow9QhO9wfoF7Vmg/G2JX4vIid+D5TO7M8+RE/T6ptQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjRPGpkfaDHPQDaGMuCjusXCm9bJHWJDYQ+Ln9OcPVkMnEAgnvb2kl3PIXf6/U1ThPBdZOi17e4cu/NmA7zz0UVwhf8nq/q5cq95Cui0VK1t5/p/6CGGim/V8V1FBo+WoIf4KNll7Ukbkj+c54StDVvcwxPoGGVOW+y3M63dEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmZ68RU3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmZ68RU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4093FC19421;
	Sat,  4 Apr 2026 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775302490;
	bh=Ow9QhO9wfoF7Vmg/G2JX4vIid+D5TO7M8+RE/T6ptQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmZ68RU39l6GEIZun8e6WzYdbO86be3EcpU17/EAfhJZv347v/TM+QxiPaMbFpeHc
	 K4bMxLwFJBq8bSrHeAVv63/rAX7/V7gFMMrtBnIlHT8gwOMNuAu5ju0PhDxH1JOkhq
	 BE1T2BXRI+aqfuAxSUg53sxoPCgXYtlSSogEHojPe4us+ppePsvedzZsAqsQaZvOfW
	 vDYeAQo33yt4zz+qbu0bfCvEuKd/pZkQlAEDiD+bgI1QtXRUBqIfESa50DAJcehylR
	 mPuikA8MEO8zbOed65evwcniqk6g07jgYhNr1Gd2xm7T9zyZ/Uj9ST/tkOnjHCvMG6
	 QuZsP5sMcUIqQ==
Date: Sat, 4 Apr 2026 13:34:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 17/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-2 clock and reset generator
Message-ID: <20260404-valiant-auburn-raven-c24be6@quoll>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-18-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402105523.447523-18-changhuang.liang@starfivetech.com>

On Thu, Apr 02, 2026 at 03:55:18AM -0700, Changhuang Liang wrote:
> +  clocks:
> +    items:
> +      - description: Peripheral-2 600MHz
> +      - description: Peripheral-2 400MHz
> +      - description: Peripheral-2 125MHz
> +      - description: Peripheral-2 GMAC2 RGMII RX
> +      - description: Peripheral-2 GMAC2 RMII Reference
> +      - description: Peripheral-2 GMAC3 SGMII TX
> +      - description: Peripheral-2 GMAC3 SGMII RX
> +      - description: Main Oscillator (25 MHz)
> +
> +  clock-names:
> +    items:
> +      - const: per2_600

Does not have any meaningful name in datasheet / clock hierarchy?

> +      - const: per2_400
> +      - const: per2_125
> +      - const: per2_gmac2_rgmii_rx
> +      - const: per2_gmac2_rmii_ref
> +      - const: per2_gmac3_sgmii_tx
> +      - const: per2_gmac3_sgmii_rx

per2 is redundant. Name these according to clock input names.

Same for your patch for per3.

> +      - const: osc
> +
> +

Just one blank line

Best regards,
Krzysztof

