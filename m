Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA6C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiENV6N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiENV6K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:58:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8940E5F
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v10so10667357pgl.11
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F4n+C6M9Aw1zMVfcPORGXMMVLEr2xX50zcVOAMomtNI=;
        b=ORcydA/uFIOR4odJFAV1XxY+PcGt2zebDpivlroBUEMd4PMs7KqLIIwFyrSrx1hQve
         IphjhRek3rFH0b0wKiFSafB46D14B6zsDaIUkgdWyUVQ4HxGNE+LGPeFItDUMmv7WDWQ
         l82UrDZKj39Vo1sdMxdDyg2ceu7AxyeuoD9GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4n+C6M9Aw1zMVfcPORGXMMVLEr2xX50zcVOAMomtNI=;
        b=jUbJR1wEZ9hXumcGVUB6zKDzC3tow94CQ+ISH7uOHarA7n04TfX7lEnUw8kHiN/4He
         PSo1X/Ry4Ct84EnuMnPe4kmP2ywK98KOHsS1DBKKw8SIinE5nzDnkcqAtHBu73lt6Mdp
         NAK2XCaLGVcwDslfDl4eaocXB20TdzC4lOGKjw6va9e41Kqthj98/bWsWQWe/9A3KIrT
         SBDeJRNBGMXKe0pY9g1LgJJ7pQpWMpakNiXJJ5Jj81FmUepv5mIuCpKswZhPZHV7Nx08
         JnW9eKifcQxx6TPBYp90rsxaUDk6lUY4ybgGSSU4GDwQIJ6FIEn6iSTngduV9HUxER0K
         7SnA==
X-Gm-Message-State: AOAM531gk11SNREgDqbaDIy4ZJAelVeXLfeRJ5+iTDixpMgek40zG5/p
        +yVQGCGLolkQ9Pbwy5Yjp1Oc2w==
X-Google-Smtp-Source: ABdhPJwOtndnmF6wotSc9dg7+c73fyG5+SBhQYVy5w8DsKeAwdpvOT6FhYjPgzOsGs5Q1NOcr1h40Q==
X-Received: by 2002:a63:190f:0:b0:3db:972b:46bb with SMTP id z15-20020a63190f000000b003db972b46bbmr7949134pgl.554.1652565488145;
        Sat, 14 May 2022 14:58:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14-20020a655bce000000b003db8dd388afsm3840321pgr.10.2022.05.14.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:07 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:07 -0700
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
Subject: Re: [RFC PATCH v2 17/21] x86: Add types to indirectly called
 assembly functions
Message-ID: <202205141458.80233E7ED@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:55PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
> must be annotated with type identifiers to pass CFI checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
