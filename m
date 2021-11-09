Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE2C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Nov 2021 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4261761078
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Nov 2021 18:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhKISPh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239343AbhKISPg (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Nov 2021 13:15:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39BC66113D
        for <linux-hardening@vger.kernel.org>; Tue,  9 Nov 2021 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636481570;
        bh=HeCI9HJjEs68l1v4UQ2VMX/NbUkAiaGgAWOojRjWMGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=avu0WLF+LDCW3nX2QtTmdAUjZtKsa7hfRbU/J1AOZFIH+AsLPDLMEAC0XWZADRRIe
         66jIR56Dg/bcGy3z3OMC5aOghBNQ6K9xHoXEq732s/2Co+98LjmldNhqt0HILO+JPd
         LNrVs5GUC2+MDDbaGTUpyJLYoKsOqOBDPEx8GmiGqIMzWqf17kjqkSjsJgciAhwyyM
         3ndQdNDQE0aqr+XYEGNYaJKZl0O+6jjAAr8SHvXmgr6OyC20qZB5uwTBl5EamioFc6
         m+nuKr7w2q8sW8p5i0hY4Kgz3FntLkfyWP8MWOKcOOnwu1bvJgOGRLiwvuMqt3j549
         upvABQTs8Rvog==
Received: by mail-oi1-f172.google.com with SMTP id bk14so189961oib.7
        for <linux-hardening@vger.kernel.org>; Tue, 09 Nov 2021 10:12:50 -0800 (PST)
X-Gm-Message-State: AOAM530baQUwMwJIJwpVUF39UrLkWx4h4mQIivG+fY8S0Ec5lMQRTZqz
        amWAsze/YyGKRIeA7Q9OHfDcky+yPug3mVWdBUE=
X-Google-Smtp-Source: ABdhPJxDuoRdtyiw4UJgaSwI/K6KdSVDjyNHPwQql+UADMAoDb8g2G/BhzxQ3RNuct1ceNHP38emUMqZBFzKjUnvV4M=
X-Received: by 2002:aca:ad95:: with SMTP id w143mr6456444oie.47.1636481569516;
 Tue, 09 Nov 2021 10:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20211028112703.1120709-1-ardb@kernel.org>
In-Reply-To: <20211028112703.1120709-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 19:12:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVBg7uvYhoeav6KDKb45b4fMeCB3SQmYkJtUPyCRSDRg@mail.gmail.com>
Message-ID: <CAMj1kXEVBg7uvYhoeav6KDKb45b4fMeCB3SQmYkJtUPyCRSDRg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] implement TLS register based stack canary for ARM
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 28 Oct 2021 at 13:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102352
>
> In the Linux kernel, user processes calling into the kernel are
> essentially threads running in the same address space, of a program that
> never terminates. This means that using a global variable for the stack
> protector canary value is problematic on SMP systems, as we can never
> change it unless we reboot the system. (Processes that sleep for any
> reason will do so on a call into the kernel, which means that there will
> always be live kernel stack frames carrying copies of the canary taken
> when the function was entered)
>
> AArch64 implements -mstack-protector-guard=sysreg for this purpose, as
> this permits the kernel to use different memory addresses for the stack
> canary for each CPU, and context switch the chosen system register with
> the rest of the process, allowing each process to use its own unique
> value for the stack canary.
>
> This patch implements something similar, but for the 32-bit ARM kernel,
> which will start using the user space TLS register TPIDRURO to index
> per-process metadata while running in the kernel. This means we can just
> add an offset to TPIDRURO to obtain the address from which to load the
> canary value.
>
> Changes since v3:
> - force a reload of the TLS register before performing the stack
>   protector check, so that we never rely on the stack for the address of
>   the canary
> Changes since v2:
> - fix the template for stack_protect_test_tls so it correctly conveys
>   the fact that it sets the Z flag
>
> Comments/suggestions welcome.
>
> Cc: Keith Packard <keithpac@amazon.com>
> Cc: thomas.preudhomme@celest.fr
> Cc: adhemerval.zanella@linaro.org
> Cc: Qing Zhao <qing.zhao@oracle.com>
> Cc: Richard Sandiford <richard.sandiford@arm.com>
> Cc: gcc-patches@gcc.gnu.org
>

Note to reviewers: this feature has been accepted in LLVM/Clang, and
so the exact command line options introduced by this patch to enable
this feature can no longer be changed easily. I don't expect this to
be an issue, given that they are the same as x86, but I thought I
should note it nonetheless.
