Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A32DFA41;
	Tue, 15 Apr 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736944; cv=none; b=ebBIBYEllMPTciR4CSOXzhdUupQHWf02Otzcxd8IHZhoG7si4Ozvt5u/8vY3KQi9vevAIKbhrKzLo4Qc9oMlEpyTv6iH4dUbMviJ4HCDlmoOzZ/3A3OJa2v2XJBPIS+ftmyGrR40PinPSk+wkEWbi3XxOg/gkjHtXbV9i/s26hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736944; c=relaxed/simple;
	bh=itV1mnPN2J4RD1cM9Wi9CevQGPk6e65bGfzsrCLdnyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuxz5YZy02N6wBatVFEz+AeOm+JT0ZX4CICx+ioTVWejbFdNQC7I42zvUszoMM5Ggo98K63RDLZGJTjFl4+FW8Xd2fXR4L9Qj2d2aeSfnE7RLZeWgsDtYPza9Q2oZFvfNwt7UH9Q4y0tpI8beSpOQHC9aaH9uJDJuhJLGM+n77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awiPhOyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awiPhOyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89079C4CEE9;
	Tue, 15 Apr 2025 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736943;
	bh=itV1mnPN2J4RD1cM9Wi9CevQGPk6e65bGfzsrCLdnyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awiPhOyH4D5PZNFGlrG/oF3667wTf0iTqUMcdxjP2XQpyVdjWWa6MszBJStCuyU5x
	 gMzY7aGsnU2vMwx2IbCMKC4RpUfIEz/xQgFMlDaJj28l6VbwpaJkAEHvBKFNiK1QUr
	 x8tg2/iDdxXvw1Y13PKBrPmt3RYev/e8gu9gOMWNFjL9vqgbsVaX6Ah3SJKfejmbPx
	 VuGrJbbMVSer4/bPjhdznI/i0wqcR/MXGFS/UHLtmR08FKtwNvM2w9cK4X6QER98cS
	 RxtctKCNDvz0XXUztL855Oqhh1QOVp5EQJGLHt0afyVyUO6iABgJfPXZsO6R9awYhu
	 IIT7Qbk3b+MJA==
Date: Tue, 15 Apr 2025 10:09:00 -0700
From: Kees Cook <kees@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com
Subject: Re: [PATCH] lib/test_ubsan.c: Fix panic from test_ubsan_out_of_bounds
Message-ID: <202504151006.19150DFE@keescook>
References: <20250414213648.2660150-1-smostafa@google.com>
 <20250414170414.74f1c4e3542b1f10c8b24d90@linux-foundation.org>
 <Z_4dXk0RlyXYuzYt@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4dXk0RlyXYuzYt@google.com>

On Tue, Apr 15, 2025 at 08:48:30AM +0000, Mostafa Saleh wrote:
> On Mon, Apr 14, 2025 at 05:04:14PM -0700, Andrew Morton wrote:
> > On Mon, 14 Apr 2025 21:36:48 +0000 Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > > Running lib_ubsan.ko on arm64 (without CONFIG_UBSAN_TRAP) panics the
> > > kernel
> > > 
> > > [   31.616546] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: test_ubsan_out_of_bounds+0x158/0x158 [test_ubsan]
> > > [   31.646817] CPU: 3 UID: 0 PID: 179 Comm: insmod Not tainted 6.15.0-rc2 #1 PREEMPT
> > > [   31.648153] Hardware name: linux,dummy-virt (DT)
> > > [   31.648970] Call trace:
> > > [   31.649345]  show_stack+0x18/0x24 (C)
> > > [   31.650960]  dump_stack_lvl+0x40/0x84
> > > [   31.651559]  dump_stack+0x18/0x24
> > > [   31.652264]  panic+0x138/0x3b4
> > > [   31.652812]  __ktime_get_real_seconds+0x0/0x10
> > > [   31.653540]  test_ubsan_load_invalid_value+0x0/0xa8 [test_ubsan]
> > > [   31.654388]  init_module+0x24/0xff4 [test_ubsan]
> > > [   31.655077]  do_one_initcall+0xd4/0x280
> > > [   31.655680]  do_init_module+0x58/0x2b4
> > > 
> > > That happens because the test corrupts other data in the stack:
> > > 400:   d5384108        mrs     x8, sp_el0
> > > 404:   f9426d08        ldr     x8, [x8, #1240]
> > > 408:   f85f83a9        ldur    x9, [x29, #-8]
> > > 40c:   eb09011f        cmp     x8, x9
> > > 410:   54000301        b.ne    470 <test_ubsan_out_of_bounds+0x154>  // b.any
> > > 
> > > As there is no guarantee the compiler will order the local variables
> > > as declared in the module:
> > 
> > argh.
> > 
> > > 	volatile char above[4] = { }; /* Protect surrounding memory. */
> > > 	volatile int arr[4];
> > > 	volatile char below[4] = { }; /* Protect surrounding memory. */
> > > 
> > > So, instead of writing out-of-bound, we can read out-of-bound which
> > > still triggers UBSAN but doesn't corrupt the stack.
> > 
> > Would it be better to put the above three items into a struct, so we
> > specify the layout?
> 
> Yes, that also should work, but I ran into a panic because of another
> problem, where the padding before and after the arr is 4 bytes, but
> the index is "5", which is 8 bytes out of bound.
> As we can only use 4/-1 as out of bounds.
> That should also work:
> 
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 8772e5edaa4f..4533e9cb52e6 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -77,18 +77,18 @@ static void test_ubsan_shift_out_of_bounds(void)
>  
>  static void test_ubsan_out_of_bounds(void)
>  {
> -	volatile int i = 4, j = 5, k = -1;
> -	volatile char above[4] = { }; /* Protect surrounding memory. */
> -	volatile int arr[4];
> -	volatile char below[4] = { }; /* Protect surrounding memory. */
> -
> -	above[0] = below[0];
> +	volatile int i = 4, j = 4, k = -1;
> +	struct {
> +		volatile char above[4]; /* Protect surrounding memory. */
> +		volatile int arr[4];
> +		volatile char below[4]; /* Protect surrounding memory. */
> +	} data;

Instead of all the volatiles, I recommend using:

	OPTIMIZER_HIDE_VAR(i);
	OPTIMIZER_HIDE_VAR(j);
	OPTIMIZER_HIDE_VAR(k);
	OPTIMIZER_HIDE_VAR(data);

>  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
> -	arr[j] = i;
> +	data.arr[j] = i;
>  
>  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
> -	arr[k] = i;
> +	data.arr[k] = i;
>  }
>  
>  enum ubsan_test_enum {
> 
> ---
> 
> I can send v2 with this approach if it's better.

Yes please, the struct is the right solution to keep the memory
contiguous.

-- 
Kees Cook
