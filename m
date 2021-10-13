Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DFC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5634360EB4
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhJMTEU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJMTET (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 15:04:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42DC061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:02:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om14so2949918pjb.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYUZdSbtY3yILKq30armlw/nLFSTpxD7xzR0LPRYz80=;
        b=gpYKK9FHVxBdFJtwWQViBwA6f8A8yxtHj5zqNEzFZ+S0843PtoWAyD5MADhc+CKcZ4
         5ngK1kdS6dIScpdJWiiYbns6hn+I0/aa3zc8aYsrcaVwjDK/PyNeqgmgGZSw1ruKlLVJ
         KmTGnrOq0PccZ2Svs/+X9fiN4LSaKncO8PW8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYUZdSbtY3yILKq30armlw/nLFSTpxD7xzR0LPRYz80=;
        b=WpTQiKgXFNe+JUzBicnikrPaBfGgIy/+Bpf+wtDJEd4rQ9tBi0n1+aGX177g0prRd+
         0UKIZf1A9GCbgHOIL9ZEir4GRoDo4iwv/PQFoGb52JyG6+JOzbNAun3JA4WvhhjrD0dW
         uG47yMxItDZGx0K/bi5O2ThlGfkVCO0YSi/lqIQbnCKECnfvOO94lOjFgVS5Kfzn2o4q
         52PIdeeI5FGNG6cL+pCZoZFEw39mhtumVsRAlD4b/LNKvIwUVttaYadlMOFF0IU4rn/C
         HUO3D51yI52NJ13mAQy3/l3wgWTkjKubpRpCNMZH2IdQVDs8KlxShU0o1Zb9nFshJHAL
         qSYQ==
X-Gm-Message-State: AOAM531PaVXTckkvPLHBGG3am+XRkO2kk1prNO718fiwejW9j3lIeSJ9
        v2anKAN21LBlgB0dQVrgCHOglQ==
X-Google-Smtp-Source: ABdhPJzr8pB5JKBpq4Ks8L5I/+V7O+fqmjtmqNIRDwvNRhToQtzGptsraxsDs7uoU+If38Zs1gAazQ==
X-Received: by 2002:a17:90a:1548:: with SMTP id y8mr15961214pja.151.1634151735724;
        Wed, 13 Oct 2021 12:02:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d138sm251374pfd.74.2021.10.13.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:02:15 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:02:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
Message-ID: <202110131200.5D551C2D@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-5-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:47AM -0700, Sami Tolvanen wrote:
> This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> which defines a stub function that immediately returns and when
> defined in the core kernel, always passes indirect call checking
> with CONFIG_CFI_CLANG. Note that this macro should only be used when
> a stub cannot be called using the correct function type.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I remain a bit worried about this exception infrastructure, but it's the
best way forward right now.

One thought: add DEFINE_CFI_IMMEDIATE_RETURN_STUB (and maybe other
things to watch closely) to MAINTAINERS:

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..2c9a24fd6a3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4553,6 +4553,7 @@ B:	https://github.com/ClangBuiltLinux/linux/issues
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
+K:	\bDEFINE_CFI_IMMEDIATE_RETURN_STUB\b
 
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
