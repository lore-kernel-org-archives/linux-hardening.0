Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B46C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiENVus (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiENVur (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:50:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B413CE0
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:50:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v10so10658982pgl.11
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+6DXPA/etQO+MROO0HlzYfznWa6yuzqrt1lFu+IZCU=;
        b=X46GUAIQhLZgbIbW3ALwg7mUAi9aD9nKapR3TAoFkfjTlqeeHuVMk1gIo1XQ0yhsdL
         N0hnyu4RWWhHM3wtF0iEMRxtXOU5NkFees7jAbHlv51A9j241elTXlQkZcd3ZBf54JuI
         QmQxGgU2qsxD6sDjGZsdeqw6FNs+bdOxLbp9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+6DXPA/etQO+MROO0HlzYfznWa6yuzqrt1lFu+IZCU=;
        b=A4Uf57sBDwC/ICHjFgvJZmtUMoTXPNQBtZCpJ/Xfa11LCtraQVRWtxBwaeDpepujMa
         JorscTG4HS7p2+uCs1bKrO0Su3sIouM9XBLtkgxezoNrCF+ZY0fbj6j6TVglKvlGJxvV
         4wDH5wWToepRscaBSXMVYAo7dk9TPf5rT6C6bncJ9SToGTAYffNs6mGu7X5KwWs9GmBJ
         LQccltNiCJE+0irEJ+Ss0wsLGVvVkmwv1M/Wq9Vqxtn3CPeKroQt79JZWYdjuXR52NrU
         Hi0HAez2E2vJh25TeH23RspDVn/jWXJ2cOHMRVHE+he2dp4bPQ4Cx1sUTqFaPKrFtyWf
         Tnsg==
X-Gm-Message-State: AOAM532N0NXDXwxDO/zAagZ2L0mfRALjgXXe7HWygVkK1KMc3c1N3BTH
        2Sg/ge0vzZVOjOqBb/Iza6LzaldESVTRIw==
X-Google-Smtp-Source: ABdhPJyKT2rYy5VGyrBn24YvTCGmr7LDXKmlZ9vWWFE2j7T4CYJuXCvTnF4P3WJsCwUHfcUj11JmLg==
X-Received: by 2002:a05:6a00:1709:b0:505:fa47:b611 with SMTP id h9-20020a056a00170900b00505fa47b611mr6064948pfc.65.1652565045739;
        Sat, 14 May 2022 14:50:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b0015ea95948ebsm4116861plj.134.2022.05.14.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:50:45 -0700 (PDT)
Date:   Sat, 14 May 2022 14:50:44 -0700
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
Subject: Re: [RFC PATCH v2 09/21] arm64: Add types to indirect called
 assembly functions
Message-ID: <202205141450.C5287B6@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:47PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions indirectly called from C
> code must be annotated with type identifiers to pass CFI checking. Use
> SYM_TYPED_FUNC_START for indirectly called functions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Sort of related to my question about SYM_TYPED_FUNC_START itself, how
were these cases identified?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
