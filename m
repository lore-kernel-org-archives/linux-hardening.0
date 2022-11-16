Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37FC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Nov 2022 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiKPWYB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiKPWXz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 17:23:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CC1F2DD
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 14:23:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3729337pji.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 14:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK/A0JOC27A19vLbVWBAPmg5Wb7Cd8nSiAzhgk2OroU=;
        b=cKkj4SCAV5XoyT4U9NqaVHQ9R1xyL6HfTtEO/kpxTpR5RuTl5eXZJsS1y616Ml1Sq1
         dNg7UdTxT/Cwo+ZlxEJ5J+axRloWDDyZ97leyLNO0qozaT7kiQrMxFC6xHDFV+V8xdyj
         7Q0h099lkSkH8GemQWQu1AAiVEyo1ucIb7dHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK/A0JOC27A19vLbVWBAPmg5Wb7Cd8nSiAzhgk2OroU=;
        b=X9nK11iV1XqZ0y3j0kvnbxvZo5YGlLyAIciMPhbxp4te1gMg73lGWXo6mftbyUfonL
         JrAYB/Qr+pX0HRA9O37lNNMo8DL+6nzGlFUlr4bySeDk9LXXAcxI+ZUhLBGID+S1fhQ0
         t86eXehCQXl5kDXcpiviZe71J9sGWMAVrjPPIc7sDwLLWfy4GTMKYzDJSKX61MbPptDj
         3HPv/juHPgDw5+tQMH5BPw/htH3j+t+hjOev/cdGNc4A28vHKHITzLdW89MLHPYpCSgc
         NVM4pPbqKAq8/l/XEUueJmWYNnLlY1tpf3/rec7YHKyiTzT9gl2rGV34ocBnhVJU4raq
         gHRg==
X-Gm-Message-State: ANoB5plT6inmRQ3NUnsOutl//vjv1S/xQhw4iCxT7i1qNoX4euuYCW+B
        wMOk8GOW+2fuNBz03FKz8VtAoA==
X-Google-Smtp-Source: AA0mqf5pZQ9l2S/XqCYN0+ZJaxMH65eucNOvAo0YRg6+EuX5cSJzCFbSMcYggLTABXEBYPJjwi+cng==
X-Received: by 2002:a17:90b:b04:b0:213:c04:42be with SMTP id bf4-20020a17090b0b0400b002130c0442bemr5718426pjb.61.1668637433862;
        Wed, 16 Nov 2022 14:23:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0057210dc5f23sm7520958pfy.218.2022.11.16.14.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:23:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:23:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] wifi: brcmfmac: Use struct_size() in code
 ralated to struct brcmf_dload_data_le
Message-ID: <202211161423.2531CADA73@keescook>
References: <cover.1668548907.git.gustavoars@kernel.org>
 <41845ad3660ed4375f0c03fd36a67b2e12fafed5.1668548907.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41845ad3660ed4375f0c03fd36a67b2e12fafed5.1668548907.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 15, 2022 at 03:55:34PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> In this particular case, in the open-coded version sizeof(typeof-flex-array-elements)
> is implicit in _count_ because the type of the flex array data is u8:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h:941:
>  941 struct brcmf_dload_data_le {
>  942         __le16 flag;
>  943         __le16 dload_type;
>  944         __le32 len;
>  945         __le32 crc;
>  946         u8 data[];
>  947 };
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
