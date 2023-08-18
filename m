Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E909EE4982
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 17:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379081AbjHRRe0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379098AbjHRRd7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 13:33:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C34210
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 10:33:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-688769faa09so1000174b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692380038; x=1692984838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8VxOYqY0vk5zLSdtNkelkzBoODifEK09GEUE59Uh/E=;
        b=kMub35CoX+FGqGlEXa/v7SPizCC+sQH0jMFem1D1JeANqS37tH6/y0XZCXnC/aH+U5
         kJBVdMWwYkMTpF1pLdKjiX4dO1zZg9PmnllgKhcQ8/j6A+6lsAOGm7snFIH2dL+oBYJF
         zdkydtJWoioVltE5GW9w6lD0ChboN8PRmcDbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380038; x=1692984838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8VxOYqY0vk5zLSdtNkelkzBoODifEK09GEUE59Uh/E=;
        b=Uwxnyf/s7yn2EPzA9OdRJaTSouiK7vDl+n6GVVEQshrgx6aH7riY3Wcx0uXKO4zz9l
         bmZVqpSv/vH27VmfL6k+dqYewVYnEwLqv1DsaFjkR6hXy1SOh6EGeCiklp/uMWOm/ma5
         Npb1uYRmf0/aopJr6joJxqOF0H9U6bbN4Ht31bKZYBRnTBa6mxTNzblvHuKDk87Px2CV
         OGALtWDWqb9jCNrxoHHEZoY3DhrZchpOx8ei4rxvOl07hwCgXK283BF8WD+2zPTl8sWV
         xesqbGLc4/gTJr/KmbJ7M+Tbsr7tCOg/hOKdVs/V5LLyjmxeCgUJJJEEYs7ZBXzAZ/12
         ezzg==
X-Gm-Message-State: AOJu0YwTdmuaTfNxgkWElvZKW9GJp3xT2YFGutTFh9ZA9rdxkMQ/89Th
        EMcxv4C8ThZC+w8BzMOvWq4pLA==
X-Google-Smtp-Source: AGHT+IEIW5Yl9r6Sj3v9imMpgLBJxv4XcEqIkrMkv167YzQxcg7Et1cOrpJxjwCXnMm+AR6HQRKkrA==
X-Received: by 2002:a05:6a00:1249:b0:689:f693:917f with SMTP id u9-20020a056a00124900b00689f693917fmr3136404pfi.28.1692380037809;
        Fri, 18 Aug 2023 10:33:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff18-20020a056a002f5200b0068703879d3esm1794159pfb.113.2023.08.18.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:33:57 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:33:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selinux: Annotate struct sidtab_str_cache with
 __counted_by
Message-ID: <202308181033.03592D6E2D@keescook>
References: <20230817202210.never.014-kees@kernel.org>
 <CAHC9VhR-vxsaR7deTQ+zzVP9W2uSupz4ucf8p+tt0e730qbZ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR-vxsaR7deTQ+zzVP9W2uSupz4ucf8p+tt0e730qbZ1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 12:25:12PM -0400, Paul Moore wrote:
> On Thu, Aug 17, 2023 at 4:22 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct sidtab_str_cache.
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > Cc: selinux@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  security/selinux/ss/sidtab.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This also looks good to me, but similarly to the audit patch, since we
> are at -rc6 I'm going to wait to merge this until after the merge
> window.  I'll send a follow up email once it's merged.

Thanks! Yeah, there's no rush. :)

-- 
Kees Cook
