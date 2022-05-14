Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C1C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiENV6d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiENV6Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:58:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5540E45
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i17so11088466pla.10
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHRIbwbYw+C29KUQZWgduS5aUkdozvIZ+erhj6VO6FY=;
        b=GKZwyVRiKzX72oR6iRkHNGBB4Yxe4zgbdG2bd1Amyx25B8PRAkSSWxH34c2Z8H4Nnm
         1vTmWCO/WBQS1TIQlB3jNMp8kDrLZ6n4ahAh5U+uttxpOOjQf2Tn//WLGsxXWkypgUs4
         tC2mjiqHKHosECDuo/Grwg0fKMiL1EvNVf1Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHRIbwbYw+C29KUQZWgduS5aUkdozvIZ+erhj6VO6FY=;
        b=E3tPvA06wFMneygmtETpFa7rj4n72xoB+PUFYFAvrfdb7aR3jmZz/0eQ5trA9/h+5m
         DicfoYGKIeRddm0XH8KAByLqfOHJEaSw0BiQxRbD9jztRwEuvXJolfaN/5ZHZZbYyZxe
         Aw35mgmSJJ4V4nHU6NXoOI3tWUDRkJKwzJ1jqASBh0DHJyBHqhn2ToZzAioEeB3TLIjP
         xcHXx18brm2x/qpISwWWflyexGhRWWGsaG2sJhN4oZuqIqDxme10sM0g34cZLfGP7glv
         youXWRNrBC4TmiQiogKRRIwi4NpdV5zcEwdWGtuA+b/xSabX/sYy1vgEJPM9ITljHZUs
         dkFw==
X-Gm-Message-State: AOAM530YUl7rT+QLuUiIY8tndzGkqbPNp6FmNQqXRZh55zoMadeSnjw0
        Aov10FnwCMpJKqjog6nujQ7NeA==
X-Google-Smtp-Source: ABdhPJwQi9fDcAabhWlIu7XmH1XILDhZjsGUll409I75HQ6fQoXg6nsR8lupRx6Pog8YHNzHVYWXow==
X-Received: by 2002:a17:90a:db51:b0:1dc:9d7e:1e11 with SMTP id u17-20020a17090adb5100b001dc9d7e1e11mr23330312pjx.129.1652565502681;
        Sat, 14 May 2022 14:58:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm3889773pgv.87.2022.05.14.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:22 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 18/21] x86/purgatory: Disable CFI
Message-ID: <202205141458.1101A071@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-19-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-19-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:56PM -0700, Sami Tolvanen wrote:
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
