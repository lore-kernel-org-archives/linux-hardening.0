Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7FC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Sep 2022 09:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiI2JlM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiI2JlL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Sep 2022 05:41:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E203642E4
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 02:41:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e68so977816pfe.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BHx1zCDSdTBNp89joh9T11xCS+o76HH+zzILWZ9znzM=;
        b=cspSs7H3LyUUSs9vPwD5J2NT3ZdlPiwG8IHc50VADMxkebb+9p3OuMrwi7FBjgRBeX
         VuNTP4/zfWvJ6R4UK2p9BjXml4R0tE+X+qvG7jBzyNaXkYIVKy2wpWPsBHvfHXtMtw4Y
         0Wjz+oNIijRd1Y6NUhEv5/0vYUzDo+wZ4+3Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BHx1zCDSdTBNp89joh9T11xCS+o76HH+zzILWZ9znzM=;
        b=Svg+6sVST3mBQ2IJAGqV5v6I0/myHh2VNcdNNwQVrKBkwZuIAMip7BQObNT+zgKS94
         CKQ8ZP686BUzcq1ECe5ltmJJxp7urgqs0Kac8qmPO7qeI1p/Uvg8Nh6hlSBAe+N4gVeY
         mNmBV1DBp+RdVIgoBWLNXzgxsYWxI/X0pgjePrkdgL9MjOF4D2lzGCoAyyVv+s+bcWEV
         eSp5ArI/kiYsvVSc6a3s3nbeIT6jb6q3yqedwy3nM6/b32yrE+s1A6bS4C1QBmsOzXsp
         EagRMmf38IOvWUWeWObbof81SQ+0XFYrraRh+fLeXK8U5i9EqBNIh3ZJiEoFhUEaijyK
         5oYw==
X-Gm-Message-State: ACrzQf2HYQTSxPDdj3ZwHsIdqc7chYx8/yR2dkK0EaD7aagL05N9zm+0
        GhlTa/+Z7u1+lRLAuWimoLix1g==
X-Google-Smtp-Source: AMsMyM7cG9XsS1TIYyKJGdWfGcgtAFkynXxpmmB24h4K+JChwZhLRsSjLhp3bViOpwBYNP8xmORLbQ==
X-Received: by 2002:a63:91ca:0:b0:436:64db:c902 with SMTP id l193-20020a6391ca000000b0043664dbc902mr2134275pge.87.1664444468572;
        Thu, 29 Sep 2022 02:41:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm5588429pfp.113.2022.09.29.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 02:41:07 -0700 (PDT)
Date:   Thu, 29 Sep 2022 02:41:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler_types.h: Test for __alloc_size__ again
Message-ID: <202209290240.A2C342CF30@keescook>
References: <20220929081642.1932200-1-keescook@chromium.org>
 <0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 29, 2022 at 11:14:47AM +0200, Vlastimil Babka wrote:
> On 9/29/22 10:16, Kees Cook wrote:
> > While the "alloc_size" attribute is available on all GCC versions, I
> > forgot that it gets disabled explicitly by the kernel in GCC < 9.1 due
> > to misbehaviors. Add a note to the compiler_attributes.h entry for it,
> > and restore the #ifdef in compiler_types.h.
> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/lkml/CAMuHMdXK+UN1YVZm9DenuXAM8hZRUZJwp=SXsueP7sWiVU3a9A@mail.gmail.com
> > Fixes: 63caa04ec60583b1 ("slab: Remove __malloc attribute from realloc functions")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks, I decided to late squash it so we don't needlessly cause issues for
> people doing bisections with gcc-8 later.

Sounds good to me; thanks!

-- 
Kees Cook
