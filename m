Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ACC433ED
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Apr 2021 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A314161152
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Apr 2021 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDZWZB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Apr 2021 18:25:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZWZA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Apr 2021 18:25:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619475856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQMj3D96Z+VkDGWRL+sgLmic4KkQPDsjquONKnj3+e0=;
        b=0kXjBGtvkoY+85roJ8/wdmnFyWKEPQXR5Ynt/svYWNyCep43lp0mPgolqhWp/fq2zLhaxB
        R4sslb+hensNuaWK4zyf9Z8EP7nqCvCibbDVksCuUeSF0B7mt3fhNYzt4s0M8T0ruVcDju
        jyjbprzn5gHqBQgoXLrKLdMGvv/OBdvYnNOu2QJMnketXs7m/ZcEJL5dQIhrY5i342CKVa
        1d/O71gCUtb0nsrgA7PagN9pu/+xpUdU07jmW7ovjCR7wVljEueAbc76T+UYL0RdzjC8bU
        iLspW1nm5c+EcR64GJtCj0BCyGpYZthRsaBPKPMV5ZcMusuI2BUxzBV/4tPT1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619475856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQMj3D96Z+VkDGWRL+sgLmic4KkQPDsjquONKnj3+e0=;
        b=wwSCw6IetGlLmSppQu3oR88eD6z9Rsak++JTY6E2TVutAT2oeEoUZsMp9ZvuhSn2Q0C36H
        XGwzNk8Fj7kYRBCQ==
To:     Kees Cook <keescook@chromium.org>, bsingharora@gmail.com
Cc:     "mingo\@redhat.com" <mingo@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky\@amd.com" <thomas.lendacky@amd.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
In-Reply-To: <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
References: <20210108121056.21940-1-sblbir@amazon.com> <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com> <202104081319.DAB1D817@keescook> <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
Date:   Tue, 27 Apr 2021 00:24:16 +0200
Message-ID: <87tunsofan.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Apr 26 2021 at 10:31, Thomas Gleixner wrote:
> On Thu, Apr 08 2021 at 13:23, Kees Cook wrote:
>>
>> I'd still really like to see this -- it's a big hammer, but that's the
>> point for cases where some new flaw appears and we can point to the
>> toolbox and say "you can mitigate it with this while you wait for new
>> kernel/CPU."
>>
>> Any further thoughts from x86 maintainers? This seems like it addressed
>> all of tglx's review comments.
>
> Sorry for dropping the ball on this. It's in my list of things to deal
> with. Starting to look at it now.

So I went through the pile and for remorse I sat down and made the
tweaks I think are necessary myself.

I've pushed out the result to

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush

The only thing I did not address yet is that the documentation lacks any
mentioning of the SIGBUS mechanism which is invoked when a task which
asked for L1D flush protection ends up on a SMT sibling for whatever
reason. That's essential to have because it's part of the contract of
that prctl.

Balbir, can you please double check the result and prepare an updated
version from there?

If you don't have cycles, please let me know.

Thanks,

        tglx
