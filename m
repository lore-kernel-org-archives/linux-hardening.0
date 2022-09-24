Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEC7C32771
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 04:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIXEZk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 00:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiIXEZi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 00:25:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3019000
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 21:25:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11so1725761pjv.4
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SryvsTQwltO56wFoDvYodwqQ1nJOEHCTIO0SJE5NltI=;
        b=ObuYdtRhhEO7gwpcaf1j2KjwMFpw8F5W/TLQdvkECdKCrvzl5XhjxOIVWCFrX9Pum/
         Ie1/G7co8F4srMEufyH74VkvfDtJCE9BD7NEc4LuOBhrmD6dRNV5H/A7IBng9Yt9p6wM
         dJpmNomGeevmMKL2gfWwYGOAY0fBJgpMugGrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SryvsTQwltO56wFoDvYodwqQ1nJOEHCTIO0SJE5NltI=;
        b=pjfBWB1N8co3kkpmBTKo6pL006fm1w+fWttDNoHYUIM4iTWc0PKB37PLegl/jE7tuS
         7NHymxeIr4IhRzX1pwjV21DJx90TJA55HhX1o5NRNyTqysAjIXjM7FR6FWLQ6Mu+U1uV
         PbteAlGsUBzdm/Gh8t+DI6bysX4hFxRprX8pLr2OJdP5Gdh2UOHBM1mhUXWoGsm7s+Hl
         qayD22Fw7lzmENSW/fEqkBBiMWzqAPWbaonUAxHhAfCzgP5lrLrOMCDjfz/imMtcFV2B
         MsW9Ihr/g+NbgEnYGJJc6JSyQ7Xi4JnROBA6y1flggnoF7HdRvyRCq2cJJYVnNK2wt9a
         54zA==
X-Gm-Message-State: ACrzQf0gT7fG6VKmXaBwivLQDSlOZYaaewxKfTtwWkjTrKRSxxBA4iVx
        DBjEQTOwWPAgQs8YK1uQMRmG6DERNI54Gg==
X-Google-Smtp-Source: AMsMyM7T9m312Yujg1sI+sfc1mrgJtRTD4FRf7qTOYqqZkubbh1ByTieKeWf7zSDNEfsqZiDd94wDg==
X-Received: by 2002:a17:90b:38cb:b0:203:100:bb53 with SMTP id nn11-20020a17090b38cb00b002030100bb53mr13412364pjb.107.1663993501436;
        Fri, 23 Sep 2022 21:25:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20-20020a630c14000000b0043ab80adf63sm6323708pgl.36.2022.09.23.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:25:00 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:24:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] string: Rewrite and add more kern-doc for the str*()
 functions
Message-ID: <202209232124.F8233E7@keescook>
References: <20220922062817.2283352-1-keescook@chromium.org>
 <d9e15a0b-0ec9-894b-b0a6-3425af2ddeff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e15a0b-0ec9-894b-b0a6-3425af2ddeff@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 24, 2022 at 11:31:16AM +0900, Akira Yokosawa wrote:
> Hi Kees,
> 
> On Wed, 21 Sep 2022 23:28:17 -0700, Kees Cook wrote:
> > While there were varying degrees of kern-doc for various str*()-family
> > functions, many needed updating and clarification, or to just be
> > entirely written. Update (and relocate) existing kern-doc and add missing
> > functions, sadly shaking my head at how many times I have written "Do
> > not use this function". Include the results in the core kernel API doc.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Follow up to https://lore.kernel.org/lkml/20220902223507.2537469-1-keescook@chromium.org
> > Note that this is on top of my recent fortify-string.h series:
> > https://lore.kernel.org/lkml/20220920192202.190793-1-keescook@chromium.org/
> I wanted to test this change, but I've not able to find a good commit
> where the fortify-string.h series and this one can be applied cleanly.
> 
> Would you mind creating a topic branch somewhere on your git tree
> and sharing it?

Sure! It's part of my devel/hardening branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/hardening

Thanks for taking a look!

-- 
Kees Cook
