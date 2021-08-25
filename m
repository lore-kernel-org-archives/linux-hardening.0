Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00DC4320E
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA557610D0
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 19:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhHYTox (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhHYTow (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 15:44:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC5C061757
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 12:44:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id i28so616294ljm.7
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hionP+S3WQHCeRsfV2U1fbeKdh6BHUGkpwhUBr6Opo=;
        b=cSO5M3pXxwAmQTu4luHD6GnYnkqg92T0OMr1XA6ueriTiYW41YJ1a4sLbAmVHerBfw
         Twvwln+3PoG5r3psuTBFR3bMMBT21KQan37TbOfPSqxaWBJwUjIK7Z6Fb/ySGvljgGZ+
         /9XpvKthjhblWn4cPz+TQGVoKb2//adm+EAHu702s3rePIN1d1gJtOMnHQXVRmj/jzQG
         F4Tm4Jc5nKZp+chGDsdDfI5M3twgwM5WfuqdOAGx+jF1TXsZp93DfdgRlck4ywgtDCPo
         nUMs9u6uiZnEnhVVFlQqRNnkcq+Y+UwuKC5Dbp33Me8D35Xw5mlK9Jk9Q2qJjkBhS0db
         2NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hionP+S3WQHCeRsfV2U1fbeKdh6BHUGkpwhUBr6Opo=;
        b=GbT/u47f1p/M0mh9eq0tnqn6EUgGwoV/rWfSdkPZyImZWaW+3kBSF8QoaHO0+XGC0s
         U1lAmgI8VIGrycrshBYoHGHR7PmqvzkW6Cj/SHjjG5Yi5zPjaOjObbaGZ6w+xViKY7lu
         61XtB7W0YmP/ZleAmOES6dmFGCegDIz8AE/523kDlWoHOPt0ReVvzQwkRFirna9cW+Zj
         qheozGqdcM7I2eToF8EBQB707GMiE5IhKOPnetTQybtkZ0XTSjoZ5lu7mD6KOVgbMHiq
         zM8cUuXUEDhqZqhy3GZM7WvvJ/duc5x8mEQRsKndB9TQ2uiCk8QlwC02JygqNj+4K0WK
         CsBw==
X-Gm-Message-State: AOAM533DOwh4IuR+2mINFCzXe45JTD6tqPiyTnLw7uxy38y+UjmAnVJd
        sQ5mmPBEpzKc1qnsMs8UEXXkTgynvXTGZM3Y7gcl6w==
X-Google-Smtp-Source: ABdhPJyZ7uDwfp8fuaRxMK0BR+wxPpEoAE9f9CfLQXt1nMlh04/ioOFiOdQlutGtK4GqkF0S0R4UriHTlLmeZsPRp1A=
X-Received: by 2002:a2e:a367:: with SMTP id i7mr268052ljn.244.1629920644666;
 Wed, 25 Aug 2021 12:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-14-keescook@chromium.org> <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
In-Reply-To: <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 12:43:53 -0700
Message-ID: <CAKwvOdnd_e7K9Ayn+4pMgWzbu7W8U5dWiSVa9AEKs99m+q7K+g@mail.gmail.com>
Subject: Re: [PATCH for-next 13/25] compiler_types.h: Remove __compiletime_object_size()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 11:43 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 22/08/2021 09.51, Kees Cook wrote:
>
> > -     int sz = __compiletime_object_size(addr);
> > +     int sz = __builtin_object_size(addr, 0);
>
> Not directly related to this patch, but seeing this I wonder if there
> would be some value in introducing names for those magic 0/1/2/3 that
> are used with __b_o_s. Every time I stumble on code using that I have to
> go to the gcc docs, and even then it takes me a while to grok what
>
>      TYPE is an integer constant from 0 to 3.  If the least significant
>      bit is clear, objects are whole variables, if it is set, a closest
>      surrounding subobject is considered the object a pointer points to.
>      The second bit determines if maximum or minimum of remaining bytes
>      is computed.
>
> means. The names don't need to be too verbose, just having a few
> #defines in-tree with the above quoted above them makes it a lot easier
> to figure out what they mean.

We share a similar experience.
-- 
Thanks,
~Nick Desaulniers
