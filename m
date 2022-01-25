Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162ABC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384528AbiAYNAj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574440AbiAYM6c (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 07:58:32 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B7C06173B
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 04:58:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c15so10895054qtv.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ObgW7GMZrjNyJrZnK/c5aZcQ8In8o+gHMAIQFfUL8g4=;
        b=RiFM3eGZFZYsElvhuiHpTLpK2yZKKeJZBFMRSIG+Zv7tTpJLnZ0fhW9T4iBNkUObo7
         Z5Y8qixG+H+IBjS58yWP3ZUF9GYyKIc+ToLoZCL8QpR2HZIqn3t/XUegmpCl0S917vDj
         o0I5S+20ABl940VrhDOfdUeyY828MOU/0gwitfT7X6koWRal4aXeXJtFVAx5TfeZ4Kod
         hV+9j8nt4fWM0YgwjlzK7dx/3c37lPax2IqWRajWG4nnx65hmApZZNG/jD1zcyjXH1by
         55R2JmVHkzPCpAbhBVKCN6EBlW5u0CcunF+RnkeKAWaRrXQQm57bhiktXGrCaR7PEQyo
         JO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ObgW7GMZrjNyJrZnK/c5aZcQ8In8o+gHMAIQFfUL8g4=;
        b=S9vgru4A5dL6bNIc3/ddU+Rmy7BCfOmDfANhc1UPPrpcF7hG1Cy+Nhf97BURDc2mYw
         NeDbx0j8YsXcPCRCYV21ZYBD9b20VSSX3nmge0y1Gr22kiWqyQe46nMjKidLZ+Kw0yEY
         ZwzrqPEoIFzn/3F2Ol00HVwf/9bazbuJBXr+vNTRdW9zNUrO6kbDW1ZPqI+iMPJvBTd4
         A/EixzbGwSY0sdrQcE9KwRdijXkrFMpJkGT2VMsdpjhSZ6/Xwt3jDJxERAhTSdwOvZSE
         BbQHGDSCcxiirfQLlCKEWroB5THuyGhfs7CSgbuTDL/TlcFtM8gzn1jND+zMQ4bB/CcZ
         WvXQ==
X-Gm-Message-State: AOAM531Bqen0RsRIoTHGkQ5LcUV13HeCd9tApPQu8SgOCKhN5R+ASIfC
        SPXIJBvxOZ0EjGGSRSINzL6N3A==
X-Google-Smtp-Source: ABdhPJxdt6MzvRGRy7DhU8dYiiKR5o7gqh7UlLLVITnAT4jmMjP9tlKFF7Pm770byRHYvwwTaACx8A==
X-Received: by 2002:ac8:5784:: with SMTP id v4mr15013138qta.37.1643115510217;
        Tue, 25 Jan 2022 04:58:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u37sm8961695qtc.76.2022.01.25.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 04:58:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nCLP2-004qqE-1u; Tue, 25 Jan 2022 08:58:28 -0400
Date:   Tue, 25 Jan 2022 08:58:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
Message-ID: <20220125125828.GM8034@ziepe.ca>
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
 <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
 <202201241237.C82267B66C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201241237.C82267B66C@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 24, 2022 at 01:13:20PM -0800, Kees Cook wrote:
> *thread necromancy*
> 
> On Tue, Sep 21, 2021 at 08:51:53AM +0200, Rasmus Villemoes wrote:
> > Not that I can see that the __must_check matters much for these anyway;
> > if anybody does
> > 
> >   size_mul(foo, bar);
> > 
> > that's just a statement with no side effects, so probably the compiler
> > would warn anyway, or at least nobody can then go on to do anything
> > "wrong". Unlike the check_*_overflow(), which have the (possibly
> > wrapped) result in a output-pointer and the "did it overflow" as the
> > return value, so you can do
> > 
> >   check_mul_overflow(a, b, &d);
> >   do_stuff_with(d);
> > 
> > were it not for the __must_check wrapper.
> > 
> > [Reminder: __must_check is a bit of a misnomer, the attribute is really
> > warn_unused_result, and there's no requirement that the result is part
> > of the controlling expression of an if() or while() - just passing the
> > result on directly to some other function counts as a "use", which is
> > indeed what we do with the size wrappers.]
> 
> What I'd really like is a "store this in a size_t" check to catch dumb
> storage size problems (or related overflows). In other words:

Yes, this. The overflow things are nice, but quite often we need to
get things into a size_t to use with an allocator and the rigorous
type checking in the normal overflows is a problem.

Jason
