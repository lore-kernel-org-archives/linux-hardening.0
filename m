Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64571EB64DB
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Jun 2023 09:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbjFOJd6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 15 Jun 2023 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbjFOJdw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 15 Jun 2023 05:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43682715;
        Thu, 15 Jun 2023 02:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEF7616F6;
        Thu, 15 Jun 2023 09:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D84C433C0;
        Thu, 15 Jun 2023 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686821617;
        bh=3k+knOQOzZnH8UJm7bzmzxgb1d8QVR/mgApFW6PhNBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6DtK70SDECzJY5SatfKEV6HwkQ4t8exPWgleKEXqqYglnKNFi0jB74TDYe+zs9XQ
         wEeg+FGNy2ojiq6aQ87OBnaWR5cHGWQLeQ+qEzmMG4q/dsg07CY8IxRwoFfyAhgrjk
         ltKQ4mFzu2/ReB59b4KlzyzXgnGX+4aL0OXcrbU0=
Date:   Thu, 15 Jun 2023 11:33:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <2023061516-stricken-prior-8057@gregkh>
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 02:10:26PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@gmail.com/
> 
> Changes from v1 - uses "< 0" instead of "== -E2BIG".

Please fix the reported errors from the build bot.

thanks

greg k-h
