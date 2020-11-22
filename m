Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27104C5519F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECABD20757
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKVWEC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:04:02 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51190 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKVWEC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 17:04:02 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 11E5D80567;
        Sun, 22 Nov 2020 23:04:00 +0100 (CET)
Date:   Sun, 22 Nov 2020 23:03:58 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 084/141] drm/via: Fix fall-through warnings for Clang
Message-ID: <20201122220358.GB566387@ravnborg.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c21a588bf9e222826f6b138db91de26a2b21df33.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21a588bf9e222826f6b138db91de26a2b21df33.1605896060.git.gustavoars@kernel.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=iH7RfIX4AAAA:20 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
        a=gTDArIOx2wuNTLb-19gA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 12:35:54PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, also applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/via/via_irq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
> index 24cc445169e2..a3e0fb5b8671 100644
> --- a/drivers/gpu/drm/via/via_irq.c
> +++ b/drivers/gpu/drm/via/via_irq.c
> @@ -364,6 +364,7 @@ int via_wait_irq(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  		irqwait->request.sequence +=
>  			atomic_read(&cur_irq->irq_received);
>  		irqwait->request.type &= ~_DRM_VBLANK_RELATIVE;
> +		break;
>  	case VIA_IRQ_ABSOLUTE:
>  		break;
>  	default:
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
