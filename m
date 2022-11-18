Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B024C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 17:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiKRRLQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242334AbiKRRLJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 12:11:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090608A16D
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:11:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b185so5444424pfb.9
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDyeQiupLB9oqNpxPK4jyqPn5HRNeTYV3/chespM10E=;
        b=mmBzH89Hj2Bxse1fbp/MklJ4r7OTki1zNjRRRoNQFmICn2xKHkYyz+YKjcBjiei1rV
         8aGlrsSZjZwe06eqH7BaCdtc1W69Hm0vttGjaN7A1SZITtFdzA5ZWyCsvO9CFMjt7TIV
         HXgVsNpwjx4s42njacRq4K+S9PszEvbNPTV08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDyeQiupLB9oqNpxPK4jyqPn5HRNeTYV3/chespM10E=;
        b=5m2VMurQlu6eFhYogRZS6eNoZpxkpHF2nwZs8joofskNfsLphrHdV7qpTgBes1muFr
         C3Yy7hAkrAFUidG6hbh2q0eRLoh8ZIv7zaJdfScAji9MkccmzYQHFs/ecG1jL2Cuy0sg
         ol6LCgAEtQS9H0f577Er1SKp2C3hTMAFvRbGzAF/aIV2X6qh3sMbtCd5dqFPzb3PS6bs
         qGj7zYwLzWNCBN7anbz26V+bB7ZaHG4Frt9AQKd5kQ+77/zi3JPrKFyblOB+Nd21+vRz
         vSbRD/pM5umwDgf6WYpyr1baLW1TBieNfjSestXHtet73MQwOuhlXyEcS5g+DJnmMb4v
         j4Ow==
X-Gm-Message-State: ANoB5pmyqcD6a+hWMFarDI6X7akVA0/kNoBl57r8LT2arhIgFNsbPJMU
        vwrvCZwIsEgfG+WvUKFnB6SY0A==
X-Google-Smtp-Source: AA0mqf4ZnmEE8OLUxPyWmX6DtdMNs26euLf7TggL/hADBnpVlbL4hqcSzhOLXCBe0EvSz9uq5N2EHw==
X-Received: by 2002:a63:ec11:0:b0:470:5b0d:b50e with SMTP id j17-20020a63ec11000000b004705b0db50emr7217183pgh.488.1668791468487;
        Fri, 18 Nov 2022 09:11:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b00186881688f2sm3884671pla.220.2022.11.18.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:11:08 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:11:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Message-ID: <202211180907.A4C218F@keescook>
References: <20221118035656.gonna.698-kees@kernel.org>
 <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 18, 2022 at 11:32:36AM +0100, Vlastimil Babka wrote:
> On 11/18/22 04:56, Kees Cook wrote:
> > With all "silently resizing" callers of ksize() refactored, remove the
> 
> At cursory look seems it's true now in -next (but not mainline?) can you
> confirm?

Almost, yes. I realized there is 1 case in the BPF verifier that
remains. (I thought it was picked up, but only a prereq patch was.) I'm
going to resend that one today, but I would expect it to be picked
up soon. (But, yes, definitely not for mainline.)

> That would probably be safe enough to have slab.git expose this to -next now
> and time a PR appropriately in the next merge window?

Possibly. I suspect syzkaller might trip KASAN on any larger BPF tests
until I get the last one landed. And if you don't want to do the timing
of the PR, I can carry this patch in my hardening tree, since I already
have to do a two-part early/late-merge-window PR there.

-- 
Kees Cook
