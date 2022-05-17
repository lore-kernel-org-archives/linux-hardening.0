Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA2C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351442AbiEQRfs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiEQRfr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 13:35:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E537F6E
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 10:35:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so3142945pjp.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjTMC22wSJ47xdwSvqZCnDiGp9aPojAuMgBLE3Ru6Ns=;
        b=glbJj5X4FvEyfTXgOl7rRrg5gxtB02qGsHzTepdXpPxdD+2EOa2Gd3eR+cGDpYSzpZ
         79iaET+rnGfoymf5ex9uVGJjxTgNteZwuM/XWfbSqIrF+vTMPu5tIWJ3oAcEe5S/xh79
         6BCVObEo2xeexg0OiEd+nYK3Nfn7PexZn1WBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjTMC22wSJ47xdwSvqZCnDiGp9aPojAuMgBLE3Ru6Ns=;
        b=VlGEbykmxlck64NgiRC80kzOHiAQrNi7Dh2EvswrBjDt/fAAbaeXNF2Waq0aX+wwu0
         OsflaL7J+MljWUhBmuw4PAW8PNs1X+dj6/6KZHXeBZUK2oqSI2xhuj7p0nqNLoiW8aYV
         b1DaoGn1tFv6z/dlPc+X+U60VWW8Fei+RJ2DAMSB23of2LO9xnQPBx7NqVkDxYkd95kj
         L9P5Oz/iebpx7LCThPNDVpeEz4K6vaxfojppcisa6fbIjARuszlxjNhy7zOI59QHHKf/
         Hm0OJIb3YKr0E62F6c7kIRKkaKULSH9w1GiToPjMdj/8Pq421Ki47oBmRQOtZ7qd6muH
         YDfw==
X-Gm-Message-State: AOAM530Gp5E/ZQxy/1qCrAWjEFoTlxCJRHnDA9yAJeeIDM6p0ATR8AF0
        wNEv2kxbNEtcO5EEcDyKC3EMPQ==
X-Google-Smtp-Source: ABdhPJyklgL9P7KQ8KleeVzd4Z0HdMD3Tyeg8TCp4qbuh8EG/GLEpomy43Lre0Y6YoLoviPMTxtK/Q==
X-Received: by 2002:a17:903:41c9:b0:15e:b449:ce9a with SMTP id u9-20020a17090341c900b0015eb449ce9amr23097999ple.136.1652808945761;
        Tue, 17 May 2022 10:35:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281a7sm67978pfe.129.2022.05.17.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:35:45 -0700 (PDT)
Date:   Tue, 17 May 2022 10:35:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <202205170952.A5251F141@keescook>
References: <20220517030024.3388355-1-keescook@chromium.org>
 <202205162032.5161269A45@keescook>
 <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 17, 2022 at 01:46:54PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 08:33:25PM -0700, Kees Cook wrote:
> 
> > I just need to start today over.
> 
> :-)
> 
> Also, even with this sorted, there's a ton array bound things left.
> Please don't just mangle the code until it stops complaining like in the
> previous postings of these patches.

Yeah, other code is much simpler. The sched code has been a bit tricky
to figure out.

> As such, I'm only barely ok with the below patch. Ideally I'd shoot GCC
> in the head. Its *really* tedious you cannot just tell it to shut up
> already.

What you've got below is almost exactly what I had in my first attempt
at this (that I never posted). What I was missing and couldn't track
down were the places you used sched_class_above(). I should have sent
_that_ patch and asked where the comparisons were that I couldn't find.
I think what you've got is much cleaner, as it makes the for loop use
the normal iterator idiom.

Thank you!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
