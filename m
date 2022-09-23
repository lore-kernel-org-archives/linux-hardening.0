Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08658ECAAD8
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 00:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIWAU4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Sep 2022 20:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiIWAUz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Sep 2022 20:20:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17884C888C
        for <linux-hardening@vger.kernel.org>; Thu, 22 Sep 2022 17:20:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so3841525pjl.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Sep 2022 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fE8nCD0AAGL6m11CnMBfi2PNly3cqHNqiT4DGj6b5Gc=;
        b=ZcgEPa5GX4lJbCqdaQIoVzgDaAGB2ncYfRY5U+Q2yAy9IywhwFoEoy1uuMIfswt3ny
         794u3NbJDIPlXO3iAM9o8Z2XldjYuBr70GXIXXMpFKlmSoVyLitAOvWbioDxzj83ipsx
         dnX65KS5JpCN9hZliXHZZTTpOarXoM17UEoGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fE8nCD0AAGL6m11CnMBfi2PNly3cqHNqiT4DGj6b5Gc=;
        b=vPdjhWCQIE6iXoxRrcUn7s0qrHGT9G7zOlf0ODUIR1NxmBy71oXHk0L4ZCg8htSbR4
         4pDsv+8o/FJzuHnG0CiVVWCXHQzV8sloDDaQWye4B2bJ7Jcm2NJEn5Mi4PGlr+4j9x6e
         Hd9ob6LxUF8Rrm+iyPHjTmUQeDm9PEKjHTcIILzc7zaxFhHXn8Gpv4+6YS2ml1ebA4ew
         zP3UFKgODRKyhvoPDXTDzFulrCB4C4EZdmWWdHhDrViZ2aCy2UfVnnX6sgrZO/rjlPCM
         sOQke8D6j8ZnyaBDbdzPDAA619AeRlowUX0uKnKdsvvkDnix3jdVJAwYJKIEHKsmnFTj
         GTAg==
X-Gm-Message-State: ACrzQf2ZuBwqfucqq0ObFUJRLT/2ChZcL6e74DHULtpwQ8tQVUk4R/ws
        AZzmTXIiTEKgcWnfgRqsXMXYuRRT72kl1Q==
X-Google-Smtp-Source: AMsMyM7i+eNakcX48qpc7Mn5PvOUozzI8YxksEJeQObNVkyr/89+42nVUtZy0igEPuZyD7dfedjxXw==
X-Received: by 2002:a17:90b:4a85:b0:202:4f3f:1f65 with SMTP id lp5-20020a17090b4a8500b002024f3f1f65mr6397691pjb.241.1663892453590;
        Thu, 22 Sep 2022 17:20:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a4cc200b002006f15ad4fsm378261pjh.10.2022.09.22.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 17:20:52 -0700 (PDT)
Date:   Thu, 22 Sep 2022 17:20:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] fortify: Use __builtin_dynamic_object_size() when
 available
Message-ID: <202209221714.1D792FE6@keescook>
References: <20220920192202.190793-1-keescook@chromium.org>
 <e2a0debe-e99f-2259-1cb9-35193c387c82@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a0debe-e99f-2259-1cb9-35193c387c82@gotplt.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 22, 2022 at 04:26:54PM -0400, Siddhesh Poyarekar wrote:
> On 2022-09-20 15:21, Kees Cook wrote:
> > Hi,
> > 
> > This adjusts CONFIG_FORTIFY_SOURCE's coverage to include greater runtime
> > size checking from GCC and Clang's __builtin_dynamic_object_size(), which
> > the compilers can track either via code flow or from __alloc_size() hints.
> > 
> 
> FTR, I ran a linux build using gcc with allyesconfig and fortify-metrics[1]
> to get a sense of how much object size coverage would improve with
> __builtin_dynamic_object_size.  With a total of 3,877 __builtin_object_size
> calls, about 11.37% succeed in getting a result that is not (size_t)-1.  If
> they were replaced by __builtin_dynamic_object_size as this patch proposes,
> the success rate improves to 16.25%, which is a ~1.4x improvement.

Thanks for check that! Yeah, a 40% increase in coverage is nice. :0

> This is a decent improvement by itself but it can be amplified further by
> adding __attribute__((access (...)))[2] to function prototypes and
> definitions, especially for functions that take in buffers and their sizes
> as arguments since __builtin_dynamic_object_size in gcc is capable of
> recognizing that and using it for object size determination (and hence to
> fortify calls) within those functions.

Yeah, this could be another interest set of additions. It seems like it
might be more "coder friendly" if, in the future that has the
__element_count__ attribute, it could be used in function parameters
too, like:

If we had:

int do_something(struct context *ctx, u32 *data, int count)

this seems less easy to read to me:

int __access(read_write, 2, 3) do_something(struct context *ctx, u32 *data, int count)

as this seems more readable to me, though I guess the access-mode
information is lost:

int do_something(struct context *ctx, u32 * __element_count(count) data, int count)

But yes, this would be excellent to start adding!

-Kees

-- 
Kees Cook
