Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D525ECAAD1
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiHaTCE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiHaTBl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 15:01:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56BAB4DC
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 12:01:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kk26so30217532ejc.11
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0guvX6CdC6+lkNNlrZup+CjHGuoRwmgwPktN8aSa5Dg=;
        b=cW7QRE50uRd1u3+fTEsX8n3iPW03Ajb4IjDv4d12ILcNWH6K4Wl3TLUWfUjqQQjukT
         inHeaIkzIB8xjOmMh/4xBOXxYmse3IBrP0LiIZc0bAzKqYA4XxgYeXhiE1/yPLcBIMs7
         Jij2tNtEBtAdZ2xMJl/rG3GghtwopHPetwqPxsl6YqudSKBAyf24ZAK6LBpfUyoyuPEO
         iHkERF6Np6lC7bcqR7kL8CkHgsMffRThNmsJ7mNxIOD+Fw/uoWGJ/YhZlVt4ECZPGOAZ
         iwtRzjFHNEd7PUILk6YglflgGfBIZ2tuA3IKYNKil4ZNrXTzAjZu9HPqqg+J75c7sjKh
         8dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0guvX6CdC6+lkNNlrZup+CjHGuoRwmgwPktN8aSa5Dg=;
        b=LXD0qa1JBN+SIZB2OMC7ljUY/RB8iqZj0G2rFTXD6gq9Prt48BEvG/oRrCRmOGuyZq
         9/8U8/e1hthZrzZBcRvOuvXNCPuqXs794I8yAlgHUBdIP4ndlQk6xImauxxiZ1K9IGHl
         TZzdyaA8ABQMNEPNS+8+c83Nt5zLBTGqoxhkFdOoyE6/8RzPIHEhOB6D3uS6J4LpDv+U
         7z7vrjan6ORj+4JuR6ErfI8+viGA+rVEDnS3fOyuDUdyMx6u+CJVuHfTcxDL8UwR/uwD
         YVaHfq2KWcDYR0bl1jV+hwhnOSJqrQol23Ic4lJOfP/5ymRg49nu2y2/9NygTw9K1P/o
         0qRg==
X-Gm-Message-State: ACgBeo1J6xQJ2xqHac4eHtgLJ4CpLey4GLy0z27xchvW5r7Hw+KLkKYn
        oFFN+7QaM7tKaiecw3MPRkPat4NOVSptcaKqeSUzAiSJcJw=
X-Google-Smtp-Source: AA6agR5dencj6+Gxk5MgyF3/1d0mP+Bbv9YhUqKLvvR2G/Ig/K/ygovKx39x84jy8+l4/Ghhz3TS356SXIqxFmyqMHk=
X-Received: by 2002:a17:907:2724:b0:741:4a1f:6159 with SMTP id
 d4-20020a170907272400b007414a1f6159mr14075478ejl.542.1661972487230; Wed, 31
 Aug 2022 12:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220831181140.842093-1-keescook@chromium.org>
In-Reply-To: <20220831181140.842093-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 31 Aug 2022 12:01:16 -0700
Message-ID: <CAGS_qxoqRrQmECRNAx092j=PArO00NPHansYd8+6TkuFgxe4XQ@mail.gmail.com>
Subject: Re: [PATCH] overflow: Split up kunit tests for smaller stack frames
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 31, 2022 at 11:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> Under some pathological 32-bit configs, the shift overflow KUnit tests
> create huge stack frames. Split up the function to avoid this,
> separating by rough shift overflow cases.
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202208301850.iuv9VwA8-lkp@intel.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

It's sad that we're forced to do this to eliminate such warnings, but
I like this organization a bit better, actually.

I wasn't able to reproduce the stack size warnings in the past, so I
haven't tried to do so here and can't give Tested-by/Reviewed-by.
But I did run the tests and they all still worked for me.
