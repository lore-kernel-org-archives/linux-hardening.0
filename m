Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A1ECAAD1
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 22:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiHaWEZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaWEY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 18:04:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08576E588F
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 15:04:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 76so15743864pfy.3
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eXEYaFnP4mOKjstNFujmxTiRRJjn9XYWqPXOjFo+1fQ=;
        b=S/NcZDY5SZ6CRMmy+D6KjP0bTurAvGghafOwYbc+nw/dwS4ozUP9sQwnkdU2qYD+X1
         8UMSc5iO5Qk+z++YNmfVFYjUcIBjFchohVKc75j5HUMkRFDUetf4U6l4sH4tLuN2RSPS
         ffiBV5V5SggAAOzfGOvkiCIpVaWQVrpea4yF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eXEYaFnP4mOKjstNFujmxTiRRJjn9XYWqPXOjFo+1fQ=;
        b=GtJRZxlMQp8orEC3oDupTOO1udhEp5r6Cg8kRXNEm5AAiv0c1KhtkOMW6zceM4M6PH
         /TzdmeyXOzbKHghCN4f12xycBgzwde5Zno36o2pBDb1G+Duokawclnll6ob+i03Ljo0o
         e6XjSFnMFf8gE5m1TZNGS0GzaN7eC+r/+y1J/pB5Z4pPr0j5QR5bjon9UsTXMwfIlp+D
         MuQQBMVqAcSlod+7mGB3CHD9tB499pv3jZ23Z+n7Im8s9w0AKfydKzx4TIcypB4jaIcE
         AW/j8qiAkjSzlUtwJX40Y4sdiEfAojyjIECjju4EYGmglwVwWSldkDaeK3w79i2wkK8X
         BnaQ==
X-Gm-Message-State: ACgBeo3N2iwtnVJIKFIWGqO9qDdLlq5TiO7N8YxwJn7cCawyrjm8EVsb
        Qf9JG4YohUDX7foxXlWzfIdvCQ==
X-Google-Smtp-Source: AA6agR5Zz4u2SM6bdRyYRSBSx8G9I+mIKqnLqni5bLKs1f95ZDZtfZ5SgHlRdwxyL0X1H+0S1pMqCg==
X-Received: by 2002:a63:88c3:0:b0:42b:33f8:6bc2 with SMTP id l186-20020a6388c3000000b0042b33f86bc2mr23258567pgd.495.1661983462486;
        Wed, 31 Aug 2022 15:04:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902710e00b0016d150c6c6dsm11999017pll.45.2022.08.31.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:04:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:04:20 -0700
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
Subject: Re: [PATCH v4 00/21] KCFI support
Message-ID: <202208311503.62B2C1BC@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:08PM -0700, Sami Tolvanen wrote:
> KCFI is a forward-edge control-flow integrity scheme in the upcoming
> Clang 16 release, which is more suitable for kernel use than the
> existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> LTO, doesn't alter function references to point to a jump table, and
> won't break function address equality.
> 
> This series replaces the current arm64 CFI implementation with KCFI
> and adds support for x86_64.
> 
> KCFI requires assembly functions that are indirectly called from C
> code to be annotated with type identifiers. As type information is
> only available in C, the compiler emits expected type identifiers
> into the symbol table, so they can be referenced from assembly
> without having to hardcode type hashes. Patch 6 adds helper macros
> for annotating functions, and patches 9 and 19 add annotations.
> 
> In case of a type mismatch, KCFI always traps. To support error
> handling, the compiler generates a .kcfi_traps section for x86_64,
> which contains the locations of each trap, and for arm64, encodes
> the necessary register information to the ESR. Patches 10 and 21 add
> arch-specific error handlers.
> 
> To test this series, you'll a ToT Clang toolchain. The series is
> also available in GitHub:
> 
>   https://github.com/samitolvanen/linux/commits/kcfi-v4

This happily runs through all my initial testing hoops. :)

Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
