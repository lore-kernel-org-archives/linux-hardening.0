Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2385C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 23:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbiEKXZR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 May 2022 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349244AbiEKXZO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 May 2022 19:25:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1916209569
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 16:25:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 31so3055113pgp.8
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ki49xHqa46J2jAs7ta/eJtZ8QS3SBu8XEWl7+OO2No=;
        b=FhScX8YR/t+vuAsu1redHAA4dDPOcMsoT3Bq+dzybnZ3agrhS1LJ82u+gJrbLnbC8A
         hrKKxi5iv3ybGmAYitDOps4nXz87M944fN4oMkhk1uFkNFlc6EYWAzxfJfrLwTCTuLes
         4rZNEMAUENDzVKr1twRJ/olrDDqwPfrLj0+3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ki49xHqa46J2jAs7ta/eJtZ8QS3SBu8XEWl7+OO2No=;
        b=REksSDFZyIcKJg3O0RVh9PrFsgQeKaOI7bs2rfcbGEEYDTtrV9BMa7Chu+kmmPZBQD
         v3FLO51kxfx5G5k5Y8Pobemf+te485s4RQMEaajFG9YGKRwaxRYNb5bYDerlxk+8630r
         DNJ+Scsz7qFuGG/KSNLvR7wsPnA51IDdGwsfaQgwp9GwetTr7XZlboaXZgd6ArdjhQRK
         VdJXQGTmzoKqVGJjnP5VBfsjpS5ZCiHct4g5kgIaxbgBSFZ5mBQnTKq2sbXf5mvp40sA
         NGi3VmEolg6koKRnhYzRWyUguN4q2VBErXoottsHMn0dH2tAEfuuyfo1i/ih8AEyfQeQ
         dOYA==
X-Gm-Message-State: AOAM533kKIGBHKqouefqwcIUQKNrkBM7UZgDkMyBl2ziFarzT3joq5D0
        nY5T860FddXMRcnf9Su1MxbmBA==
X-Google-Smtp-Source: ABdhPJzMcvdao9wgCqtHsLuaqbFD5VrRt/A5zEaBjVmcMJGr1jzZWaoQvr9OGs1D6j+yLudNM/YImA==
X-Received: by 2002:a63:d408:0:b0:3c6:e382:c157 with SMTP id a8-20020a63d408000000b003c6e382c157mr10022534pgh.470.1652311512304;
        Wed, 11 May 2022 16:25:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11-20020a63370b000000b003c14af5061esm407098pga.54.2022.05.11.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:25:11 -0700 (PDT)
Date:   Wed, 11 May 2022 16:25:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Du Cheng <ducheng2@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] niu: Silence randstruct warnings
Message-ID: <202205111624.60295F3A2@keescook>
References: <20220510205729.3574400-1-keescook@chromium.org>
 <20220511151647.7290adbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511151647.7290adbe@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 11, 2022 at 03:16:47PM -0700, Jakub Kicinski wrote:
> On Tue, 10 May 2022 13:57:29 -0700 Kees Cook wrote:
> > Clang randstruct gets upset when it sees struct addresspace (which is
> > randomized) being assigned to a struct page (which is not randomized):
> > 
> > drivers/net/ethernet/sun/niu.c:3385:12: error: casting from randomized structure pointer type 'struct address_space *' to 'struct page *'
> >                         *link = (struct page *) page->mapping;
> >                                 ^
> > 
> > It looks like niu.c is looking for an in-line place to chain its allocated
> > pages together and is overloading the "mapping" member, as it is unused.
> > This is very non-standard, and is expected to be cleaned up in the
> > future[1], but there is no "correct" way to handle it today.
> > 
> > No meaningful machine code changes result after this change, and source
> > readability is improved.
> > 
> > Drop the randstruct exception now that there is no "confusing" cross-type
> > assignment.
> > 
> > [1] https://lore.kernel.org/lkml/YnqgjVoMDu5v9PNG@casper.infradead.org/
> > 
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I presume you prefer to take this one via your tree too, so:

Yeah, that's easiest for the exception removals.

> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

-- 
Kees Cook
