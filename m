Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF33C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiENVuK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiENVuI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:50:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F712AF4
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:50:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q18so11079998pln.12
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wUsCnBDPbKVJv+EaQK22IFJZJAmFRuI1WgmUtyrig2Y=;
        b=nA8vOrKYtkCzRykOxnyfADoil/vhGzEfF70wnCDaNvJJi5xuvhhAkbtAFjQwLeFpJS
         1jap5Med/qc57M9VzJiXmB/EA4QArrQBeeuX93F+CfTCQiapplPgFCGvqmsenet4C1Fo
         u8B84Aa7txzzssJbvS8cZtMj8GyAW5qEFMceU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wUsCnBDPbKVJv+EaQK22IFJZJAmFRuI1WgmUtyrig2Y=;
        b=J0qNvoH41R27seO8efLOnFMTtAdmTIFihTSis628VReKE3NqClrkgncNBNA772URvU
         imh3sQ9EWJgJvFljFOfHz0TgXn4CAvkk+3lgo1zXvT85WRFt21I9j1VwGkX34jGo0dJq
         N7OITChL5+ptelMDG7Zc0Uot2g7BBF28KmVrUFrE9t9wIT7o1S5BAmhgADtK7zdIJ2Qo
         7cCN2a4wEdjaWJggjIxKxAYd7ivbzQWs3AGT/Y4Q/koV07cWuSgvMsni/PPExfTt/IDi
         bPEc4XWgL7TX1PP4q1ZddCrxgIGIVM/VjFo14Vzk9MtGd5gZAbt4LsuKuXFJNSIKGYIm
         4Xng==
X-Gm-Message-State: AOAM532H8gLwXKd698w6o3MzcprIsE3z1ewQIx07DRqkzmHmAPxpLUHZ
        7Xkuegn8MiIo5xR4KMyeh6JX+g==
X-Google-Smtp-Source: ABdhPJw2E4A+XrCLXCnm95DuJx6yjrgtSzMtn/EEPgJ80ptCzVUybF5Z7bgAS+rJxfbXjJ5+NcMoMw==
X-Received: by 2002:a17:90b:3d90:b0:1df:70c:c65f with SMTP id pq16-20020a17090b3d9000b001df070cc65fmr5818574pjb.238.1652565005959;
        Sat, 14 May 2022 14:50:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b0050dc76281a3sm4037702pfj.125.2022.05.14.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:50:05 -0700 (PDT)
Date:   Sat, 14 May 2022 14:50:05 -0700
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
Subject: Re: [RFC PATCH v2 08/21] psci: Fix the function type for
 psci_initcall_t
Message-ID: <202205141449.87738FDF@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:46PM -0700, Sami Tolvanen wrote:
> Functions called through a psci_initcall_t pointer all have
> non-const arguments. Fix the type definition to avoid tripping
> indirect call checks with CFI_CLANG.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This could land separately from this series, too, yes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
