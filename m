Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C3AC433DF
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3209320878
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7JWKDvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408456AbgJPXUC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407447AbgJPXUB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 19:20:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B51C061755
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:20:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id p21so2173181pju.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSA0nss07cUvcQ5IsoAAuUaAcStUlCCwoMhMOvnPjuc=;
        b=E7JWKDvcp+DcaYTepcBjxhkvOIWKMLK0tkkOdOefCcWzxEOPo77qZ0hCqI6aLQcYsf
         IRkn45oxP8duDlI29IjZD7uFewxmk2XGh3t0/T+Jq4yQ3q9S0qvRzRDLQGDuiG2y2WqZ
         1lvamQFNbx6b8epK7BMHjyNyvJcHy+q1/wbJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uSA0nss07cUvcQ5IsoAAuUaAcStUlCCwoMhMOvnPjuc=;
        b=bSt2ZYJCDQny7qpRI4fOqnakPDqZXcCod1HeeephWO58gFuXeHE8PmYLKT2u2oAy5G
         IYOzMHEgsd6Y2z+sHKPVNpi+oc9P1jKlKy/fgVLE1FrJqRvc8gFv1LwbtCZz0xmDfRyx
         AAO6on7kqsgEgn5xuTF5nyzn3zVI/uET8d4/C4vRN7DdufFUNJonXt+Je0JRSvBEm5LS
         Gm7ev3aUcUkdA7wDk05iiep+RGOLBfywFl5nND9cQrKB/YT7l0o0tZIHsnv+cgA5iO9Q
         0n9UMY5dKHDu9zDM2gTmmVi0rftDZTVx0ShrIl7nckJ4DOkyWURJGkYr6313Il38P09f
         hb1w==
X-Gm-Message-State: AOAM530Poq34lShLJrV25Hjg0Z3705JRkOvZ1Q8Iy8MZSlCaFh7Ft+4Q
        609DvuUVApGmRC3HHuUQGr+dg8ZZfpA/+w==
X-Google-Smtp-Source: ABdhPJwTJI1ivO9EQkKrcm1vW8dS1+z935MMVFzOAHhGN2KrYPV5S4Eht4edTDUWQHevH1EHcX5+zQ==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr6169340pjj.41.1602890401186;
        Fri, 16 Oct 2020 16:20:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d145sm4375135pfd.136.2020.10.16.16.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:20:00 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:19:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Fix unefficient call to memset before memcpu in
 nla_strlcpy.
Message-ID: <202010161618.8E214473@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201016125216.10922-2-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016125216.10922-2-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 16, 2020 at 02:52:14PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This patch solves part 1 of issue: https://github.com/KSPP/linux/issues/110
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  lib/nlattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index 74019c8ebf6b..ab96a5f4b9b8 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -731,8 +731,8 @@ size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
>  	if (dstsize > 0) {
>  		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
>  
> -		memset(dst, 0, dstsize);
>  		memcpy(dst, src, len);
> +		dst[len] = '\0';

I don't think this is right: callers are likely depending on the entire
destination buffer to be zero-padded. I think you probably want:

		memset(dst + len, 0, dstsize - len);
  		memcpy(dst, src, len);

(but double-check my pointer math)

>  	}
>  
>  	return srclen;
> -- 
> 2.20.1
> 

-- 
Kees Cook
