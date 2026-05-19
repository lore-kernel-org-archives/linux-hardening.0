Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D348C70
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197681; cv=none; b=qaLKHPzqK9fG9feriln+5RzQgoVvQa/UhTp02JCkHUeQqbFCGepZCL8a8rBTDTvn4/HIRanXSeW/VLtpu2JNfCgerJJWm7s/RcRytnZvAqD37V0ubZ06GVOjJcP5GLY97d7Ro7QFz93fxZ+YcK2R5Cg2rvN+Xq5YZ42Kht5GgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197681; c=relaxed/simple;
	bh=9xmreuXX4OZRwbshJEWIm0npDYKfIXX0w6soI7Hy82M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnMwXL2/YxGirci6zuhu7X6UBz1/AEhYlePMF2ubIeyedmRvxhQ29khul1jOWH2K2ryYe5Fi68GNcLsU9Fe9yJShnwXNAG7QtAu1h/pbZ6aIKoHPjejNdHeRmBrxkayNhNxT30uNPe39JmvR7TPW/dq+7PlBFVOFeoKvdlO5YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-57513a91514so993732e0c.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197679; x=1779802479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFTXmUfGllClZ3AjkTxvr6AJKDsibhiDcNnm6JqqsT0=;
        b=LUilMyGClNlxjkIy49yGrRKI+02Vv8h2XqP+dqkTR5ZXKIb1hKHY5iFC+mPkNfw7ca
         M7qAkVRAXxJmsLyF6qnVkCYp+atVv8XBea0DUdcZdOcNHb89N6ydFhbiS5QtbokTiFg8
         D5dTpF+a0Z64qs8m3AGGLdC1PggR9Jf1VcEZOT+0jVoxziiSpqHQOJReSeMr3RXpcOHJ
         xcgLZdgZ1txCBkPMvvcINClk3FCiEbcKogY6eC7jN7mrNuq8s0MEqOPohmQ4N+/5SkqC
         PVdyoWk51V5yexLIj+sZWDo76J7UHINB+fdZ+pedlDVaGquHc5ognI0N1lbm3Mkc/tdo
         6B5A==
X-Forwarded-Encrypted: i=1; AFNElJ917K8y74mfwI0Y0MNHLYNQLokDIP14jtX/chVHlDmAjVvqdaxl74iiyOr4vuTQeF5UeB7AYiNOYDQXji44toE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2X3i3x03amcUCqggIgGzoYK5uk8TAHwrzlx7bSpZCvV1cYTmt
	v4IKNmN9kEB4f7mPSRurIKTyo4X4BnfNqntSReMh8GCoX+vmvl7O7RcI7e5hzl1V
X-Gm-Gg: Acq92OE4JeCKqr4dDRnjj1HuwlsPEvjUFb0I91042kJc9XYqEKebMY49QmeC5mkLgDc
	FIVA2hT8on/V+KdXmqixZF2ibvEwuJjJsda4bJic5VEQ3+ipdV5mCIDuduXDa5en8f7N1c7ZaE5
	zfg2s0NFAAQE4ApeeIzeKPNJ9BkKujPtfR95YNzaP32544uMlZ6V8sSxQQnUr4znzTf2zkQBBkz
	YbjFlCW0s/Y2Rg2Wb5Wlv0m5vezpjlX+FK/XXiwFY72KL6pIa7Ao4p7D2e121G4hmofaB+aGzPQ
	DMF8ezT58sgaKuR54yWgWJnVkCqLectn21j11lLDKNmCdhE7mtuYnznwuZW0ju9qyOcm7HLywTk
	GvRi4R/xJOLurb15llf8YQjDOHoIAGXzryq7cwXNJkNjXTyga+QEbO0jj/7cFBwfi5DTiz1Ogsy
	0FSJ3JH9AmAPFkpaTg2MDn7MaxbmMF4bHn6HpFE15VhO9Nt6YRvmRygmNskKSjEjKL
X-Received: by 2002:a05:6122:338f:b0:56e:e68e:9fc2 with SMTP id 71dfb90a1353d-5760c013b50mr11245953e0c.10.1779197679296;
        Tue, 19 May 2026 06:34:39 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fa5c008sm8282304e0c.12.2026.05.19.06.34.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:34:38 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-57513a91514so993712e0c.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:34:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+coRWd+aLrSN45HvaPWpFJ7EH+r9fKKBvxgqGnIl7l3UiNSOQc5pwanslSPIicgi4/Qk8q0QI6qkrT3dYOiPA=@vger.kernel.org
X-Received: by 2002:a05:6122:338f:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-5760c013b50mr11245780e0c.10.1779197677423; Tue, 19 May 2026
 06:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 15:34:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
X-Gm-Features: AVHnY4LojIxsw5qMq3Y5Vfna_ILMHrHCSLgg2NltrAvQXVuBSgCgEDdy5WadACI
Message-ID: <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel panic
> during error unwinding.
>
> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on its
> flexible array member `arr`. While kzalloc_flex() initially sets the
> counter field (`cnt`) to `max_segs`, the allocation loop needs to track
> how many elements have actually been populated.
>
> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop failed
> midway (e.g., "Failed to map sg list"), the error unwinding path in
> mmc_test_free_mem() would attempt to clean up uninitialized trailing
> array slots. This resulted in passing NULL pointers to __free_pages(),
> triggering a kernel panic:
>
>   [   66.172845] mmc0: Failed to map sg list
>   [   66.176722] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   ...
>   [   66.432747] Call trace:
>   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
>   [   66.439119]  __free_pages+0x14/0x20
>   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
>
> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> allocation. Then, move the existing `mem->cnt` increment so that it occurs
> prior to populating each array slot, using `mem->cnt - 1` for the actual
> assignment index. This guarantees that the counter accurately tracks
> initialized entries for safe error cleanup, while dynamically expanding
> the `__counted_by` validation boundary ahead of each flexible array write.
>
> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use a
> standard forward for-loop. This addresses the unsafe post-decrement logic
> in the original `while (mem->cnt--)` loop which evaluated and decremented
> the counter field before indexing the array, and avoids a potential integer
> underflow/wrap-around of the counter field if the cleanup path is invoked
> when `mem->cnt` is 0.
>
> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Started with cnt = 0 and incremented before assignment to ensure
>   accurate tracking of initialized entries in mmc_test_alloc_mem().
> - In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
>   safely iterate over initialized entries without risking underflow.
> - Updated commit message to clarify the issue and the fix.

Thanks for your patch!

> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>  {
>         if (!mem)
>                 return;
> -       while (mem->cnt--)
> -               __free_pages(mem->arr[mem->cnt].page,
> -                            mem->arr[mem->cnt].order);
> +       for (unsigned int i = 0; i < mem->cnt; i++)
> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
>         kfree(mem);
>  }
>
> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         mem = kzalloc_flex(*mem, arr, max_segs);
>         if (!mem)
>                 return NULL;
> +       mem->cnt = 0;

This is not needed, as it is set to zero by kzalloc_flex().

>
>         while (max_page_cnt) {
>                 struct page *page;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
