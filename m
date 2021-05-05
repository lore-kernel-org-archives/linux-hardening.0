Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD8C43460
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0772360FD7
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 18:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhEESji (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhEESji (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 14:39:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7DC06174A
        for <linux-hardening@vger.kernel.org>; Wed,  5 May 2021 11:38:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e2so1585766plh.8
        for <linux-hardening@vger.kernel.org>; Wed, 05 May 2021 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POQGQj7ALoCPENTaHpI2WeLM1iSFaDi818aVBMGOLqw=;
        b=Db7y3p0IEKbFRtxFUuYHcc68qZZR873peN9d0aGG9tlw2rZmwTOGIz/dx5FTZ5Lphi
         6fuBUvVN2bTS1kqRzIhmnlmKpakG8unMK8hTv9EYWQRvwhYHW7AFphwdkFb7ZpM7neay
         rktKL9ozidaqOd0M8nj1aEFODm3v9hbv8k6+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POQGQj7ALoCPENTaHpI2WeLM1iSFaDi818aVBMGOLqw=;
        b=bsVT3oeZK9d9tKW4H1f+x4dxVGZW98+ivkkbpOWyXEI+H/9OrXUO1UsgReRFiW0AEY
         Ve1wlEify2gUZPGC0d4AxJbDPN6HVgHQZV0u1ETIJzq6aDnbS2KZcQlqLcPwSvpUbv87
         SEea2j2hmTMstzw9gASpUG7ZGlwlarDJkp1lSYKIF4S0xOdw4ycBimK0JR6LNb7hYxjY
         vofa0uKMOkPikTdGnoq8JB4mvGGKAXrTo7AhL/Ujb3KrooHK94FPMPCpioS0j4/eRjyz
         OSinXvebCK/cAO93y/3lYCfXFB7TgY6J+yFHhyokcZ5yYB5XfsMpbJnnG6PJ71crCzis
         HMcg==
X-Gm-Message-State: AOAM530fpWyRUrW7m1hbRGa8c3nIQFPvvgICNebk47Ay+g/P8vZWdAdM
        VbVONQuVW7p86OnCjIVPEBFJZa8uMNqcVg==
X-Google-Smtp-Source: ABdhPJxiN86yOamEdzSsvtrqNATfjczZniozKJJExXyIhzlZO4VwUnelTWDRAcgOFOWnS4+Z9USU8g==
X-Received: by 2002:a17:90a:302:: with SMTP id 2mr13376430pje.34.1620239921095;
        Wed, 05 May 2021 11:38:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm15882079pfm.134.2021.05.05.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:38:40 -0700 (PDT)
Date:   Wed, 5 May 2021 11:38:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <202105051132.7958C3B@keescook>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <202105042253.ECBBF6B6@keescook>
 <YJJZSdVoP6yBbIjN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJJZSdVoP6yBbIjN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 10:37:29AM +0200, Peter Zijlstra wrote:
> On Tue, May 04, 2021 at 11:25:31PM -0700, Kees Cook wrote:
> 
> > It looks like PKS-protected page tables would be much like the
> > RO-protected text pages in the sense that there is already code in
> > the kernel to do things to make it writable, change text, and set it
> > read-only again (alternatives, ftrace, etc).
> 
> We don't actually modify text by changing the mapping at all. We modify
> through a writable (but not executable) temporary alias on the page (on
> x86).
> 
> Once a mapping is RX it will *never* be writable again (until we tear it
> all down).

Yes, quite true. I was trying to answer the concern about "is it okay
that there is a routine in the kernel that can write to page tables
(via temporary disabling of PKS)?" by saying "yes, this is fine -- we
already have similar routines in the kernel that bypass memory
protections, and that's okay because the defense is primarily about
blocking flaws that allow attacker-controlled writes to be used to
leverage greater control over kernel state, of which the page tables are
pretty central. :)

-- 
Kees Cook
