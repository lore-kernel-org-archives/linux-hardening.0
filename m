Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FBC32793
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Jan 2023 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjARUny (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARUnx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Jan 2023 15:43:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A35F3B1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:43:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b12so25442576pgj.6
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KStM3HmfW6zjszqSuM2wQKSCCuEFuFkt3tPZnP+tR7I=;
        b=L3qce/23w/O2c6J0Sgvm8TGIFHR7tKd5Beqd1seyYV/7EV6novDaC5eXSiWU/f2FS5
         zSaPnuKyAYIsn+fAqZCqa1zAtjqrkRU6JUhLJSSO/aayxOkqt4XedkfO4QfCQWo7R1zM
         3jfnJDXMc4ataF6oRRyoiuCLTocCsVrHqDJns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KStM3HmfW6zjszqSuM2wQKSCCuEFuFkt3tPZnP+tR7I=;
        b=XCb7IbJ41ZCWSkGBZvYsjTjfotJeoHNd1GNlGNy8IPERc1zH+sA160NSmQGl2b6lS0
         PxPe9J55iOv7rm63a6JBAl+w1FdHTcY2jvGTaDGSvTGWUb4Bm4Nrw2rcWKxwWkbdCG2C
         raVB8gwVT6H9a00hxlpw+rj9hAcu5qEAg7kFRBr2pUrFlGB7d+/OGwIKiaMDVq+8b1HG
         /JBY55TJ7Z7b2qb+J1li7IZyNNWBlsavQ78e2bBBBkTU7N82PwNOexpmC4jUpB6XmXKA
         8LAUX0ARFIg+9IQWlvBoP0l8G/lAu77lU7vdYqzWEqlWDmbl+VT8DEjDdynfx7ARF0tl
         pNBg==
X-Gm-Message-State: AFqh2kqW6TmusXDG2Y2qPgLhwTPtbaN1zxlgvXuQLqMYSMJAQCDmM3X7
        8kNfRkMIAzwT/FB7R5OWWN/klw==
X-Google-Smtp-Source: AMrXdXtQTleYSShMrqb3uuqdACEmAmgcS2GNXTtWlwQaiiEsj75gzw65XygJAnb8zA+2WFBUq52IWg==
X-Received: by 2002:a05:6a00:2a04:b0:582:26bc:a75b with SMTP id ce4-20020a056a002a0400b0058226bca75bmr9405109pfb.9.1674074626585;
        Wed, 18 Jan 2023 12:43:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7990d000000b0058a313f4e4esm16911700pff.149.2023.01.18.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:43:44 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:43:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <202301181243.2DBDD432E@keescook>
References: <20230118200653.give.574-kees@kernel.org>
 <20230118203216.GA987351@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118203216.GA987351@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 18, 2023 at 12:32:16PM -0800, Guenter Roeck wrote:
> On Wed, Jan 18, 2023 at 12:06:54PM -0800, Kees Cook wrote:
> > Since the long memcpy tests may stall a system for tens of seconds
> > in virtualized architecture environments, split those tests off under
> > CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v3: fix defaults, avoid redundant returns.
> > v2: https://lore.kernel.org/all/20230114005408.never.756-kees@kernel.org/
> > v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
> > ---
> >  lib/Kconfig.debug  | 9 +++++++++
> >  lib/memcpy_kunit.c | 3 +++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 881c3f84e88a..149d6403b8a9 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2566,6 +2566,15 @@ config MEMCPY_KUNIT_TEST
> >  
> >  	  If unsure, say N.
> >  
> > +config MEMCPY_SLOW_KUNIT_TEST
> > +	bool "Include exhaustive memcpy tests"
> > +	depends on MEMCPY_KUNIT_TEST
> > +	default y
> > +	help
> > +	  Some memcpy tests are quite exhaustive in checking for overlaps
> > +	  and bit ranges. These can be very slow, so they are split out
> > +	  as a separate config, in case they need to be disabled.
> > +
> >  config IS_SIGNED_TYPE_KUNIT_TEST
> >  	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
> >  	depends on KUNIT
> > diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> > index 89128551448d..90f3aa9e909f 100644
> > --- a/lib/memcpy_kunit.c
> > +++ b/lib/memcpy_kunit.c
> > @@ -309,6 +309,8 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
> >  
> >  static void init_large(struct kunit *test)
> >  {
> > +	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST))
> > +		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> >  
> >  	/* Get many bit patterns. */
> >  	get_random_bytes(large_src, ARRAY_SIZE(large_src));
> > @@ -327,6 +329,7 @@ static void init_large(struct kunit *test)
> >   */
> >  static void copy_large_test(struct kunit *test, bool use_memmove)
> >  {
> > +
> 
> Some whitespace noise slipped in here.

Ah-ha; thanks! I'll fix this in my tree.

-- 
Kees Cook
