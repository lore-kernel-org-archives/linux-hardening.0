Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39503EE14D3
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Sep 2023 18:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbjIFStB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjIFSs7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Sep 2023 14:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D460D7;
        Wed,  6 Sep 2023 11:48:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5126C433C8;
        Wed,  6 Sep 2023 18:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694026135;
        bh=FUjJSNaNySpHXdpjBDulHvktyqmJmbzlHQ2rZl4+DUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw9RfUnNJLWYnkfTN43zkd2mmweGaSCB/kjTbHb0GyV+knYup+sK47fLXJB+fvBmO
         AL885m8modU8XQ16XZXzWSdPh6ZASQZ4plzezOvPsAwwgeeyXIP49Py59yVqTBakxa
         5NizT9Ke5/akI9JPazDHUuwTmEplubZ7HOvVZx3gba9PcEkhmckj66EUiA6btKkIWM
         kYA6rSchXTlo30cjDijz4l/N953L1QOmkMDCr/OtlyU1CcI0um4kFBKcwI5D+X0Vhm
         KASIemRMZZjGgWuoGZTlNeEYQZO75yBymhytM/y+2iHk5HHcqBn4pg4FsMbV/hjEEm
         mbdc7uOIU/rlw==
Date:   Wed, 6 Sep 2023 19:48:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
Message-ID: <20230906184849.GB5021@willie-the-truck>
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 05, 2023 at 08:10:21PM +0000, Justin Stitt wrote:
> strncpy is deprecated [1] and should not be used if the src string is
> not NUL-terminated.
> 
> When dealing with `cmdline` we are counting the number of characters
> until a space then copying these over into `buf`. Let's not use any of
> the str*() functions since the src string is not necessarily NUL-terminated.
> 
> Prefer `memcpy()` alongside a forced NUL-termination as it more
> accurately describes what is going on within this function, i.e: copying
> from non NUL-terminated buffer into a NUL-terminated buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v4:
> - rebase onto mainline (thanks Will)
> - Link to v3: https://lore.kernel.org/r/20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com

The original patch converting the strncpy() to strscpy() has already landed
upstream, so this doesn't apply as-is.

Rather than go through a v5, I've reverted your original patch and squashed
this on top with a new commit message. I'll push it out tomorrow on to the
arm64 fixes branch.

Thanks,

Will
