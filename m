Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F22C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiENVoq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiENVop (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:44:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C818395
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:44:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l14so106401pjk.2
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kwcy74YlztxWF5D6kkYQbaOPu8Yx3i8Twa6E2rtWI4=;
        b=heJeUZ0XTY4GUls4GZuegGii5t/VwuhS1ZpQ37mLZwfCDKDm207g1xsj8JBCk2bIrS
         aNjlGwo9LlONQauWo+z/yeNmUVPWAY1F26BDhdC/o/qVf3CI2gOFdgEkH/GZhaehv6/3
         Dmfe/noGcr5iWvP/+oMw+4wEkUZvgRyFHIKFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kwcy74YlztxWF5D6kkYQbaOPu8Yx3i8Twa6E2rtWI4=;
        b=gmynMYq9fq5t9Pr9zpdJut6bqUQVX3c2qzar/Wr+5+cUS9kz/nmsC5eUQmlHK7zWUB
         Gq5wl79LzCMrmkX0l6zyFR3IYwCVxxa8fyAamver4go73lk3Su+0cdPm9DmuEYHmUJYu
         jEcTYj8NXjIOQAe04EH2pcuZAhw1MlBHSMoSxnZAMlNByZjCHoqJHNyR/88CbWVVoftL
         XGt3qoNGGFuqdMa86CxuafzgeafjREMV2wyQeXdmQKc8cTYcPmOVbwH6Dmhm/5arJ5+v
         9coWhGmzq9X30e+cXwcxfhKCGzM+kYgutoAdaa6QFrqvA2s7IukqzL85ccme7MVo288K
         o4jA==
X-Gm-Message-State: AOAM53387qypg5EyfJxYAG0ZzuKbIPVN/9bxYRW0VD552xsr0L6R6XtZ
        HQtIuTX8H8+I9VUvFLbbgs2l9g==
X-Google-Smtp-Source: ABdhPJyYU70G1FRfxpgzmsNw6UDgPZOqMteS5Gy+WK+6rpMWNA2Cp5ca2EEFT2ryVSs0JXIcUkTZhQ==
X-Received: by 2002:a17:902:e746:b0:15e:b4f3:72e7 with SMTP id p6-20020a170902e74600b0015eb4f372e7mr10953716plf.8.1652564684488;
        Sat, 14 May 2022 14:44:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902a38c00b0015e8d4eb1d2sm4121582pla.28.2022.05.14.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:44:44 -0700 (PDT)
Date:   Sat, 14 May 2022 14:44:43 -0700
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
Subject: Re: [RFC PATCH v2 05/21] cfi: Drop __CFI_ADDRESSABLE
Message-ID: <202205141444.0C1A3ABD1@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:43PM -0700, Sami Tolvanen wrote:
> The __CFI_ADDRESSABLE macro is used for init_module and cleanup_module
> to ensure we have the address of the CFI jump table, and with
> CONFIG_X86_KERNEL_IBT to ensure LTO won't optimize away the symbols.
> As __CFI_ADDRESSABLE is no longer necessary with -fsanitize=kcfi, add
> a more flexible version of the __ADDRESSABLE macro and always ensure
> these symbols won't be dropped.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

These macros were so fun to build, though! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
