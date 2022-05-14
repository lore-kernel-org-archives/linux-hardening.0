Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09250C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiENV6A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiENV4x (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:56:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1131526
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:56:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n10so11030570pjh.5
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9B0ELg8h6PY+Vl2TDucjtXSCma3zXaus6HyZVuhPIE=;
        b=W1eubUSb/5LGT0PX48eWAAjFP3e+45qNMMJH5elMun/Sun50qtQzJU6DnSdp6Eg/+a
         sZUGxqEPzvzsqRpYUlnPpUwqsnDjU3f8F0t6paJwsZDv37wZBcBScTKMeytTqcg+gQ85
         fq0u+JX10bVU5Nl4qNuwnXTR65D2Gmk7mjZv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9B0ELg8h6PY+Vl2TDucjtXSCma3zXaus6HyZVuhPIE=;
        b=IEo77JNgE5apq/jagTn37QzPDF49UAnb7Xx3TJLksPe1gcftVPHNgWihIqhFByvJ/9
         +H5MAPUOcRZRiwfKKOBhBXJ0fHiZLToUbF4zVTdJIbJaUP6LgPouyCSYtmHwrmGRvx9D
         8v/6TJjMtIQacxJkcfuPPFF+vtBp9S/K1PcLcAifbNp/xJASQ19i/8in15W9v6t6RstL
         3lRJQv7SmGFY7OzKMgeVSzQTAQXfG5XI9zY4CvBmWACazaWjfhNvKglfolMKGJp424sh
         Q7NfrzItQmDtZ8qaJlp5z46KDupTe9Lw9NmZBkPzJd8su8CDcUvvdoS1hUP4rPAcyigs
         He5A==
X-Gm-Message-State: AOAM532DmPM2BmIWnl/d29A1SUTqd5xOurEQGDRG5SW7Lku24SUKgjHV
        M2WXBFoxO5kR4uMCvX2jgdBL/Q==
X-Google-Smtp-Source: ABdhPJxYql9CKgnQAH/6nysRco+nTc9rw86pT4JEKLv1mVouDl0G3T6mTm3JsTqv8m6tl1+a5OAhsw==
X-Received: by 2002:a17:90b:4f81:b0:1dc:69a0:432b with SMTP id qe1-20020a17090b4f8100b001dc69a0432bmr22733023pjb.203.1652565411533;
        Sat, 14 May 2022 14:56:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b003c14af5060fsm3886055pgj.39.2022.05.14.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:56:51 -0700 (PDT)
Date:   Sat, 14 May 2022 14:56:50 -0700
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
Subject: Re: [RFC PATCH v2 15/21] objtool: Don't warn about __cfi_ preambles
 falling through
Message-ID: <202205141456.72950C77B@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:53PM -0700, Sami Tolvanen wrote:
> The __cfi_ preambles contain valid instructions, which embed KCFI
> type information in the following format:
> 
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...
> 
> While the preambles are STT_FUNC and contain valid instructions,
> they are not executed and always fall through. Skip the warning for
> them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
