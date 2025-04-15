Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495782550C6;
	Tue, 15 Apr 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750032; cv=none; b=NJSCeY0/0PMUZhfjU9spt9lS82ltGGBleL6SXbAjg1lsNzdxHFqmF1oyos8ucNiVAkBdgd34MFGcPy+DhUgqayZSBtx103sNtpQW6n3UN8sv+M2Tuc7dYmllXtsm89bsXQ5bSwVVlA8SbqmcvzpMLikEWkAJiEJdISK4NpixRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750032; c=relaxed/simple;
	bh=r7uM/9g94EHTRq00KXQL6go1X6wAY1HdtWiU8hwnLzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3AOkWdBBu3PT208XxGw3kjK1HoMfRsGEq/lAzCdFij6JxOrytvLqr+rfFY5VY2WNfoay/xKAKdFZzfAT6OJ0eZ29tFffQ7T0F+AZ270m2U5sT78QnWqqERqvkqPQI31EUXlENDynIB0av/ZwV8yZbXPWxu09Qm7jFcll48c3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh1G5a9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh1G5a9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6BC4CEEB;
	Tue, 15 Apr 2025 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744750031;
	bh=r7uM/9g94EHTRq00KXQL6go1X6wAY1HdtWiU8hwnLzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qh1G5a9XxCtz6MRT8Zo6lIgGHQjZxEcb0C8pOjI2UPOcx52U6ZppVxifvvVG4Gkb8
	 xc/3pD5slwUQdqKQB/YjtZeIYajZ31ZOKSbGSMw8JBUVe2tBpOKOdoRXaGgThJlERn
	 LAL05IZ4b7h8lIFZqf98JsL4Y5+B9Z1wgKp9AYEIbpfSbg2kL9ZiBbSfkL7FNQd/Xj
	 +zkE15wodl7NiyBSjGUuf8Cd0xN8Q9YgeJcJT87ASFKoADD64bwy4qv+oNn2D52Xi/
	 H6JGVnilmy+X88w3OOlF0JCuHaNsFS92nzfxIjiACo9pZP4E9sQglQJSM9TAVGpDhy
	 60oaaA2AhCvYg==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Mostafa Saleh <smostafa@google.com>
Cc: Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org,
	elver@google.com,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com
Subject: Re: [PATCH v2] lib/test_ubsan.c: Fix panic from test_ubsan_out_of_bounds
Date: Tue, 15 Apr 2025 13:46:51 -0700
Message-Id: <174475000897.3429336.4470350657359091880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415203354.4109415-1-smostafa@google.com>
References: <20250415203354.4109415-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 20:33:54 +0000, Mostafa Saleh wrote:
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
> [...]

Applied to for-linus/hardening, thanks!

[1/1] lib/test_ubsan.c: Fix panic from test_ubsan_out_of_bounds
      https://git.kernel.org/kees/c/7fd007c84e4b

Take care,

-- 
Kees Cook

