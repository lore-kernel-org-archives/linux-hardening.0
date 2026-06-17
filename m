Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC7284B3B;
	Wed, 17 Jun 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657103; cv=none; b=GISck0tE5US/kkFiFBYsTyefFbr/FemqKnf6TvDcnPMzEkHNkKdhO7Dy4VBT5xRgMcv1/1Y40vFOpt/+Up5BGv8nyhwwQwtSnQ6jiEOu2jruXuFrExk+hMxdiS62ATFIdfL4d5xcYc1oa5oGpj0o8TMMWQtc0Y0PoiW8Vx8mjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657103; c=relaxed/simple;
	bh=ujNOBZ2z5FskbAtT7vVX8+tki15O3MQSuqBHC0N/3OU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSjVOlhyd0tfB8BHazqh6CfrDezNairXZxzTBgJXCzPUZG0q51PyvJdn95QszJFwpfBBBaZXHZH2wz9BwEpx10WGdtI36WQSxoHwrS1CzCG/2iE+zP9oXwhmWYDXKQl+DMlXC2NSeOD8UZaQn9gysbpk8It/YybAGrmJ3W+tkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZL2rTl7Z; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZL2rTl7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781657086;
	bh=oW3NBxoz0h1ByrSqH5tPVmY3lr7CHCdPxDnqXMlrypY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZL2rTl7ZbPOIJdHwOxroNvNWUC/kgtRAbAsWGXCKonHXLRrmL/CwWU+Z7+Gkh+iwA
	 rkleWiff1R18xZXbDHV+V6vMusxH4YNZC0aGcNbfh4HOuA7mznwR5ltcHkR4fT3sDm
	 x/mZEoOJHLzPyiLd/vEHJeeIGlfhNiMfAETpc0G+CkSpDn7tzt4F4t1En5OBL/lM76
	 LzFyNucIhKKmtxaZyCp/u1GAB7I+Mr7Ul1tYOBMQ6EbabGD4O1M8frojJ/D/NRwiPU
	 Iu+YKrclcxY0vsp14NBVCDcBduvG3TjzN8iwbtZkI6ijucd3m8yoAvkqE898hdaM/q
	 MxOsQal375ETw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0A1D7659B9;
	Wed, 17 Jun 2026 08:44:45 +0800 (AWST)
Message-ID: <b50b84b169b632200ca348971451baca83357c7b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 17 Jun 2026 10:14:44 +0930
In-Reply-To: <20260616073053.1144730-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260616073053.1144730-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-16 at 07:30 +0000, Karthikeyan KS wrote:
> Hi Andrew,
>=20
> Happy to. Short version: ast2600-evb can't hit the SMP timing window,
> so I reproduce each missing piece deliberately. The driver code under
> test is unmodified -- only the stimulus and the post-race state are
> injected. Stock qemu-system-arm (Debian 8.2.2), no QEMU changes.
>=20
> Three obstacles, and what I did about each:

This looks like a lot of heavily LLM-assisted effort. Please review the
relevant documentation, starting here:

   https://docs.kernel.org/process/submitting-patches.html#using-assisted-b=
y

I feel the testing strategy is pretty questionable. Any invariant
violation is possible with that type of meddling.

I was interested in whether you drove the interrupt sequence via
emulated hardware. I asked because upstream qemu doesn't currently
support the snoop device.

In v3 you said:

   The issue was observed on physical AST2600 (dual-core Cortex-A7)
   in production under heavy POST code traffic during concurrent
   userspace reads.

   https://lore.kernel.org/all/20260527175939.2939714-1-karthiproffesional@=
gmail.com/

Is this true? What platform did you test with?

Andrew
