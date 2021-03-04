Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF147C433E6
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C368A64FF9
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhCDXhg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhCDXhg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 18:37:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FEC061756
        for <linux-hardening@vger.kernel.org>; Thu,  4 Mar 2021 15:37:34 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t9so187365ljt.8
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgwulWHwm1MDs+ICpQBPD7tM8b4zQh4kzB1wSHVNQH8=;
        b=NmW9oG/5sfp7MEL33QTzTJ0jjyxr8w5jl1+3me8QO/Y8lp3Iq3E1E8vUoObTXScAaK
         HwU6zyO+CH+u7r4c9Q2T37+GP4KtyYQ50FAtKVcIjR7CvPRKnIwyeBzpJAPc5dJP609f
         vs9+ekKihDooog4vC9rIvjW+LwOLRLUJMBMaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgwulWHwm1MDs+ICpQBPD7tM8b4zQh4kzB1wSHVNQH8=;
        b=GSkA5r6o2yc1g66RH1ORwPQX83sSv9yQ43495NYruBw6aqZSw7nZjUco4O71I7KyZG
         Wp/RvAE3tg9yXbLghqjjh7RMvzttB8ithe8r6IFvpVIHCTVZjedjceFN6f0Etz+9ULmS
         Vqj/pV9vLLwTszix0BPtM7RECTnmO33Ghp5w58bRW4ZMRlIFi36WlM7ngsgrNtR6EszA
         Cw+f682clMD/+F8L1BPpYqMVkRD03wORTP3cHSttRKWkwNpxMKMwfrhzFu/QBJafZEQw
         rBZMlkeIEMZAeaD91i1lSUMqOrZLOVGSrNLU6WuT9ryqHZaH5jvwTN3hIiOiaA7nfNMJ
         H/TA==
X-Gm-Message-State: AOAM531BxgAcdPAADvTG8kQtexPKL2GSdQxSYmdidQK968QhfamxqjCX
        2z4huFnhoBNIgqKH3sZiega7gEpeJWmejg==
X-Google-Smtp-Source: ABdhPJxDPqdNDeM21ICbBMofMK5Cpuy8f69Z2ijONJoSCItB/jnJklEl3ySK14CaejCh1RSsD77Y1g==
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr3735812ljn.358.1614901052229;
        Thu, 04 Mar 2021 15:37:32 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j2sm88269lfe.134.2021.03.04.15.37.30
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 15:37:31 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id p15so159432ljc.13
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 15:37:30 -0800 (PST)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr3468202ljj.465.1614901050597;
 Thu, 04 Mar 2021 15:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20210304113708.215121-1-masahiroy@kernel.org> <202103041518.22EB819E@keescook>
In-Reply-To: <202103041518.22EB819E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 15:37:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
Message-ID: <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 4, 2021 at 3:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> This seems fine to me, but I want to make sure Josh has somewhere to
> actually go with this. Josh, does this get you any closer? It sounds
> like the plugins need to move to another location for packaged kernels?

Well, it might be worth extending the stuff that gets installed with
/lib/modules/<kernel-version>/ with enough information and
infrastruvcture to then build any external modules.

Yeah, yeah, there's the /boot/config-<kernelversion> thing too, but
honestly, that probably shouldn't have been in /boot to begin with.
That, and the plugins - and possibly any hashes needed for randstruct
etc - might be good to squirrell away in a
/lib/modules/<kernelversion>/build/ subdirectory?

I dunno. I obviously don't build external modules to begin with, much
less with distro kernels...

             Linus
