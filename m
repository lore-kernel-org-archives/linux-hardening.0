Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC726AF6;
	Mon, 10 Jun 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044400; cv=none; b=gydSrPMMhfrsI1g5BOe+o0Hj39RsQo1j/Hg2JArLKRdvWOsBPuPUiSXKRlSd5lN1TYjdQdeQeWOOQXmni1LInY9UNcMem3o5MEnztFCT/gpcGoGjzZRPW7QtKGbYUJEmG7aTQvcefuCP2Cvb2iEMsWU8hk4Eo+bSbfvtlFoxbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044400; c=relaxed/simple;
	bh=z7GoEVteVgOtc8npLSzQ50VzcFsj6U4Ypa2U9npOXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyYXIDZ4DXfAZNYncfnOjGJCpCiDIVU1jbOBxkU51L108jde2QNPiKVuugLHcibxFJCBQTgW/n/XdvSyFPFNo3PRvOqXnBD/eX9PGN4ya4Q9DA57VcJoDxDWqlxh0s1IHWQ59XcKcUjzxIp9F0yK5NGfwM5XzAC/ny0aon+OSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzWqFXHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzWqFXHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970D9C2BBFC;
	Mon, 10 Jun 2024 18:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718044399;
	bh=z7GoEVteVgOtc8npLSzQ50VzcFsj6U4Ypa2U9npOXw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzWqFXHL5/BIn5baIlyMU1n811fD+ayPsVixBIeSOKOiUePsTJkpYe5wS0/Nw4cpp
	 3o9WDVMHokXbbtKfTUfbsuTlZkHy23s/3joKCh3We6yoIzyJQrrqxUAM2/nwTXui4b
	 P3f3/OsEv6VSMvMRo4wQM7Sz898CHzmS/veCX/nBtq9a55jj5q8jLD/xfy3MDVzNGC
	 0BZXwiSL+rwRv08pFWXNAeEusMBhtWzisLvAZPUWzPW/cvMLeTAU/KhJmcZFtv73R9
	 6wyS/LoeI6GNIlL5vCA8eiA2/qg8U6VeA60HcqQV/y1FFAlK/IVLlhuk0Zqan8ysxP
	 pBPz2hK/5G/DQ==
Date: Mon, 10 Jun 2024 11:33:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/overflow: Adjust for __counted_by with
 DEFINE_RAW_FLEX()
Message-ID: <20240610183318.GA3321@thelio-3990X>
References: <20240610182301.work.272-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610182301.work.272-kees@kernel.org>

On Mon, Jun 10, 2024 at 11:23:05AM -0700, Kees Cook wrote:
> When a flexible array structure has a __counted_by annotation, its use
> with DEFINE_RAW_FLEX() will result in the count being zero-initialized.
> This is expected since one doesn't want to use RAW with a counted_by
> struct. Adjust the tests to check for the condition and for compiler
> support.
> 
> Reported-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> Closes: https://lore.kernel.org/all/0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com/
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

Seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/overflow_kunit.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 4ef31b0bb74d..d305b0c054bb 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -1178,14 +1178,28 @@ struct foo {
>  	s16 array[] __counted_by(counter);
>  };
>  
> +struct bar {
> +	int a;
> +	u32 counter;
> +	s16 array[];
> +};
> +
>  static void DEFINE_FLEX_test(struct kunit *test)
>  {
> -	DEFINE_RAW_FLEX(struct foo, two, array, 2);
> +	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
> +	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
> +#if __has_attribute(__counted_by__)
> +	int expected_raw_size = sizeof(struct foo);
> +#else
> +	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
> +#endif
> +	/* Without annotation, it will always be on-stack size. */
> +	DEFINE_RAW_FLEX(struct bar, two, array, 2);
>  	DEFINE_FLEX(struct foo, eight, array, counter, 8);
>  	DEFINE_FLEX(struct foo, empty, array, counter, 0);
>  
> -	KUNIT_EXPECT_EQ(test, __struct_size(two),
> -			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
> +	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero), expected_raw_size);
> +	KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
>  	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
>  	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
>  }
> -- 
> 2.34.1
> 
