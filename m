Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC98EE49A5
	for <linux-hardening@archiver.kernel.org>; Sat, 19 Aug 2023 10:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjHSKmB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 19 Aug 2023 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHSKlo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 19 Aug 2023 06:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6818C3B338
        for <linux-hardening@vger.kernel.org>; Sat, 19 Aug 2023 03:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06FE6602E5
        for <linux-hardening@vger.kernel.org>; Sat, 19 Aug 2023 10:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D862CC433C7;
        Sat, 19 Aug 2023 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692439572;
        bh=eZmjagX06AR0K5BLwB36iJyx8ATCTPYSXUB2lSow2tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oozmb8NYVD4jQQRjJEOWIn7yMeKn7xI4+shKJJU9Gu78uzOjqJtClLybhs3IasuDm
         kLGvPYP+JmwlimLUtAni2m+A88effmA5MAIQYpNrDt8CAbIbyxRY54bhm8rFp466jp
         R9Fdyhztw4Xcq2xFfybSOE2jDSM99pAh4OjDPwLk=
Date:   Sat, 19 Aug 2023 12:06:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        kernel test robot <lkp@intel.com>,
        Yujie Liu <yujie.liu@intel.com>,
        Philip Li <philip.li@intel.com>,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <2023081940-linguist-pantomime-ebc2@gregkh>
References: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <202308170000.YqabIR9D-lkp@intel.com>
 <cfc29063-9e20-5101-d70b-62b5423d2d10@intel.com>
 <CANiq72m9ZEVkP76FMFOnPYkA8ih4Mq72HtW9AbrJ-JPy9ku3jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m9ZEVkP76FMFOnPYkA8ih4Mq72HtW9AbrJ-JPy9ku3jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 01:10:07PM +0200, Miguel Ojeda wrote:
> On Fri, Aug 18, 2023 at 12:38 PM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
> >
> > Rust folks, could you please tell me if this is something I should fix,
> > or I just uncovered some existing bug in "unstable" thing?
> >
> > Perhaps it is worth to mention, diff of v3 vs v2 is:
> > move dummy implementation of __has_builtin() macro to the top of
> > compiler_types.h, just before `#ifndef ASSEMBLY`
> 
> Nothing you need to worry about, it is an issue with old `bindgen` and
> LLVM >= 16, fixed in commit 08ab786556ff ("rust: bindgen: upgrade to
> 0.65.1") which is in `rust-next` at the moment. Sorry about that, and
> thanks for pinging us!
> 
> LKP / Yujie / Philip: since we got a few reports on this, would it be
> possible to avoid LLVM >= 16 for Rust-enabled builds for any branch
> that does not include the new `bindgen` or at least 08ab786556ff? Or,
> if Greg is OK with that, I guess we could also backport the upgrade,
> but perhaps it is a bit too much for stable?

Commit is tiny enough for stable backports if it fixes a real issue that
everyone needs to address, so I have no objection to taking it for
stable releases once it hits Linus's tree.

thanks,

greg k-h
