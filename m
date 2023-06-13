Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E65EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFMTmW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFMTmR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:42:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC910F7
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:42:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3afd2f9bdso22038665ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686685335; x=1689277335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxEcj49+vGwYkRgl1icr+yGC9c7gL0eXEsyVyEAa72I=;
        b=QDF6XybuuSbESC6lsMPSOgkZPqsKAZRVX6eAzuQeJFFgsCxewr0dbZQsAQcrNv/Jt/
         cUwNgWA3FaBmym/Q0URJfdCq/RYEH3el9I+AIsJg4wNI/j3dqAL883+nv6ycCEqwu8Is
         szTUB9KYgk+4+OrfO9cFjQmr2dHKH1dCCXOEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685335; x=1689277335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxEcj49+vGwYkRgl1icr+yGC9c7gL0eXEsyVyEAa72I=;
        b=cRbyOzQc0cNOWlHUkAcKb75FIUl3eW4rZA9VX9Uv4zDsHLkxQ8bnAk8q97eaTptRn0
         UkSA1MAaS5ldsiBf2OUm/N3YO8zvkizpaE7jtp/dmGY9X+78J75bRI3hIj88qOLD/nBt
         Q2EMW8WaBs8pP4/NbY4JDNDsmn94R6yvBwtZjaKkWVWbIFsTOQD6cs55WdOOkSRLgAZw
         26XVWz/yAFnLcL04PMwevBb7Ss97KVeoFg85NxymBeDUI4gGIUs6zqe+xmC0f8TCeN/b
         AdZhexn0nvng2rMFDlY5b6QB3krP8I29DCaxPLIw3/WKcetD8hf5nO4SYjNNVTkamyDW
         le/w==
X-Gm-Message-State: AC+VfDyn+/uQK6CR0nCYDneq/AWdClrhpnN4Lwd4oLTYSFqM945mWx/M
        56/f9OfpytkKWDYjaQJrKKFap529G0vgw6tYApE=
X-Google-Smtp-Source: ACHHUZ4ASqDKrvZKerhnxXxdgCYThmTm+1P/kHDzqnN8JNmhcPCltk7Mdv4E+dofJzdv0DLD1v2ZjQ==
X-Received: by 2002:a17:902:e88f:b0:1b3:ebda:6563 with SMTP id w15-20020a170902e88f00b001b3ebda6563mr2783752plg.53.1686685334830;
        Tue, 13 Jun 2023 12:42:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001b3c48d01d0sm3902plz.65.2023.06.13.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:42:14 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:42:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Replace strlcpy with strscpy
Message-ID: <202306131238.92CBED5@keescook>
References: <20230613004054.3539554-1-azeemshaikh38@gmail.com>
 <01E2FCED-7EB6-4D06-8BB0-FB0D141B546E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01E2FCED-7EB6-4D06-8BB0-FB0D141B546E@oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 02:18:06PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 12, 2023, at 8:40 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> > 
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> 
> Using sprintf() seems cleaner to me: it would get rid of
> the undocumented naked integer. Would that work for you?

This is changing the "get" routine for reporting module parameters out
of /sys. I think the right choice here is sysfs_emit(), as it performs
the size tracking correctly. (Even the "default" sprintf() call should
be replaced too, IMO.)

> 
> 
> > Direct replacement is safe here since the getter in kernel_params_ops
> > handles -errorno return [3].
> 
> s/errorno/errno/
> 
> 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> > [3] https://elixir.bootlin.com/linux/v6.4-rc6/source/include/linux/moduleparam.h#L52
> > 
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> > net/sunrpc/svc.c |    8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index e6d4cec61e47..e5f379c4fdb3 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -109,13 +109,13 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
> > switch (*ip)
> > {
> > case SVC_POOL_AUTO:
> > - return strlcpy(buf, "auto\n", 20);
> > + return strscpy(buf, "auto\n", 20);

e.g.
	return sysfs_emit(buf, "auto\n");
...

> > case SVC_POOL_GLOBAL:
> > - return strlcpy(buf, "global\n", 20);
> > + return strscpy(buf, "global\n", 20);
> > case SVC_POOL_PERCPU:
> > - return strlcpy(buf, "percpu\n", 20);
> > + return strscpy(buf, "percpu\n", 20);
> > case SVC_POOL_PERNODE:
> > - return strlcpy(buf, "pernode\n", 20);
> > + return strscpy(buf, "pernode\n", 20);
> > default:
> > return sprintf(buf, "%d\n", *ip);

and:

	return sysfs_emit(buf, "%d\n", *ip);


-Kees

-- 
Kees Cook
