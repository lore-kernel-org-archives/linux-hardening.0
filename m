Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FEC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2422E6008E
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhJMS5v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMS5u (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:57:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69165C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:55:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x8so2456881plv.8
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CeDioKlYWP/Ln2/sv3Boh4vbm3yoXHdApCIilZ4yhGw=;
        b=adSofeNpkzFQ7ekSQ+w/o5WGdQNGCajwgRa++HMYHPPE9dE7+IC42Fj/GAeu8fYZ2r
         T/XBrlk0nCBGvuFRp8tBJuAGrzUUCHkF6HcKiI/zzyA7Z6Ea0LF0Z2ezCoSZ8jcy8UHd
         LFxEWL7AMGZDGCcK2aRmNHSiq6g3Eol3eDjVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CeDioKlYWP/Ln2/sv3Boh4vbm3yoXHdApCIilZ4yhGw=;
        b=wkNSeFLxvibsqHwVNgPb1kG7jiuUlJ7UzYxRrQ9HIPAGQa/b6e7FoNqgiwdKRv4Wj9
         q+lXxTcyt2VM534xvbtK9wPn7SzOHPc37oTzDbTv6O6tYKZ4bAkDWd0e6r5Yw8Yx2+mk
         zoLARPD90nq0HZLENTUJhRmMlszHwKoFLF1CsYhZeLouUxE/0Oo4zJEUk5yJOD6Ef7vf
         N/gAmq3TMFqVMyYDcgyngmKnAiWWVpPFMIPGzZEG83yogNopommAju/1AUrg8hUODGeq
         r3jhU8LsfQxfYtrf3HeH07lodRA2FwIamCdzXNbuLejARWIEisoBYn68AshixrCA8i71
         71fA==
X-Gm-Message-State: AOAM532cidKt3tRNOtO+9Ma+9ZC4cBTeYINhjAWdQ4M7sUgvZVF2y6MN
        YBfNTfCqzh1jjuEeGCXSp1HmaA==
X-Google-Smtp-Source: ABdhPJwbaTpa6edmN31oVJb/gCU2mYzliazMjcWHBH0jE37kLU9+/IH13a8ovSasYEkmTLsZf/xfDg==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr1109096pjr.9.1634151346914;
        Wed, 13 Oct 2021 11:55:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm225896pfb.175.2021.10.13.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:55:46 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:55:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 12/15] x86, module: Ignore __typeid__ relocations
Message-ID: <202110131155.3A730AB3@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-13-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:55AM -0700, Sami Tolvanen wrote:
> The R_X86_64_8 __typeid__* relocations are for constants the compiler
> generates for indirect call type checking with CONFIG_CFI_CLANG. Ignore
> them when loading modules.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
