Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A61C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiENVy6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiENVyt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:54:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B89F2DABE
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:54:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p12so10794821pfn.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2yObVrbf/L9Jq6+JbbAXZHKIfGO1DeBECBvtcKWJrQ=;
        b=a2vCFtT3tXCJFlaBwLlox/cAPNUXQljxjpojw0pEncSqcq0/+C10zLDNqQyY4H4MZd
         kD7/dRMNsR6kSF64Nx5WKF94/fOyf5uHx7flzonMY2TVUorztqn2oJepkCTboXILUDhF
         ufEifGfG/qIMCjWxrANBavsxx++WXTI1Q3Clc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2yObVrbf/L9Jq6+JbbAXZHKIfGO1DeBECBvtcKWJrQ=;
        b=KSSiYUATumJ8ZmpFtmNRrce+yDF609GopvFYISm1xCUykZKUAHNFVNJwE6FSl9BHUf
         1zsFqA/S7U9AWQ5soX55E1PtWr5MD8nzyF0fUN0KPX0IPxpwGjf03sDwXjAvgyvaIM1A
         QX6JZ9JkgySbkciSnk/7rP6CwB6x6Oxn2ipQ3lurx2Jsrb9RD5DG/wA3TR4mQBQSwPu/
         aq35IgmzGuDyOGZBYO2b4L+PcrIznY4qGudU94nVcB48f3kj2csUDaCXaFVV7hho1+LM
         Sa7ZILtfQQrKmPHfkIgv1e967OXcMVe9kaWVdC+l87btAH/4f0orHhVDYVWmFXLUIwz3
         fxRA==
X-Gm-Message-State: AOAM533DuX3hKZNEovvxmjWCUBzIx9COBuDLLRY5QOz/h2K1VFqjVN5p
        uYTZEheuJu87YIzjeV3fWlRq9A==
X-Google-Smtp-Source: ABdhPJzEbT+xSq2G7nTj/6I7DpbTkFKAAE5DIrDPZRYeOTIN7iK2Q3o6lSrZl7RpCs6ZWKyW4Fzjtg==
X-Received: by 2002:a63:381e:0:b0:3c6:d5e4:fed9 with SMTP id f30-20020a63381e000000b003c6d5e4fed9mr9243439pga.553.1652565287615;
        Sat, 14 May 2022 14:54:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0015e8d4eb1ffsm4184143plk.73.2022.05.14.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:47 -0700 (PDT)
Date:   Sat, 14 May 2022 14:54:46 -0700
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
Subject: Re: [RFC PATCH v2 13/21] treewide: Drop WARN_ON_FUNCTION_MISMATCH
Message-ID: <202205141454.12B573ABC@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:51PM -0700, Sami Tolvanen wrote:
> CONFIG_CFI_CLANG no longer breaks cross-module function address
> equality, which makes WARN_ON_FUNCTION_MISMATCH unnecessary. Remove
> the definition and switch back to WARN_ON_ONCE.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This one always felt like a trade-off, so I'm happy to see it go. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
