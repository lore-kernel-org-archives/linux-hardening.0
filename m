Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A0C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Apr 2022 00:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379927AbiD3AxS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 20:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiD3AxR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 20:53:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF74D265
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 17:49:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f83983782fso101233837b3.6
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9Y7U0wTKqKyrzCZ5VtAbMiTlejqirW8gTMxmJkTfiA=;
        b=o904YtYKww9l65iOnpFttd2oN+roVVJk4YvsnVIJZjXPGnvk61QhExALxCRC4rOedS
         GZ+fEIz4xNSI4vgwWDhEYwf63lfKesGr31yZNfmw+UXEX9XN/y2wAhsIjWCitplmO4ps
         8JTE/bKIyu2Jm+PEDZiXmNfTMKnVsLhQOq62VLJ4/GgKGeiH6TciRzAU6SsdTfIYcJER
         3BHGtLCXph4PQRO9JLg1+n+i6SRl5zEq6LVsT2vXCl1IbFZA5JBiHGbCTkleXv53Ljbs
         eh5U/POqRL31KOiefyvGXo2puzoXdUfX+v/WX7nlyz/6NPUWqBhPoK3P/gCH2Cg0mxKY
         c5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Y7U0wTKqKyrzCZ5VtAbMiTlejqirW8gTMxmJkTfiA=;
        b=c2bagvQtsp62hPS4YYuVfnA/nCz1gLw3U7a5Wb4DLlAYQOjfTe75phrRat1M6rPlRh
         n5IDdWSsCVbEoPhT07cLm1gW747etoK9+K2PnckyzKepPk/MKXmUyw/lBMKH2/oDq4Oe
         OwBHkf9CVQeMC3NSgujWXNV6xvCjiF9Ddl8qfOBmEj6hMpc/sR3RdiRdRC5Ja5kdco6h
         agO170hmQE6MlRoAfDwXO6xJOVCpNdL8Lai9fAQ608STHFufKGw8vv5PUIa34wPN/fy8
         XZCwdUEeifAEjQprymNm0YIvoRo0XAapi8Zqk0PAXa8fYsmXy2clS9JDA8fRL5omHFpm
         Urmg==
X-Gm-Message-State: AOAM533HG+rOh+8Q7SA8BSo9XlbZMJtxv1QgVaFzS1QwT/h4MM+uiNo+
        heuwb8440bmdzA2Jcov/EphtQlbAjlXx2e1bYqpnHQ==
X-Google-Smtp-Source: ABdhPJwgM0DU8R1vt+rPUv9v3MVwX19+YnYIl4ZgilTxVCVrF9omxoBF3LL/7AkmrlziboUU9RSRxP5sBIMxP78CMas=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr1937122ywk.243.1651279796955; Fri, 29
 Apr 2022 17:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-15-samitolvanen@google.com> <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
In-Reply-To: <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 29 Apr 2022 17:49:21 -0700
Message-ID: <CABCJKud8vC6RwQLs2YXnZMZaXGNYBEq+sNmOsgGjjAw4MfuZuw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/21] treewide: static_call: Pass call arguments to
 the macro
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 29, 2022 at 4:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Can you explain why this is needed? I don't think there are any indirect
> calls to get confused about. That is, if you have STATIC_CALL_INLINE
> then the compiler should be emitting direct calls to the trampoline.

Clang emits an indirect call for ({ &f; })(), which is optimized into
a direct call when possible. Come to think of it, the recent
InstCombine change to the compiler patch should solve this issue. Let
me double check, I'd be more than happy to drop these two patches.

Sami
