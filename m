Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24807C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiENV6t (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiENV6e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:58:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA440E69
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m12so11124212plb.4
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzfWF5xEUyLdKqhX0/BNfMvKzUJWiSaq1KcpW14iYMw=;
        b=WUlUbVRF6tirwuKwDy2NkFQO/d2QfrAUOspNRkHBFDb8zh5PYzqPFuh8T5V1C13dXL
         LFH13+Od0CwiqKj4zQII9grfBvdPGnYi6BlF50c5YX57xB7aI063mkiBbOk+Ls4I51VW
         Ea82sWo3QQSM5HKAsah/AH9GJKBYLeEbbBlqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzfWF5xEUyLdKqhX0/BNfMvKzUJWiSaq1KcpW14iYMw=;
        b=m3d74hfaUB04FdIJGFM23g4uCPE5pl8ha6qPvl/9lwzdq424LbfUhgLhBmeq/UjojW
         qu3Qiyuugi2zpLuxEOLNwaPBTWrU9e757yaBIVGmVK3CZurnpNy9wUE2Z1jtgWeCrAlo
         oWjl1vvYIsQGHfRBHEhX6+1DgwOdR8iHp4KNXfx239kq9lXCh1NISm8IHgJPe1CSVxXA
         4NeB1b7Wp3h3CLtGj/pksynET0vit6u3MpPFOQF+aAe7dLiFlQmRMElxO5l8Mn6DxBAS
         DbSghwFbQbtMk8mVReaXGUN0VxUOGSYKKyylVErO8vr39aPnRttP9o3aaN3dAr9+SlPN
         5sZQ==
X-Gm-Message-State: AOAM5306UGybDCZLH13uzt0kpJ3SO9KzTiux+h/AQt7u/CBszXDPCORy
        Zq0PKyi44K4cf7lIoibnZp/5pQ==
X-Google-Smtp-Source: ABdhPJwpfw7TbvPXHehxghPWQ4Qsa1e3wKrxEzkB//8n2/gpnFICcaugpHJZByhUFKa3kZET1C0iOA==
X-Received: by 2002:a17:90b:4b03:b0:1dc:6554:1bf9 with SMTP id lx3-20020a17090b4b0300b001dc65541bf9mr22748680pjb.246.1652565512306;
        Sat, 14 May 2022 14:58:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0015e8d4eb264sm4182146plk.174.2022.05.14.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:32 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:31 -0700
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
Subject: Re: [RFC PATCH v2 19/21] x86/vdso: Disable CFI
Message-ID: <202205141458.54A04805B5@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-20-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-20-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:57PM -0700, Sami Tolvanen wrote:
> CC_FLAGS_LTO no longer includes CC_FLAGS_CFI, so filter these flags
> out as well.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
