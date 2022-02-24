Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E07C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 01:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiBXBsJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Feb 2022 20:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBXBsD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Feb 2022 20:48:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7423BDC;
        Wed, 23 Feb 2022 17:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB9BB81CA4;
        Thu, 24 Feb 2022 00:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6CFC340E7;
        Thu, 24 Feb 2022 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645663953;
        bh=1wzgF479p3ytx0ZzaTYvEhrP3c0Wz+/eVxMr9mVuoZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdZ5AkMj1MD0sYFXndFb06IDhwCIkzDr7t2p2oT0ogjvpr2ArUTTHSzrNAKO7qRxS
         jf+xOFGqcxnPN/ma3hgugytyYGivksqL7y5bDQBArhCfujBGigla05WPUcBR95FdZu
         0pR2l90PQKftIkKZN9TQwGdG64fWaOv4tmsahmJXEKl9GzFWdOy3tDk77iWHH69fGj
         dd/5hfGB3TiuJFzTdZPCmppuSzZiROOFjxqg146sty23/VZ3BhxWHKp5t8YBbzNmRq
         7lf//GGQHPH6x48jpmaF93eVWNMpU6IwOsEuQt23XUfhWB1aGIlNqK0RaDT12XEM8N
         OhI/HudSZpLEQ==
Date:   Wed, 23 Feb 2022 19:00:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
Message-ID: <20220224010030.GA1282918@embeddedor>
References: <20220224001403.1307377-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224001403.1307377-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 23, 2022 at 04:14:03PM -0800, Kees Cook wrote:
> As a follow-up to the UMN incident[1], the TAB took the responsibility
> to document Researcher Guidelines so there would be a common place to
> point for describing our expectations as a developer community.
> 
> Document best practices researchers should follow to participate
> successfully with the Linux developer community.
> 
> [1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/
> 
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
> Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
> Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Steve Rostedt <rostedt@goodmis.org>
> Acked-by: Laura Abbott <labbott@kernel.org>
> Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

See a comment below...

> ---
>  Documentation/admin-guide/index.rst           |   1 +
>  .../admin-guide/researcher-guidelines.rst     | 141 ++++++++++++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 Documentation/admin-guide/researcher-guidelines.rst

[..]

> +* What is the specific problem that has been found?
> +* How could the problem be reached on a running system?
> +* What effect would encountering the problem have on the system?
> +* How was the problem found? Specifically include details about any
> +  testing, static or dynamic analysis programs, and any other tools or
> +  methods used to perform the work.
> +* Which version of Linux was the problem was found on? Using the most

I think there is an extra "was" in the question above.

Thanks
--
Gustavo
