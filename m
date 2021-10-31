Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3FC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598D160FC2
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 20:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhJaUry (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 31 Oct 2021 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJaUry (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 31 Oct 2021 16:47:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5FC061714;
        Sun, 31 Oct 2021 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b0tZ34w3Ic/Z3fpfctU3wLrlrqGfXpeSj1s0iMzBRVU=; b=i6BkDMLzyKLvVbr1i4NEQhkLZ9
        82XSy4Uu1ZTFMpMyViuLzQnbslUjAE+ckAW5MITXbBrdWMlIzTgty+2xvDlk/OXfI6W6f86lIMljF
        ++G7icrzNSeblisrIdgxsWtqLJvjFHPB9+ztuBZxIfljJW4aZV0q/hqvLoaaYSnMD4uI3IrMC2LXf
        ps3h6kkpNMSV4MkNPijnUCps+cjhxWe6R9CNYjmAcEzNSTx13wdJHMt90X4gWsqtAQi+5xA9baXTM
        MlcQ90iuCbP1tgI8wrLQ1AlEDtaZFRF8roAvtpW8gtFjfq2CSWs4J35ra6BB5+f6SrjQuCKMMFjPB
        u9uk3HZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhHhC-00DRyA-Ee; Sun, 31 Oct 2021 20:44:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C936300243;
        Sun, 31 Oct 2021 21:44:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCD8B2057F811; Sun, 31 Oct 2021 21:44:48 +0100 (CET)
Date:   Sun, 31 Oct 2021 21:44:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
References: <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 31, 2021 at 09:21:56PM +0100, Ard Biesheuvel wrote:

> That means we can support static calls on arm64 now without breaking
> Clang CFI, and work on a solution for the redundant jumps on a more
> relaxed schedule.

Yes, arm64 has a 'problem' with having already merged the clang-cfi
stuff :/

I'm hoping the x86 solution can be an alternative CFI scheme, I'm
starting to really hate this one. And I'm not at all convinced the
proposed scheme is the best possible scheme given the constraints of
kernel code. AFAICT it's a compromise made in userspace.
