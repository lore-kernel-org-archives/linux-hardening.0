Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B6C4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BA960F91
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 15:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhG1PNp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhG1PNn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jul 2021 11:13:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79407C061764
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jul 2021 08:13:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x7so3480574ljn.10
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jul 2021 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iH7MSHpYkHvJt7wqynx3N1nt28MSGKLy81RVHV/rOTQ=;
        b=llOIVjkPDOZVDBnCosKuNvsEwkGlWS1duCcU81fec5dLbyZ+vz3cfmKDjR9lQtzwSG
         A0ymlnFmm9551mLAmo5Whqh/m6dBueJazpXw/bGY1fiIosrvEj2QAAxL5QpxTKUYSIlS
         HX7IoGgIHHYboHkDAS9HOUX4BCbesRw74+gJuKvZbUZDwK/3KZfYK8/gLLT3rSpiKBJM
         9LN5HJL/IwS1rnrcnZ738sljO+6aSoih7gJROXbEZhfMWE/uLDXzLMAF6fnB4//FdKtX
         SjS5Hd0psszALArFmdQekmeSjC+2D82Tytzk4WzeKsRxLO6AeVG/ev1ccO2iv4SqMl7a
         iXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH7MSHpYkHvJt7wqynx3N1nt28MSGKLy81RVHV/rOTQ=;
        b=ImTYAL8Xa7gCnuJNwcrij0zFvvVfHi4dF1M6hcDQPNtXXfZ/Pr6/7TaudAnluz3KYD
         Jl8sVLTlHw2ERIZpCqKbPMAdVRu7i9yJB6TBokVnMh7Yg/ToZn+BH5prQGijOgAeXAkc
         phDjeBnF976MCk4I/vL2mMW0iXEJqcxYw6NeRBCz85692ZFsBWj3TxyIAanGuz3QsRtJ
         up4Xc2dVEUXhw4BdskRvof7QNTZPAyVZnjuitVSWhOPD8rWzUEUwWRrnY5qOR4CveFQw
         9ZZdMjjd19i44sJyx3Hg13Qydtq243rVeOij3ZYqFQgi+T55/Mh1+7N+QTNp5WvSBRrd
         MSHg==
X-Gm-Message-State: AOAM533QHuXW1g7QyPjobAUSLE8gpaCv/p1OwG2hd5RY1MaHb7M8QQed
        voc1Y3vT8Z/FspdEetP0UIqT6iLVpS3wX9j4AtV43w==
X-Google-Smtp-Source: ABdhPJzeiZ+1TgzPSirdloqJjM8mUbNaOn+fNJgtn233eJ55reHRi5N7Rx6u/RLgqpRP2CibU35ecP2NVyDLu+yjOlU=
X-Received: by 2002:a05:651c:218:: with SMTP id y24mr221427ljn.448.1627485219260;
 Wed, 28 Jul 2021 08:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210715055923.43126-1-xiyou.wangcong@gmail.com> <202107230000.B52B102@keescook>
In-Reply-To: <202107230000.B52B102@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Jul 2021 17:13:12 +0200
Message-ID: <CAG48ez0b-t_kJXVeFixYMoqRa-g1VRPUhFVknttiBYnf-cjTyg@mail.gmail.com>
Subject: tracepoints and %p [was: Re: [Patch net-next resend v2] net: use %px
 to print skb address in trace_netif_receive_skb]
To:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Qitao Xu <qitao.xu@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

+tracing maintainers

On Fri, Jul 23, 2021 at 9:09 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 14, 2021 at 10:59:23PM -0700, Cong Wang wrote:
> > From: Qitao Xu <qitao.xu@bytedance.com>
> >
> > The print format of skb adress in tracepoint class net_dev_template
> > is changed to %px from %p, because we want to use skb address
> > as a quick way to identify a packet.
>
> No; %p was already hashed to uniquely identify unique addresses. This
> is needlessly exposing kernel addresses with no change in utility. See
> [1] for full details on when %px is justified (almost never).
>
> > Note, trace ring buffer is only accessible to privileged users,
> > it is safe to use a real kernel address here.
>
> That's not accurate either; there is a difference between uid 0 and
> kernel mode privilege levels.
>
> Please revert these:
>
>         851f36e40962408309ad2665bf0056c19a97881c
>         65875073eddd24d7b3968c1501ef29277398dc7b
>
> And adjust this to replace %px with %p:
>
>         70713dddf3d25a02d1952f8c5d2688c986d2f2fb
>
> Thanks!
>
> -Kees

Hi Kees,

as far as I understand, the printf format strings for tracepoints
don't matter for exposing what data is exposed to userspace - the raw
data, not the formatted data, is stored in the ring buffer that
userspace can access via e.g. trace_pipe_raw (see
https://www.kernel.org/doc/Documentation/trace/ftrace.txt), and the
data can then be formatted **by userspace tooling** (e.g.
libtraceevent). As far as I understand, the stuff that root can read
via debugfs is the data stored by TP_fast_assign() (although root
_can_ also let the kernel do the printing and read it in text form).
Maybe Steven Rostedt can help with whether that's true and provide
more detail on this.

In my view, the ftrace subsystem, just like the BPF subsystem, is
root-only debug tracing infrastructure that can and should log
detailed information about kernel internals, no matter whether that
information might be helpful to attackers, because if an attacker is
sufficiently privileged to access this level of debug information,
that's beyond the point where it makes sense to worry about exposing
kernel pointers. But even if you disagree, I don't think that ftrace
format strings are relevant here.




> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier
>
> >
> > Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> > Signed-off-by: Qitao Xu <qitao.xu@bytedance.com>
> > ---
> >  include/trace/events/net.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > index 2399073c3afc..78c448c6ab4c 100644
> > --- a/include/trace/events/net.h
> > +++ b/include/trace/events/net.h
> > @@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
> >               __assign_str(name, skb->dev->name);
> >       ),
> >
> > -     TP_printk("dev=%s skbaddr=%p len=%u",
> > +     TP_printk("dev=%s skbaddr=%px len=%u",
> >               __get_str(name), __entry->skbaddr, __entry->len)
> >  )
> >
> > --
> > 2.27.0
> >
>
> --
> Kees Cook
