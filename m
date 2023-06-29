Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA044C001B0
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jun 2023 19:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjF2TAW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjF2TAT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 15:00:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782F1BC5
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 12:00:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so756928a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688065218; x=1690657218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzTSZl4ZrMV7S9CxcKysPR5GZsJOMyGfyeQpbnniNwY=;
        b=bYMJnnMVkMD1qGU3V/p2Ksfzduhx5dbgVJffIfoqMFs2zQyvuRMkPgL+1BjBND7Muc
         Jcam2Ox77QJytBsj2kM1hw+xGiYGSBwXNo9sr6RzzrTeGKQiPC8WsvifCXYovFYAH8iX
         8wXcab/QlDRfTxuLZB3G+PdjQ5GcfjrTk25jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065218; x=1690657218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzTSZl4ZrMV7S9CxcKysPR5GZsJOMyGfyeQpbnniNwY=;
        b=Z2lPG2z40BNkodGNjN+yRUlkzHDXNFIfrbAUO29ADjJ/cN+++WVtNYBBh98QNfbzjP
         6CZ/+/wIrDnaOI9FG1YZEJUkQBPqzPfiK9e7cC+hTVUA7NsImlN4G4JAyc7FUnooz2bs
         VkILHXTlmMhzy6gaYE94BeFkrolVG/Tk/sWEcjwDtJxvm179XZW2X3ku7NdNW18VhGIv
         mMfsLnhwlkFBgfFMQVX8Z8l+Yw6PybYSGfcDl4Nb0sBwkwMBcrfEo2U0PGaG2t+lCKdI
         Lvymw+zvRhBACR7eikbp1na/KdfLtnuVFkKyZqqfpaRzcJfwJngaELCz/rC0Loz5xlYf
         y25w==
X-Gm-Message-State: AC+VfDz8/j4Y2X5oiHFynbsGeqKPnVahxh50MKdxAajPR0mCQUwkMoN1
        JGWsRUrlMum+HXYu8DYg/LGblw==
X-Google-Smtp-Source: ACHHUZ6UmgnsuBwbjXdkwkW0c7gX7XjDQZrqe1/4vO5USaZh7WQ07jAviGsUCR0heTlL1OVpHkpx3w==
X-Received: by 2002:a05:6a20:a10c:b0:11d:9307:8acb with SMTP id q12-20020a056a20a10c00b0011d93078acbmr408192pzk.45.1688065218303;
        Thu, 29 Jun 2023 12:00:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a636202000000b005439aaf0301sm9060262pgb.64.2023.06.29.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:00:17 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:00:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-usb@vger.kernel.org
Subject: Re: UBSAN spat in valid xhci code in Linus's current tree (6.4+)
Message-ID: <202306291159.44DFB7CE6E@keescook>
References: <2023062945-fencing-pebble-0411@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062945-fencing-pebble-0411@gregkh>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 29, 2023 at 05:36:51PM +0200, Greg KH wrote:
> in include/uapi/linux/usb/ch9.h

Oh wait, this is a _different_ one in ch9. I'll send a patch...

-- 
Kees Cook
