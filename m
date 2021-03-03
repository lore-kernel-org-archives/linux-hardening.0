Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E66C433E6
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558C564F51
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCDAvi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390184AbhCCWCA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Mar 2021 17:02:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B128CC061761
        for <linux-hardening@vger.kernel.org>; Wed,  3 Mar 2021 13:52:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t25so17386503pga.2
        for <linux-hardening@vger.kernel.org>; Wed, 03 Mar 2021 13:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U4O+yoeWHzagedfUZbZH3qiIab8SJ8X8eM+Tksp4UhY=;
        b=YYN0VZ5WcAWAdy5YeXEE1zzzPSpAz9ryE+zz2Xjricab0JVxyluPP4MCa4XoxvZyfy
         PfoXpn+gE9tdYbkr5nG+wTiMmd0FKuwgAulwdpx7KWHw8T7g/kR8Q+EDGF6YJwapvUHQ
         BTZa6v14yrVnKiN9VM1L5Am+qXRvEVRvEOeE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4O+yoeWHzagedfUZbZH3qiIab8SJ8X8eM+Tksp4UhY=;
        b=YQHzi0UDnb2OwZHZI1gnkl32LFX6+BewJL4N+xFN3sO9PluT1YADvFpwDq9ALHMZOX
         xyX8kmm5SZsulfQX5ULxJO2i6YYr1kA0lFD4O1AOUyCnuqtxrC2l1y6r3IFf1FGroNQQ
         8Q1s9/0VidRNw//qRq3wVrV+PJRcbAzEdTzFmXEGICw5GV4hkNl/l9nvDguhVk3zNNbm
         BaEBGvkq4p8ggY2riX9fatKGplAjcpgsHFUOoZsoB2Rmv9AxiHkkq/BSipIpp45+dCDv
         kV4XMbeh6hGPkRr76hK6/0YrbKkUNcsaAa2baTmJK7e4IjCSa5QastgFQ581iKpaW62j
         g9cw==
X-Gm-Message-State: AOAM530e+0xgeIyhwzvT3wUM8Yd9rl/eh4sNMsn9PMBvzut2ieHaemRm
        p3Mg6ZKX7cxum3QBwEtn2SKCdZ2n6VFfAA==
X-Google-Smtp-Source: ABdhPJzRbr7qT0eiEBpzaXHBBfgfy8P7f5UDk1iAQYT1T8aUAdJl816Nk43z6fbffM6tjXW+X0hvoA==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr427004pga.452.1614808375205;
        Wed, 03 Mar 2021 13:52:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k69sm25568517pfd.4.2021.03.03.13.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 13:52:54 -0800 (PST)
Date:   Wed, 3 Mar 2021 13:52:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <202103031334.8D898CA@keescook>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble>
 <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble>
 <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
 <20210303193806.oovupl4ubtkkyiih@treble>
 <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 03, 2021 at 11:57:33AM -0800, Linus Torvalds wrote:
> End result: gcc plugins are pure garbage, and you should shun them. If

I think that's pretty harsh, but okay, opinions are opinions. As Josh
says, people are interested in them for not-uncommon real-world uses:

- stackleak has data-lifetime wiping coverage that -ftrivial-auto-var-init=zero
  for either Clang or GCC doesn't cover. There are no plans to provide
  such coverage under Clang yet. It's arguable that stackleak's benefits
  are smaller than it's maintenance burden compared to having
  -ftrivial-auto-var-init=zero, but we can have that conversation when
  we get there. :)

- structleak is likely to vanish as soon as GCC supports
  -ftrivial-auto-var-init=zero. Clang's implementation is done and in
  use by every Clang-built kernel I know of.

- latent_entropy is likely less useful since the jitter entropy was added,
  but I've not seen anyone analyze it. No "upstream" GCC nor Clang support
  is planned.

- arm32 per-task stack protector canary meaningfully reduces the risk of
  stack content exposures vs stack frame overwrites, but neither GCC
  nor Clang seem interested in implementing this "correctly" (as done
  for arm64 on GCC -- Clang doesn't have this for arm64 yet). I want this
  fixed for arm64 on Clang, and maybe arm32 can be done at the same time.

- randstruct is likely not used for distro kernels, but very much for
  end users where security has a giant priority over performance.
  There's no "upstream" GCC plan for this, and the Clang support has
  stalled.

> you really believe you need compiler plugins, you should look at
> clang.

This is currently true only in 1 case (structleak), and only a few
"traditional" distros are building the kernel with Clang right now. I
don't disagree: doing this via LLVM IR would be much easier, but the
implementations for the other above features don't exist yet. I expect
this to change over time (I expect Clang's randstruct and GCC's
-ftrivial-auto-var-init=zero to likely be the next two things to
appear), but it's not the case right now.

-- 
Kees Cook
