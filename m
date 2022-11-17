Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC53C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 23:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbiKQXR2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 18:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbiKQXQ5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 18:16:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3763748E5
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 15:16:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3217256pjt.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFHM35UNmfkldWlBK35cn48oG6HZgrQ/KKBOkaB7rqU=;
        b=ATU3KjrZtjnHaTJObubyH+A7KNgBJz/4UaptmzMu4aSuS9NdqlPG0tYK4xIrw4V0NB
         4RU5QBMu8DWiBXX1/TktUDKtbUKAnZx48Xhzr5n3cj0tYPXPgg6lNQQwF68TEdbEM6dh
         1Bx+Y3+kimUVDCJga+7SSlvRvh7BS7Opi4JuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFHM35UNmfkldWlBK35cn48oG6HZgrQ/KKBOkaB7rqU=;
        b=PHk8EeCvg9AIVdBY8c4Ia0+yxPCpimsyqZ8n3NkGA/77rjGJIi/mrTXhpi5jQ1aT8Q
         Tbihq/3xDHw53gWurgNzCXzmrpSVhsxTg1DBjm6SFJKjkL2sh/O3v9ttrYc7hJIDY1b3
         mSeRwicY/HIgAIGPhXci6cOgil9eqWFNFf19X1dMmW8VekT3SJHdxucWuVTWDhkbL985
         K8r+hb724/sY0PmIGRp0OEfK1OW5S6ee/+vkLUEySSNcIFVNv3DKOMXDOpARQPQqBAIv
         hQwmDYLOQGGFUo4FRrJH6+Vmo3YeVYCG2NtYFekBgd7T1+izjOu7zp6+cnA4kwuNSB2v
         iHnw==
X-Gm-Message-State: ANoB5plYyBrOW6RGpMSHxPRTKaulRmLJnjmiW51CSHFt+1O1Fne7t4mx
        ldPQpQNIOzr3uuISx7YHnmpopw==
X-Google-Smtp-Source: AA0mqf4Z52LhYoKCKnrcJ/sZ0XNkqqlzxYRePSfLz9EXsNXDAWUPh3OJgEchOas5UoNkbsmIaRRXqA==
X-Received: by 2002:a17:90a:6e47:b0:205:a550:e529 with SMTP id s7-20020a17090a6e4700b00205a550e529mr5065529pjm.25.1668727016281;
        Thu, 17 Nov 2022 15:16:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ls5-20020a17090b350500b00205f013f275sm4149719pjb.22.2022.11.17.15.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:16:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:16:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] wifi: brcmfmac: Use struct_size() and
 array_size() in code ralated to struct brcmf_gscan_config
Message-ID: <202211171516.19C8EB37@keescook>
References: <cover.1668466470.git.gustavoars@kernel.org>
 <de0226a549c8d000d8974e207ede786220a3df1a.1668466470.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0226a549c8d000d8974e207ede786220a3df1a.1668466470.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 14, 2022 at 05:02:06PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Also, use array_size() in call to memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
