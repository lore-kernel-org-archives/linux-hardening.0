Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3489C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Dec 2021 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbhLCXE4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Dec 2021 18:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbhLCXE4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Dec 2021 18:04:56 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529EC061353
        for <linux-hardening@vger.kernel.org>; Fri,  3 Dec 2021 15:01:31 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id m15so4459226pgu.11
        for <linux-hardening@vger.kernel.org>; Fri, 03 Dec 2021 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7eG/LpBpIoDnmkkVRB1Vl+hz0IOd/cbgCmXoaPwHfQ=;
        b=Kqdt+V2+8MMJ+dlp+a/a0oLuuQr8cvKUDrkpYQuwEiuxsngWfr17BQf4DOTq2Lh4fu
         N8ITGCBtg143Ru+FsXq4bDQwC1z6lwkwdx2wZwDqAO0/zpvj8+pD2B7RW86gbi69lZmF
         UvVbp8QJPz8k/E0XNi5H5DmyRVDDL+cUFAv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7eG/LpBpIoDnmkkVRB1Vl+hz0IOd/cbgCmXoaPwHfQ=;
        b=AZk9/60CcbJROEJlOSnPqI2Gd2aka/5naJkI0F+xsFGSOwCQWbFsQvQOWdUcWSqV+O
         ZVUSR4REzoyLaTXHBTgPRhP0RNVSq62mGrY8DUwOpRc3+eZoCa/0Apw5kIfz+q26jrzS
         MV8+P3fF1T73574dpeSzoieN8497wLbVcgWJqOwsquTRzD+VfFZYRYhonmm55LCTGpQ/
         a2kFc/UjU+tawYmJZUwXx/wn3MvO+r5kCsY7xQzzTUHP9o/8wFuYXrpOEixILyS/5SKu
         zJ+W9Lus4KMgvdaEl68SnXW+HeJ/vuBgEHvUFiPY/ueB/YrTrYVgQJveurhkMfOFwkHg
         kdVw==
X-Gm-Message-State: AOAM531Pbq4wA5gN7oXLE+3ABWnrGFiglYsK/eYW+AslsexFvRE1eyz0
        orIF2g/aLgrq2eYFg2e0NGCCMg==
X-Google-Smtp-Source: ABdhPJxfq+pZGUTD+G+gefYGdCFsLh79Rg82YRWjEdarh3PeOrocMsXVVva9firtbRXWQagQJ2vS1w==
X-Received: by 2002:a63:5f8d:: with SMTP id t135mr6624293pgb.610.1638572491418;
        Fri, 03 Dec 2021 15:01:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc10sm3567730pjb.9.2021.12.03.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:01:31 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:01:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112031450.EFE7B7B4A@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203182638.GA450223@lapt>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 03, 2021 at 10:26:38AM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > > It's common practice to cast small variable arguments to the find_*_bit()
> 
> Not that common - I found 19 examples of this cast, and most of them
> are in drivers.

I find 51 (most are in the for_each_* wrappers):

$ RE=$(echo '\b('$(echo $(grep -E '^(unsigned long find|#define for_each)_' include/linux/find.h | cut -d'(' -f1 | awk '{print $NF}') | tr ' ' '|')')\(.*\(unsigned long \*\)')
$ git grep -E "$RE" | wc -l
51

> > > This leads to the find helper dereferencing a full unsigned long,
> > > regardless of the size of the actual variable. The unwanted bits
> > > get masked away, but strictly speaking, a read beyond the end of
> > > the target variable happens. Builds under -Warray-bounds complain
> > > about this situation, for example:
> > > 
> > > In file included from ./include/linux/bitmap.h:9,
> > >                  from drivers/iommu/intel/iommu.c:17:
> > > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> > >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > >       |                                     ^~~~~
> > > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> > >  2115 |         int pds, max_pde;
> > >       |                  ^~~~~~~
> 
> The driver should be fixed. I would suggest using one of ffs/fls/ffz from
> include/asm/bitops.h

I don't think it's a good API design to make developers choose between
functions based on the size of their target. This also doesn't work well
for the main problem which is the for_each_* usage.

The existing API is totally fine: it already diverts the constant
expression small sizes to ffs/etc, and this change is only to that
part. It's just changing the C description of how to get at the desired
bits, so that -Warray-bounds doesn't (correctly) get upset about the
wider-than-underlying-type OOB read.

This is one of the last issues with -Warray-bounds, which has proven to
be an effective compiler flag for finding real bugs. Since this patch
doesn't change performance, doesn't change the resulting executable
instructions, doesn't require any caller changes, and helps gain global
-Warray-bounds coverage, I'm hoping to convince you of its value. :)

-Kees

-- 
Kees Cook
