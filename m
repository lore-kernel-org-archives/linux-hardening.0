Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5140C7EE23
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 16:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjEVQEP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjEVQEO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 12:04:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6730C1;
        Mon, 22 May 2023 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kbVu+js/u49UVSKkc3Whb+MdTHWX0VoM6dHArdtJbQI=; b=wKGo5FF9Sv1SMb8FRQ1zB/vGMN
        8IR3y7Ttvy3shfgEg6LMq4kvEIUNezlX4y/XPKd41Pdq//gTGjkqqHgcoq3v2bi2mtub7WBW3qaBE
        pO53wVAbKaO16or8TfpbZVg0kHeHy4EjqRJF/0zXhn+g+bz80wtz4GCR+yanVkXPrgeewHmnuKeWj
        Hgq5f30ZWlA6R9AIcOek8Lv9vzxKVRQFjgMaDMh1d6+WbPh2BKAWqESX4sIWarrKI4flVCqC3tqEF
        NaLbECBcIs62U3ziVE7CCFysdwyPO4B9H32JcsbDpxXfJeIrV8NadCYpXMNK39KcK0ewVPeFSm8tx
        P3UQQHdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43546)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q1815-00077K-8R; Mon, 22 May 2023 17:04:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q1813-00084G-L4; Mon, 22 May 2023 17:04:09 +0100
Date:   Mon, 22 May 2023 17:04:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with
 strscpy
Message-ID: <ZGuSeZcLfXNyCqtv@shell.armlinux.org.uk>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 03:53:50PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
...
>  	memset(&cec_info, 0, sizeof(cec_info));
> -	strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
> +	strscpy(cec_info.type, "tda9950", sizeof(cec_info.type));

Please explain how:

1) a C string can not be NUL terminated.
2) this source string could be longer than I2C_NAME_SIZE (20 bytes)
   which is unlikely to ever shrink.

I'm not saying I disagree with the patch, but the boilerplate commit
message isn't correct for this change, and is actually misleading
for what the patch actually is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
