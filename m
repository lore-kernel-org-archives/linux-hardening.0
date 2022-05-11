Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26970C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 18:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiEKS1l (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 May 2022 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiEKS1k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 May 2022 14:27:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88F66689
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 11:27:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so5697086eja.11
        for <linux-hardening@vger.kernel.org>; Wed, 11 May 2022 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8i5OqL859EJUndLqdpyRDZH0AKz1Nfbg5NkEZBumyYc=;
        b=F6YUNe9JYU5exa1en7crUAFK+IeIw5wm5JMGme/AEz7g6vN52RFIEcQcD/G21CCjRZ
         b467EIkBU5M1TKpIY4myh0XwqOBshQypUujtntee3xmYSWRS4cl1doIzj1mendYjL5j7
         Ai1PtykjGc7qTjXN3nuZJtpoH/Di2UULVtiavKLilDIRTDu6DiI9yrkaWD7vEjJtWUeY
         Y9FvW+d2yPucKBBzdOuHx3xmFByxjbIaFRW2tPj33TsVW+e7ji/BDmo+tLQvLG+0orwy
         661nqi4oX56tfPHd+HkgOAbQYvsiAPRT8KC+iG9R6BTFFYqvBOCY345Y9gAel+l1QC8X
         HT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8i5OqL859EJUndLqdpyRDZH0AKz1Nfbg5NkEZBumyYc=;
        b=utgvrfWRX2wFE3h2nlHScUR2ftMfGMXS1UkKbO5pXi5ka7eOOcaqT1Q/DiNsHOh3cJ
         NhCIsbySAQcjb9eOk4b4tlz8s3NsojtTxMBlX2ZYTd+jG0GxQa1rUfGdTVhi8o7WhGhE
         OiwhMLQA96IOmOCx6/o+z3pJIxqx9WzhPy6lAArBuh3G3KO8dur4Chs/nSB+kR2F5TuR
         FFCsiHwNp+Nj+oLUeA548TPO5hSPqPFB7Urx2TwWsaCACoTRWmKqrlPewig9YczqSI/L
         9dOIctBqL7M87j0pnttBVKu/XhknZu6/EMCMMZMc+SarXyhnBlafl4VhbubERQE/ax7/
         5MqQ==
X-Gm-Message-State: AOAM533HrlxiKSrhY6DMOlfsW3lohwdH7mHvhY5QV9NC0y4e6dL9lNTa
        HUfuAkrmvVnt99t++W+QiS4ZXSGslQKdRzqg1AyEM4P2O+4ajQ==
X-Google-Smtp-Source: ABdhPJz8PQsE966KybB3t7TlW7Rim3780OS2G5SrFf8O6unqFgUy8x0/fq7MqIYU0bnTay5CY4mVC+0ZXmQXFhKy5RA=
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id
 e14-20020a170906314e00b006f006590963mr26522983eje.358.1652293657552; Wed, 11
 May 2022 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511174531.1098548-1-keescook@chromium.org>
In-Reply-To: <20220511174531.1098548-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 11 May 2022 11:27:26 -0700
Message-ID: <CAGS_qxokQAjQRip2vPi80toW7hmBnXf=KMTNT51B1wuDqSZuVQ@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> systems; the types exist there too. Remove the #ifdefs.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Daniel Latypov <dlatypov@google.com>

Makes sense and looks good to me, I was able to run it via
$ ./tools/testing/kunit/kunit.py run --arch=i386
--build_dir=kunit_i386/ overflow

Raw output was:
    # u64_overflow_test: 17 u64 arithmetic tests finished
    ok 7 - u64_overflow_test
    # s64_overflow_test: 21 s64 arithmetic tests finished
    ok 8 - s64_overflow_test
