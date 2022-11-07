Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A39C4332F
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Nov 2022 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiKGVW5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiKGVWk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Nov 2022 16:22:40 -0500
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 13:22:25 PST
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC700BD0
        for <linux-hardening@vger.kernel.org>; Mon,  7 Nov 2022 13:22:25 -0800 (PST)
Received: (qmail 3224 invoked from network); 7 Nov 2022 21:15:02 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2022 21:15:02 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 9FA69AB3A4; Mon,  7 Nov 2022 22:14:40 +0100 (CET)
Date:   Mon, 7 Nov 2022 22:14:40 +0100
From:   Solar Designer <solar@openwall.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
Message-ID: <20221107211440.GA4233@openwall.com>
References: <20221107201317.324457-1-jannh@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> +oops_limit
> +==========
> +
> +Number of kernel oopses after which the kernel should panic when
> +``panic_on_oops`` is not set.

Rather than introduce this separate oops_limit, how about making
panic_on_oops (and maybe all panic_on_*) take the limit value(s) instead
of being Boolean?  I think this would preserve the current behavior at
panic_on_oops = 0 and panic_on_oops = 1, but would introduce your
desired behavior at panic_on_oops = 10000.  We can make 10000 the new
default.  If a distro overrides panic_on_oops, it probably sets it to 1
like RHEL does.

Are there distros explicitly setting panic_on_oops to 0?  If so, that
could be a reason to introduce the separate oops_limit.

I'm not advocating one way or the other - I just felt this should be
explicitly mentioned and decided on.

Alexander
