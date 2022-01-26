Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFAC2BA4C
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 11:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiAZLJi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:09:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33308 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiAZLJ2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 06:09:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1067618B6
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 11:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DCAC340E8
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643195367;
        bh=6QZTVPS0GwztJKGpfky2ql+3Bz3pnwXtia6ts3FYbqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qRmZPk0/toz2j0j+EkrkqC4HrQ9coAUSwG7p/+kxi3ITedymeSol/Zudj58N2HB+F
         3hvzJ2CjJEsa62Li3afJeHPwF2ePo5borPsU9MV9QY9Hv10A+xK5XfvTG11ZfXxyl8
         QAlbuRon49iiF2a43tNNnawFl44YkYKIns4MgFEB71+N7rk2N1yYIb1a0yDaEg9x5g
         9tG1Ttyn9HFLj5jobNK4rZjlfpcYNhDiQDE7ws0N0sXD2lFpeLk3uPg2m1SCp4fMXa
         8RrlRn+N1zXywgxVMvfBSi3lo4uTCYJhanSzUYRGNxvF46k0tpOe2ufXt9lBxbxVyn
         AkUyZroGpkUYQ==
Received: by mail-wm1-f48.google.com with SMTP id c2so27432016wml.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 03:09:27 -0800 (PST)
X-Gm-Message-State: AOAM532DSfPNfFFBCGStg34wtwYzJN+HGyJVbUTSAAgBmbnlCKp3R8FS
        4iODIUCIjZ9qjqtv3IOK3rQ29Wl0bNKOAmbwSpA=
X-Google-Smtp-Source: ABdhPJxHGoNOqp7byhcjthmQxC7dNBsYGJwvkmVQlUaO2dDSztPJSWsL/Mde2YfnmGWYzU2NZ5Ofv2IHaXi6bz6ORkc=
X-Received: by 2002:a05:600c:4b95:: with SMTP id e21mr6931788wmp.106.1643195365711;
 Wed, 26 Jan 2022 03:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <81d54b71-7c9c-47ef-ac8d-72aae46cd4ee@linux.alibaba.com> <mptk0euk42w.fsf@arm.com>
 <a9daf6bf-94f2-0c5f-b9aa-7fb69781c9d5@linux.alibaba.com> <mpto840kti9.fsf@arm.com>
 <3ae4a533-352b-f3e3-27b3-9386df5f56c3@linux.alibaba.com> <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
 <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com> <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com>
In-Reply-To: <3f2027af-bbe0-f46f-2ceb-bffc4bbbf70e@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Jan 2022 12:09:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEdTR_Rna1pP9gHH5hLk_3k7=7u2wC_VnxzrddZaU66Tg@mail.gmail.com>
Message-ID: <CAMj1kXEdTR_Rna1pP9gHH5hLk_3k7=7u2wC_VnxzrddZaU66Tg@mail.gmail.com>
Subject: Re: [PING^3][PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        marcus.shawcroft@arm.com, Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        hp@gcc.gnu.org, Nick Desaulniers <ndesaulniers@google.com>,
        nsz@gcc.gnu.org, pageexec@gmail.com, qinzhao@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        linux-hardening@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 26 Jan 2022 at 11:40, Dan Li <ashimida@linux.alibaba.com> wrote:
>
> Thanks, Ard,
>
> On 1/26/22 00:10, Ard Biesheuvel wrote:
> > On Wed, 26 Jan 2022 at 08:53, Dan Li <ashimida@linux.alibaba.com> wrote:
> >>
> >> Hi, all,
> >>
> >> Sorry for bothering.
> >>
> >> I'm trying to commit aarch64 scs code to the gcc and there is an issue
> >> that I'm not sure about, could someone give me some suggestions?
> >> (To avoid noise, I did't cc PING^3 [1] to the kernel mail list :) )
> >>
> >> When clang enables scs, the following instructions are usually generated:
> >>
> >> str     x30, [x18], 8
> >> ldp     x29, x30, [sp], 16
> >> ......
> >> ldp     x29, x30, [sp], 16              ## x30 pop
> >> ldr     x30, [x18, -8]!                 ## x30 pop again
> >> ret
> >>
> >> The x30 register is popped twice here, Richard suggested that we can
> >> omit the first x30 pop here.
> >>
> >> AFAICT, it seems fine and also safe for SCS. But I'm not sure if I'm
> >> missing something with the kernel, could someone give some suggestions?
> >>
> >> The previous discussion can be found here [1].
> >>
> >> [1] https://gcc.gnu.org/pipermail/gcc-patches/2022-January/589257.html
> >>
> >
> > As was pointed out in the discussion, binary patching is in fact a
> > concern for the Linux kernel. E.g., Android uses generic binary
> > builds, but we would like to be able to switch between pointer
> > authentication and shadow call stack at boot time, rather than always
> > support both, and take the SCS performance hit on systems that
> > implement PAC as well.
> >
> > However, it seems more straight-forward to patch PACIASP and AUTIASP
> > instructions into SCS push/pop instructions rather than the other way
> > around, as we can force the use of these exact opcodes [in the NOP
> > space]), as well as rely on existing unwind annotations to locate any
> > such instruction in the binary.
> >
>
> Well, then I think I don't need to submit a kernel patch to
> enable SCS for gcc :)
>

Not entirely.

> BTW:
> Do we have a plan to submit patches of dynamic patch PAC into
> the kernel recently?
>

At the moment, there are just some ideas floating around. I did
implement a proof of concept that uses unwind data, but it hit some
issues with cfi_negate_ra_state being emitted imprecisely (GCC) or not
at all (Clang) in some cases. Using objtool would be another
possibility.

So in summary, getting SCS support proper into GCC is definitely worth
the effort.

-- 
Ard.
