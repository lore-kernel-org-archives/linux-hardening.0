Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C28C47088
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLARPo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiLARPl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 12:15:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55732AFCF8
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 09:15:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g10so2232567plo.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIINIHGhGskcMDqmUFFXNmVZPREPkJD5rw4zIRk+6sQ=;
        b=lX7ncvUzSC9rS2ZdVzvSVXdSjYS0XfkOJUpUDqM9m1MziQwQ+9qm+151brYvHnWkOo
         FgANLgqlGG/z5WgU/eqZH7t6i4HEXTREHuZ76s9iSD6WuDoDYQ9MIb/9FB99Uo1dHdPm
         I1pD+By6iGuvWEmYvkWzU2tygVfKpSYoBbn4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIINIHGhGskcMDqmUFFXNmVZPREPkJD5rw4zIRk+6sQ=;
        b=ResCwuxHCFhEfVkFCINKD8NfnhQxHDqn6gIP8jWaed8fg0+YE+ScRQgVLITSMMyPge
         2G1FNF/WTTH5kQhn+xyQ/0iQhbcrWL+8gT/0LyNkj3sKf532CvnNqMtdOOuQ0iviAWJA
         a2Cjhr8AWqHIquqCBICAqT68Z8AOQu9myRyhHFlqkDGBWHEWLBdVztoz8N5JrLj8IxkT
         09MUdWz9gjYNrHj8/a0TGtlMfYocCW10xeeMXwqScGNXHqLrjPTakSFPuDUQHKI5zdkG
         PsBO4A+R7b9B5Ikt+QoGUJn5/76rxR+tPsfprV6vn2e/l7ir9neKekjlcdpKrrqYkfJf
         mRig==
X-Gm-Message-State: ANoB5pkYZvLIDn18Oa3tMDGoQlVtSTRoHlMVqn1KN5N4iczOz1dslagR
        90z2y6b+vJje7vAfaMC7rXitPg==
X-Google-Smtp-Source: AA0mqf7hLOuoteAV7+avN4qvvGgVHF7ekfjG+aG+RXbz2yEIxrPB3hTqariDmAhhNwmKDWq0XzzGcg==
X-Received: by 2002:a17:90b:3e8b:b0:1fb:825c:af8a with SMTP id rj11-20020a17090b3e8b00b001fb825caf8amr31770278pjb.104.1669914935787;
        Thu, 01 Dec 2022 09:15:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902a51400b001894dc5fdf2sm3850559plq.296.2022.12.01.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:15:34 -0800 (PST)
Date:   Thu, 1 Dec 2022 09:15:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/6] slab: Provide full coverage for __alloc_size
 attribute
Message-ID: <202212010915.ADB7D298@keescook>
References: <20221101222520.never.109-kees@kernel.org>
 <Y4X6AHdMZcxvFnDP@wendy>
 <63ced4a4-33b9-4c03-8d7a-987ceb1fc2c7@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ced4a4-33b9-4c03-8d7a-987ceb1fc2c7@app.fastmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 29, 2022 at 01:33:03PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 29, 2022, at 13:24, Conor Dooley wrote:
> > On Tue, Nov 01, 2022 at 03:33:08PM -0700, Kees Cook wrote:
> >> Hi,
> >> 
> >> This is a series to work around a deficiency in GCC (>=11) and Clang
> >> (<16) where the __alloc_size attribute does not apply to inlines. :(
> >> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> >> 
> >> This manifests as reduced overflow detection coverage for many allocation
> >> sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was
> >> not actually being propagated to __builtin_dynamic_object_size(). In
> >> addition to working around the issue, expand use of __alloc_size (and
> >> __realloc_size) to more places and provide KUnit tests to validate all
> >> the covered allocator APIs.
> >
> > Hello Kees!
> >
> > It would appear that one of the macros you've added here is doing Bad
> > Things^TM to allmodconfig on RISC-V since the 22nd:
> >
> > ../lib/fortify_kunit.c: In function 'alloc_size_kmalloc_const_test':
> > ../lib/fortify_kunit.c:140:1: error: the frame size of 2384 bytes is 
> > larger than 2048 bytes [-Werror=frame-larger-than=]
> >   140 | }                                                               
> >         \
> >       | ^
> > ../lib/fortify_kunit.c:209:1: note: in expansion of macro 
> > 'DEFINE_ALLOC_SIZE_TEST_PAIR'
> >   209 | DEFINE_ALLOC_SIZE_TEST_PAIR(kmalloc)
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > CONFIG_GCC_VERSION=110100
> > CONFIG_AS_VERSION=23700
> > CONFIG_LD_VERSION=23700
> >
> > The report came out of my CI (which I should have passed on sooner) so
> > I do not have anything other than stderr - I can get you anything else
> > you'd like/need though if you LMK.
> 
> There is generally a conflict between kunit and the structleak
> gcc plugin, I think the Makefile needs a line like
> 
> CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)

Thanks for the report! I've taken Anders's patch for this now.

-- 
Kees Cook
