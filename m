Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB48C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  5 May 2022 12:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiEEMkT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 May 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiEEMkS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 May 2022 08:40:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E24031CB22;
        Thu,  5 May 2022 05:36:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A1F106F;
        Thu,  5 May 2022 05:36:39 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918A43F885;
        Thu,  5 May 2022 05:36:37 -0700 (PDT)
Date:   Thu, 5 May 2022 13:36:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <YnPEzeab/R270gAZ@FVFF77S0Q05N.cambridge.arm.com>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <YnKnLyyXPJl5Llc0@FVFF77S0Q05N>
 <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
 <CABCJKuc-6daZd8N6hQV6i_TtCtVpfzxJ2UW6xwxC2vxTmJ2deg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuc-6daZd8N6hQV6i_TtCtVpfzxJ2UW6xwxC2vxTmJ2deg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 04, 2022 at 01:17:25PM -0700, Sami Tolvanen wrote:
> On Wed, May 4, 2022 at 9:41 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Hi Mark,
> >
> > On Wed, May 4, 2022 at 9:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > I wanted to give this a spin on arm64, but I'm seeing some very odd toolchain
> > > behaviour. I'm not sure if I've done something wrong, or if I'm just hitting an
> > > edge-case, but it looks like using -fsanitize=kcfi causes the toolchain to hit
> > > out-of-memory errors and other issues which look like they could be memory
> > > corruption.
> >
> > Thanks for the detailed bug report! It definitely looks like something
> > is wrong with the recent switch from std::string to Twine in the Clang
> > code. I didn't see this issue when compiling the arm64 kernel, but
> > I'll take a closer look and see if I can reproduce it.
> 
> I was able to reproduce this by turning off assertions in Clang. It
> seems to work fine with -DLLVM_ENABLE_ASSERTIONS=ON. I'll go fix.

FWIW, a `-DLLVM_ENABLE_ASSERTIONS=ON` build also seems to work for me when
building a kernel with CONFIG_CFI_CLANG=y. It's much slower than a regular
Release build, so I'm still waiting for that to finish building a kernel, but
it has gotten much further through the build without issues.

Thanks,
Mark.
