Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E882EE57EF
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 10:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjIHK27 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjIHK26 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 06:28:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A602123;
        Fri,  8 Sep 2023 03:28:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC8C433CD;
        Fri,  8 Sep 2023 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168317;
        bh=7ppBGSYE/D1DEoQwtHJNYsJokjRP5do2Yy52Rv5Uyxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtpRW/1t8nNfLPqbo8IsCfPOJ0tpjyhRkcrwyjGZc1qXUr7kx+xBgWnf4qnDaq77F
         ukvUPCQmK7go5SvzVPY9r4Lx0yyK5QoY3Fg+B7UhjyTV6JC1WeOGCIQzyRlW8iO1i0
         leYHJP3eNUq9z+n8Ei3tikxScTyzXQuHcNomq8QtyWul2ZarX0T7Ho6WjLblQa36Qk
         hMZxVKMkr/G1XEnGV4HHLYggegV+eqcVCz2Th4PJXzTsPv6RHXp2//ur9ztXIv3qDv
         NUYLjzfG0afA3ziCgVdjO08R3Rsgop/ZCNgZiomsBZC1b4+aGbnkpY78ckK5c7tfM+
         eVYu9zOdxc4Yw==
Date:   Fri, 8 Sep 2023 11:18:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
Message-ID: <20230908101831.GA6849@willie-the-truck>
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
 <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
 <CAFhGd8pMeTuvn_OqzYtRbfAM7L_-Jb_hFA4WY0hMap_eG=F7RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pMeTuvn_OqzYtRbfAM7L_-Jb_hFA4WY0hMap_eG=F7RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 07, 2023 at 11:17:08AM -0700, Justin Stitt wrote:
> On Thu, Sep 7, 2023 at 10:37 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
> >
> >
> >
> > On 5.09.2023 22:10, Justin Stitt wrote:
> > > strncpy is deprecated [1] and should not be used if the src string is
> > > not NUL-terminated.
> > >
> > > When dealing with `cmdline` we are counting the number of characters
> > > until a space then copying these over into `buf`. Let's not use any of
> > > the str*() functions since the src string is not necessarily NUL-terminated.
> > >
> > > Prefer `memcpy()` alongside a forced NUL-termination as it more
> > > accurately describes what is going on within this function, i.e: copying
> > > from non NUL-terminated buffer into a NUL-terminated buffer.
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > Hi,
> >
> > some form of this patch [1] went into -next and it broke booting
> > on at least the Qualcomm SC8280XP-based Lenovo Thinkpad X13S.
> >
> 
> Thanks for the heads up! The previous versions of the patch (including
> the one that was applied) had some errors. This patch should be good
> and Will is looking to apply it to arm64 fixes tree.

Yes, it should be fixed in linux-next 20230908.

Cheers,

Will
