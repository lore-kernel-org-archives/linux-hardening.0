Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E7C77B73
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 02:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFACvO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 May 2023 22:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFACvN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 May 2023 22:51:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E983101
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 19:51:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-256712d65ceso58710a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685587872; x=1688179872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJvI42hzqEfLq+DDW1OxT0grFxR3mOlryj6N6dIoRA8=;
        b=BSgJOLNKhZW08Q5W2hVYZFOOYILOZsab5M9FRjNq9kNADqpxi+0yEasbwoPQ6C0RYD
         AEkZuY1Lhs0sZ+QMQ0sT3uB6hHd+//YLWvGQIDj1eyc19RJZOhVosve0y8PQfp/dXpnq
         FLwmUqCk0ZZMTo35hD81j8HljdTyAil05pPVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587872; x=1688179872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJvI42hzqEfLq+DDW1OxT0grFxR3mOlryj6N6dIoRA8=;
        b=ILD/n3b3PdooIsXmcnEfMkEtymRaU+52LUCi1bFT7JJ7ZcArE+bkrRKqabT3sgcKz9
         yvjVFLTZgOl6vGheL8XzIjgqsA8NlMk29QnxtGTQq9jnbhgcnTLzL03SJcvj+1OthVrw
         rL69K2ev7g+TK9H2u+6fePbkV7uoZiCXT6bvymcbAH6v08DR72jO0nzMwx5reZjqQ+j+
         iHdAAwMY1MmY+4/Fp/iRIJ5Uu6Ns0MxYjnRNq9BkTyAIshrpaHeKk0kT9Yfg7vGGLMJN
         D5COkcsR/zVDmgyzPO9Ne0HqfNp0S/2BkM8SkSnY3kjkg36IoUpNJPB8Db886tt6Ummc
         xWAQ==
X-Gm-Message-State: AC+VfDxhYfrYYsQrnwRDRREuetRvlSR2g/Dm3ZmXc9nmz/d5KtqEfHJh
        zG7vhvaLPbrb4TMu3ewdxXmbkQ==
X-Google-Smtp-Source: ACHHUZ7PFFFjKduMvOqjuZYsP8C5LHYpM5N6RALb9qSn8RKP39imX2lcG+hpivB2yErAslXEfNFSPw==
X-Received: by 2002:a17:90a:db8a:b0:24e:688:30f8 with SMTP id h10-20020a17090adb8a00b0024e068830f8mr5009755pjv.49.1685587871737;
        Wed, 31 May 2023 19:51:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b002500df72713sm257413pjb.7.2023.05.31.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 19:51:11 -0700 (PDT)
Date:   Wed, 31 May 2023 19:51:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alyssa Ross <hi@alyssa.is>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv/purgatory: Do not use fortified string functions
Message-ID: <202305311950.EFFD6521@keescook>
References: <20230531003404.never.167-kees@kernel.org>
 <20230531-abruptly-settling-f9852f408dcd@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531-abruptly-settling-f9852f408dcd@spud>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 31, 2023 at 11:37:20PM +0100, Conor Dooley wrote:
> Hey Kees,
> 
> On Tue, May 30, 2023 at 05:34:04PM -0700, Kees Cook wrote:
> > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> > 
> > struct sha256_state {
> >         u32 state[SHA256_DIGEST_SIZE / 4];
> >         u64 count;
> >         u8 buf[SHA256_BLOCK_SIZE];
> > };
> > 
> > This means that the memcpy() calls with "buf" as a destination in
> > sha256.c's code will attempt to perform run-time bounds checking, which
> > could lead to calling missing functions, specifically a potential
> > WARN_ONCE, which isn't callable from purgatory.
> > 
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
> > Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Conor Dooley <conor.dooley@microchip.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Alyssa Ross <hi@alyssa.is>
> > Cc: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-riscv@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Perhaps this is indicative of other issues in RISC-V land, but
> allmodconfig complains about this patch:
> 
> ../lib/string.c:17: warning: "__NO_FORTIFY" redefined
> ../lib/string.c:17:9: warning: preprocessor token __NO_FORTIFY redefined

Argh, thanks. My compile test clearly failed. I'll fix this up.

-Kees

> 
> > ---
> >  arch/riscv/purgatory/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index 5730797a6b40..11f4c275f141 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -31,9 +31,9 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
> >  $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
> >  	$(call if_changed_rule,cc_o_c)
> >  
> > -CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> > -CFLAGS_string.o := -D__DISABLE_EXPORTS
> > -CFLAGS_ctype.o := -D__DISABLE_EXPORTS
> > +CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> > +CFLAGS_string.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> > +CFLAGS_ctype.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> >  
> >  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Kees Cook
