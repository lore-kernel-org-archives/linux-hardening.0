Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31FC27C40
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Aug 2023 13:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjHXNx3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjHXNxC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Aug 2023 09:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5EA8;
        Thu, 24 Aug 2023 06:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5B466CF2;
        Thu, 24 Aug 2023 13:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFFCC433C8;
        Thu, 24 Aug 2023 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692885179;
        bh=rf6BADon7wtlQK5/CewelBxyxeM7vYZHhvfOWir4Wtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfUtcUMXSyhi5s3fbjVmEVYueSFBcmo+WzQqCXhFJR44LhQhuF7H7jisZ7nPIFbfo
         0RtWU8pNz7WycS7kn74fGY6MVYvS0b3tRTUWAgJ1oxbw/RMp0mEeaOC9pCRvnyzf6c
         vgRkm//VY7dvHtsazfgk4iUDOhEDY84Hs4rR/ZME=
Date:   Thu, 24 Aug 2023 15:52:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <2023082458-vividness-habitable-cbc8@gregkh>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> Hey Paul,
> 
> On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > I hit the splat at the end of this message in recent mainline, and has
> > appeared some time since v6.5-rc1.  Should I be worried?
> 
> does it go away if you try the latest tip:x86/urgent branch?

Note, this problem is showing up in the 6.1.y branch right now, due to
one objtool patch not being able to be backported there easily (i.e. I
tried and gave up.)

4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
can't seem to get to work properly, my attempt can be seen here:
	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh

Just a heads up as this will start to affect users of the next 6.1.y
release, and probably older releases, as they are taking portions of the
"fixes for fixes" but not the above mentioned one.

thanks,

greg k-h
