Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0505C001B0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 00:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjHIAmv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHIAmu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 20:42:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424391995
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 17:42:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc7e65ea44so2989235ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691541770; x=1692146570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i01tCZPNe6L9U5Q4HebDp2m0Pk6TUjD+eZo+m4Fm8ns=;
        b=gtcdoSyHJhxAjQa1WvyqmpaathCr/egiED4WO3SKFud6eIw5LPxYjENlnuN2v/8pP+
         7JomdzFIf0P2WpawQxVK/R6ri5DnSGPw5O9u2GvuVV/9icqfaiRNoA8PW7mEvWUT59pq
         3/wAgET0vY3axeGQ+MZMFdDDUt5UNEVOt19vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541770; x=1692146570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i01tCZPNe6L9U5Q4HebDp2m0Pk6TUjD+eZo+m4Fm8ns=;
        b=efuiCIUe74Yt/Q3TvqrlN66TIj5nQyoZHAa21ZYia4OYfz7pzaFNSy3LCiKXFrrxlR
         ZWq12JuQYMLI8dycLHIOc1U0UJnR4fQHx684pjaJXo3Z5z/yQfLePXnnzxKDH03XXegP
         9+s6j4Yaoa8+XeZ5nBsFoA7iCaMcfuDE623DlAxKWF8OJ5j2XItl3KN6XJ/Ltj8uH8oD
         B6yeQA03e3BwTReZetaXJzeI95HOIXzrylQUdCR5PK8nuFmKSqH/qGcEu3+9Q9ywIQK0
         wavhFPGEjVbhqwDeQ0LyqALAoURs1cHbPtOxa3fCvFJlMYKiXh0+SLKkCdW7U+dr+//u
         sSOw==
X-Gm-Message-State: AOJu0YzrXFmy03UC62DD76860pHr2UODgT35XzblR28/RA1RVtJkXIiA
        4OsyH3x1utEuEC1rDuZfzF6W/A==
X-Google-Smtp-Source: AGHT+IHy3qTOPxKTcKRTqd3zRSKuJlFunxAWjvfw0+BfXbsWDF1K1YF+/1raLGejZ1cQHbGkVrHTUg==
X-Received: by 2002:a17:902:ec8e:b0:1bb:cd5a:ba53 with SMTP id x14-20020a170902ec8e00b001bbcd5aba53mr14009044plg.14.1691541769687;
        Tue, 08 Aug 2023 17:42:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001b890b3bbb1sm9631074plw.211.2023.08.08.17.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:42:49 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:42:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] um: refactor deprecated strncpy to strtomem
Message-ID: <202308081742.47A777CEF@keescook>
References: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 08, 2023 at 09:17:35PM +0000, Justin Stitt wrote:
> Favor a more robust and less ambiguous interface over `strncpy`.
> 
> Use `strtomem` here since `console_buf` is not expected to be
> NUL-terminated.
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Keep usage of ARRAY_SIZE (thanks Bill)
> - Remove unnecessary import (thanks Kees and Bill)
> - Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
> ---
> Notes:
> I only build tested this patch.
> 
> I am also making an assumption that `console_buf` need not be
> NUL-terminated. Am I right in believing this?
> ---
>  arch/um/drivers/mconsole_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> index 5026e7b9adfe..d5fa9c8dcd18 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -554,7 +554,7 @@ struct mconsole_output {
>  
>  static DEFINE_SPINLOCK(client_lock);
>  static LIST_HEAD(clients);
> -static char console_buf[MCONSOLE_MAX_DATA];
> +static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
>  
>  static void console_write(struct console *console, const char *string,
>  			  unsigned int len)
> @@ -567,7 +567,7 @@ static void console_write(struct console *console, const char *string,
>  
>  	while (len > 0) {
>  		n = min((size_t) len, ARRAY_SIZE(console_buf));
> -		strncpy(console_buf, string, n);
> +		strtomem(console_buf, string);

See my reply to v1: I think this should just be memcpy(console_buf, string, n)

-Kees

>  		string += n;
>  		len -= n;
>  
> 
> ---
> base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> change-id: 20230807-arch-um-3ef24413427e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
