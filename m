Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D70C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhLHTX0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLHTX0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 14:23:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11503C0617A1
        for <linux-hardening@vger.kernel.org>; Wed,  8 Dec 2021 11:19:54 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f125so2950251pgc.0
        for <linux-hardening@vger.kernel.org>; Wed, 08 Dec 2021 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiV3SooUB/32JJTITL+mPBqPfWfpat3lRw3V23Hza2M=;
        b=JgRfy44mQ8AleVBvEo4YVLO+SVZruhEnT70qtxc2H2yTddGuynAwOcHmUkpoAp8vsE
         R5xxaWjydBe1Ccok4e7HJIROXFNNznmvV6REvSYUKbB4R4y7+B4xaPTnnuUtOWcoznll
         an2C3ZPTtQlD9XxlIrC5EpAxkUiWK3r0dlY5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiV3SooUB/32JJTITL+mPBqPfWfpat3lRw3V23Hza2M=;
        b=To+m1pypOW0pZsXKpASyGKkooz7zCVsguG5d5YTnF8hsH0zJoAcZ8GTSQgNMOQe+N/
         vb9AZw/Vv4ytlNh1gVsx3L0tYqTlV/TT/75ZynoMLBxDJX8MFavAOjMt8mBvVELM9oGp
         M8YELJzXfqA6SJBKdEcmplWW/YRHZabzs62ITLJXuBQgQu1N/LRQqLaI6oEfTgE34A4+
         njMVb3xOREQetpTU+Y7VXxuvp0f9BEeVIht/hOW81MO0Zrl6FFRUUVmqv5Z2v7b8IqXZ
         i41x/F1PIyQ/MopYbReVsFy9mC8VAc772WX57hc5MqLDvL193TyKSfft/cUypVZyHHGi
         bvOg==
X-Gm-Message-State: AOAM5337S533kpKRff5VkbFPyt6eBhRmW06fu16jduVZat2Ni67KFcHz
        MciObHNifvlGpHbK2CTXhL7aPQ==
X-Google-Smtp-Source: ABdhPJz1we00WF6hm8MuqpqUiPezlj6zhYoPMtWoYO/1fRqzLahY8pP9UK7D6i/3sxTjVqEElH2OjA==
X-Received: by 2002:a05:6a00:16cc:b0:4a8:2ea1:1df0 with SMTP id l12-20020a056a0016cc00b004a82ea11df0mr7506402pfc.62.1638991193572;
        Wed, 08 Dec 2021 11:19:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t38sm4552392pfg.218.2021.12.08.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:19:53 -0800 (PST)
Date:   Wed, 8 Dec 2021 11:19:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112081104.958EC2E6@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
 <202112031450.EFE7B7B4A@keescook>
 <20211207233930.GA3955@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207233930.GA3955@lapt>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 03:39:30PM -0800, Yury Norov wrote:
> Bitmap functions work identically for all sizes from 0 to INT_MAX - 1. 
> Users don't 'choose between functions based on the size of their target'.
> [...]
> for_each_*_bit() requires a pointer to an array of unsigned longs. If
> it's provided with something else, this is an error on a caller side.

I have a sense we're both talking past each other. Let me try to show
what I'm seeing: the code in the bitmap API chooses one of two paths:

- if "size" is a constant expression and is sizeof(unsigned long) or
  smaller, mask to "size" and call into ff*() built-ins.
- else, use a dynamic sized loop against a series of unsigned longs.

For the dynamic size case, yes, absolutely, things must stay unsigned
long aligned, etc, that makes sense. I don't want to change anything
there.

For the constant-expression size, this requirement does not hold. Every
helper performs a constant expression sized mask of the argument before
using ff*(), for example:

                unsigned long val;

                if (unlikely(offset >= size))
                        return size;

                val = *addr & GENMASK(size - 1, offset);
                return val ? __ffs(val) : size;

In this case, the argument does _not_ need to be a pointer to native
unsigned long. And this is seen in the many many places in the kernel
using non-unsigned-long arguments with a constant-expression size. (e.g.
an int with size 32).

-- 
Kees Cook
