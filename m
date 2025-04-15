Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0A4A23;
	Tue, 15 Apr 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675456; cv=none; b=iHbiDX/ljAF2Ck0+HA0GIgIb9cRuKY3EWWh4cfzrzVHx4WLAaCmR0rRfero7XOHFcnqOcIttXD7dBMrj9KhIIQIoFCL0B8f63FiM9z8y/a+r85rKVp+eQlJjUvw9QJn3Dd//352aBN95frr4PYOo6BC8h/+FjoMjJ3/EgeJGzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675456; c=relaxed/simple;
	bh=lifbmNCQmU9zh2B3tmcVoijI433snnQDoYy9dEDxz28=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M3EQ26tW1bJgvuY4WayYBalgZ4ohqMVD0CONPEAC6ecCMfvtFvA1XceSi1XuzL8L/4ihO3Qwn4y2ymYUuAfWAB9FpEmFCHAquaye6xsT4tojhb+sr4WFFzOlDmNDbTw8ggfkG/MW7MC1Wc1/LM1NWiQPHioTYjaKSabt6ephGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KMQ3JZY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KMQ3JZY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EFDC4CEE2;
	Tue, 15 Apr 2025 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744675456;
	bh=lifbmNCQmU9zh2B3tmcVoijI433snnQDoYy9dEDxz28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMQ3JZY8G8JX5h1ArhbPlvN9ZBlJZp5m5Ed9WPLttWLYSU8bps0lDdTxHm+PZDane
	 z4a08HxJ3lTPcWLdU04ZKydOpJum82B74lLRr40O9ku39CweW2kgBZMee/F8Uj/EFZ
	 hiXHMd70BbJBnpBQfkZi0oRrevKksyvo3wMg0dQc=
Date: Mon, 14 Apr 2025 17:04:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, kees@kernel.org, elver@google.com,
 andreyknvl@gmail.com, ryabinin.a.a@gmail.com
Subject: Re: [PATCH] lib/test_ubsan.c: Fix panic from
 test_ubsan_out_of_bounds
Message-Id: <20250414170414.74f1c4e3542b1f10c8b24d90@linux-foundation.org>
In-Reply-To: <20250414213648.2660150-1-smostafa@google.com>
References: <20250414213648.2660150-1-smostafa@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 21:36:48 +0000 Mostafa Saleh <smostafa@google.com> wrote:

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

argh.

> 	volatile char above[4] = { }; /* Protect surrounding memory. */
> 	volatile int arr[4];
> 	volatile char below[4] = { }; /* Protect surrounding memory. */
> 
> So, instead of writing out-of-bound, we can read out-of-bound which
> still triggers UBSAN but doesn't corrupt the stack.

Would it be better to put the above three items into a struct, so we
specify the layout?

> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -77,18 +77,15 @@ static void test_ubsan_shift_out_of_bounds(void)
>  
>  static void test_ubsan_out_of_bounds(void)
>  {
> -	volatile int i = 4, j = 5, k = -1;
> -	volatile char above[4] = { }; /* Protect surrounding memory. */
> +	volatile int j = 5, k = -1;
> +	volatile int scratch[4] = { };
>  	volatile int arr[4];
> -	volatile char below[4] = { }; /* Protect surrounding memory. */
> -
> -	above[0] = below[0];
>  
>  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
> -	arr[j] = i;
> +	scratch[1] = arr[j];
>  
>  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
> -	arr[k] = i;
> +	scratch[2] = arr[k];
>  }

