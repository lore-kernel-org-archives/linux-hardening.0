Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1050C433C1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BE1619CA
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhC3VSg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhC3VSe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Mar 2021 17:18:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7C8C061574
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 14:18:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e14so6819514plj.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EHZz0CH2PbVVqRv7QJkmrFjtEJPk2k0V6T7UFiDv3pY=;
        b=m5ZWm2C5ye+Gw/PfKvTXS0ZJy2ROSkEYIcy/qaB4jD9ugPVMEzxEguXT6k3N5U7lAt
         woNxovoTLejySpGiX5WR4bTAImGe7paFsUwhtGvII8YvdOcR28l7M471uKkzDdRPwBjI
         xwqc2eyr6FGUK1Rm5RSnkvoDEkL3uUHdf0Cdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EHZz0CH2PbVVqRv7QJkmrFjtEJPk2k0V6T7UFiDv3pY=;
        b=oI/GrfYF5b6bfgBIzx2cSAviUh15zClHBi93xOJ8+GTp3e18Cxisyw9XB12zVCXq7X
         axpkIMaRVGZD7oRytpkiDDIzFh3L66ZQRE0I4JTr61FwL+9W6B1j4Ts7/OuLYxBwWiGD
         txzPODzDU/5UEoaBMSYsGHLadNZKySEvph1DZeGPP0yKI5+MeESbQ0TJNP8ZxIeQhHa4
         5nU9DmcQbeZ4eHavbFYcFWqHHPRfzKGiQYnai2FVyUcd3p8asYfvynYpXGvSoVnkNHNo
         YC+vVexHm/ryBtMiA16l3Q8NU0DXQIYpt1Pw1W/7pBBnBBZ81O2unt9ZLUCaZhU14gv+
         tnNA==
X-Gm-Message-State: AOAM533Up5kejIT7zMOdBffBAncxvIsn8uCpS70BNrUegKTEY2IZxDoS
        yZLTbW47TLpQ7VeoKt1S8Rw0DA==
X-Google-Smtp-Source: ABdhPJxgbdL2qS8YgyYBZ6kjZ8PmLOutdptDj31H1GjVyBTt3EJl64RTCkDi3jsaGMyZuN+KZBCfng==
X-Received: by 2002:a17:90a:f2d5:: with SMTP id gt21mr257802pjb.197.1617139112859;
        Tue, 30 Mar 2021 14:18:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm21622374pfi.175.2021.03.30.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:18:32 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:18:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Brad Spengler <spender@grsecurity.net>,
        PaX Team <pageexec@freemail.hu>,
        linux-hardening@vger.kernel.org
Subject: Re: two potential randstruct improvements
Message-ID: <202103301407.C7E9F9F@keescook>
References: <CAG48ez1Mr1FNCDGFscVg0SpuuA_Z4tn=WJhEqJVWW1rOuRiG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1Mr1FNCDGFscVg0SpuuA_Z4tn=WJhEqJVWW1rOuRiG2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 29, 2021 at 09:26:35AM +0200, Jann Horn wrote:
> Hi!
> 
> I'm currently in the middle of writing a blogpost on some Linux kernel
> stuff; while working on that I looked at the randstruct version in
> Linus' tree a bit and noticed two potential areas for improvement. I
> have no idea whether any of this (still) applies to the PaX/grsecurity
> version, but since the code originates from there, I figured I should
> also send this to the original authors.
> 
> 
> === no explicit randomization of padding holes ===
> The randstruct plugin works by shuffling the list of C struct members.
> So if you have a struct like this:
> 
> struct foo { u32 a; /*4-byte hole*/ u64 b; u64 c; };
> 
> randstruct might rearrange it into one of the following layouts:
> 
> struct foo { u32 a; /*4-byte hole*/ u64 b; u64 c; };
> struct foo { u32 a; /*4-byte hole*/ u64 c; u64 b; };
> struct foo { u64 b; u32 a; /*4-byte hole*/ u64 c; };
> struct foo { u64 b; u64 c; u32 a; /*4-byte hole*/ };
> struct foo { u64 c; u32 a; /*4-byte hole*/ u64 b; };
> struct foo { u64 c; u64 b; u32 a; /*4-byte hole*/ };
> 
> So if there is only a single 4-byte member among multiple 8-byte
> members, the 4-byte member "a" will still always be 8-byte aligned;
> and if there is a small number of 4-byte members among lots of 8-byte
> members, it'll probably still end up that way. This means that if an
> attacker e.g. manages to type-confuse "struct foo" and an array of
> pointers on a little-endian system, they'll be able to use arithmetic
> operations on "a" to shift one of the pointers in "a" up and down.
> This wouldn't be possible if, after the existing randomization, struct
> members with following padding holes were explicitly randomized with
> regard to the padding (subject to alignment constraints, of course).
> (In practice I guess that might be implemented in the existing
> randstruct plugin by computing padding holes after elements and then
> randomly inserting dummy members in front of those members, with
> dummy_size%member_alignment==0 and dummy_size<=padding_size.)
> 
> (Yes, I realize that this becomes less interesting if you have a
> different mitigation that makes type confusion between single-struct
> allocations and arrays harder.)

Yup, it would be a nice improvement. It would need some work to reorganize
the shuffler, which doesn't have a way to insert fields currently. It
can sort of calculate padding (see partition_struct()), but that likely
needs improvement too.

Patches welcome! I've opened an issue for this:
https://github.com/KSPP/linux/issues/122

> === non-cryptographic RNG used for randomization ===
> I haven't looked at this in detail; but randstruct uses a
> non-cryptographic RNG
> (http://burtleburtle.net/bob/rand/smallprng.html) to derive randomized
> structs from a 256-bit seed. In theory, this means that an attacker
> with knowledge of at least 256 bits worth of information about
> structure layouts in a given build _may_ be able to recover the seed,
> and from there, the layouts of all other structs.
> 
> It might be possible to indirectly determine some amount of
> information on structure layouts through various side channels; for
> example:
> 
>  - cacheline grouping might change if performance-mode is disabled,
>    which might be measurable through false sharing effects
>  - function sizes might change slightly because the encoding of an access
>    to the first element is shorter, which might be measurable e.g. through
>    icache and branch predictor state
> 
> I don't know whether the amount of information leakage would be enough
> to actually determine the seed - and I'm not a cryptographer, I have
> no clue how much output from the RNG you'd actually need to recover
> the seed (and an attacker would not even be getting raw RNG output,
> but RNG output after additional modulo operations). But if the goal
> here is to ensure that an attacker without access to the binary kernel
> image can't determine struct layouts without a proper leak primitive,
> even if they know exactly from which sources and with what
> configuration the kernel was built, then I think this needs a
> cryptographically secure RNG.

Since the RNG runs on every compilation unit on every randomized
structure, any performance hit from swapping the RNG could be large.
That said, folks using randstruct likely don't care. :)

This looks easier to do than the former idea, though. Again, patches
welcome! Issue captured at: https://github.com/KSPP/linux/issues/123

-Kees

-- 
Kees Cook
