Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5BC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 15 May 2022 03:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiEODTy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 23:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiEODTx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 23:19:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075191903B
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 20:19:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y41so11084382pfw.12
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MEi80uS+Hv7whcnPDmWumoTBr+8suRXlPOFaSGMgA4w=;
        b=k2E2gWVeuIcJmXctth50gI+JpHO8Jdri7XEy81BsIY5b7LBB+U+mfEZEpjht24f6UP
         dpH1IzclL/xXavJ7dhUZAwraqMh5bh6+PNchYFKigMWuFKoAjMlY5pRxsSmlGENEVH77
         eDbavVNzNaxKdVIVDHOBiq7SWRKR8gbONOzLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MEi80uS+Hv7whcnPDmWumoTBr+8suRXlPOFaSGMgA4w=;
        b=MmOfoCv3pruaXJbGpI+baaNa1LGT1bQfjPooK8+fZMTu7GSfYvnJqTEoQBiawn6K/t
         zZXZkAXneqTveZPb9TW2dIFQMrnnbXdEI6sMLZhhbiRXLZ7D9F3zmund+BOSya+G9Re8
         vNYcTAQ+zRIonWxOKNCWtqiGN8dqDkaIp3bgFeSb9lvRBlEFo08GoPI8OYl9BcFM99c4
         Jnd0+x3qZNfmOinWlNU11T54ywI+qeS7+47cPcYsNSznOGYLosgTyWFUehAnd0twwDxV
         uXVko7+BlUU0q6K7vcbcgeZh2xXXkadzYDNxRK5pD0gPYMX4R8OnDyGIxPLvVg0yHpYM
         JALg==
X-Gm-Message-State: AOAM531RYZubAbnq37MmIcUzLK8gVSDzddkLZAFvi5B/YkYjqADDR7e0
        hfP6O6ud3unCHaRUFgGRdWGoJg==
X-Google-Smtp-Source: ABdhPJwR7XZOxJrS4oIzgQbamR8MN0/jGNaXZitp2YdTHflXf1xkjcnFI+uVSj0ggVkl4+1JzhTJtw==
X-Received: by 2002:a63:8843:0:b0:3da:fe5c:9374 with SMTP id l64-20020a638843000000b003dafe5c9374mr10329905pgd.342.1652584791498;
        Sat, 14 May 2022 20:19:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b0015e8d4eb27csm4411356plg.198.2022.05.14.20.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 20:19:51 -0700 (PDT)
Date:   Sat, 14 May 2022 20:19:47 -0700
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
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <202205142016.DB5DB8638A@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513202159.1550547-21-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler injects a type preamble
> immediately before each function and a check to validate the target
> function type before indirect calls:
> 
>   ; type preamble
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...
>   ; indirect call check
>     cmpl    <id>, -6(%r11)
>     je      .Ltmp1
>     ud2
>   .Ltmp1:
>     call    __x86_indirect_thunk_r11
> 
> Define the __CFI_TYPE helper macro for manual type annotations in
> assembly code, add error handling for the CFI ud2 traps, and allow
> CONFIG_CFI_CLANG to be selected on x86_64.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks good testing with LKDTM...

$ echo CFI_FORWARD_PROTO | cat >/sys/kernel/debug/provoke-crash/DIRECT
[  144.084017] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[  144.086138] lkdtm: Calling matched prototype ...
[  144.087833] lkdtm: Calling mismatched prototype ...
[  144.089777] CFI failure at lkdtm_CFI_FORWARD_PROTO+0x34/0x67 [lkdtm] (target: lkdtm_increment_int+0x0/0x7 [lkdtm]; expected type: 0x7e0c52a5)


Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
