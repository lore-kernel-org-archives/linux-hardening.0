Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513310E5;
	Mon, 23 Jun 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647804; cv=none; b=WhUBhiiWojSIXWwirVMkIkbomIP/Iv+Pc8t1JWTAbU2+tDaGoKEux+9i8wLiXF6ym4Ia1XZlLVjtuuiofzFNsOkEL7c05lfTfG2GxCLmVYHvYtU03DKdaGXBfDLtEQ1m8CtEnmVEccQD4PhAMGhjFhpsDd+p5QbvfoXmP0LNztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647804; c=relaxed/simple;
	bh=CtM1j44AW8Nx9dJ1sWGyQOtEti3sxM6oRMI24t/gS+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL+ziavMn/mK+oKpeR7DJL/ivsfoxiqNOp3jTN22mErcfAtnykLzsnQdHRMbl6lmND2QsJKjX9jcuQmQhvYokk2XyfoaX3DJ4lRhhA5J60wHDfwAZkiMA2xdljE6pBu9RDqWZ5P8fskTX7DclFIpsxgyPFtcveAz8x+qgzuhVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNm/WZ9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNm/WZ9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFF2C4CEE3;
	Mon, 23 Jun 2025 03:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750647803;
	bh=CtM1j44AW8Nx9dJ1sWGyQOtEti3sxM6oRMI24t/gS+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNm/WZ9B2983JkffowdOz+WFQrh1QsQXBDZ8Dg3tr5uQTjMXEY8tVVIQy756iW53n
	 0J6Xel9HnMEZ4/1rESG49XJgAfVGiWgdC5KgvTFk1FMPf+lUOG9H7lEJ7S4TQDzsTh
	 PnL35RyBdoUS2EYJe/NZJkB6fTuCA9gM08vMoYd0qZC1UBHB/cljNG1CNXosTrIVNQ
	 2tFOBEPqB68u6Vt+FeM2GPtOrtXFeuLMIp9/B3ysD8tTh0BU/SOLh2wlyDSIkjh4if
	 UczUCnNH/gVfWS58c7ayXYK4WI8o9COiXENnd0U5LKLV3V4osDpk5ZjB8TjIdKefY+
	 fVsZROON1LL+g==
Date: Mon, 23 Jun 2025 03:03:20 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Naoya Tezuka <naoyatezuka@chromium.org>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Validate ECC parameters against Reed-Solomon
 constraint
Message-ID: <aFjD-D45LkBH_gnA@google.com>
References: <20250620054757.1006729-1-naoyatezuka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620054757.1006729-1-naoyatezuka@chromium.org>

On Fri, Jun 20, 2025 at 02:47:57PM +0900, Naoya Tezuka wrote:
> The Reed-Solomon library enforces the constraint `n <= 2^m - 1` via a
> BUG_ON(), where `n` is `block_size + ecc_size` and `m` is `symsize` for
  ^^^^^^^^
Better to provide a link, e.g. [1].

[1]: https://elixir.bootlin.com/linux/v6.15/source/lib/reed_solomon/decode_rs.c#L43

> the pstore RAM backend. A driver providing invalid parameters can trigger
> this, leading to a kernel panic. For more details on the theory behind:
> https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html
> 
> This issue was discovered during develop chromeos_pstore driver:

s/develop/developing/.

> https://lore.kernel.org/lkml/20250610050458.4014083-1-naoyatezuka@chromium.org/
> 
> Add a check to validate this constraint before initializing Reed-Solomon
> codec. On failure, return -EINVAL to prevent the panic.
> 
> Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>

The patch makes sense to me:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
