Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEADEE49AD
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjHYVJm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHYVJc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 17:09:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CF211C
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:09:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26d2b3860daso858915a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692997770; x=1693602570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQKGwwST1RthAffY/CRFRLeYHHtXZCpUg2hQhGIx4VE=;
        b=TSZcbdThXszeLvs0Zj6M3SwxWft124El5SKYDwCciFgIwZ2ee0tZ1iXcboFpF36IMv
         Hdo0lgI16M5kW6ZJSO8AuM4AcTVaUUy4mzzi60OWhuyLvJ6Fkc3fby4YaOdxHPl/BfKg
         bRgNJg7iMfmVyiyd+Z/EMeG/Umc+vZsK5/L5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997770; x=1693602570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQKGwwST1RthAffY/CRFRLeYHHtXZCpUg2hQhGIx4VE=;
        b=Ny32r5bniMv6hLAtYI2Boh8Tot356pZb3ifbt58Miat3MbPpwOw9fLz2hI39zHgULU
         rl5OPNHLsnwmP3vDvSp2C3VcRJRSZzlRs4BVow7yygwovVpROyXgLSJgrAi9zThK9HQi
         SU7aWdL4jQ6xzlzedFaEqLM4l6IAwNzUhXqaneXBOxX3+1ipGOy2WT9BM72TbniIwZBi
         SqsEGlpMdx0fmzpV4R6mTzQMfGQv+ny2+Oi21fL1OKZGaGragbabCF8YjpET5oaVyXFz
         Te6ONUjN3zf0Xc7teYG0LVQLNogFD0hbyxA2fxy7AOlLcTtUjN9HJH3gaxdS1L4st680
         UTyg==
X-Gm-Message-State: AOJu0YyMQZinvyCLzhbYbc6RzkwQ8OJC1kZMKkhZ8IlPZAZBvGps5ysH
        ybkYGIASG1UakEmzfYwPNNGpP5XX+dPK6Jhr6Ek=
X-Google-Smtp-Source: AGHT+IGERcG56t83TTPVFatMxLLRcshSDdcsSXUxSZuSNShX74kT+RE54AoLlFIm3zuPsumzwFyZGA==
X-Received: by 2002:a17:90a:8a95:b0:268:b7a2:62e8 with SMTP id x21-20020a17090a8a9500b00268b7a262e8mr18640814pjn.7.1692997770466;
        Fri, 25 Aug 2023 14:09:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001b89891bfc4sm2178997plg.199.2023.08.25.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:09:29 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
Message-ID: <202308251409.D62880A8@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 24, 2023 at 09:06:51PM -0600, Gustavo A. R. Silva wrote:
> In a TLV encoding scheme, the Length part represents the length after
> the header containing the values for type and length. In this case,
> `tlv_len` should be:
> 
> tlv_len == (sizeof(*tlv_rxba) - 1) - sizeof(tlv_rxba->header) + tlv_bitmap_len
> 
> Notice that the `- 1` accounts for the one-element array `bitmap`, which
> 1-byte size is already included in `sizeof(*tlv_rxba)`.
> 
> So, if the above is correct, there is a double-counting of some members
> in `struct mwifiex_ie_types_rxba_sync`, when `tlv_buf_left` and `tmp`
> are calculated:
> 
> 968                 tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
> 969                 tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
> 
> in specific, members:
> 
> drivers/net/wireless/marvell/mwifiex/fw.h:777
>  777         u8 mac[ETH_ALEN];
>  778         u8 tid;
>  779         u8 reserved;
>  780         __le16 seq_num;
>  781         __le16 bitmap_len;
> 
> This is clearly wrong, and affects the subsequent decoding of data in
> `event_buf` through `tlv_rxba`:
> 
> 970                 tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
> 
> Fix this by using `sizeof(tlv_rxba->header)` instead of `sizeof(*tlv_rxba)`
> in the calculation of `tlv_buf_left` and `tmp`.
> 
> This results in the following binary differences before/after changes:
> 
> | drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
> | @@ -4698,11 +4698,11 @@
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:968
> |                 tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
> | -    1da7:      lea    -0x11(%rbx),%edx
> | +    1da7:      lea    -0x4(%rbx),%edx
> |      1daa:      movzwl %bp,%eax
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:969
> |                 tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
> | -    1dad:      lea    0x11(%r15,%rbp,1),%r15
> | +    1dad:      lea    0x4(%r15,%rbp,1),%r15
> 
> The above reflects the desired change: avoid counting 13 too many bytes;
> which is the total size of the double-counted members in
> `struct mwifiex_ie_types_rxba_sync`:
> 
> $ pahole -C mwifiex_ie_types_rxba_sync drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
> struct mwifiex_ie_types_rxba_sync {
> 	struct mwifiex_ie_types_header header;           /*     0     4 */
> 
>      |-----------------------------------------------------------------------
>      |  u8                         mac[6];               /*     4     6 */  |
>      |	u8                         tid;                  /*    10     1 */  |
>      |  u8                         reserved;             /*    11     1 */  |
>      | 	__le16                     seq_num;              /*    12     2 */  |
>      | 	__le16                     bitmap_len;           /*    14     2 */  |
>      |  u8                         bitmap[1];            /*    16     1 */  |
>      |----------------------------------------------------------------------|
> 								  | 13 bytes|
> 								  -----------
> 
> 	/* size: 17, cachelines: 1, members: 7 */
> 	/* last cacheline: 17 bytes */
> } __attribute__((__packed__));
> 
> Fixes: 99ffe72cdae4 ("mwifiex: process rxba_sync event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Excellent commit log!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
