Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E158ECAAD3
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 18:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiHaS2U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiHaS1s (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 14:27:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD25104010
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:23:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l5so11034226pjy.5
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fS7xlk8exOPxYXHFLdn8iabPIslSYjRlhaKGdRBrbZw=;
        b=MNJusS+5Xh80LA5c1pprHLLub+S28s+9/p/b/OOz7IAJSptPqkqQlXfv5FO9nna7My
         MOnGz7gea2rJeQf4IClBH2ymUQoF910kZAFSn4Op4vV9G0z3m5++AuppB6fHkfzGO741
         uZaElfhQRXmG5iRG0vhJY3t97cmpA8p041qGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fS7xlk8exOPxYXHFLdn8iabPIslSYjRlhaKGdRBrbZw=;
        b=YeiNW+t8Mx9Uo6/qLhd+RM27IF81jxNOOFDSh8VF+G7fwm6N6o2Of+YcESYXYosdec
         cpd1DEqdCL1mVz3Sa4WAAmuaLntqJy7KSDgrTNu9HnE0uNUw5hG9r5HzObPT1swQtsRM
         LgVnBev0mwLeQu/xxpVqgld70I65Ixyks/N75PHnW+BtpzLqJ7kHtfLX/faAPnQRja1g
         orXLiGsZ0inaT+b2Vt9Hb+GJXim7Q+gqH3QqGit50zs2bYSA2MYt6BjW1K6u926X44wL
         inyzzhV58sH40Yi2rUojXJUSoHC62WnzxC9FQalHgcT+3bV1CWv17eMI3Ee0arrexS4F
         EWcA==
X-Gm-Message-State: ACgBeo0YhdRPAPVL+ngATyB2pO7fieNKZe+ZcMaAU7JsLtauJEYQSeiB
        nMPovgZwScVWlgm5qOwZfcuBLA==
X-Google-Smtp-Source: AA6agR6p0pm5G+0tEg3FHLipUz0PBlM7zrfbRO94La2RKxHAydUxfZxpVV8PdPYV5O1NMEFkLbhxJA==
X-Received: by 2002:a17:90b:3803:b0:1fa:ebea:e90e with SMTP id mq3-20020a17090b380300b001faebeae90emr4544973pjb.111.1661970215991;
        Wed, 31 Aug 2022 11:23:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a170900b001fe136b4930sm1590311pjd.50.2022.08.31.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:23:35 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:23:34 -0700
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
Subject: Re: [PATCH v4 16/21] objtool: Disable CFI warnings
Message-ID: <202208311123.CFD2B1B9@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
 <20220830233129.30610-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:24PM -0700, Sami Tolvanen wrote:
> The __cfi_ preambles contain a mov instruction that embeds the KCFI
> type identifier in the following format:
> 
>   ; type preamble
>   __cfi_function:
>     mov <id>, %eax
>   function:
>     ...
> 
> While the preamble symbols are STT_FUNC and contain valid
> instructions, they are never executed and always fall through. Skip
> the warning for them.
> 
> .kcfi_traps sections point to CFI traps in text sections. Also skip
> the warning about them referencing !ENDBR instructions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
