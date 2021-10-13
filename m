Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D15C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DB960E96
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJMTF2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhJMTF2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 15:05:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FDC061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:03:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n11so2479686plf.4
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iv6F8EdUVptzUcmUANbF0d3VY4H4nepm9NcMDwb+Q2M=;
        b=QCqvZgQSjJeThpfGG6mDINdKSxpEJde0lHGEs529BoaLFmGKSSa9/BwOze1gFeBrkc
         lLVjTB5wROe00bVWuz94F+yf4Q8zhyBUKuijtUfRhp8lL91hUJWMFemYgH97mMeJfU8D
         HnOrgKGJr4OybKcAM1oP7lCM7jrqjiU6yWgkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iv6F8EdUVptzUcmUANbF0d3VY4H4nepm9NcMDwb+Q2M=;
        b=JfEY+srJ4pFEmLJ4sY9C3OYdSOvWa4SUybrJ/d4gPqsJ1BmbpAWhg9cnPxc5UbC3he
         /QuGgBVKI+iO4rYm3CmIovPDeYvO582XpoKBZka/+qOiWUrcZmELcnPbMNnyBy8CBSFC
         hhwkU9/ZWpb4iJfNMz7hOAz8USC+VRS57uhiuWMt7Xa3yLhxa0fr6xBc8J06u4YQyT2z
         MfwvJBEmu+KXwAao6i/hCGZfT8EncmnWlo7M6aOaiC8K6fXU7XYvArfGvqIUT3gX0bPI
         zs71mYtKUKS/qdmWckasZBrZZNkZi/RHOlBHzS7p5325oubF38gUzFARMJUKlC+pIRiE
         ZxIw==
X-Gm-Message-State: AOAM532qBoIMyVhB39TseTvnnOXAcqkNONzjrT52UZHkbArJ825AlHZv
        gMKoVN6UdHI3VpKR0+D6/izOPw==
X-Google-Smtp-Source: ABdhPJybFKFUEUtMWbN9X9Wd7+oHR82JGwqbytlB4hKD6IKyhNeTw4u55lNMXBn2h9uN5t6kBfV/0A==
X-Received: by 2002:a17:902:c409:b0:13f:1a43:c5c with SMTP id k9-20020a170902c40900b0013f1a430c5cmr931113plk.40.1634151804483;
        Wed, 13 Oct 2021 12:03:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm7143151pjh.0.2021.10.13.12.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:03:24 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:03:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 05/15] tracepoint: Exclude tp_stub_func from CFI
 checking
Message-ID: <202110131203.78C3851CA9@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:48AM -0700, Sami Tolvanen wrote:
> If allocate_probes fails, func_remove replaces the old function
> with a pointer to tp_stub_func, which is called using a mismatching
> function pointer that will always trip indirect call checks with
> CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> tp_stub_func to allow it to pass CFI checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
