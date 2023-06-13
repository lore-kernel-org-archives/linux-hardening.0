Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF07BEB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFMTal (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjFMTad (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:30:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D4DE6F
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-651f2f38634so5949467b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684632; x=1689276632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9zTL6WkhKlD8rEo4R4d64UgNtBnLNYoZuMTJCOlN+o=;
        b=lAMvXmQMui7zMEyr/DPCNp/XJdds6GKxaPeycgssCkQOE9zzABt+B60heDpSUwgub0
         T6bl3aZRtjyB2UGO/F2+mtawwBoFCu/22qjqzmBMJ9z9SsfbQZQbgXgl2OD8h6SxyF2f
         qS0QoHEZtRplgwwONhm390XaklAvofry7DfpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684632; x=1689276632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9zTL6WkhKlD8rEo4R4d64UgNtBnLNYoZuMTJCOlN+o=;
        b=Y8arYLRMZaMBjSJ4mDAKRnGEI7K2Sa0jF6xoRIVh4oU3Dx4KOMuUE1aOMys4aMTz49
         zKydItkw9C2Vwmgx8JScZaZwDp7GjZPG1ElULUraXvgnAo9LhCd9TNvPlj3mWESgwHWI
         vt/BaZ/t2oQ4zXLpBdw2bFS6QOMItgxS/0CzGZeMMwuMPQ0iwMt6yeaUC/6a9nUkiel5
         Fhz2o7gV/hFWNknu3GjaVCu6w21/6eG8IlzbJJnnDmMuYkFeYQ9RW7QEwywglp7/j0sP
         FkBgqHRsnQLv4z31FTGGI2lr3rBL2pJUPJJ4BF+AJKWXEAFbs/vhYMpjuY34KhR+9xUM
         7GWg==
X-Gm-Message-State: AC+VfDzJ4fBkz31waMPgWqw6se75+NsLCPPXD7Mhci4muUMl6ytcPDxD
        oT+VfKlhAaa2BfEeIYZL0Cu+4Ie5HS2QZskQ1aA=
X-Google-Smtp-Source: ACHHUZ6N9gkZEMIB3vFpJ9HaIYshp93Z/o2OR28UTSw5/MCUvWPAgeLhGW714sGpBVb0mutFqUP4Mw==
X-Received: by 2002:a05:6a20:7491:b0:118:c4c1:e0ed with SMTP id p17-20020a056a20749100b00118c4c1e0edmr16540792pzd.30.1686684632312;
        Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 31-20020a630a1f000000b005348af1b84csm9761797pgk.74.2023.06.13.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:30:31 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:30:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Replace strlcpy with
 strscpy
Message-ID: <202306131229.B5F2D9F@keescook>
References: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 12:43:41AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -E2BIG
> is used to check for truncation instead of sizeof(dest).

Perhaps say "PAGE_SIZE" here instead of sizeof(dest)?

> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/usb/gadget/function/f_printer.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 28db3e336e7d..10dc7c55c25f 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1211,8 +1211,8 @@ static ssize_t f_printer_opts_pnp_string_show(struct config_item *item,
>  	if (!opts->pnp_string)
>  		goto unlock;
>  
> -	result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
> -	if (result >= PAGE_SIZE) {
> +	result = strscpy(page, opts->pnp_string, PAGE_SIZE);
> +	if (result == -E2BIG) {

I think "< 1" might be a better test here.

>  		result = PAGE_SIZE;
>  	} else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {
>  		page[result++] = '\n';
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 

-Kees

-- 
Kees Cook
