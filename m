Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD5C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jul 2022 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiGRSfL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiGRSfK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jul 2022 14:35:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA772871C
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 11:35:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so22972642ejb.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvDVeCPZSKsQ1iYeMyLd3oWMSh1qMXx1KJqR09/AQsE=;
        b=EwLXjpVQO3GPGwx9EHiWHXuUFvxgk+FZuiceO6VnMKQHAqh1pVyaaXS4ceyIIeSpcH
         L/hqkZztVlSz/vxaWsGsgm4BkBiPOafZx9hF/It8EUx+FH4+Xs+F8Anfhp9JVMcin2/v
         oOUJ5W/BUU2E0ppmAklPxWL1CFcOprHfrOyRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvDVeCPZSKsQ1iYeMyLd3oWMSh1qMXx1KJqR09/AQsE=;
        b=wICsHycATgpj99kkM8RTGORFyUlsBMS/GnAickCGJfWMaDpSfqQ2fRDU5XpCDt5/ci
         9pN5AOAagqeCWSXGBSr847kLZnO+GMi/uBtOMuQSdI84NCKjutvDxvXw2YasWBBbjIU8
         fTVW44P3vW39lTul+1K/KBY6Lz3B6d4B8CSrLrYi30YdpHHQuqO3sxM21Gcq9jSdR/zn
         TkxrPE7lpwtI+Qc2yd2SKUzni0eAgj8sSvvzQ9lOsI+7HRAKE0Z9JA50wwV9nPYu2v7N
         QmIuSjJ3dvOlwDGWgysL3NLPGERUGxgfF/jc7kGPFHdZWF8XKZ5u11K6u6Pb9Kk9AxpI
         g8Xg==
X-Gm-Message-State: AJIora/70ih0C/Dv/rlr4FeiNErIMTG8JMOzik7LF/gwJ7bU0K3jzL/N
        IpLOSTcXnGLmZwtBICCbpSgqHy50QPXRq88A
X-Google-Smtp-Source: AGRyM1vL3NPyt2HfcqvteMFvkJWbUF6kPXaLP513476cNL/HRXibXetbWnO0jwvmOGWAx/RAIdW+VQ==
X-Received: by 2002:a17:907:2856:b0:72b:8e8e:3d9 with SMTP id el22-20020a170907285600b0072b8e8e03d9mr27191357ejc.0.1658169308135;
        Mon, 18 Jul 2022 11:35:08 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id sa8-20020a170906eda800b00726dbb16b8dsm5716527ejb.65.2022.07.18.11.35.07
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:35:07 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v16so18290060wrd.13
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jul 2022 11:35:07 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr23821149wrw.274.1658169306930; Mon, 18
 Jul 2022 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <87cze3docs.fsf@mpe.ellerman.id.au> <20220718134418.354114-1-mpe@ellerman.id.au>
In-Reply-To: <20220718134418.354114-1-mpe@ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:34:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihbCSydApZcH21hev5pcKu=-CrQgwp6qmPwuv5kMpwxQ@mail.gmail.com>
Message-ID: <CAHk-=wihbCSydApZcH21hev5pcKu=-CrQgwp6qmPwuv5kMpwxQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/64s: Disable stack variable initialisation for prom_init
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 18, 2022 at 6:44 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> With GCC 12, allmodconfig enables CONFIG_INIT_STACK_ALL_PATTERN, which
> causes the compiler to emit memset calls to initialise on-stack
> variables with a pattern.

Ahh, and that explains why "volatile" made no difference. That did
seem very odd.

Thanks for figuring it out,

                   Linus
