Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E7ECAAD3
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiHaS1e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiHaS00 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 14:26:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E7E86B0
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so14198443pgb.4
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=I/i5jIe0pyAtTiwLTepRVRpt6gmHv8ChBfodrmmozEo=;
        b=eSmUjyzYgre0PZ1K00Cfc8tvsDugBnadfNSIUOuoe+VuxkBIDN4sFvali/8YxpY2Yy
         JIo1eombL289lhqWvm4w90+7iwbQTGS8DQI4bTYvXQ2UGf4oRT2v6ha0ViH5ugWvQM94
         yweXGcDiRcyk17EsCOuWNdrpHURxwoyHfpaC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=I/i5jIe0pyAtTiwLTepRVRpt6gmHv8ChBfodrmmozEo=;
        b=xiablBf2VS2AxVK1KjU05/YmOJeOgMY7Qw0DRJgKV5IFuR7lmOGvyeyNF35DGdhI5R
         8EqU2djG0eHf8cK9/Xd8rrSxx7zgTNFJKL99tCHgTP3Q4/M+5Ud4VAo89oSp4iMAnFGd
         utCdrgIMOpUSWhcJIS1ULXxDbqwWp15qMyLupW1NvBjTHgRBn7UEF9nuXhHrJ8EUhtnv
         ZZ24YlA4kscaDObkntcQ2taQhg2RaPwsx9oK1xgx3p2iqDqN95ryYgrDGYB5p5EKI6Or
         7YhOvSi+MZLH9o0mfjYdaR0r+G/9DDBspJTtFv08/Cqy7vW96qTJG1MxrEWqv2Lvh2m5
         yoZQ==
X-Gm-Message-State: ACgBeo0UVbwaXpRCWgKRL8BybSAHycbRCSXIHXJBRJBwZvzMIaOO4XFK
        cfRzPHV/0rNTP5FsNLBq0tzr6Q==
X-Google-Smtp-Source: AA6agR4SBpLEuXeN8GNzl9PJ01BUjf3qaampgOd1NHZi1cFWVwtFCQRkYKzxOrJcywDgmWTUMxK8Ag==
X-Received: by 2002:a63:91ca:0:b0:42b:4847:90dd with SMTP id l193-20020a6391ca000000b0042b484790ddmr22369351pge.28.1661970176454;
        Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7990f000000b0052c849d0886sm11627704pff.86.2022.08.31.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:22:55 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:22:55 -0700
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
Subject: Re: [PATCH v4 08/21] psci: Fix the function type for psci_initcall_t
Message-ID: <202208311122.FA0ECD5782@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
 <20220830233129.30610-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:16PM -0700, Sami Tolvanen wrote:
> Functions called through a psci_initcall_t pointer all have
> non-const arguments. Fix the type definition to avoid tripping
> indirect call checks with CFI_CLANG.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
