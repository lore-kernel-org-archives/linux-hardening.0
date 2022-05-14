Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF93C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiENVmo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiENVmn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:42:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38E1838F
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:42:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x12so10665816pgj.7
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=23xyQlazTAPWzzday3S3EoO5Wm7fZvGvsyQkqyX645Y=;
        b=TMkRhl/wkoxlOPIUjWFpDEdYryjRLo1aur2RO+svl712U8by/JGzX+5ItuVlWn03tA
         KgpiOLWAc0epLFPuSyHy+n6EnTesI6a5Crv6i50DYOfevDec6pWiGr/qo7ei40Il/CZF
         9DlqRR/GnjNe/MZg9aFcb3rMM559MvTBwPk+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23xyQlazTAPWzzday3S3EoO5Wm7fZvGvsyQkqyX645Y=;
        b=g6KackJ9E1+7LQsQCqvOzd7iGBMT6jHroCirMZfpTTuNe2fhGQOhT5lTU5p/MZDNUz
         YY/vwcAcHxNrGWx8eT8lTC0ybf3Yx7+rcx+ovBKH2fMP1q5s2JxfK20m5SdAiI6On/vY
         fATBE2re/dnWS7NiAPs+/SCgCPy4TGQWR9RA637D36KLRGe52N4zRBO7WYHuLQaUEEgL
         Go/yY7UKmgXQzqPmOAISKIkprbKVsNcdSChkhyc0OWttb5yvS61SxtxdadnRGcb/k5MR
         EwPd/wIeY0v5X5oQ+55PLOMdFt4/Oan5U7d036fLKFbLHgvqPDLWzdH6l1CbHAU4ZMs/
         6y8w==
X-Gm-Message-State: AOAM532Mx+ver+9NoSDpaI4WB7WhNj1rdK6dxFicrLDT11ajEgroAZ4u
        UIxxNen4Rrh57inSEoxal19RBQ==
X-Google-Smtp-Source: ABdhPJzM6sSqhlRvKZoHaTHCB67LhQRuHcOSpewjHrxQxN3l5+JJ6IuUuizN+MmH7IWYXI6gsxrCog==
X-Received: by 2002:a05:6a00:c91:b0:510:73d6:a890 with SMTP id a17-20020a056a000c9100b0051073d6a890mr10685973pfv.42.1652564560673;
        Sat, 14 May 2022 14:42:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b0050dc76281a5sm4083831pfo.127.2022.05.14.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:42:40 -0700 (PDT)
Date:   Sat, 14 May 2022 14:42:39 -0700
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
Subject: Re: [RFC PATCH v2 02/21] arm64/vdso: Filter out CC_FLAGS_CFI
Message-ID: <202205141442.9DBF84F15C@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:40PM -0700, Sami Tolvanen wrote:
> Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> removed from CC_FLAGS_LTO.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
