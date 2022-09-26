Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4AC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIZWCA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiIZWBr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CCE36BC
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y136so8039633pfb.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jyUZYtxAtN1iTCX6RvQjDGcCuH9kvS5eYzROcFEThqY=;
        b=MzGhAq5OFEs2Jw3eI9RLQ+YxWhJkO64hQtgKbJilL0PzjLuQEVe9C+/uRy4PdTG8tz
         bG/i1MUi6O6fNF6xlb8WrrVfZWKq91jRdsDITIW/6qF8KZWGb0TzYKKhR/KIZDGttILa
         jSjcZeLBLVxe8wgx2SPAqVZWq/GXhl8HuDA9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jyUZYtxAtN1iTCX6RvQjDGcCuH9kvS5eYzROcFEThqY=;
        b=a9WEPg2i1e71wWg4swDd+rp+vgMunyOReTQ9o3xoX7CzmnXcDwq/3X3JKfNrNv4ljN
         9xBuuQLSkGJpBMF0GuyDuhFZJHxupQsTvON0bbedCgVreMxxmLFj75YULOzFUJesxCXV
         NpoXi/v3hf18V/yExtcx9y9ea5YxAHjnkIopyXR6VFpQdhXauOX1y1PV1BXFkeA4oVdv
         +JME6dRBxnoPQWYtYsNWOBsQEO4e3Tw1kXlUU/e+hs9xEblk4mgt95npprbf5TvZTdn8
         h7TYgQh5tWpxHXxImrzAtJ4014VsIccpjk+aNJm/UZm6jAAMtpbcMBb9YG+EOfZbjWCe
         peew==
X-Gm-Message-State: ACrzQf39F3eWca5+ahmyYSW+117h6gPeHEfFe0pFzYQOoPA5qyacvKNt
        qUVPAfu+HG5WyzwzpZDEafz5tQ==
X-Google-Smtp-Source: AMsMyM74ae4NJ4uEWNYiyk2e2ui6FrMQMT3qMJP8N0KnVh3xSmJR82MhWuJadxiI/Ex1FCEuybYffw==
X-Received: by 2002:a63:91c8:0:b0:438:d55c:4484 with SMTP id l191-20020a6391c8000000b00438d55c4484mr21974518pge.157.1664229702792;
        Mon, 26 Sep 2022 15:01:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b00173cfb184c0sm11728552pln.32.2022.09.26.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: talitos - Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.D540C881@keescook>
References: <YzIdiQLXup1qtf6l@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdiQLXup1qtf6l@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:45:45PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/216
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
