Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D500C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B392613C2
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTU0b (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhDTU03 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:26:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F7C06138A
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 13:25:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p202so909375ybg.8
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZnvC7WqtbGWJJ90rcSCNfd5IgRs5WT1R+r3wLlKOvA=;
        b=Py3f40b0nf5cI5BfBtqXJGDUaFTD1Ffq+FieXmhIuOdeqrJBC9ST3uixHFF4RtIDHi
         gvlacx9ZSL1nuTEouTfQwHfZ1F81drfsPl2n8K0R62/mXLyvOIpbyDB8HxOcuwATW0C8
         bQyiZEpuuAudaCnZEaOJ1asNTZiqnak0ep/WuDQOBMq0WuC1bLXFn9ksZFhhajsHnQ+1
         uF86qJh8oCbpKDFONrQsaNQt46a8Nue9lTmWj1wJsdg9SDQf15yAf7QlkTsfeRoOcqEM
         UIxdhBs5eW8wU3PldTBPwLLA/0mJ2lluxerLIqsXRhOoRU/nI7lrLhNXu/UDGjOcfjKy
         WzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZnvC7WqtbGWJJ90rcSCNfd5IgRs5WT1R+r3wLlKOvA=;
        b=c3sdxe1dRwOEYtx/JNgW3BYiJ3i6FfobvrwBaP8CbGthCJORiEME+0MJjP2MS0U3c/
         maVfREYF0fgLrCiFrxFo6osDUgAynCmJrInE0IjseOZNz3GykJ+jVcxcehujEgr+8BHu
         sY/hCua9THsDBVddfHH/oycqOcbTD5ZxPhhn79GY65/q3qA09cKIFOJ1v4IKPtnkjSTz
         GskbF4FWtENyvVB2V7fn32rKUppbTPPWAt7u+bpkPfAXYGZvvNlLfoh0gp+OE5IM/kGC
         IHRDt4h3VWmNI/KVh0L85M4xQmaUV3M/tk5gkh63rkYANToGsH3ZxULH4eChH9QzxaJZ
         qmRg==
X-Gm-Message-State: AOAM532ielBcJEcWXfWFixh4ynfP6LPqeAdyPAENF/rKQpIXlOrHmVJL
        ZRhxIirS0d8/Awf3Dmnyt/31xdVpojoJZyVP+r872Q==
X-Google-Smtp-Source: ABdhPJxVGLLM/eG1NkKpWkXN/Pb0N2bQIRRCmeqri95nr5U/1ekvrnyvttCaB4PypphENW5I9rpX0Ly+XvAM6pUs+F0=
X-Received: by 2002:a25:7085:: with SMTP id l127mr27885350ybc.293.1618950354345;
 Tue, 20 Apr 2021 13:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com> <20210420181412.3g5dsyhggxnvif7k@treble>
In-Reply-To: <20210420181412.3g5dsyhggxnvif7k@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Apr 2021 13:25:43 -0700
Message-ID: <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com>
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 20, 2021 at 11:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> > With -ffunction-sections, Clang can generate a jump beyond the end of
> > a section when the section ends in an unreachable instruction.
>
> Why?  Can you show an example?

Here's the warning I'm seeing when building allyesconfig + CFI:

vmlinux.o: warning: objtool:
rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c()+0x149:
can't find jump dest instruction at
.text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c+0x7dc

$ objdump -d -r -j
.text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c
vmlinux.o
0000000000000000 <rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c>:
  ...
 149:   0f 85 8d 06 00 00       jne    7dc <.compoundliteral.4>
  ...
 7d7:   e8 00 00 00 00          callq  7dc <.compoundliteral.4>
                        7d8: R_X86_64_PLT32     __stack_chk_fail-0x4

Sami
