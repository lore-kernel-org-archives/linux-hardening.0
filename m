Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A6C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiENVvu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiENVvu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:51:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FB13E06
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:51:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v11so10738385pff.6
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJbcM6BaGnVsc+lH7+1M1k2jbZydRk22NNewGkDa1NU=;
        b=e4BoHA9WL9qeZc71RDo+gwHI/WVGlF9ihGMZvl3GjCTnYqbpdgT6ARC97V0Sx005vk
         CVBefGzFOPkHSpdQU0IONguMIhpytTi32o8F4sAZ9Hu6oN0VZfc4WwF5S47maDqlHjGa
         9VthZjOMjNu86ZiHEs9AjxoajYC5HNqWD/Eqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KJbcM6BaGnVsc+lH7+1M1k2jbZydRk22NNewGkDa1NU=;
        b=vxfUwxNI6Fd4WG0PYzjTHd04+SM39W7e6L0JoHnfbMzlmi6hvP6/qQ80lT75/K/3Fi
         AvZ6mTpSHhAfF5T65iE/MJxdvuHgsykv7yWe/MIVodsxEHvJKXdplJcAYDFODC0BpV2a
         nuEfuGI8ubBkpGR3Xr2+txsurFKRh0Wgx2e3zG/wHG5NNDu9FcFtOA1QAwlIxtLIDxoH
         P+eNFdYUNPtfhWfVozMdwFchj48BlW6+A8BKYPWE3DB93iXRn3pSgdqm9YLGgnncQVow
         P2QZqkaShf6bGrx3HyJPJxa/TtcvQnXMQi2OLdDERFHk9WWWkWjmlZgSoRZpW1jE/wwe
         oIUw==
X-Gm-Message-State: AOAM531Ny09vqa2nuIJrC95fFO2SMTSjX8QD1kLo5MfS/BGg3lBUF/mU
        qEB9LAT5UVBd8ibWoau8+Ox7hA==
X-Google-Smtp-Source: ABdhPJzVcwxnf5BHi4PD4v22PQexaSGjmN/U7xVBOR3pb4vN2IMRcgUsw+BYxfv+bMDVujgoNZB/uw==
X-Received: by 2002:a63:f0a:0:b0:3c6:e825:2431 with SMTP id e10-20020a630f0a000000b003c6e8252431mr9189653pgl.166.1652565108504;
        Sat, 14 May 2022 14:51:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b0015e8d4eb244sm4117847plk.142.2022.05.14.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:51:48 -0700 (PDT)
Date:   Sat, 14 May 2022 14:51:47 -0700
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
Subject: Re: [RFC PATCH v2 10/21] arm64: Add CFI error handling
Message-ID: <202205141451.AABEE8B@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-11-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:48PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling
> CFI failures. The registers containing the target address and the
> expected type are encoded in the first ten bits of the ESR as follows:
> 
>  - 0-4: n, where the register Xn contains the target address
>  - 5-9: m, where the register Wm contains the type hash
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

It might be nice just to include an example exception Oops in this
commit log.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
