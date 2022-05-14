Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A434C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiENVnG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiENVnF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:43:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20018382
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:43:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j14so11104902plx.3
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlRFKx1f5LgxGYiRBStshQO2lcl0shwRTsz4d5msIg8=;
        b=eVJvq+ghFVgsLl2S9H413dqQTj8DyyaMX5Lri0ldevwz5nr6Vcgdxe0+ij/LV+qfcg
         ng+ldMyJk1bq4BG01m2rz/bktU34wNy4ejseMuCe/8j4MBVXCDe6GfufyslHYCZreNjs
         zLCBvZKrj9tb+YOYdvXa5qk9tB4rwunj+IEIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlRFKx1f5LgxGYiRBStshQO2lcl0shwRTsz4d5msIg8=;
        b=NS6Pmg0jDtmMwQhTRv3vKeRTY9ZCtmELCCFD3gvkxUHD6SZQrcvgh4HdroX0QCoMi1
         hetBH/qXjrd+yNHo8CKj3E4tHiU4yqAcexSJ09HAAalniwFLcRhbOCYoNSQ8NRFlSCxO
         RHYyk7EsMgNGCGfWXFCjIDDDnYYuKMz5MNLBcTFlBlCMLURPyOao8LFT0jnoCnsQz6WH
         5aHf/24lQQdRCotgtEK49Rl5CMVbnc9gtE8SrvRj0q7Qlj88AKfw5PDcBR3aTmz7ap6V
         mj5skoLDxjLYjNcXigH0o1WX5W/zmzQAp1QiPzYpPnsZDz/Fyk3vGQ11u3pj6cUu75vj
         M6kg==
X-Gm-Message-State: AOAM531UBFSJhfr2KTDoJ5f7It0Hjs6ZOPLeqvlB0fOIHcuV4k7QCOMf
        d/2XdxGeltsRjnyWC/p11hIOdA==
X-Google-Smtp-Source: ABdhPJwjF7T387a9POXFRR70Tq2h4uk//J7YzYRByRcEsqcopbrDpy2LgsoIKFTW6B9DZ116TxnPTQ==
X-Received: by 2002:a17:902:bcc6:b0:15e:e60e:f3e8 with SMTP id o6-20020a170902bcc600b0015ee60ef3e8mr10898049pls.174.1652564584093;
        Sat, 14 May 2022 14:43:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0015f4b7a012bsm4078815plb.251.2022.05.14.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:43:03 -0700 (PDT)
Date:   Sat, 14 May 2022 14:43:03 -0700
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
Subject: Re: [RFC PATCH v2 03/21] kallsyms: Ignore __kcfi_typeid_
Message-ID: <202205141443.9A3BAEAA5F@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-4-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:41PM -0700, Sami Tolvanen wrote:
> The compiler generates CFI type identifier symbols for annotating
> assembly functions at link time. Ignore them in kallsyms.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
