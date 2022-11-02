Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B8AC4332F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKBRSX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiKBRSV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Nov 2022 13:18:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864E1C41A
        for <linux-hardening@vger.kernel.org>; Wed,  2 Nov 2022 10:18:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b9so10926762ljr.5
        for <linux-hardening@vger.kernel.org>; Wed, 02 Nov 2022 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RknuEqUoiunPXi2OLjUbhlEwq60lRe2RTsR6hdfQJ0Y=;
        b=RRnZ2dze/6CLhyKFhxGEw08Ckp4XwE8DWxZ0rZxAOcMdf5vdt9kUpYu0i/LLqPGehj
         pYwLBE+/5Qto0rQ3PGtpUP8z7cfs5Z97tOSErjIiA7F6Gr0KhuXI0VS03iRzDSRFYUNa
         ZtYLM10ihngzyi4eQW3AMFVgmfH2JF5B4VVzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RknuEqUoiunPXi2OLjUbhlEwq60lRe2RTsR6hdfQJ0Y=;
        b=6P9wBjCmRUYBZjjOmLiF3W6SO3T+uI4++9qUhatkvxUuiEexKj7uc2RraBc2s1JP16
         UtERNVnCJ3FVpdgqUpgIS2/rMp8pp66IKmfWRzE07VfUj0tOh6Bh/7W70QMgQ38qkRNL
         EV1CiRYlVVdfkjGGOdmSqVz9bZ83rtxN5TZXxJ8oiwWBq+Xi674F6wy7Y/GROYO5nmpS
         xT8fJU5sK9huv15EG2+LYdV5k90gatNT8lBr6nDBSWlLPLjMYUzIhS3x5mTYywVJVrFN
         JFbXwbjvkZsPTr/qNf+MXFzmpVG1Gr2qoDmvPunC0yrTs7nUVE/1QS+XGYQ5v4O/ROHn
         okww==
X-Gm-Message-State: ACrzQf1Z92mMn6wZ8yY3j1hcgnQqOXpQ4Qpu/opstRC89fzzT3YqSMra
        vKxb57F3KBvkpKpR+knvJfDaH+e2SAqVwmKiSf3Kvg==
X-Google-Smtp-Source: AMsMyM7GIYG7A4ghgZ0+aS8SyddPotFMK2d1/uL5kMGl7GKycv3x9BCqeqPj62YF1UHA3B/H7CEDTV/OSueDj54yRvU=
X-Received: by 2002:a05:651c:19a8:b0:277:3cb2:d9f9 with SMTP id
 bx40-20020a05651c19a800b002773cb2d9f9mr9918004ljb.278.1667409498411; Wed, 02
 Nov 2022 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com> <202208081018.9C782F184C@keescook>
 <CABi2SkVXMUVhSTJezfHt_BKxyKP+x++9oveuB3qJZL7N672UKw@mail.gmail.com> <202211011933.DD0979338@keescook>
In-Reply-To: <202211011933.DD0979338@keescook>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Nov 2022 10:18:07 -0700
Message-ID: <CABi2SkWGo9Jrd=i1e2PoDWYGenGhR=pG=yGsQP5VLmizTmg-iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@google.com, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        dev@opencontainers.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 1, 2022 at 7:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 01, 2022 at 04:14:39PM -0700, Jeff Xu wrote:
> > Sorry for the long overdue reply.
>
> No worries! I am a fan of thread necromancy. :)
>
> > [...]
> > 1> memfd_create:
> > Add two flags:
> > #define MFD_EXEC                      0x0008
> > #define MFD_NOEXEC_SEAL    0x0010
> > This lets application to set executable bit explicitly.
> > (If application set both, it will be rejected)
>
> So no MFD_NOEXEC without seal? (I'm fine with that.)
>
no MFD_NOEXEC because memfd can be chmod to add x after creation,
it is not secure.

no MFD_EXEC_SEAL because it is better to apply both w and x seal
within the same function call, and w seal can't be applied at creation time.

> > 2> For old application that doesn't set executable bit:
> > Add a pid name-spaced sysctl.kernel.pid_mfd_noexec, with:
>
> bikeshed: vm.memfd_noexec
> (doesn't belong in "kernel", and seems better suited to "vm" than "fs")
>
SG, will use vm.memfd_noexec

> > value = 0: Default_EXEC
> >      Honor MFD_EXEC and MFD_NOEXEC_SEAL
> >      When none is set, will fall back to original behavior (EXEC)
>
> Yeah. Rephrasing for myself to understand more clearly:
>
> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like MFD_EXEC
> was set."
>
> > value = 1: Default_NOEXEC_SEAL
> >       Honor MFD_EXEC and MFD_NOEXEC_SEAL
> >       When none is set, will default to MFD_NOEXEC_SEAL
>
> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like
> MFD_NOEXEC_SEAL was set."
>
Copy, this is clearer. Thanks.

> Also, I think there should be a pr_warn_ratelimited() when
> memfd_create() is used without either bit, so that there is some
> pressure to please adjust their API calls to explicitly set a bit.
>
Sure

> > 3> Add a pid name-spaced sysctl kernel.pid_mfd_noexec_enforced: with:
> > value = 0: default, not enforced.
> > value = 1: enforce NOEXEC_SEAL (overwrite everything)
>
> How about making this just mode "value 2" for the first sysctl?
> "memfd_create() without MFD_NOEXEC_SEAL will be rejected."
>
Good point. Kernel overwriting  might not be a good practice.
I will add to vm.mfd_noexec.
value = 2: "memfd_create() without MFD_NOEXEC_SEAL will be rejected."

Thanks!
Jeff

> -Kees
>
> --
> Kees Cook
