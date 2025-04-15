Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019A25525E;
	Tue, 15 Apr 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749819; cv=none; b=aGLhInv2FMLCv2teYgr+AAao6vvejE8FughIuOFl0TmsA33JuBgPP5fI1y5ISzeUlTWh5XBmiSpDyNtFU+fwPX6vojLIoYrJsfmDodQvRQOlU9TB7y1qbSghMTgjsslf9Vij5vq24gL3NRuFX8z+L6U+6+P6j5mAbHcaWWyV4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749819; c=relaxed/simple;
	bh=1EYMhKxcRTGteJOZXgc+9Mq4KqYNF9X4ORio08rRZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOipBuIarTTP/MW/LCXkV8+IybE5HjPnfaAcVk5xOmO0zf4Q4xcrSYykmfqq2p70Vk+QGquzCSwB6bv/0dTI00bh/Vj967FNptGdnid1LbQRflL1+utMfdZ3N5d2SpFYPifNBgk5AWLsxpgqyD2LN/zzH1rk17xWUG223QNGl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yntpc1eL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yntpc1eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DED9C4CEE7;
	Tue, 15 Apr 2025 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749819;
	bh=1EYMhKxcRTGteJOZXgc+9Mq4KqYNF9X4ORio08rRZe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yntpc1eLYzygWqALEt6TgeHFdDkjme0qwJLRDQQnmQQ4IBHNmsiLd3xYrcJPXAMdI
	 Knng/iNI+DJ9PYj4LkXZGvXgn2NlZaEbo33Zwv8+EzwoJnO874IDL/xIsbAzMepcqe
	 ieBsBctbhoZC93k+efuD8jcjBKo6C3I4ZJbNynJhBQEnutSbwEZP19qz9dfTWytMi/
	 ySJ7qHEDtioOb8jZvH8kIzhhcncbaGkmTapHT6gnAkPZt56XeaT9ImOLfj/8AMsId4
	 qCPZZvVFIAAhY394uS2y0iAL8CmjSAi45i7LR8AihNXvLRVFElghLMcKlfow1YYGLM
	 ZPPpDJXQN16XQ==
Date: Tue, 15 Apr 2025 13:43:36 -0700
From: Kees Cook <kees@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
	elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com
Subject: Re: [PATCH v2] lib/test_ubsan.c: Fix panic from
 test_ubsan_out_of_bounds
Message-ID: <202504151343.794CF53@keescook>
References: <20250415203354.4109415-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415203354.4109415-1-smostafa@google.com>

On Tue, Apr 15, 2025 at 08:33:54PM +0000, Mostafa Saleh wrote:
> Running lib_ubsan.ko on arm64 (without CONFIG_UBSAN_TRAP) panics the
> kernel
> 
> [   31.616546] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: test_ubsan_out_of_bounds+0x158/0x158 [test_ubsan]
> [   31.646817] CPU: 3 UID: 0 PID: 179 Comm: insmod Not tainted 6.15.0-rc2 #1 PREEMPT
> [   31.648153] Hardware name: linux,dummy-virt (DT)
> [   31.648970] Call trace:
> [   31.649345]  show_stack+0x18/0x24 (C)
> [   31.650960]  dump_stack_lvl+0x40/0x84
> [   31.651559]  dump_stack+0x18/0x24
> [   31.652264]  panic+0x138/0x3b4
> [   31.652812]  __ktime_get_real_seconds+0x0/0x10
> [   31.653540]  test_ubsan_load_invalid_value+0x0/0xa8 [test_ubsan]
> [   31.654388]  init_module+0x24/0xff4 [test_ubsan]
> [   31.655077]  do_one_initcall+0xd4/0x280
> [   31.655680]  do_init_module+0x58/0x2b4
> 
> That happens because the test corrupts other data in the stack:
> 400:   d5384108        mrs     x8, sp_el0
> 404:   f9426d08        ldr     x8, [x8, #1240]
> 408:   f85f83a9        ldur    x9, [x29, #-8]
> 40c:   eb09011f        cmp     x8, x9
> 410:   54000301        b.ne    470 <test_ubsan_out_of_bounds+0x154>  // b.any
> 
> As there is no guarantee the compiler will order the local variables
> as declared in the module:
>         volatile char above[4] = { }; /* Protect surrounding memory. */
>         volatile int arr[4];
>         volatile char below[4] = { }; /* Protect surrounding memory. */
> 
> There is another problem where the out-of-bound index is 5 which is larger
> than the extra surrounding memory for protection.
> 
> So, use a struct to enforce the ordering, and fix the index to be 4.
> Also, remove some of the volatiles and rely on OPTIMIZER_HIDE_VAR()
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
