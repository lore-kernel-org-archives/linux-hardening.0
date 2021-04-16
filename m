Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_SECURITY,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C77DC433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15DB611AF
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhDPWN4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:13:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDPWN4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:13:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618611209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfOo0OteF00ZxNk4tUH5JwKaUxTTUHXfQsULrq8CSaA=;
        b=nKJUfgNOKbvZ5e5W6fqauqp/GpXbABoACYclVK7RtGRKnJwVkbPDiKNhAxzM0tv7JenO1c
        HW8DcetSVRZ2mmBk+hjbmYy82+ZIPIxi05o9/cwv9jQqe7tXQOG46JfLDgi2kWTfmCmxFX
        Ozm8Gy+yNDiZ6qanLf+cIkKPE7QunPhpRjlXA3cyIzQV8Liqd7EPoh45JVcP2YK1tNnwu6
        OXwBTZz+GqQubx2Eclf401NSp9EQi+Yt8LM3/vmqJcdy2x6fPEx1bR1O7YNgkrxyRzQtKc
        kMLKtOe2FBOMG+ExFUFu8GfKioxOL+TXb4dv+e2F0u2LeBfdG8RcNFvw4xBQ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618611209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfOo0OteF00ZxNk4tUH5JwKaUxTTUHXfQsULrq8CSaA=;
        b=//3+6Y0vYzFHv2Ip8Eph+x5NmhNIgzFNp/SudAgIq8Cr2MkL22VqiJADgaM+DK3rGfuNyj
        BCYuyKVBUh7HREAA==
To:     Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
In-Reply-To: <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic> <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
Date:   Sat, 17 Apr 2021 00:13:29 +0200
Message-ID: <87mttxubcm.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 14:49, Sami Tolvanen wrote:
> On Fri, Apr 16, 2021 at 2:18 PM Borislav Petkov <bp@alien8.de> wrote:
>> In file included from ./include/linux/ftrace.h:22:0,
>>                  from ./include/linux/init_task.h:9,
>>                  from init/init_task.c:2:
>> ./include/linux/ftrace.h: In function =E2=80=98ftrace_init_nop=E2=80=99:
>> ./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of fun=
ction =E2=80=98function_nocfi=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>
> This is defined in linux-next, but I do see another issue, which I'll
> fix in v2. Note that CFI_CLANG itself cannot be selected on 32-bit
> x86.

Sure and because of that it's overrated to make sure that it does not
break the build. I know, sekurity ...

But aside of that when looking at the rest of the series, then I really
have to ask whether the only way to address this is to make a large
amount of code unreadable like this:

-	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
+	wrmsrl(MSR_LSTAR, (unsigned long)function_nocfi(entry_SYSCALL_64));

plus a gazillion of similar changes.

This is unreadable garbage.

Thanks,

        tglx




