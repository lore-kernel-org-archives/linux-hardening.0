Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1BC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiD2XZP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiD2XZO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 19:25:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B9C6159;
        Fri, 29 Apr 2022 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GuE59RNYBcSn7YxgPNLjHOdq2pqA9HQAGI3HMZ8V3bA=; b=Mg6soHH5neJME8iJ1TwIkua8FK
        4tj0TafDVMPpeqLC33cK1YvHmi7JKaWuMNmUIkVN7Y5J9FG967oWK9ZMRBXuyLwz3coHcpSnYUi+S
        qhtN1hnGwCbfWy13sN3Rb4aNTkWYbehc3ihRODwUTj8ysjEiGmXzA4lrwdgXtQ6bq+ELPHbxUOM+B
        6IFDD+ykq2CD1tvoNT307XYOgsBkVrEz2iS3Xrn1sDUIH1xX/aNS2ggcoVsZ0xk3+6lylomVF2OLm
        J9fk2qe3YH1VFmcfT3hTEdUBxC7MYdG8CFqTEqrNUPkmbgLPHUoP0VcyhXhwBVhzxJqlkbr033Ii+
        g/4U+wQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkZvZ-009j5m-Ls; Fri, 29 Apr 2022 23:21:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8436300385;
        Sat, 30 Apr 2022 01:21:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CEFA2028F01B; Sat, 30 Apr 2022 01:21:32 +0200 (CEST)
Date:   Sat, 30 Apr 2022 01:21:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
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
Subject: Re: [RFC PATCH 14/21] treewide: static_call: Pass call arguments to
 the macro
Message-ID: <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:37PM -0700, Sami Tolvanen wrote:
> Include the function arguments in the static call macro to make it
> possible to add a wrapper for the call. This is needed with
> CONFIG_CFI_CLANG to disable indirect call checking for static calls
> that are patched into direct calls at runtime.
> 
> Users of static_call were updated using the following Coccinelle
> script and manually adjusted to preserve coding style:
> 
>   @@
>   expression name;
>   expression list args;
>   identifier static_call =~ "^static_call(_mod|_cond)?$";
>   @@
> 
>   - static_call(name)(args)
>   + static_call(name, args)

Urgh, sadness.. I worked so hard to get away from that terrible syntax.

Can you explain why this is needed? I don't think there are any indirect
calls to get confused about. That is, if you have STATIC_CALL_INLINE
then the compiler should be emitting direct calls to the trampoline.

At no point will there be an indirect call.
