Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE434C77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEPU3c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEPU3b (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 16:29:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400BAA
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:29:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643a6f993a7so9377002b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684268970; x=1686860970;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfFalckieIL5b2BMB4ZeT1fia028FDcDqWo0QUktAqo=;
        b=D0/ujM4BqVgm4nEuqrEBAsa53WxwmDFDuUI0WmtUnYj4BGKAYb+p69MaZhrD00NGhC
         b0cqtw2GOsdimNCJKovFC4eejJoeoRvUduu1rY9Skx4zk90MZrx07TwHw2DsaN1Kw3s6
         BZkodjuDZQXxenKtjT1mlt/Qy5nZbwIe+Hta4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684268970; x=1686860970;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfFalckieIL5b2BMB4ZeT1fia028FDcDqWo0QUktAqo=;
        b=VK1dhnXo1d0O8mW8bIT7/Zb/txkaKesip3lYdbOkSQBeCFWdmagvG/JM5lcE3DG1MZ
         /I7X0EJ7cb1XWK2bK+w+ijjVDISKXXHIN/cA4Orr5FydUOs9qrQKMRrOqe4zHx9O2q3x
         Pp9rqnJ4c4TGm8PkfQtqR2P4+ogB9LweA2RrIvq76YXI1tJM2l3uf94wnEfHJoWN1K9L
         mzZGTEdjz71+tasBxb3jUZOZQbarqCVqav2ja2CLT+eR2vc4V+ZzcseHxbzTpp4ilU0p
         tdY/SUTSe05gNuQ3Xsp2a0INqYhTvoKnKmxDzvBQkiwCIvsz+u1DCxJkCF4D2f2LrFTM
         Cmxg==
X-Gm-Message-State: AC+VfDxQQdqH8fHfCVHGHarLAAzx3L0F71QnvVC/+EVVzlItwJwWJiUE
        zJ5WBb/R+jX35sByCwUHy0vmog==
X-Google-Smtp-Source: ACHHUZ4+MaFwt3xS1rb+Fkm6fp513EzV3CUwD4ldx8oXI+1yeey+Ve91BlBZI2JfErGrqIuLSCHBag==
X-Received: by 2002:a05:6a00:981:b0:645:5d3b:ed2f with SMTP id u1-20020a056a00098100b006455d3bed2fmr43702362pfg.9.1684268969788;
        Tue, 16 May 2023 13:29:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b0064394d63458sm4602023pfn.78.2023.05.16.13.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:29:28 -0700 (PDT)
Date:   Tue, 16 May 2023 13:29:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Progress on Bounds Checking in C and the Linux Kernel
Message-ID: <202305161325.0E3BF912@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

I just wanted to share links to the presentation Gustavo and I gave at
last week's Linux Security Summit. Repeating the abstract here, just so
you don't have to click through if you don't want to:


Linux, like all C code, regularly suffers from heap buffer overflow
flaws. Especially frustrating is that the compiler usually has enough
context to have been able to stop the overflow but has been hampered by
needing to support legacy coding styles, ambiguous language definitions,
and fragile APIs. This has forced the compiler to frequently ignore the
intent of programmers in an effort to support sloppy code patterns that
may not exist in a project at all.

The history of the C language specification's "flex array member" (FAM)
is long and twisty, and technical debt exists due to ambiguous
implementations. With the introduction of -fstrict-flex-arrays, C can
now unambiguously declare array sizes. In the kernel we can build on
this, by transforming trailing zero-length and one-element arrays into
modern C99 FAMs, adding the use of __builtin_dynamic_object_size(),
applying it to defenses like FORTIFY_SOURCE, and expanding where the
compiler can use this knowledge internally for improving existing
sanitizers. Finally, adding a new struct member attribute, we can expand
object size tracking to cover all array types, freeing Linux from this
persistent class of buffer overflows flaws.


Summary: https://lssna2023.sched.com/event/34dfdb61ccf86035c031b5bf2173765a
Slides:  https://outflux.net/slides/2023/lss-na/bounds-checking.pdf

I haven't seen any video published yet, but if that shows up soon, I'll
reply to this thread with a link.

Enjoy! :)

-Kees

-- 
Kees Cook
