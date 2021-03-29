Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2290C433C1
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Mar 2021 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FE560249
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Mar 2021 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhC2Snh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhC2SnZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Mar 2021 14:43:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28819C061756
        for <linux-hardening@vger.kernel.org>; Mon, 29 Mar 2021 11:43:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so4834164plj.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Mar 2021 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlNrP/9Ut5sXN3pkzKNi+WSrlgUBYs/IFekoNMyL2Jw=;
        b=T+DpvsxQed12BAoexlkki+09jZcOH2cjiPTOOafDyn6acCeGPxIcFenrtcJ3zGGa8+
         mSk7Iu22+Txx0wacKigEu3+FnKaFEgH82nuqdasm4GN0gQoF+hpT3m52TrAsh9p0Gnkv
         ME2leGRxC72wu2uxStmg0L9ey3ygUFNqHk0V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlNrP/9Ut5sXN3pkzKNi+WSrlgUBYs/IFekoNMyL2Jw=;
        b=TsuCuqa3tWJgim7vy37TSZB8imVvWwq6RE4e4WIX+ff/lwAQQOcb7Jaomy5PtV8eCW
         U5Hq5/Jwg7Ob0AMn5oAimC76H0l8n9pwQYOfM7ZhuK4NmexLLmYHO2BzKSMSR9/9GLUa
         Dmpd5hOuNjlFXUMaJ9z5K21ZS2qWq6nOL8cJWoUT2Q0LhxcjgI9wr1rCMTTZUxSS2iIj
         cxuk1OK7KecTZgQwwnsyVIVOhbkkHPnl5m0/A5kWRoKJpoetamKMDcfqrnPKDO7MhhD6
         pkNXUhAXddJW0gR0c4VF7pEyHdHV0z4Q4Y9DoywgY1UngEhTRQrjBqGcObGr0XuptQuX
         IT5Q==
X-Gm-Message-State: AOAM530zXAR6mEypfswGx81CSo3hamck1rWoCVymjdS8UAmGHBgH9h6w
        I8aIITMs9YwdQq4KZIa1ZhLoyQ==
X-Google-Smtp-Source: ABdhPJxToxGXO0GwIsEriJuM+yDUQVqjN+yq+LJpGrMhEoXh9Okut5BCawWoS9xITNbBK4nDieDGBg==
X-Received: by 2002:a17:90a:bd09:: with SMTP id y9mr458540pjr.179.1617043404655;
        Mon, 29 Mar 2021 11:43:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9sm17260832pgc.59.2021.03.29.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:43:23 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:43:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
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
Message-ID: <202103291141.EC2A77731@keescook>
References: <20210319212835.3928492-1-keescook@chromium.org>
 <20210319212835.3928492-5-keescook@chromium.org>
 <87h7kvcqen.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7kvcqen.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Mar 28, 2021 at 04:18:56PM +0200, Thomas Gleixner wrote:
> On Fri, Mar 19 2021 at 14:28, Kees Cook wrote:
> > +
> > +	/*
> > +	 * x86_64 stack alignment means 3 bits are ignored, so keep
> > +	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
> > +	 * the top 6 bits will be used.
> > +	 */
> > +	choose_random_kstack_offset(rdtsc() & 0xFF);
> 
> Comment mumbles about 5/6 bits and the TSC value is masked with 0xFF and
> then the applied offset is itself limited with 0x3FF.
> 
> Too many moving parts for someone who does not have the details of all
> this memorized.

Each piece is intentional -- I will improve the comments to explain
each level of masking happening (implicit compiler stack alignment mask,
explicit per-arch mask, and the VLA upper-bound protection mask).

-- 
Kees Cook
