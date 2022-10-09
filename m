Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BDC433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  9 Oct 2022 04:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJIEDc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 9 Oct 2022 00:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJIEDb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 9 Oct 2022 00:03:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E32C651
        for <linux-hardening@vger.kernel.org>; Sat,  8 Oct 2022 21:03:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fw14so7386584pjb.3
        for <linux-hardening@vger.kernel.org>; Sat, 08 Oct 2022 21:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGcANlxwwAoMV2yYuqmWVwlrAW36ZFrUJRQgUMMRe4U=;
        b=gRnfSz3W7cd+YWPYek/6AId3fc/Ne6mR0yCBLDN8d87c7zrFVIkgLBWdAPuEEGp1Hw
         e8SCJ0un44FP95xt8dHchQSalUd35CG4vhSnWcimwklP01o8phVipH0OJr4fBtqcTbhd
         HvTYXv2Th6sj80FrvNKrEf8tCpyGhaKbp8C3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGcANlxwwAoMV2yYuqmWVwlrAW36ZFrUJRQgUMMRe4U=;
        b=WInL7Ez6yWEpV7om+nxxt6trXJ2WlYv9D2DcrfZeWRMQlHzI0h5KtvG6jfSVZMofsm
         nu1aV/mqmHTShocnK3nRIMj1qLOruu0JkrDJnX7qtzgC55usWYRPpUQzmEI3EPAhdzFV
         wTl2UzmakNzpxYpzjc8v0DxYFOijGQJeyZlaORM9g/31230ZfAdrBfjcG59qxEBf6h0s
         4PqtluMqSGkKc9+XQhZdBxfmf10ttFXVWCNt4RgxEnNzsaazMAKGXeBms6CgheHxM3VN
         dF4YHTO3T4IAE4h6C3SASuswS7WLpjO1Amx+CvG+NuAWg+unQbqp5UadwJMEs9vdgFjY
         WikQ==
X-Gm-Message-State: ACrzQf0lVRkc8R40xrLH7sVCNUNbI8XT/kefk+OdDDjNBI89Bz7ek9rD
        a7kDgiim0ePJ+M6O3CMXyFavgA==
X-Google-Smtp-Source: AMsMyM4wxlo6Eqvw98xHCVgZjF9QkQXjx7TiytIor/82u/00GrEhO16CVKVF/xw7v1ToUcMCP8llZw==
X-Received: by 2002:a17:902:b20a:b0:178:6f5b:f903 with SMTP id t10-20020a170902b20a00b001786f5bf903mr13070468plr.39.1665288209694;
        Sat, 08 Oct 2022 21:03:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a628606000000b005629b6a8b53sm4384256pfd.15.2022.10.08.21.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 21:03:29 -0700 (PDT)
Date:   Sat, 8 Oct 2022 21:03:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <202210082044.51106145BD@keescook>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0IsXXYnS4DnWkMW@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> 
> That's true. I agree that leaving "+ 1" would work and produce a
> no-binary-changes patch due to the existing padding that the structure
> has. OTOH, I thought that relying on that space could bite us in the
> future if anyone tweaks the struct again...so my reaction was to ensure 
> that the NUL-terminator space was always guaranteed to be there.
> Hence, the change on c693 (objdump above).
> 
> What do you think? Should we keep or leave the above
> "+ 1" after the rationale above?

I think it depends on what's expected from this allocation. Christine or
David, can you speak to this?

> > I would expect the correct allocation size to be:
> > offsetof(typeof(*ls), ls_name) + namelen
> 
> Fair point, I will make this change.

Well, only do that if we don't depend on the padding nor a trailing
%NUL. :)

> > Question, though: is ls_name _expected_ to be %NUL terminated
> 
> Yes, it is. I tracked down ls_name's utilisations and it is passed down to 
> a bunch of routines that expects it to be NUL-terminated such as
> snprintf and vsnprintf.

Agreed: I see the string functions it gets passed to. So, then the next
question I have is does "namelen" take into account the %NUL, and is
"name" %NUL terminated? Those answers appear to be "no" and "yes",
respectively:

static int new_lockspace(const char *name, ...)
{
	...
        int namelen = strlen(name);


The comparisons for ls->ls_namelen are all done without the %NUL count:

                if (ls->ls_namelen != namelen)
                        continue;
                if (memcmp(ls->ls_name, name, namelen))
                        continue;

> >, and was the prior 3 bytes of extra allocation accidentally required?
> > 
> 
> I am assuming that you are refering to ls_namelen in the struct dlm_ls
> (please correct me if this isn't what you meant).

No, I meant ls_name (the pahole output shows the trailing 3 bytes of
padding before. And with your patch it becomes 4 bytes of trailing
padding.

So I think this is "accidentally correct", since it's so carefully using
memcmp() and not strcmp().

Given the existing padding on the structure, through, it likely needs
to keep a certain amount of minimum padding.

original size was actually this, so you could use this for the new
calculation to get the same values as before:

	offsetof(typeof(*ls), ls_name) + 4 + namelen;

In reality, it may be possible to do this to get exactly what is needed,
but no less than the struct itself:

	max(offsetof(typeof(*ls), ls_name) + 1 + namelen, sizeof(*ls));

-Kees

-- 
Kees Cook
