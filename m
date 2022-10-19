Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA927C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Oct 2022 04:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJSEGE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Oct 2022 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSEGC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Oct 2022 00:06:02 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8B79ECA
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 21:06:00 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e22so6514807uar.5
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt/UcBSCq3ctx1DKdxEOe9zXd6vUi6e+DDOW65PuwO4=;
        b=RKe187DKCSoCTURbr9ZAU0yWdaK9ahuEJWINssob59FtsoOG+hMisVufWysSTUF2ao
         22JQPrz0XvwsEz7xmdXKqpHpp8PG3Fd2ZDl4zFE6v4VZojqqADhaperM0Qua9qpIs9e4
         038jg+zd6IyH3g6hZmKeR4A2ZAuD8qwX1NAFzvVgaX5287/5SjLnkjmZ7UaXR5F9qe7k
         8Ze4JscErl62Z0ZW5Yep3GI/r7XLub/cgMvKMDoNXTDBKur0RQbuVnihbZqSTcy4QCIR
         xkPNMH4faws2wX8FOdDcLSjQ3n1vKJ9fWI4pR3htOGy0Asm3FiYO5U8K64vkbAGxRJkO
         lTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt/UcBSCq3ctx1DKdxEOe9zXd6vUi6e+DDOW65PuwO4=;
        b=ytw/5/aYAHzFsf1axQB0DOCpvRmC473VfXxzPTxHpu9PhWbc2qIxritp3H0p7rXgOU
         BMeiLm90rfPK4TXCI0yp2YY8buP61ZZF3Qt2lixV8q34xfhcL0rmrXOMEYSA9JoL7JEr
         CC2klxE+L3kqrO6S1fTwMMKBaTnfimtpS4ii57vFbXXjhdmDehTuC5qoTdF95UAtMFZX
         /Ip+gGOXnWHHGhk7EI+dOmcOlaf95AqcHYrwjguEO2+fA8ZPtnuaCPn25rw4r6P5VYQh
         MiaacO0ZdVoOiL8D7s3HIpPlhDURwLX27Ps+xsBUqkgSy3O0+lfvNonqkY+GH6Q+cBRY
         OU8Q==
X-Gm-Message-State: ACrzQf3Zj+VusTiOy9MD8ZcUP5VPiDpGW85cmKLHneqkPKArpKIUtt2c
        dWMImbmssVDCjh4N2eiday5jeWtyZINvsKMhrArWag==
X-Google-Smtp-Source: AMsMyM42bURtQBgKrnpb7sjx/vFddcQMeV8rl3jwrihWTbA8d8xRUQa6Dvo4aXngxEtzihHgTWasga503vRyGkalxRA=
X-Received: by 2002:ab0:132b:0:b0:3e4:ac2d:9e0f with SMTP id
 g40-20020ab0132b000000b003e4ac2d9e0fmr3458525uae.107.1666152359194; Tue, 18
 Oct 2022 21:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221018100510.never.479-kees@kernel.org>
In-Reply-To: <20221018100510.never.479-kees@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 12:05:46 +0800
Message-ID: <CABVgOSmT7y7uNqLb+uyJpsHy4sezFdm_UWrFZvGQ90d+xYbcVw@mail.gmail.com>
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 6:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert the siphash self-test to KUnit so it will be included in "all
> KUnit tests" coverage, and can be run individually still:
>
> $ ./tools/testing/kunit/kunit.py run siphash
> ...
> [02:58:45] Starting KUnit Kernel (1/1)...
> [02:58:45] ============================================================
> [02:58:45] =================== siphash (1 subtest) ====================
> [02:58:45] [PASSED] siphash_test
> [02:58:45] ===================== [PASSED] siphash =====================
> [02:58:45] ============================================================
> [02:58:45] Testing complete. Ran 1 tests: passed: 1
> [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Works fine here, and looks good from a KUnit point-of-view.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
