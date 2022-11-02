Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9680C43217
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 02:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBCpq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKBCpp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 22:45:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB220F6F
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 19:45:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2673942pjn.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 19:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3z7CAwRrbhiy3Fh87yqUT0bKa1tvVxCGpJDy2Nva08=;
        b=D9k+K8+zb1Hw1FZdM5Q4KowBW3VDqCAe+J9yQLJGJEIxDte78hlq5eeQNbWl0nT1qs
         Rg4pv+E29J1DJzwg/nZuydW0KGgko2YCgDP2MvNEYH+d//aYbE7X9FNY9PA50QfYZZzk
         VS1TtxLpZhLHALz8nbknl1NTioYIqTJ4/Gq6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3z7CAwRrbhiy3Fh87yqUT0bKa1tvVxCGpJDy2Nva08=;
        b=1Hfu/R+mG4i90ptkly2c+KeGO8gYQfpNCCcqb5UakxzOM78NiSJoZNGFBwPLeo3BEj
         CrSeABfdVsmqnzeQF5WPrmBYJrUFDRs/umcmnAtQP88GeuLEObeDCRD7aZy1U1Oyl01D
         jjS21xeK4k4TL/NC00ZdsQqY6uPoNKZdYTQrmjg2H21FDL1bTfYWGZCrqXwX9DTzKmD0
         xSQkjPNL4RWCcSnsLnn+VA1MODJOcsql/iMIU3FgsHh+6VCZV5mAKDtA/Bc9XNBb3t47
         pPFYh8BCHs5nOmS2QriLdkZN3oIa1+tbRvvKAc3Wm+bLlp+0ephTLZEUICDjvNtnpr70
         kpgw==
X-Gm-Message-State: ACrzQf23FPZZJn2sMlyUxTM/9osLXGxNsPci7iFDPrsHT6m0sZFgClT0
        aazoPaXnxDxOaMD+sN1snzoiNw==
X-Google-Smtp-Source: AMsMyM4ChAOWz5lSp4choDZEK9kgzF2daJaX4Pp4EqxUxMKFLQ8UVWsyw490lLgFVqRXKtCwd4d8gw==
X-Received: by 2002:a17:90b:4c12:b0:213:d3e3:ba4c with SMTP id na18-20020a17090b4c1200b00213d3e3ba4cmr15519784pjb.22.1667357144287;
        Tue, 01 Nov 2022 19:45:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id np3-20020a17090b4c4300b00208c58d5a0esm226382pjb.40.2022.11.01.19.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:45:43 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:45:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     jeffxu@google.com, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        dev@opencontainers.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
Message-ID: <202211011933.DD0979338@keescook>
References: <20220805222126.142525-1-jeffxu@google.com>
 <202208081018.9C782F184C@keescook>
 <CABi2SkVXMUVhSTJezfHt_BKxyKP+x++9oveuB3qJZL7N672UKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkVXMUVhSTJezfHt_BKxyKP+x++9oveuB3qJZL7N672UKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 01, 2022 at 04:14:39PM -0700, Jeff Xu wrote:
> Sorry for the long overdue reply.

No worries! I am a fan of thread necromancy. :)

> [...]
> 1> memfd_create:
> Add two flags:
> #define MFD_EXEC                      0x0008
> #define MFD_NOEXEC_SEAL    0x0010
> This lets application to set executable bit explicitly.
> (If application set both, it will be rejected)

So no MFD_NOEXEC without seal? (I'm fine with that.)

> 2> For old application that doesn't set executable bit:
> Add a pid name-spaced sysctl.kernel.pid_mfd_noexec, with:

bikeshed: vm.memfd_noexec
(doesn't belong in "kernel", and seems better suited to "vm" than "fs")

> value = 0: Default_EXEC
>      Honor MFD_EXEC and MFD_NOEXEC_SEAL
>      When none is set, will fall back to original behavior (EXEC)

Yeah. Rephrasing for myself to understand more clearly:

"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like MFD_EXEC
was set."

> value = 1: Default_NOEXEC_SEAL
>       Honor MFD_EXEC and MFD_NOEXEC_SEAL
>       When none is set, will default to MFD_NOEXEC_SEAL

"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like
MFD_NOEXEC_SEAL was set."

Also, I think there should be a pr_warn_ratelimited() when
memfd_create() is used without either bit, so that there is some
pressure to please adjust their API calls to explicitly set a bit.

> 3> Add a pid name-spaced sysctl kernel.pid_mfd_noexec_enforced: with:
> value = 0: default, not enforced.
> value = 1: enforce NOEXEC_SEAL (overwrite everything)

How about making this just mode "value 2" for the first sysctl?
"memfd_create() without MFD_NOEXEC_SEAL will be rejected."

-Kees

-- 
Kees Cook
