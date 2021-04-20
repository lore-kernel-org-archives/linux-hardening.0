Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE0C433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782356140A
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDTW5f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTW5f (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 18:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618959422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LnQ53sg5fwiQMRw1Pm3HtTObLBLrjcyC95xl1vP82O8=;
        b=aGuxYAxwyFdRQr/7z05TfwnPSVMa/gQpPXEBOi+OG34+veqdissTFaZ5wzkNRXZ2DsFtbA
        rVOkCIqaP0TrYbpnJ78VG1n9wPsV67j9RMV68cBLLNBCR5nMoOLCIrLuY4l/eP7HMrK7j5
        Y59qmwNIiozoSV+uSvExGxCySNX5P8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-vzBdi_YsOOSuKZd02ektjw-1; Tue, 20 Apr 2021 18:56:21 -0400
X-MC-Unique: vzBdi_YsOOSuKZd02ektjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A72E80D6A8;
        Tue, 20 Apr 2021 22:55:54 +0000 (UTC)
Received: from treble (ovpn-114-107.rdu2.redhat.com [10.10.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBF9D5D9C0;
        Tue, 20 Apr 2021 22:55:52 +0000 (UTC)
Date:   Tue, 20 Apr 2021 17:55:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
Message-ID: <20210420225550.szbmrpwv6awd7tp5@treble>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com>
 <20210420181412.3g5dsyhggxnvif7k@treble>
 <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 20, 2021 at 01:25:43PM -0700, Sami Tolvanen wrote:
> On Tue, Apr 20, 2021 at 11:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> > > With -ffunction-sections, Clang can generate a jump beyond the end of
> > > a section when the section ends in an unreachable instruction.
> >
> > Why?  Can you show an example?
> 
> Here's the warning I'm seeing when building allyesconfig + CFI:
> 
> vmlinux.o: warning: objtool:
> rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c()+0x149:
> can't find jump dest instruction at
> .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c+0x7dc
> 
> $ objdump -d -r -j
> .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c
> vmlinux.o
> 0000000000000000 <rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c>:
>   ...
>  149:   0f 85 8d 06 00 00       jne    7dc <.compoundliteral.4>
>   ...
>  7d7:   e8 00 00 00 00          callq  7dc <.compoundliteral.4>
>                         7d8: R_X86_64_PLT32     __stack_chk_fail-0x4

Instead of silencing the warning by faking the jump destination, I'd
rather improve the warning to something like

  "warning: rockchip_spi_transfer_one() falls through to the next function"

which is what we normally do in this type of situation.

It may be caused by UB, or a compiler bug, but either way we should
figure out the root cause.

-- 
Josh

