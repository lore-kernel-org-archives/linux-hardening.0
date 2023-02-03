Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274BC61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjBCRyl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBCRyf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E4ADB89
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 09:54:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so2687951pjw.2
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R8ufPH7bTftRwsQjzz55HUv+bYFzzWYZWI0aqKJbnlM=;
        b=RjJmJmOStcp52nBMq8W2804rVNjEMR6y0Zk8U9GC2UFTaj19G+HlCKWNpqRPKTrZsJ
         thQA2JF/Xtf8RWp3HVFDXeXRWrDuDEitexR85nIx12VHc89pXL3o2QhQiphpZgDPnqKs
         bro+6C/iyRt/sIxOvUywY0BqUViCm+O3I3diM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ufPH7bTftRwsQjzz55HUv+bYFzzWYZWI0aqKJbnlM=;
        b=w1RTwzce/w4hP2k3RnXaSHIxMuNikRi62ri2b05VF8UllI/cxfLMCJXrvwdCZ2oFSz
         m8V8SsR3apDI89jgvLG+V1lVm2ApqK7/a9Z4hqX1Mj4RF01xHRg8V4zfloyt5Nah+Qmi
         7WzENhLQvOO6c8nmFUvF/ZwCJeHr5ge/gbpZmotKdpWPwLnVWs2bN9SEaNCqvfTf9kC1
         lk8bz4rUdVIMn9qU4d3Vo+utNZPFzkbkxPSD9hLtbXM7vijKg2XQZQE7C3VosCkgnF0c
         o4UlGNLP06O24dvjUMlkh3c+87N6zEKtNBH1wZVGf/ZskfCb15UKuWrAciw9RNrTxERf
         0/aQ==
X-Gm-Message-State: AO0yUKWD/RvgMPv/JAEd3DN693QDZ07zTZhpqL2S9Yh/caHOK4MO1aG+
        tLz2Qru3wHg+J6c7ZuShiC10Pw==
X-Google-Smtp-Source: AK7set8kyDB7ke6F1jZoIVEstiFpFa+7n6l6dDQrd+DcHUlMDeWxnH/+duod2iw0p7EJb++f6sHo+w==
X-Received: by 2002:a17:902:c651:b0:196:3f29:779f with SMTP id s17-20020a170902c65100b001963f29779fmr6881496pls.6.1675446865049;
        Fri, 03 Feb 2023 09:54:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b00186a437f4d7sm1880088plj.147.2023.02.03.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:24 -0800 (PST)
Message-ID: <63dd4a50.170a0220.c7a03.3a65@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:24 +0000
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
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] brcmfmac: Replace one-element array with
 flexible-array member
References: <Y9xjizhMujNEtpB4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xjizhMujNEtpB4@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 07:29:47PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct brcmf_tlv.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/253
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
