Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C7C32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiIZWCv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiIZWCW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:02:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19DE11C2
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso8263954pjm.5
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qj/rlMAzv9fMg5FuS4NiEjLu9sI/usrFEsXRahlge0E=;
        b=GBEigg8BnMS+VYk23Q4ZmTb+E5BWgrOqvEWvUreJpETHfR+XdKseHhYdNc4tsltgMz
         s4v2Lr+ZvgSCioJ3z3JN8PT+akqP+R7AZyonY8FjkZO3t6QBeEGL8fOaQ1M21Ak00s8z
         u5AsvSSsGir2Pd2/F/wXJ446swZYDBiAdnTFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qj/rlMAzv9fMg5FuS4NiEjLu9sI/usrFEsXRahlge0E=;
        b=YE6S/jQMThVN+G7sPFhqlkYsiobJNNhdSV2tgUXeyI1RxhUdYVqosGocD4Evhk8luC
         YECbuAzSrRYbrWWss+2tKXRORPBYP836s8xUpF4mGX/NL7tFkaIg2U8KgUKG2Njy+8JD
         4Hr2m8qAt4bMU8Nsv1gqRnhXJmUapDZ8aggzHtSzTQpBaK3hL/HWtKQ1AtNiMyja9KKG
         alnDSMSoonU3HYpz4KxhaQS/9rcwNkK/XeHlrc6dOStMdDk+0WzJ5Uj6fnql0fJFGSvH
         8Qb0qWbFLxVvqZBCcSU35lsNbgcw4DWelQC3WkQ30hg4y7NJ2qN3uLRPyk61N8lJ/Lwb
         HXaQ==
X-Gm-Message-State: ACrzQf2ERyMN2ajt1cX23uRt02ZGeze05wCWpMuBfjjve8loe4e/sy4R
        7Bx6mgoY9lfZdlOzMNDfUqW+9w==
X-Google-Smtp-Source: AMsMyM70ikX80wxOPu3LibTpDGV3/8vxdXB9poqRgI/Xx03fmcB9OAAaI/KVZo8cuHBGqhMQ+MvSJw==
X-Received: by 2002:a17:90b:1d8b:b0:203:246e:4323 with SMTP id pf11-20020a17090b1d8b00b00203246e4323mr923040pjb.192.1664229732910;
        Mon, 26 Sep 2022 15:02:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b00176c89243fcsm11794460plx.179.2022.09.26.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:12 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Input: applespi - replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.60C97A49@keescook>
References: <YzIeJeqU73G+UI8g@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIeJeqU73G+UI8g@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:48:21PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/219
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
