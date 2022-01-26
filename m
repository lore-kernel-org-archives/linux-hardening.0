Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82845C2BA4C
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 08:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiAZIKc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:10:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44922 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiAZIK3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 03:10:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6F160E9A
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 08:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FCCC340EC
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643184628;
        bh=m6jmMUrtXjuve4xSGCkHW0qzA9qCTZGzv3j080eNgs0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bLMzenNYtzePxpJEQX+9B76gD6z8tV0bMbXuQr8JjVsLt5MShWBHmmKslDkRzSfll
         JiL5m8rUE6yf6q7TlvgwbpzwUP8+MIYNkVmVRzqHK1rd5e8fEn+pINXOqvjIuHynha
         zRPU6V1y/N17EDAjtdYFzBtCOQXkLiWX9UVyatdJYpsH2AWeM8ktnBzlUkBc3UosOf
         Wgxs/V7YFP0mlEENkkShBZYoawBelSgNDd/e6mtz90NBO6VCqAZ5oEX/8xSLj5UIyQ
         LEXRDosyvBWbYOav8Ku+Zw9g0MAuYb2sjOWCJD1WjdofNoCMe6QqT6qC+8wtSanLsh
         T2owKsgSi7Mwg==
Received: by mail-wr1-f49.google.com with SMTP id e8so22442047wrc.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 00:10:28 -0800 (PST)
X-Gm-Message-State: AOAM532fMS5kROw6+yH64kcJ3nMn3KCjGTmbPp/7bucZ1epLE4j+o8ai
        4Cpt1R2OitML7fLSwzTIw2A3aZ4/s9l0gRKg9IU=
X-Google-Smtp-Source: ABdhPJx225nJ83tFw4hU0hQyFpCWaHLWNYLGf/dzu9EUFDePikCtbiapak+Opm8wAQmOjRBSOrYfTBy2mDnMuILD+Zg=
X-Received: by 2002:a5d:6210:: with SMTP id y16mr20243412wru.454.1643184626516;
 Wed, 26 Jan 2022 00:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <81d54b71-7c9c-47ef-ac8d-72aae46cd4ee@linux.alibaba.com> <mptk0euk42w.fsf@arm.com>
 <a9daf6bf-94f2-0c5f-b9aa-7fb69781c9d5@linux.alibaba.com> <mpto840kti9.fsf@arm.com>
 <3ae4a533-352b-f3e3-27b3-9386df5f56c3@linux.alibaba.com> <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
In-Reply-To: <61acb6f4-9a86-ddad-e48c-c68e4bcb08f1@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Jan 2022 09:10:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
Message-ID: <CAMj1kXG5oSo0Z+bEjExaaG6Y942R7fiL0fDKH59RETS=G4jDoA@mail.gmail.com>
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

On Wed, 26 Jan 2022 at 08:53, Dan Li <ashimida@linux.alibaba.com> wrote:
>
> Hi, all,
>
> Sorry for bothering.
>
> I'm trying to commit aarch64 scs code to the gcc and there is an issue
> that I'm not sure about, could someone give me some suggestions?
> (To avoid noise, I did't cc PING^3 [1] to the kernel mail list :) )
>
> When clang enables scs, the following instructions are usually generated:
>
> str     x30, [x18], 8
> ldp     x29, x30, [sp], 16
> ......
> ldp     x29, x30, [sp], 16              ## x30 pop
> ldr     x30, [x18, -8]!                 ## x30 pop again
> ret
>
> The x30 register is popped twice here, Richard suggested that we can
> omit the first x30 pop here.
>
> AFAICT, it seems fine and also safe for SCS. But I'm not sure if I'm
> missing something with the kernel, could someone give some suggestions?
>
> The previous discussion can be found here [1].
>
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2022-January/589257.html
>

As was pointed out in the discussion, binary patching is in fact a
concern for the Linux kernel. E.g., Android uses generic binary
builds, but we would like to be able to switch between pointer
authentication and shadow call stack at boot time, rather than always
support both, and take the SCS performance hit on systems that
implement PAC as well.

However, it seems more straight-forward to patch PACIASP and AUTIASP
instructions into SCS push/pop instructions rather than the other way
around, as we can force the use of these exact opcodes [in the NOP
space]), as well as rely on existing unwind annotations to locate any
such instruction in the binary.

