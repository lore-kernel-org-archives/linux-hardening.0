Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E9C7EE2A
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjEVUOj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjEVUOh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:14:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E62B9
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:14:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae4c5e1388so62465065ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786471; x=1687378471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=900cszRWXxQoVl3oVB2zqsQHSshuzoop+HBXoBzD00M=;
        b=Ff2OYiITp1NJrFn/wO8bo/1CejTJipXWtX1fP39zTI678Ut60n/s8BUGRNzK12D3iL
         Mrn31lycKjByyM+B91iN7fPc0s9tEEYTQkmA+NF7Mqa3gRSGIXuCjkWMRIDr6V9tzo6T
         8Dht9vzAssSm2hR9h4B+Rb3Gcj9T//pQhLYdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786471; x=1687378471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=900cszRWXxQoVl3oVB2zqsQHSshuzoop+HBXoBzD00M=;
        b=CCraloFVvasIJaQouvkomKmYwOVQ+DdQ/65ggvkq1nSkdpuKLYs/f/yBgaix2Gswxj
         5XpaTx9HSBFvio8A+kQCpiQ7rNSzZ+6aqITe+sZdBu/YTqTezVyeEaNnbKZj4MGV/nVs
         imTNS/pjhHAhz3Oh38X+wsCK9jtINTVVePNgdTmFY6H7sF0unzcR7uR1ahdQJXwxQMSH
         uQntEJK/MpFPuuTBOmA5AbcFBtvWMD76Diu74Y6vx+tdipFpwMdikCeCivBET9rHFDmY
         secwg4I/mQFHx/3LylKvAGQJlFP7ai/04F1No4JnVjbVjiM7JfnuibEW9kLTu/4Oir65
         /9jA==
X-Gm-Message-State: AC+VfDyj8q583Z/R+Al2msMnJW1bc+D+32LKWqgiSPQHOeLsop/uNp5K
        DR9h/LPwsAkeRnS4NIrEqHhDxQ==
X-Google-Smtp-Source: ACHHUZ4CFFruolCKI7zFd8Pf82D6NMM0+DeTB27w2fTNM9+6kuU8ngyBaFYRn8IOgTSd0ZhtVqdIvA==
X-Received: by 2002:a17:902:a515:b0:1ae:6efb:7a60 with SMTP id s21-20020a170902a51500b001ae6efb7a60mr10295058plq.39.1684786471496;
        Mon, 22 May 2023 13:14:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001a95f632340sm5222053plg.46.2023.05.22.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:14:30 -0700 (PDT)
Date:   Mon, 22 May 2023 13:14:30 -0700
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
Message-ID: <202305221312.F5EDE0548@keescook>
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
 <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com>
 <202305101223.B940A881@keescook>
 <CAKwvOdn9ytF7EVykt3YXk2QzqYjTfWBzwwXm8LpgPpCLkCvH+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdn9ytF7EVykt3YXk2QzqYjTfWBzwwXm8LpgPpCLkCvH+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 12:43:51PM -0700, Nick Desaulniers wrote:
> On Wed, May 10, 2023 at 12:24 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Apr 07, 2023 at 04:42:27PM -0700, Nick Desaulniers wrote:
> > > On Fri, Apr 7, 2023 at 4:33 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Apr 7, 2023 at 12:27 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> > > > > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> > > > > running with --altests to gain additional coverage, and by default under
> > > >
> > > > two L's in alltest?
> > >
> > > Also, while testing this series:
> > > ```
> > > $ LLVM=1 ./tools/testing/kunit/kunit.py run
> > > ...
> > > [16:40:09] ================== fortify (24 subtests) ===================
> > > [16:40:09] [PASSED] known_sizes_test
> > > [16:40:09] [PASSED] control_flow_split_test
> > > [16:40:09] [PASSED] alloc_size_kmalloc_const_test
> > > [16:40:09]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED
> > > at lib/fortify_kunit.c:249
> > > [16:40:09]     Expected __builtin_dynamic_object_size(p, 1) == expected, but
> > > [16:40:09]         __builtin_dynamic_object_size(p, 1) == -1
> > > (0xffffffffffffffff)
> > > [16:40:09]         expected == 11 (0xb)
> > > [16:40:09] __alloc_size() not working with __bdos on kmemdup("hello
> > > there", len, gfp)
> >
> > I'm still tracking this down. I'm not sure what's happening here, but it
> > seems to be Clang-specific, and due to some interaction with the changes
> > I made for Kunit examination. WHY it happens I haven't found yet.
> 
> Was this what exposed https://github.com/llvm/llvm-project/issues/62789?

Nope -- I found this while working on:
https://lore.kernel.org/lkml/20230517225838.never.965-kees@kernel.org/

i.e. I was surprised I could use static initializers with a flexible
array, and then I went and verified various related behaviors between
GCC and Clang.

-- 
Kees Cook
