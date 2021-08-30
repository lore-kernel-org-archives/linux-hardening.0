Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D51EC432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 20:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F0A60F5B
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhH3URl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhH3URh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 16:17:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B6C06175F
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 13:16:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so14506169pgr.11
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Gjmh2khQtTIto6ydtTcLMQuTQMVcLm+SAujgODL3VA=;
        b=UaZfjuIcymN1ROobWl/Af4JyhzjOTdxqDjeIoICTu9HvZvDDpP3iKwj1jJM8+5i4D4
         7AG+wW1u6sruUD0zVcbMr9SHPUqfNCcS/YRiSO9irljKBdLgfyhrRTLU/QNPFA44gp7j
         Xzyyw8BkHLJjSxN5nLG3KlasYTbMU/DV/8aKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Gjmh2khQtTIto6ydtTcLMQuTQMVcLm+SAujgODL3VA=;
        b=hJjUqDdPH/3SwOe9Fb5hMTa7AXbzZIwxRzvGCOzPgxHvNPixzUiZWfHGajI1B02gDL
         5MiRj7U/D9KQQnLCkC5O5wqpyvLxPD/0JrP6eJq5cLKqiGM8M6WgrzlGxFnzwAayZbg2
         42qUROHHmlhQt9jmFX4A7vLWGdciuVlf/Ej6Cdlthwz+K02hl7TRoGKLxTmnVz/zlJ7m
         z1MXAyVOrgSUC5kh+sof554tTyzMSITozc3hSpNcH14gHuPoZLKuwRn/EZgocorWjZu+
         q6QBQux0Gk4QmU2Qav7+9bF85K0z/Lq8/yMXQUKQ+hx3FyKjWuaeVXv/qQ6NEUPNVoSB
         2kNw==
X-Gm-Message-State: AOAM532Kv2PQVGER0P2mFE9aiDIzqtbw3qjVsVa0G0pz4z4GCBj+v7+Y
        oz+NTtQLNb2J3G88ApfYqx5rwg==
X-Google-Smtp-Source: ABdhPJyfyfv0j5SsIb7SF7ruWGzc0JgMsZg+XrtwWeRgwZ1dqSmBiT4CuujRduBedSkB7IpGBLg0uw==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr24825041pff.49.1630354602955;
        Mon, 30 Aug 2021 13:16:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c123sm15588127pfc.50.2021.08.30.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:16:42 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:16:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Message-ID: <202108301314.22B3CB015C@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 30, 2021 at 11:44:54AM -0700, Nathan Chancellor wrote:
> arch/powerpc/kernel/signal_32.c:780:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
>         unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Or is this a Clang DCE failure?

#define unsafe_put_compat_sigset(compat, set, label) do {               \
        compat_sigset_t __user *__c = compat;                           \
        const sigset_t *__s = set;                                      \
                                                                        \
        switch (_NSIG_WORDS) {                                          \
        case 4:                                                         \
                unsafe_put_user(__s->sig[3] >> 32, &__c->sig[7], label);        \
                unsafe_put_user(__s->sig[3], &__c->sig[6], label);      \
                fallthrough;                                            \
        case 3:                                                         \
                unsafe_put_user(__s->sig[2] >> 32, &__c->sig[5], label);        \
                unsafe_put_user(__s->sig[2], &__c->sig[4], label);      \
                fallthrough;                                            \
        case 2:                                                         \
                unsafe_put_user(__s->sig[1] >> 32, &__c->sig[3], label);        \
                unsafe_put_user(__s->sig[1], &__c->sig[2], label);      \
                fallthrough;                                            \
        case 1:                                                         \
                unsafe_put_user(__s->sig[0] >> 32, &__c->sig[1], label);        \
                unsafe_put_user(__s->sig[0], &__c->sig[0], label);      \
        }                                                               \
} while (0)

if "set" has only 1 element, then _NSIG_WORDS must be 1. The warnings
are coming from cases 4 and 3. (But why not 2, which would also access
beyond the end?)

-- 
Kees Cook