So omitting the load of X30 from the ordinary stack seems fine to me.

> On 1/25/22 22:51, Dan Li wrote:
> >
> >
> > On 1/25/22 02:19, Richard Sandiford wrote:
> >> Dan Li <ashimida@linux.alibaba.com> writes:
> >>>>> +
> >>>>>       if (flag_stack_usage_info)
> >>>>>         current_function_static_stack_size = constant_lower_bound (frame_size);
> >>>>> @@ -9066,6 +9089,10 @@ aarch64_expand_epilogue (bool for_sibcall)
> >>>>>           RTX_FRAME_RELATED_P (insn) = 1;
> >>>>>         }
> >>>>> +  /* Pop return address from shadow call stack.  */
> >>>>> +  if (aarch64_shadow_call_stack_enabled ())
> >>>>> +    emit_insn (gen_scs_pop ());
> >>>>> +
> >>>>
> >>>> This looks correct, but following on from the above, I guess we continue
> >>>> to restore x30 from the frame in the traditional way first, and then
> >>>> overwrite it with the SCS value.  I think the output code would be
> >>>> slightly neater if we suppressed the first restore of x30.
> >>>>
> >>> Yes, the current epilogue is like:
> >>>       .......
> >>>       ldp     x29, x30, [sp], #16
> >>> +   ldr     x30, [x18, #-8]!
> >>>
> >>> I think may be we can keep the two x30 pops here, for two reasons:
> >>> 1) The implementation of scs in clang is to pop x30 twice, it might be
> >>> better to be consistent with clang here[1].
> >>
> >> This doesn't seem a very compelling reason on its own, unless it's
> >> explicitly meant to be observable behaviour.  (But then, observed how?)
> >>
> >
> > Well, probably sticking to pop x30 twice is not a good idea.
> > AFAICT, there doesn't seem to be an explicit requirement that
> > this behavior must be followed.
> >
> > BTW:
> > Do we still need to emit the .cfi_restore 30 directive here if we
> > want to save a pop x30? (Sorry I'm not familiar enough with DWARF.)
> >
> > Since the aarch64 linux kernel always enables -fno-omit-frame-pointer,
> > the generated assembly code may be as follows:
> >
> > str     x30, [x18], 8
> > ldp     x29, x30, [sp], 16
> > ......
> > ldr     x29, [sp], 16
> >                          ## Do we still need a .cfi_restore 30 here
> > .cfi_restore 29
> > .cfi_def_cfa_offset 0
> > ldr     x30, [x18, -8]!
> >                          ## Or may be a non-CFA based directive here
> > ret
> >
> >>> 2) If we keep the first restore of x30, it may provide some flexibility
> >>> for other scenarios. For example, we can directly patch the scs_push/pop
> >>> insns in the binary to turn it into a binary without scs;
> >>
> >> Is that a supported (and ideally documented) use case?  If it is,
> >> then it becomes important for correctness that the compiler emits
> >> exactly the opcodes in the original patch.  If it isn't, then the
> >> compiler can emit other instructions that have the same effect.
> >>
> >
> > Oh, no, this is just a little trick that can be used for compatibility.
> > (Maybe some scenarios such as our company sometimes need to be
> > compatible with some non-open source binaries from different
> > manufacturers, two pops could make life easier :). )
> >
> > If this is not a consideration for our community, please ignore
> > this request.
> >
> >> I'd like a definitive ruling on this from the kernel folks before
> >> the patch goes in.
> >>
> >
> > Ok, I'll cc some kernel folks to make sure I didn't miss something.
> >
> >> If binary patching is supposed to be possible then scs_push and
> >> scs_pop *do* need to be separate define_insns.  But they also need
> >> to have some magic unspec that differentiates them from normal
> >> pushes and pops, e.g.:
> >>
> >>    (set ...mem...
> >>         (unspec:DI [...reg...] UNSPEC_SCS_PUSH))
> >>
> >> so that there is no chance that the pattern would be treated as
> >> a normal move and optimised accordingly.
> >>
> >
> > Yeah, this template looks more appropriate if it is to be treated
> > as a special directive.
> >
> > Thanks for your suggestions,
> > Dan
