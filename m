Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E4C87FDC
	for <linux-hardening@archiver.kernel.org>; Thu, 25 May 2023 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbjEYSp6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 May 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbjEYSov (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 May 2023 14:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC626B3
        for <linux-hardening@vger.kernel.org>; Thu, 25 May 2023 11:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530B260B2D
        for <linux-hardening@vger.kernel.org>; Thu, 25 May 2023 18:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE57C433EF;
        Thu, 25 May 2023 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040000;
        bh=UPYQ/2+qcl3CSRKOhikoX0u1rzdZ68Tmras9W9H8pN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9I5IZZ8Cne4G63dNifjY+lK3iZI2NFON/CAq9S+NnSXofWzaK+0NHjy4OrnjZWVa
         x6RahcTabWC+YxjLwzrunm3aLPcJNyhJ9Jm3eBu+upEZgaiKVjiyBBhHbYMSJJ6HKQ
         gc+FNshdtlfjaWX63b1ytvgWw6F0/Wr+wiPBV1xocfs3CG6yzIDYV9DxpUbxYiPgVq
         Jc5zYNu++5MrWmhLSKYAYF7XkZal89PYtMfUZxTcrAr2L4MNULrc7DgAVPPjvy9FnR
         IuxlKcidTX3EAccqVSsqWOoA/sBIrsiCaqKXq4YxXFbasYWhYQqUBdUnSgqXcLBqD5
         Nqo9x0McC9ecw==
Date:   Thu, 25 May 2023 12:40:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: Progress on Bounds Checking in C and the Linux Kernel
Message-ID: <ZG+rsFgyQ1R0/ypG@work>
References: <202305161325.0E3BF912@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305161325.0E3BF912@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 01:29:28PM -0700, Kees Cook wrote:
> Hi!
> 
> I just wanted to share links to the presentation Gustavo and I gave at
> last week's Linux Security Summit. Repeating the abstract here, just so
> you don't have to click through if you don't want to:
> 
> 
> Linux, like all C code, regularly suffers from heap buffer overflow
> flaws. Especially frustrating is that the compiler usually has enough
> context to have been able to stop the overflow but has been hampered by
> needing to support legacy coding styles, ambiguous language definitions,
> and fragile APIs. This has forced the compiler to frequently ignore the
> intent of programmers in an effort to support sloppy code patterns that
> may not exist in a project at all.
> 
> The history of the C language specification's "flex array member" (FAM)
> is long and twisty, and technical debt exists due to ambiguous
> implementations. With the introduction of -fstrict-flex-arrays, C can
> now unambiguously declare array sizes. In the kernel we can build on
> this, by transforming trailing zero-length and one-element arrays into
> modern C99 FAMs, adding the use of __builtin_dynamic_object_size(),
> applying it to defenses like FORTIFY_SOURCE, and expanding where the
> compiler can use this knowledge internally for improving existing
> sanitizers. Finally, adding a new struct member attribute, we can expand
> object size tracking to cover all array types, freeing Linux from this
> persistent class of buffer overflows flaws.
> 
> 
> Summary: https://lssna2023.sched.com/event/34dfdb61ccf86035c031b5bf2173765a
> Slides:  https://outflux.net/slides/2023/lss-na/bounds-checking.pdf
> 
> I haven't seen any video published yet, but if that shows up soon, I'll
> reply to this thread with a link.

The video is finally out: https://www.youtube.com/watch?v=V2kzptQG5_A

Thanks
--
Gustavo

