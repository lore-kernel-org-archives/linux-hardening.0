Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD8C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiD2X0t (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381502AbiD2X0t (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 19:26:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8385678;
        Fri, 29 Apr 2022 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nw5+DCDAgbYnw63b50aZapwbst9gheKHUiNTK0c+glI=; b=t/y3uaGLkk1K1sDyb2K3Ls7Jxm
        SA51OV1lTHSX4/BOEtThWIa6781axuDGiEaeDs6O3wPUpG8EQVi/6tMv0nA0jv936vLcORWLkRPBL
        ZVQMjCcZCAfbcPRqSG+9bmwOp/fEhakBsm2ItHjmEUtugB/NN0tAcexe1dhBxdx2K9V3GluUu5ALC
        14HWkbywWBtgzR8bJb/YaHTrVxHLB9xiMdaXgG9sL23aoPNHXUHh5Lvn1AIpBg9XKcd/OgUyCTGTM
        qmQYiJuud9mz8aBfDqj1x0YvBIX8yYLj2zXHr1iVlto8RePy2hYCLPRDn9MHSyiFbbKKFNLRFw1oF
        SFU4VHPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkZxC-00CtkK-R2; Fri, 29 Apr 2022 23:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F05D53001EA;
        Sat, 30 Apr 2022 01:23:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E24FE2028F01B; Sat, 30 Apr 2022 01:23:12 +0200 (CEST)
Date:   Sat, 30 Apr 2022 01:23:12 +0200
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
Subject: Re: [RFC PATCH 15/21] static_call: Use cfi_unchecked
Message-ID: <YmxzYAdzom0XOTwa@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:38PM -0700, Sami Tolvanen wrote:
> With CONFIG_HAVE_STATIC_CALL, static calls are patched into direct
> calls. Disable indirect call CFI checking for the call sites with the
> cfi_unchecked macro.

-ENOPARSE

There are no indirect calls.
