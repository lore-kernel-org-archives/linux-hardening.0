Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EAC433DB
	for <linux-hardening@archiver.kernel.org>; Sun, 28 Mar 2021 14:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A02A6196E
	for <linux-hardening@archiver.kernel.org>; Sun, 28 Mar 2021 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC1OTc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 28 Mar 2021 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1OTL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 28 Mar 2021 10:19:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3599C061756;
        Sun, 28 Mar 2021 07:19:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616941137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jt5HUbqaBbpJnFpBonfd9d+7RkA3BHSrsmyPxYI6Ow=;
        b=MPtduieEpysU4q9js5b0yPqytBVqj1yGGjDnyAvsGIVcZRlh1fGCuPgfVVgOBFKMBTNevn
        fLl17KJGqS+zzYhMdcfKfoWMZEiIOJ/1IxDriACV0viIjOxWGlZer8SDDiVpAwayddS5Nr
        dKzFubYqsIfVfviXl0oePNENDLeHuSpGRwsjxcNazb1vgd/tTLiqC1L11q9sk3HJj7auzp
        2RFKTUCCknRw1+XvPIFRYtgjlb9HqycmRITXwMVyD29pfWJb/DT40AZ2N0HulmJEyJJdyi
        wHhXCK0OW2CGaOTWyHH5SniDM+3e2+oAlwxo6M7w6ZpvQul1zg54QDaFYymMpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616941137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jt5HUbqaBbpJnFpBonfd9d+7RkA3BHSrsmyPxYI6Ow=;
        b=HnBEwLsP7QX3vSPeVDkKOWL7X+V2OXCZ1w0icw1CyJUPckQDr18pNfiQHYF3yrMy/hE0TQ
        adt3cwnSbiDqF5Cw==
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] x86/entry: Enable random_kstack_offset support
In-Reply-To: <20210319212835.3928492-5-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org> <20210319212835.3928492-5-keescook@chromium.org>
Date:   Sun, 28 Mar 2021 16:18:56 +0200
Message-ID: <87h7kvcqen.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 19 2021 at 14:28, Kees Cook wrote:
> +
> +	/*
> +	 * x86_64 stack alignment means 3 bits are ignored, so keep
> +	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
> +	 * the top 6 bits will be used.
> +	 */
> +	choose_random_kstack_offset(rdtsc() & 0xFF);

Comment mumbles about 5/6 bits and the TSC value is masked with 0xFF and
then the applied offset is itself limited with 0x3FF.

Too many moving parts for someone who does not have the details of all
this memorized.

Thanks,

        tglx

