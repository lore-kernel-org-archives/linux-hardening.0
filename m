Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9561C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjAEEdU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Jan 2023 23:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAEEdT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Jan 2023 23:33:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FA6186D1
        for <linux-hardening@vger.kernel.org>; Wed,  4 Jan 2023 20:33:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9so21473213pll.9
        for <linux-hardening@vger.kernel.org>; Wed, 04 Jan 2023 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3P/yf/Hljx0yUONKxZmR3tzsFqGPhmtDq2uLfC/DAPI=;
        b=jauRVyhKIwkNePvpGC4NUNVr92nnvtr8JS2ouuCWzXeaLOGh4HNJWTDlqhB1fPEBDV
         CKAakJCtuzSw2WwlMb8mjBT4Ql4egtwlwjAUkWQ6As5W+O+JPKK80CvniYz3/0KselA6
         5xGKalkLRCFgU0Kc7OVV064La+CRnv7IXB5DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P/yf/Hljx0yUONKxZmR3tzsFqGPhmtDq2uLfC/DAPI=;
        b=JClFsaZsd9ObTu2OMPEoYMjzmbwUNCmBvaEFGFofBNLK8WGJHQfXrHXx6y3FQJnSb6
         ieIQiybaF0sscnfScC+DAkfwcCFdlWKLvuiZ5vOCwRkcFHHIoPK0qcrNLKwW4/buCZLY
         ZyHaHuzlcb8yuCazubSjDBnnwBBurH91UWLY1Q7oveWLzz/Do1Mjg1I187WaxevXlYt7
         jDNdEfvMaO/bXUbywyyLFpADRTk/l0Pcuhu25TXH3M6qj6EGNaZQUyX4H/fxgeyoRDqT
         Wkg79uoHDeH8tngncEMMQpsscoHeMGsGJd/tOwu50LDZUpFy4mD0wuOWjJxltKXixQ6g
         ui+g==
X-Gm-Message-State: AFqh2kqucOdQtPFz1s0ZnxDMgG+6+4kiH7IRR8+ddsPeyj/NBxnrVZRa
        WAMO4KVD9eLgS92aQtpZplzMrQ==
X-Google-Smtp-Source: AMrXdXs4aVvEZrtENUtxRpzVzMYSsjc5m1KZqdaufmQcznMSfcXfv+Q0wulk6C3zb5AZpsfz33RUwA==
X-Received: by 2002:a17:902:a513:b0:192:fe0a:11d4 with SMTP id s19-20020a170902a51300b00192fe0a11d4mr584152plq.64.1672893197721;
        Wed, 04 Jan 2023 20:33:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b00183c6784704sm24771489pln.291.2023.01.04.20.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 20:33:17 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:33:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        stable@vger.kernel.org, io-uring@vger.kernel.org,
        Dylan Yudaken <dylany@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] io_uring: Replace 0-length array with flexible array
Message-ID: <202301042032.C293ACB95@keescook>
References: <20230105033743.never.628-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105033743.never.628-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 04, 2023 at 07:37:48PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct io_uring_buf_ring's
> "bufs" with a flexible array member. (How is the size of this array
> verified?) Detected with GCC 13, using -fstrict-flex-arrays=3:
> 
> In function 'io_ring_buffer_select',
>     inlined from 'io_buffer_select' at io_uring/kbuf.c:183:10:
> io_uring/kbuf.c:141:23: warning: array subscript 255 is outside the bounds of an interior zero-length array 'struct io_uring_buf[0]' [-Wzero-length-bounds]
>   141 |                 buf = &br->bufs[head];
>       |                       ^~~~~~~~~~~~~~~
> In file included from include/linux/io_uring.h:7,
>                  from io_uring/kbuf.c:10:
> include/uapi/linux/io_uring.h: In function 'io_buffer_select':
> include/uapi/linux/io_uring.h:628:41: note: while referencing 'bufs'
>   628 |                 struct io_uring_buf     bufs[0];
>       |                                         ^~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: io-uring@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/linux/io_uring.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 2780bce62faf..9d8861899cde 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -625,7 +625,7 @@ struct io_uring_buf_ring {
>  			__u16	resv3;
>  			__u16	tail;
>  		};
> -		struct io_uring_buf	bufs[0];
> +		struct io_uring_buf	bufs[];
>  	};
>  };

Oops, please ignore. My test build misfired...

>  
> -- 
> 2.34.1
> 

-- 
Kees Cook
