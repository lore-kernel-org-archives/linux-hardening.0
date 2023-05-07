Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36BCC77B75
	for <linux-hardening@archiver.kernel.org>; Sun,  7 May 2023 15:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjEGPUl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 7 May 2023 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGPUk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 7 May 2023 11:20:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294583C9
        for <linux-hardening@vger.kernel.org>; Sun,  7 May 2023 08:20:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab032d9266so34310435ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 07 May 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683472838; x=1686064838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpz7HOvQ4sbM65oc1RHD60Zy17J1MPnakrLeLIsq2CQ=;
        b=M4Z7QCpBi8ZXwuooS/eX+qNSdz3KypQirIzggSbfO50pBYzVJN+m0wXBv0C48wRFV1
         UVfAIs4kKtCF03a3wVYkVgntgNpIV35k4SS4f50751iv5e09msjGB8uN67ZQRxYXhVc3
         r0w4DCYgLzwXafkL2yrZZkrlJUjIJUhaeIHLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472838; x=1686064838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpz7HOvQ4sbM65oc1RHD60Zy17J1MPnakrLeLIsq2CQ=;
        b=aXtRgoU/jtKgkK0RJHTWt2bXXjn/T9wkwQHu4pWEnsKQpuY3SSrJpNUgd68YVUxfx7
         BO2PVNlzdmxHcp2ZOAbqBkNmpu3/nHf3kU52wW76Mdqy7Py8oS7nz4jaSLLNfIJDxImh
         uMtr75WLoKdJMdE934AZC/CVg24Oj+AxEih1zUNqjh05FP8fXVx+Qdjf+XZnz6broPz7
         VFVhiAEZgBCKR5EcLQWQ6cWzneXA4Xu4bf9ltZz5yTGj2BVFKTnb9XU5oG2Eam8Bx0OO
         Up5gD5c2aKGcQhSQasye4w99gdqsyV8BgwMFp3I5XWd2niZsp8xRJ7R26O4Y5FBVYisE
         Wp6w==
X-Gm-Message-State: AC+VfDzLfsFu3YgaPAPAc31uVVmIYsPksr00t0wOseZjKty1ZcOMlCz/
        gxDtPNEvUfKpF6gzfx00Cn++/b6sNnpo/I8342k=
X-Google-Smtp-Source: ACHHUZ5iczZH9IUaSLs91dVgHohXAqrhze6RILukG1s65EnShELl45vuFv2gSidDE+1nOlw5G8yU5A==
X-Received: by 2002:a17:903:48f:b0:1a6:4cbc:14dd with SMTP id jj15-20020a170903048f00b001a64cbc14ddmr7160987plb.8.1683472838646;
        Sun, 07 May 2023 08:20:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001a4fe00a8d4sm5302064plq.90.2023.05.07.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:20:37 -0700 (PDT)
Message-ID: <6457c1c5.170a0220.36712.8d84@mx.google.com>
X-Google-Original-Message-ID: <202305070820.@keescook>
Date:   Sun, 7 May 2023 08:20:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under
 UML
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 07, 2023 at 04:33:43PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 7, 2023 at 12:27 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> > running with --altests to gain additional coverage, and by default under
> 
> two L's in alltest?

Oops. Fixed. :)

-- 
Kees Cook
