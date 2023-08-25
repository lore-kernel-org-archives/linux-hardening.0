Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D363EE49A0
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 21:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHYVLQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHYVKt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 17:10:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7F2114
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:10:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so755175b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692997846; x=1693602646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g+XMtH2uVcd/Xff9kVc8hNxYGD4VUSG8tsCVsq7nwQ=;
        b=nRAwuKFCb2SWRK+G2/m/pWH3P7qbIw5blthE0bbcJ3tqSvx9gQvl6yLT7iLwx5AODs
         WFd92SjNhDaLy/wimwxb92IaJthui7vbmAaW9UfrRjuuMVBTHlPPVP3TpSKd1ehm3gWO
         ZAWFsFp9ggcS6RN07E61j2ppTphWnzXVUaFuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997846; x=1693602646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g+XMtH2uVcd/Xff9kVc8hNxYGD4VUSG8tsCVsq7nwQ=;
        b=XUO0K+XvSb8NYgTnfESKfxamnZMskF3zODPgqSD9+J8wNRyguPukIPJGZ8JlC7+9qu
         WIL5TREkY1IS5koMFlpQuk9n04w2H1gFBR4mj1ZVSJyjMUziuMEQf18Jr9C0zCGzCGmg
         w9SdpDu2zPYbXQJG+ijWj4luxPrvB12SKUHPQ18d7Uhg6IAIgsA8xw3EIlY+6GFOUNwn
         leIknM2wDmF435LRN0VhO/XRzRL21VpnV1ZEZ6MBDsRKbWae4Dqk7xq0ilcw7Nxio7f0
         ifrKnDNyEiR66RuRSShAfuYmWKRyFY3oR8sOFVJBy4R9raPG8v68x2vejkdm3ULqE+IO
         vnXw==
X-Gm-Message-State: AOJu0YxMF1P91UObg8ypfZJjoIIH6ZiRgQ00MDuVByzSnTiYC1iQy55S
        IfoJiBaCx4UppOKaEgk0wFtHiA==
X-Google-Smtp-Source: AGHT+IHf9yEm1va+mcGEzYOWBCYUQs/vbpcCPXpBgpqcJ5V4v2iQU4jD8aPm42XEbXwQfdprL59J/g==
X-Received: by 2002:aa7:8887:0:b0:68a:51dc:50c0 with SMTP id z7-20020aa78887000000b0068a51dc50c0mr18354512pfe.32.1692997845932;
        Fri, 25 Aug 2023 14:10:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0068892c40253sm1973202pfn.216.2023.08.25.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:10:45 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:10:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and
 tlv_bitmap_len
Message-ID: <202308251410.8DAA6AC5E@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> Add sanity checks for both `tlv_len` and `tlv_bitmap_len` before
> decoding data from `event_buf`.
> 
> This prevents any malicious or buggy firmware from overflowing
> `event_buf` through large values for `tlv_len` and `tlv_bitmap_len`.
> 
> Suggested-by: Dan Williams <dcbw@redhat.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Fix format specifier: %ld -> %zu
>    | Reported-by: kernel test robot <lkp@intel.com>
>    | Closes: https://lore.kernel.org/oe-kbuild-all/202308240844.leyoOwdG-lkp@intel.com/
> 
>  - Update warning messages to explicitly mention that TLV size is
>    greater than tlv_buf_len.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org/
> 
>  .../net/wireless/marvell/mwifiex/11n_rxreorder.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index 735aac52bdc4..10690e82358b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -921,6 +921,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
>  	while (tlv_buf_left > sizeof(*tlv_rxba)) {
>  		tlv_type = le16_to_cpu(tlv_rxba->header.type);
>  		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
> +		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
> +			mwifiex_dbg(priv->adapter, WARN,
> +				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
> +				    size_add(sizeof(tlv_rxba->header), tlv_len),
> +				    tlv_buf_left);

With the suggested change to make this a warning and not dbg:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> +			return;
> +		}
> +
>  		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
>  			mwifiex_dbg(priv->adapter, ERROR,
>  				    "Wrong TLV id=0x%x\n", tlv_type);
> @@ -929,6 +937,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
>  
>  		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
>  		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
> +		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
> +			mwifiex_dbg(priv->adapter, WARN,
> +				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
> +				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
> +				    tlv_buf_left);
> +			return;
> +		}
> +
>  		mwifiex_dbg(priv->adapter, INFO,
>  			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
>  			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
> -- 
> 2.34.1
> 

-- 
Kees Cook
