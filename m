Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E6EC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 22:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiENWDv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiENWDt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 18:03:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2C193E4
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 15:03:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a191so10711668pge.2
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cv5IfzzB62q+sLnNCDbD30QBd73u3J6+zboNpO/j4RY=;
        b=VETNqwy6PZmcQN3F3QHSWlt30W22U3LCrLRvKSeesIcM9qLdix4sdzIOt/G8doxqOb
         OcoqV/LPIMHwGJxM1kBkp24tJ8lnxNfHbqvA5/XfJrtBOFx283bTamig0x1zX3ftp4Ez
         dBx+vI7MyUSpc3Sh0MhnbfuW2COnE4U2FEV4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cv5IfzzB62q+sLnNCDbD30QBd73u3J6+zboNpO/j4RY=;
        b=oUu4y4/JxWJRWpQVafnqFGpo9uyLAzkPtIIb88MPDflK6zjwh2kmhQVyPyI7GfLdWu
         I9z7P9CUZyYwxXqPVNYP5EnXegbcfsbb8u+VfNxzfN/tasae0oxuElB0AIaz6E07L4V/
         kGomnEEE5Fo4RTO+TrM2MUB//ElciePRVDkoNAQo3/aVXboiqrEmdcoYKU8/DyKBBkHr
         wGXNNSjDHfHeUsqJRYaH/aTNpPcLUAsSPujDay2UqITL3FV5H/IsTyQ1e2FX0I4J3251
         gjD4UjUR0gxT7KGsu/LC4rkNXAACd9Ufxcs7fGktZ2zSboQeTfSuZuI07YVyIlsQHSmJ
         Nk1A==
X-Gm-Message-State: AOAM5329teEkiXRkFHWjNth6x0QnPvtpG7kPcRX0HBMxfcAuxOa3JkZB
        5Iyfwb/rpbIfPlhQ3ip8+NOeTfNjHe35xA==
X-Google-Smtp-Source: ABdhPJw20gLVrovNCtH9oPgnmWWI4khPHrgIkrbw39eJj00oseNyUiPYd0WVdGDzgNKQyhd7WsWu9A==
X-Received: by 2002:a63:190f:0:b0:3db:972b:46bb with SMTP id z15-20020a63190f000000b003db972b46bbmr7963890pgl.554.1652565828255;
        Sat, 14 May 2022 15:03:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip14-20020a17090b314e00b001d81a30c437sm3672870pjb.50.2022.05.14.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 15:03:48 -0700 (PDT)
Date:   Sat, 14 May 2022 15:03:47 -0700
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
Subject: Re: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
Message-ID: <202205141503.3D87637B85@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-22-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-22-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:59PM -0700, Sami Tolvanen wrote:
> It's no longer necessary to disable CFI checking for all __init
> functions. Drop the __nocfi attribute.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Maybe move this up after patch 11 (the arm64-wide __nocfi removal)?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
