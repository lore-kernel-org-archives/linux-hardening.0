Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D138C83F37
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbjHaSm1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbjHaSmZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 14:42:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2A10CB
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 11:42:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68bee12e842so953128b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693507336; x=1694112136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz4a2x19zbfNUm77S91HyO3WUpP/Tfo2YEu/Zh4ddEg=;
        b=WXjYVGlH0bDciHH8xzHjB9eVOAkttQguc8MMRsSScYw+J4N/8KaJHTfSp1MWmWWnUd
         GHrUyzZwJw/UvN/xePqvWpS5c5mmD29Zumq2aWGlFBkde+9RBNEt6yFBd+7Uiuz+2PAp
         tNwaf/iv1Q47LHUllFNc7NeXiKzxyrQdsaK1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507336; x=1694112136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz4a2x19zbfNUm77S91HyO3WUpP/Tfo2YEu/Zh4ddEg=;
        b=GNnQf32drUBmO7hKjUBpSRwNOMAPQDYanNcqCh7xiv8WN2LZKKWJ5MHRJbDU4Vo913
         3VPGyr6ON7FJqZQPpbplHzx4MskO6FS5AxPDjsevErt9EZcWPxd7FTJG5Tt2QjjtLM+7
         xXXtVK47bk9rmhs1iSwFnUBOR7QT0dE/cWYgwQqX9CSbaWPXy9IbxQzKTdfb1NI91LRx
         HxHNexqPp4dUj3XSrq5O5JhQHTwG6QUGGsk9g6aYKGYun5xJC6udZ4cftijOcV29D+9F
         RpQiRiHep6gqyYmuYhVd/Vdks6FruVCpFegFNqvyiWWMGYYlYJHxxa0SLmc5Kx9iTdjp
         ESBw==
X-Gm-Message-State: AOJu0YwkICQf5fDMe3zKWBKUn4dHT3cVi0E1jzuRKT4RzpfNB/OCIbgS
        7RC9Ub6dUJUbbLQbSfkc1WQZVeWwtAxmB32tOvw=
X-Google-Smtp-Source: AGHT+IGMmkdigA5BBQO6iDcRuVwj0b/wtfySuh+4OgLVGbZtxIXHhrSkmvb+qgLuaThXCX4M+JQBeg==
X-Received: by 2002:a05:6a20:914f:b0:14c:de3:95e8 with SMTP id x15-20020a056a20914f00b0014c0de395e8mr611901pzc.52.1693507336493;
        Thu, 31 Aug 2023 11:42:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v25-20020aa78099000000b0068b1149ea4dsm1590960pff.69.2023.08.31.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:42:15 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:42:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
Message-ID: <202308311141.612BF8D@keescook>
References: <20230831143638.232596-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831143638.232596-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 02:36:38PM +0000, Azeem Shaikh wrote:
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
> v3:
>  * Address readability comment.
> 
> v2:
>  * Replace all instances of strlcpy in this file instead of just 1.
>  * https://lore.kernel.org/all/20230830210724.4156575-1-azeemshaikh38@gmail.com/
> 
> v1:
>  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/
> 
>  drivers/target/target_core_configfs.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 936e5ff1b209..d5860c1c1f46 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1392,16 +1392,16 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
>  	char *stripped = NULL;
> -	size_t len;
> +	ssize_t len;
>  	ssize_t ret;
> 
> -	len = strlcpy(buf, page, sizeof(buf));
> -	if (len < sizeof(buf)) {
> +	len = strscpy(buf, page, sizeof(buf));
> +	if (len > 0) {
>  		/* Strip any newline added from userspace. */
>  		stripped = strstrip(buf);
>  		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_VENDOR_LEN) {
> +	if (len < 0 || len > INQUIRY_VENDOR_LEN) {

Agh, sorry I missed this before: the first "if" needs to be "len >= 0"
otherwise this:

        ret = target_check_inquiry_data(stripped);

will be passing a NULL pointer...

-- 
Kees Cook
