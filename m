Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEC34251B;
	Mon, 30 Mar 2026 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883758; cv=none; b=dW+6eHLdYdvCCDkxHaQ2PvQwveLHZqjmRYNis7xuG+gzLjbX37h4ILZoc3C+5pluXzzscBVvApAMy70cVe67wiRftUqWzzpfONplXq6T0UqJH6RD0epJuPlFohcReTQSnhjCKrgibtwABK7xza3m27gppy8nsX+DOC+tu5M8UpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883758; c=relaxed/simple;
	bh=8elS0smqCV9zVa0e7/7p6zCrVm//tVCNuv61Q4VKQJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDWEan8rHvj28nk1UucmtLbS8sSFVY3bXC1MKSvm+/0cM8WDvqLyxewa6ONhgP29jJ7Q9rzefAvRPLY4joe9BOHV3oVeO/GYKW9zAKjlVeTQJydBc5zEgOgn+zgwG9+bTwwZP1kfoxuhpgws40tTQBxqqUIR/QKI0YSpEx7pBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ATqkaKQ5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ATqkaKQ5"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1384E40E029A;
	Mon, 30 Mar 2026 15:15:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pcRaPXK4-0pe; Mon, 30 Mar 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774883750; bh=dryEDKZVEvugcKeaSJHtQQ/YkB5oXGBmXyX+cxURUgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATqkaKQ5uOMYeJ+PtWMPkv1Xsiu0nX7i3eH7LYspRyUBcOTRR2DPQGJmylH+8Btr6
	 x0JcyNgUlIPyyFZXD4XUu4zxPHED5j8boKMUxiVMdqQUD5IvIUf3JlBnhw4AtiEhm6
	 kI+KPaszYWf2iBUONMJlfh+5ZQ7Ne9LvgHXEXaMfwR6fh2L2jw3Dv2lZLwa8jsSj5d
	 Mfd5DgHuGH2+8Nwa+m4t2bDA8Z4rYStlI9VFO73mPMOvXl4UVQr3rA3ywJdI5ogxmV
	 xzuMrXnLrBTEfT1h50XAoDBxRfhbx40TkpQeCR57yxF9CfLC+0A1V6Z3aPf6kVvfWA
	 rmqv5XYc8eylLezA+auZNP0mGFbADhhJMxi5Axh/KR3g8qOWueGYapXPuYEe5wHv3p
	 d2moZz4vdGHmjtn9HMv9zVmoLL2OOOJAiHTWCukV7r8fjIVvwHYwpLA8Qhl2QBFm8l
	 vB+jL/M4em2MUIsllKwOYoWALytElVTELhpk6s5Tzgwmd0JPT/cpgVt9LPZnXUicuT
	 LB4j8aJdhNe2m3Luu2Dm23flRYxD8LaMMlUIYYNmtbek8g59G3NVVDBC04NoHEypxO
	 sH0u8NeeuFA34oKCq1CIOwa4lCldh/1/4y9xLtg/DiPg6qLZPL6YP+zS502dMxsR54
	 RMqljrefaBxMeL0YcA87L9Mk=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5DF5B40E0298;
	Mon, 30 Mar 2026 15:15:43 +0000 (UTC)
Date: Mon, 30 Mar 2026 17:15:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
References: <20260327024828.7377-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327024828.7377-1-rosenp@gmail.com>

On Thu, Mar 26, 2026 at 07:48:28PM -0700, Rosen Penev wrote:
> Convert struct mem_ctl_info to use flex array and use the new flex
> array helpers to simplify initialization.

Meh, simplify... rather to teach an old dog like me new tricks... :)

> Add __counted_by for extra runtime analysis when requested.
> 
> Move counting assignment immediately after allocation as required by
> __counted_by.

So far so good.

> Move memcpy to make it clear that this should have been kmemdup_array.

But you lost me here. What do you mean with the "should have been
kmemdup_array"?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
