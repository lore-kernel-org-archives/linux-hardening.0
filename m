Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53478C001B0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjHITtc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjHITtR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Aug 2023 15:49:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E033C15
        for <linux-hardening@vger.kernel.org>; Wed,  9 Aug 2023 12:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F2564762
        for <linux-hardening@vger.kernel.org>; Wed,  9 Aug 2023 19:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88310C433C9;
        Wed,  9 Aug 2023 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691610476;
        bh=LVWmFLNlFsqLy7e1BUA70TvOsNkzKB2qYX+hUuhwmhQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Aql09T/KU4U45nTZhmqhdMaNcjh9oYupox8RIjC0j2HKj6VcUL/JKYKrTToqtwuzX
         /wmxcvc+q49SQY+CuLOBjIDq5KBgD1n6l3QDzfgqwhbsfSAU0M9olFW5mRcMpTiwNa
         hjIqNvgYC9KNhP+ZV4bsKAGFLuxi08lHd65SZ3WDKqDi/wm1lQFNOIEJyV+nVym9pF
         UYb8jEN7yJDNskTonLLk185U1ugsB95X5oSD3QMqzuTqsBIdZS0f/LeQylZxUVk0Tl
         VPPRxoQQHiSXQkMobs5JRKxasIZR3n0LAg9O4104oBRHV+rSZP8wgsctQxZuubEhjI
         2bDDgSzSk9MIg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 764B227C0054;
        Wed,  9 Aug 2023 15:47:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 09 Aug 2023 15:47:55 -0400
X-ME-Sender: <xms:a-3TZOm1Uxec4_9VGuKDD5_9jJ4XLVJmLTgiG8oz8hEfbsD8wkLPgA>
    <xme:a-3TZF3m1SxZvgPZYXSjRSw8Buoq02EKI-5IaNx7G1rdbrQZHTtYx8VeIaLDVoldL
    1EnbFsyXmp74--QOis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepkedvlefghfehtdekudeggfethfegleetkeffveefgefgiefgkeefleet
    ueejkeetnecuffhomhgrihhnpegvnhhtrhihqdgtohhmmhhonhdrshgsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeige
    dqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:a-3TZMr7Jj-Rnzb4k6-56Tu4t9NdYTL94gTRUmqw04AhSBCfftwM2g>
    <xmx:a-3TZCkd7HinSA0wKXYkxoe2iTW45oDQ6pV25bz5koTkpAcRCAJdbg>
    <xmx:a-3TZM0Ey0o9qEkgA6TuDYOxtQuqwI2CzBkJipb9MhqQ8zLLtFaO0A>
    <xmx:a-3TZNnBqUIICmz2LOdUzzUgZgqMv2Sl-Y3OdhCIekUXoaMPjNCxpA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 213DEB60089; Wed,  9 Aug 2023 15:47:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <f34c11eb-89b5-48a5-bd24-c215083575a5@app.fastmail.com>
In-Reply-To: <20230804071045.never.134-kees@kernel.org>
References: <20230804071045.never.134-kees@kernel.org>
Date:   Wed, 09 Aug 2023 21:47:24 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: ptrace: Restore syscall skipping and restart while tracing
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 4, 2023, at 09:10, Kees Cook wrote:
> Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
> thread_info->abi_syscall"), the seccomp selftests "syscall_errno",
> "syscall_faked", and "syscall_restart" have been broken. This was
> related to two issues:

While it looks like my patch introduced both problems, it might
be better to split your fix into two bits.

> - seccomp and PTRACE depend on using the special value of "-1" for
>   skipping syscalls. This value wasn't working because it was getting
>   masked by __NR_SYSCALL_MASK in both PTRACE_SET_SYSCALL and
>   get_syscall_nr().

> Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
> leaving it exposed when present, allowing tracers to skip syscalls
> again.

This part looks good to me, at least it seems to be one of multiple
ways of doing this, depending on how we want to encode the
syscall skipping in the variable.

> - the syscall entry label "local_restart" is used for resuming syscalls
>   interrupted by signals, but the updated syscall number (in scno) was
>   not being stored in current_thread_info()->abi_syscall, causing traced
>   syscall restarting to fail.
>
> Move the AEABI-only assignment of current_thread_info()->abi_syscall
> after the "local_restart" label to allow tracers to survive syscall
> restarting.

I'm not following exactly what you are doing here yet, but I suspect
this part is wrong:

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index bcc4c9ec3aa4..08bd624e4c6f 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -246,8 +246,6 @@ ENTRY(vector_swi)
>  	bic	scno, scno, #0xff000000		@ mask off SWI op-code
>  	str	scno, [tsk, #TI_ABI_SYSCALL]
>  	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
> -#else
> -	str	scno, [tsk, #TI_ABI_SYSCALL]
>  #endif
>  	/*
>  	 * Reload the registers that may have been corrupted on entry to
> @@ -256,6 +254,9 @@ ENTRY(vector_swi)
>   TRACE(	ldmia	sp, {r0 - r3}		)
> 
>  local_restart:
> +#if defined(CONFIG_AEABI) && !defined(CONFIG_OABI_COMPAT)
> +	str	scno, [tsk, #TI_ABI_SYSCALL]	@ store scno for syscall restart
> +#endif
>  	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
>  	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
> 

If the local_restart code has to store the syscall number
for an EABI-only kernel, wouldn't it have to also do this
for a kernel with OABI-only or OABI_COMPAT support?

      Arnd
