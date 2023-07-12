Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB7C001B0
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGLT66 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGLT65 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 15:58:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9A1FE5
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso4245040b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689191935; x=1691783935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IM1dSYo+80BYxXSJlIL/sk/xBjg6Ots+Pol0AVH4Yb0=;
        b=kN0riAjmUZltvjS1ZZu/cmL9YDBQwpNyRLMnVeyJUsFYI7J0wzmmClyaLlqoVavvmR
         HX0aXQxW3ZgAMNfjI5b5Zwx9uGTFHByzmco0yjmVtRRTEK4R9DkGvVDg6OGwrOpdcj56
         K19maljE78z0Ngq7vlqpfwfvl2QxEWWBAC8oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191935; x=1691783935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM1dSYo+80BYxXSJlIL/sk/xBjg6Ots+Pol0AVH4Yb0=;
        b=fcm5PvuW2mDCpM+hFhVHxHDEapceuPF3QuG26/F65TyNVoOe6mqXQJyIVjQ2bGGvzI
         Sxze/q8vxOnr/xf9UnpONbdclY19yU75QWsDQf8jEdQyuHJ+l7Y9CfgM955PQadk4u+o
         o+BFwHLRM/0DBWjX6wW21CxOPjL88KgYCxRP3W0HpRuFOniF6juW/mSxXq77qOa1LFMU
         wgeMDjMKZVjyUpC3hNqh49/NYDL+nVSUoHNnnl7BqNthy8+fkhw8TgifYe0NQK2Xw9Ne
         BOkzwMdjTXF//t5zZ46FAkRa8LUxxnZofmsSWD52Mlt9UZgmmrvah2r6oplkThmG409t
         /R1Q==
X-Gm-Message-State: ABy/qLYhnzVm7wi5682bBVHLCCC76hZyJ9ynD62UTLmFWVuWbQ7VFl3R
        6QesdaatyfU5FaHXa0EQf7BjmA==
X-Google-Smtp-Source: APBJJlE4+AsaRrpGGfmncTL94MB7s8dvZvP4yBy4eC77VHo8u3xCXxW7nvKcyGe+QqgE6q1NDBivMQ==
X-Received: by 2002:a05:6a20:e685:b0:132:c11d:4582 with SMTP id mz5-20020a056a20e68500b00132c11d4582mr2302449pzb.3.1689191935305;
        Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b0068285a7f107sm4080729pfm.177.2023.07.12.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:58:54 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:58:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 29/32] lib/string_helpers: string_get_size() now returns
 characters wrote
Message-ID: <202307121248.36919B223@keescook>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-30-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-30-kent.overstreet@linux.dev>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 09, 2023 at 12:56:54PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> printbuf now needs to know the number of characters that would have been
> written if the buffer was too small, like snprintf(); this changes
> string_get_size() to return the the return value of snprintf().

Unfortunately, snprintf doesn't return characters written, it return
what it TRIED to write, and can cause a lot of problems[1]. This patch
would be fine with me if the snprintf was also replaced by scnprintf,
which will return the actual string length copied (or 0) *not* including
the trailing %NUL.

> [...]
> @@ -126,8 +126,8 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	else
>  		unit = units_str[units][i];
>  
> -	snprintf(buf, len, "%u%s %s", (u32)size,
> -		 tmp, unit);
> +	return snprintf(buf, len, "%u%s %s", (u32)size,
> +			tmp, unit);

-Kees

[1] https://github.com/KSPP/linux/issues/105

-- 
Kees Cook
