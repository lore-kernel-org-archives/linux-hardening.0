Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605EC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 01:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BAE60FBF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 01:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhIMBzR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 12 Sep 2021 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhIMBzR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 12 Sep 2021 21:55:17 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79446C061574
        for <linux-hardening@vger.kernel.org>; Sun, 12 Sep 2021 18:54:02 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w78so8908682qkb.4
        for <linux-hardening@vger.kernel.org>; Sun, 12 Sep 2021 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+PfhPG9W/lVy5ramZlbvodr40rH8UAo/+DD6H/rYHgU=;
        b=RRw5BTtqAvrwS9+emiwJjMqd2O39pRgO3Zd3l5FJNxz3o2Hrm6wuIgWuEvYJeGLuiS
         NZDi+GQt2jNdsAoTzmoVu+FBqU1KrxU5cPyzWnCm0p3waCNglVKYCvf4rVZLr5V5Inzu
         CBRk4OaF1GT+b4FFidVfQieGY21560FxDis9VeeXvFJ+WhBxzwqxGl6FoqVbBt0ADvwz
         7KPF2QRTlOjt5dXmG9xPG4IgtGnumwCKO9Kz1I5k17CNhBmAjXFV+EkN+Z9FDDQNtE2y
         RJOFMketDAz/+GIDL4v7ZhxBm2Firm1lrroKJ98UiuVsq/mTQe2/+jsZY7EY79PBW5fi
         ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+PfhPG9W/lVy5ramZlbvodr40rH8UAo/+DD6H/rYHgU=;
        b=Hablxg8bL+PB7ySnTL2z8euQV7dzbE4a/d2/EOGV1Kg7WO0ib9FbhrGrn4K1tD6LZ/
         +dpv/lh3EhIPuafRKsUkrAIf1mEQPRL38zMEhDU8LZAUh5XUFiQFMba6EP+koK7boo1V
         5Efa3swdDLKVrVGlq9kWlpDUETriRtGGfbQcLEHuN0lp8qA4vjttG6WFKlS/moY/Cnod
         vGltD4XbdmL8RZDOqXZM48K61JpdMLSoFJIAsSpj8Co64zt8sxaogpyoV+9a9TA74guC
         XpNHokGWq1mOItYp0MnAXYxKwwz0idvuNyQtSA+s6GPgv8HOyvLlF3QNmXhpuMPcdKP1
         Yp7g==
X-Gm-Message-State: AOAM533TD68jYnG1pCrQo+13ce7h+hNmp1ftxUorSSbnSGYyDcM99Fl5
        ZBZyI4y1Y3fwjHIkqSSuEO0iHw==
X-Google-Smtp-Source: ABdhPJz1tPyRLt5iDx3vqQcqvJmS7pHTx2yQurIdV5JfgES/R1rDULM39SqHER96PakPtfNvMl/11w==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr7747441qkj.67.1631498041280;
        Sun, 12 Sep 2021 18:54:01 -0700 (PDT)
Received: from xanadu.home (modemcable108.170-21-96.mc.videotron.ca. [96.21.170.108])
        by smtp.gmail.com with ESMTPSA id t188sm4412807qkf.22.2021.09.12.18.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 18:54:01 -0700 (PDT)
Date:   Sun, 12 Sep 2021 21:54:00 -0400 (EDT)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Len Baker <len.baker@gmx.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded
 arithmetic
In-Reply-To: <20210912155135.7541-1-len.baker@gmx.com>
Message-ID: <0611r11-rsq7-2n9-n834-9o31rq8qo737@onlyvoer.pbz>
References: <20210912155135.7541-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, 12 Sep 2021, Len Baker wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  drivers/i3c/master/mipi-i3c-hci/hci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 80beb1d5be8f..f109923f6c3f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -98,7 +98,7 @@ struct hci_xfer {
> 
>  static inline struct hci_xfer *hci_alloc_xfer(unsigned int n)
>  {
> -	return kzalloc(sizeof(struct hci_xfer) * n, GFP_KERNEL);
> +	return kcalloc(n, sizeof(struct hci_xfer), GFP_KERNEL);
>  }
> 
>  static inline void hci_free_xfer(struct hci_xfer *xfer, unsigned int n)
> --
> 2.25.1
> 
> 
