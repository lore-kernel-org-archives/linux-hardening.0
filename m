Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1DC7EE2C
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjHYI1I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbjHYI0o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 04:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4D19AD;
        Fri, 25 Aug 2023 01:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F656301E;
        Fri, 25 Aug 2023 08:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95696C433C8;
        Fri, 25 Aug 2023 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692951999;
        bh=n4dEAjABUpK1jXJJBo6zRCVHWgib83V/fJcuQWhG8+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F19A3i3eCm/PHXoh2KAsN7HSAL7/gpppaB2hmfA9ycB+AuZ8he2ZKOf6NLCJJLOCc
         YRyRM9qL18TPxlZbTBk+kcDTQIqhMqMH3B6HQntDkvKe8wjP/n4qlsmZGC0a/6H3wz
         m9qFi1zUNmcxUxjPJMjp81J2sQc5ymO2ijtuhIug=
Date:   Fri, 25 Aug 2023 09:24:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <2023082514-union-uphold-e7f7@gregkh>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
 <2023082458-vividness-habitable-cbc8@gregkh>
 <20230825063302.GBZOhLHgdvhIw1d6f1@fat_crate.local>
 <20230825071512.yqtpmrie2zma3qcp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825071512.yqtpmrie2zma3qcp@treble>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 25, 2023 at 12:15:12AM -0700, Josh Poimboeuf wrote:
> On Fri, Aug 25, 2023 at 08:33:02AM +0200, Borislav Petkov wrote:
> > On Thu, Aug 24, 2023 at 03:52:56PM +0200, Greg KH wrote:
> > > On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> > > > Hey Paul,
> > > > 
> > > > On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > > > > I hit the splat at the end of this message in recent mainline, and has
> > > > > appeared some time since v6.5-rc1.  Should I be worried?
> > > > 
> > > > does it go away if you try the latest tip:x86/urgent branch?
> > > 
> > > Note, this problem is showing up in the 6.1.y branch right now, due to
> > > one objtool patch not being able to be backported there easily (i.e. I
> > > tried and gave up.)
> > > 
> > > 4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
> > > can't seem to get to work properly, my attempt can be seen here:
> > > 	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh
> > > 
> > > Just a heads up as this will start to affect users of the next 6.1.y
> > > release, and probably older releases, as they are taking portions of the
> > > "fixes for fixes" but not the above mentioned one.
> > 
> > Hmm, Peter and I are away, I guess maybe Josh might have an idea how and
> > what to backport to 6.1 to get this sorted out...
> > 
> > CCed.
> 
> Sure, will take a look tomorrow.

Many thanks!
