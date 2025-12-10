Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F262FE04C;
	Wed, 10 Dec 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352175; cv=none; b=jlzbivCudwIRJmKTTm50HmIoJbVexkQGLHV16ZNdtha8l0uSOLbIFpGXntvngCK+gdyEVOzVpLHjoM2+br4L38vMyJh8VPxHgaT6VKStYhLnfyeFd6fTLeCJ+7uteCVjrB7u1K7Kb5c597CrKE/z2aWXQV2XDWyCzH9vneyrh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352175; c=relaxed/simple;
	bh=iUppsHmKIPYLCGiMvoqzAZrUDsfo/tr0nQIA84KdW+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb9JX/JoD321wWH/lGTH3ihoZ1NStBCGI2l686tK17mJkO9+TwGSxpFl7j06+lhfEuiKFsH1mifkodHJDrbFDg01JJMeC0GtTsjOR/1eaDsPEDjynx75V0/vK8yGrL+FBdIZnbKXK6WDh0qW4+Qpc8rnBObgViKqxWJ5VziFgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R50whwEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R50whwEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FCFC116B1;
	Wed, 10 Dec 2025 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765352175;
	bh=iUppsHmKIPYLCGiMvoqzAZrUDsfo/tr0nQIA84KdW+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R50whwEdf3s4QkMMgzINqP5trAK0feQtUqBRP5vmQNBVuQHIotIsBP+qEIBZFr6V5
	 LLuHl2Ghoa0cQsrqMYEYfim/KWnJbVXukuzfGjml5f00+IPJ8NXaNJUeR+qQ6tr9E9
	 BWAs+xJ2yg6qBnLO9TJ3l1mI6yqSnuzDt7Pjsi3XkQVdrG0tgfcMXtR9tMKplpSGwg
	 RufmvSl+dU+QpEEFem65R/y+JEOuIYWBG762oZeIMh+lqKDJSgFKH6U6IFPTpWGNdk
	 G5hPx5YPMjrzY5SATQ6mIsWM5dXqWDHSE8IM5BA04RfrMBW6sdHmgzPRonxVV38mes
	 xK3xV9tSho9eQ==
Date: Wed, 10 Dec 2025 16:36:11 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hardening@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	llvm@lists.linux.dev
Subject: Re: [bug report] clk: visconti: Add support common clock driver and
 reset driver
Message-ID: <20251210073611.GC1147766@ax162>
References: <aTgetqy8BGerPGTl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTgetqy8BGerPGTl@stanley.mountain>

Hey Dan,

On Tue, Dec 09, 2025 at 04:05:58PM +0300, Dan Carpenter wrote:
> Hello Kernel Hardenning developers,
> 
> Commit b4cbe606dc36 ("clk: visconti: Add support common clock driver
> and reset driver") from Oct 25, 2021 (linux-next), leads to the
> question:
> 
> drivers/clk/visconti/clkc.c
>     187 struct visconti_clk_provider *visconti_init_clk(struct device *dev,
>     188                                                 struct regmap *regmap,
>     189                                                 unsigned long nr_clks)
>     190 {
>     191         struct visconti_clk_provider *ctx;
>     192         int i;
>     193 
>     194         ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
>     195         if (!ctx)
>     196                 return ERR_PTR(-ENOMEM);
>     197 
>     198         for (i = 0; i < nr_clks; ++i)
> --> 199                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
>     200         ctx->clk_data.num = nr_clks;
> 
> ctx->clk_data.hws[] is __counted_by() ctx->clk_data.num.  Don't we have to
> set the .num before we fill initialize the array?  Or does the checker

Yes, it looks like line 200 needs to be moved above line 198.

> code allow us to access the array when the counted by variable is zero?

Nope, I just had to fix an instance where num is one and hws[0] is being
accessed:

  https://lore.kernel.org/20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org/

I suspect there will eventually be a report on real hardware when
CONFIG_UBSAN_BOUNDS is enabled and GCC 15 is used to build the running
kernel, which is the first version that supports __counted_by(). How did
you find this? A new smatch check? It would be nice if the compilers
could flag this but I guess it is probably harder to do this in a
generic way.

Cheers,
Nathan
