Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F93C07E9D
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIZWAW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIZWAV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D19F180
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so7761713pgb.4
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z+V9HKEzE/RCD+QuWbpkWnuj/UNSjdfJYogyydpcU5E=;
        b=kdUvjIZklCh7p0dy2cbAnFPWMnaQ9KU6pSVxgIsJWiq+Rg7+dTzBAtFdhyUWV/brDb
         IpNU0HceJCKIFZWASfKOAiuYPFrkk0Borpnr6U537aRJejJsQ1FDpSlMfPthP5MEWXSa
         tH5lEPrVqifpJ/Q2B8PMTZfLFiNA71z5Vn/X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z+V9HKEzE/RCD+QuWbpkWnuj/UNSjdfJYogyydpcU5E=;
        b=Md9kMz2N5ccJNzvrBZM61SyOIpGYft5GEFAecJ/eS69PPkb8Xh4gTcQhAuYosp8dve
         TCm+Eqe+fpRnaWSm8odTdiVEjkIsBB95oXqkXMe2mSlGDFIYnWrj/lobxNQSnXlZ000A
         q4A2DGWBKTul4RHUTzaCjSK9WMjoI5H9FeTHH7iks3vDFe5DTI17hLaAbBD3DX5xBmji
         4zGgkszqKthXnmP31PS2r6V028Tg83X+OVATib0ueY4lZLYu5isUdRsY3zCdiOQKlC7I
         UHAmQIpx6aQrYhCJ0gWDPFjHsijOCIvodN92vT+o8jTwkdOOvkNEINo1XwBqLW3njknN
         z9Iw==
X-Gm-Message-State: ACrzQf1ugkE3Y44wW8Vw921S/CQ92LATQi7i4/oIOZArId7xRq/Zzro+
        WKedyFNLjiKErORoIiNjS5Hszw==
X-Google-Smtp-Source: AMsMyM6EH3TLoP5Ab4HNfRJxhe6hu7QGEmIFxPc9r5Y3xSUNCHlUgH+CVhBdd6e51YbiFdKv0fGl0Q==
X-Received: by 2002:aa7:9e12:0:b0:53e:27d8:b71b with SMTP id y18-20020aa79e12000000b0053e27d8b71bmr25834865pfq.46.1664229619477;
        Mon, 26 Sep 2022 15:00:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24-20020aa794b8000000b0053e6d352ae4sm6408pfl.24.2022.09.26.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:18 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.B594CC10@keescook>
References: <YzIcZ11k8RiQtS2T@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIcZ11k8RiQtS2T@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/211
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
