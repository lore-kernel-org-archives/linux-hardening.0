Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026CC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 00:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKRAZd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKRAZc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 19:25:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF26BDE4
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:25:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so3363553pfu.8
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W25mprsVAGFYx1b8fr8tlqYACFsmAXWC018XR5v0SyQ=;
        b=XgVP9ahbj6EU5vSIAnUUS1ZmD8OtEcB/doWcaMRGDvy0kCsATAovnYDAFIryGlxpSh
         BjxXnEkc4++35Ihn95RQ6EMsvQgfMvwIZWxKDq5QOlnuP3LN9W/41z+o1A/qrq6ygJzS
         9D1QCl/mw4vifIZw8zDQnA+7imicunjdy+ddo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W25mprsVAGFYx1b8fr8tlqYACFsmAXWC018XR5v0SyQ=;
        b=iHZ/VQ61Cpoenf1oFe2eEzYeodamBgwKnFebaN13BNMMPQexsAIMWkZRBBuwzFOu23
         k2WRKzOL3CSM//iSTa774qUoOe0P0JBiFGb2qUkzUdQhCR1x95Co1G4sVtXaQ6H5KP2d
         OM10PWOPZwMwxAuY3fF0n77L3DJcTUjtZ/XeC607xjahPiHJqjf7e6ry0NNNpKXyolZx
         GMwM6KShAzkbGNn83ELVvh0LOWvncM94WxcLNX0OJYwWykJZX5I46zzHkGVg5Wq/jmjf
         dE6sM7oTZPWO2fwP2OapDTQ6jfWC/bjEoct8bkCe5sKeQf3k4+mO6KncSp0KsrHKz28y
         90gA==
X-Gm-Message-State: ANoB5plXW0tkdbbBzyRWk2TpK5E+XF10aaJOKxntJWRaG4mk7KnBrO6n
        zYtbcqr/YMSDfqBcFne+9yEL0Q==
X-Google-Smtp-Source: AA0mqf4ob29gEgyEODGGWMVDgi7AUFesJo4C/tw8/C3dixpP4x6E/ENTXYQIKisRNKdSrfPXyIj5OA==
X-Received: by 2002:a63:b54:0:b0:434:911a:301 with SMTP id a20-20020a630b54000000b00434911a0301mr4569707pgl.50.1668731130811;
        Thu, 17 Nov 2022 16:25:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mt15-20020a17090b230f00b00212d9a06edcsm870576pjb.42.2022.11.17.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:25:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:25:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __sock_gen_cookie(): Error handling issues
Message-ID: <202211171624.963F44FCE@keescook>
References: <202211171422.7A7A7A9@keescook>
 <CANn89iLQcLNX+x_gJCMy5kD5GW3Xg8U4s0VGHtSuN8iegmhjxQ@mail.gmail.com>
 <202211171513.28D070E@keescook>
 <CANn89iKgMvhLbTi=SHn41R--rBQ8As=E52Hnecch6nOhXVYGrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKgMvhLbTi=SHn41R--rBQ8As=E52Hnecch6nOhXVYGrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 17, 2022 at 03:22:22PM -0800, Eric Dumazet wrote:
> On Thu, Nov 17, 2022 at 3:14 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 17, 2022 at 02:49:55PM -0800, Eric Dumazet wrote:
> > > On Thu, Nov 17, 2022 at 2:22 PM coverity-bot <keescook@chromium.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > This is an experimental semi-automated report about issues detected by
> > > > Coverity from a scan of next-20221117 as part of the linux-next scan project:
> > > > https://scan.coverity.com/projects/linux-next-weekly-scan
> > > >
> > > > You're getting this email because you were associated with the identified
> > > > lines of code (noted below) that were touched by commits:
> > > >
> > > >   Wed Nov 16 12:42:01 2022 +0000
> > > >     4ebf802cf1c6 ("net: __sock_gen_cookie() cleanup")
> > > >
> > > > Coverity reported the following:
> > > >
> > > > *** CID 1527347:  Error handling issues  (CHECKED_RETURN)
> > > > net/core/sock_diag.c:33 in __sock_gen_cookie()
> > > > 27     {
> > > > 28      u64 res = atomic64_read(&sk->sk_cookie);
> > > > 29
> > > > 30      if (!res) {
> > > > 31              u64 new = gen_cookie_next(&sock_cookie);
> > > > 32
> > > > vvv     CID 1527347:  Error handling issues  (CHECKED_RETURN)
> > > > vvv     Calling "atomic64_try_cmpxchg" without checking return value (as is done elsewhere 8 out of 9 times).
> > > > 33              atomic64_try_cmpxchg(&sk->sk_cookie, &res, new);
> > >
> > >
> > > Hmmm. for some reason I thought @res was always updated...
> > >
> > > A fix would be to read sk->sk_cookie, but I guess your tool will still
> > > complain we do not care
> > > of  atomic64_try_cmpxchg() return value ?
> > >
> > > diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
> > > index b11593cae5a09b15a10d6ba35bccc22263cb8fc8..58efb9c1c8dd4f8e5a3009a0176e1b96487daaff
> > > 100644
> > > --- a/net/core/sock_diag.c
> > > +++ b/net/core/sock_diag.c
> > > @@ -31,6 +31,10 @@ u64 __sock_gen_cookie(struct sock *sk)
> > >                 u64 new = gen_cookie_next(&sock_cookie);
> > >
> > >                 atomic64_try_cmpxchg(&sk->sk_cookie, &res, new);
> > > +               /* Another cpu/thread might have won the race,
> > > +                * reload the final value.
> > > +                */
> > > +               res = atomic64_read(&sk->sk_cookie);
> > >         }
> > >         return res;
> > >  }
> >
> > I think it's saying it was expecting an update loop -- i.e. to make sure
> > the value actually got swapped (the "try" part...)?
> 
> The value has been updated, either by us or someone else.
> 
> We do not particularly care who won the race, since the value is
> updated once only.

Ah! Okay, now I understand the added comment. Thanks :)

-- 
Kees Cook
