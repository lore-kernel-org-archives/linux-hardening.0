Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3243698
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHzg7jHM"
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC40101
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 15:05:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-58916df84c8so3144470a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696889124; x=1697493924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rIbMEY0KLZuTJXGkvyS53BfVxkGFGvroxWH8XJdJsI=;
        b=DHzg7jHM90iHDjEjpMVZsxcPKECro4TSt3cw2gx2SqVlX+MA+mZSTS2TB4w4cdejL3
         5FBrDWCWG55KCfaiqXU/fojQuiefCwEdEgBf7tX1366TdltsrZ4Rz99QvJefA6eHEiuo
         sgf9lc4KpbU7hjV4u+SqHHloTnvhlonluxnHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889124; x=1697493924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rIbMEY0KLZuTJXGkvyS53BfVxkGFGvroxWH8XJdJsI=;
        b=ftuN75NF+L8sDOI+lzoQMBQNYs0gLEAqljp/x4UprJEIRDXhEt9HoLgoEqLNyz2W2Z
         zGp+eyBpII7V7asmX+jFcAXgHdjE0C3mMaPLw0tfi3erPnBVYaBO8JYT/iG/kvfGC26S
         Tq7zl587I0QZXgpGf2PPbS810tJDGWLuVyGaVKAmpFCwCMZIHI9wtU0WcGMA/9ZxZzH4
         wbACcBACQt7cLI8JKIfwT702Hw64xJ8kRjv0LgvT58yhAdTFXP8AzpErJEXx+R8qE072
         C0nXZ2WhazpTiRqJIdT75aH0wSPVti5dOZyG6uA0/h2FsqW7tp1A0gwKzkjTJuzzqOhe
         OVow==
X-Gm-Message-State: AOJu0YwrOv2AtgCah3SGs9i1waP9s0srrRpLD/6oxazNm0DawYZVZYkY
	25lc7j5mKetRl6JiSO2K+Fbzhg==
X-Google-Smtp-Source: AGHT+IEBCqtLNAeRUJEeWjcTOnSv1UFgTNeaa9XXwYbRiU7M2LJKxYcai3apehX/wjgyfixLRc3kcA==
X-Received: by 2002:a05:6a20:d41e:b0:16b:74bb:e57e with SMTP id il30-20020a056a20d41e00b0016b74bbe57emr8200777pzb.12.1696889124175;
        Mon, 09 Oct 2023 15:05:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c12-20020aa78e0c000000b006933866fd21sm6918310pfr.117.2023.10.09.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:05:23 -0700 (PDT)
Date: Mon, 9 Oct 2023 15:05:21 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: brcmfmac: fweh: Add __counted_by for struct
 brcmf_fweh_queue_item and use struct_size()
Message-ID: <202310091505.396E92C3@keescook>
References: <ZSRzrIe0345eymk2@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRzrIe0345eymk2@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 03:42:04PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `event->datalen = datalen;` to before calling
> `memcpy(event->data, data, datalen);`, so that the __counted_by
> annotation has effect, and flex-array member `data` can be properly
> bounds-checked at run-time.
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yeah, looks right. Thanks for moving the count assignment.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> index dac7eb77799b..68960ae98987 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> @@ -33,7 +33,7 @@ struct brcmf_fweh_queue_item {
>  	u8 ifaddr[ETH_ALEN];
>  	struct brcmf_event_msg_be emsg;
>  	u32 datalen;
> -	u8 data[];
> +	u8 data[] __counted_by(datalen);
>  };
>  
>  /*
> @@ -418,17 +418,17 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
>  	    datalen + sizeof(*event_packet) > packet_len)
>  		return;
>  
> -	event = kzalloc(sizeof(*event) + datalen, gfp);
> +	event = kzalloc(struct_size(event, data, datalen), gfp);
>  	if (!event)
>  		return;
>  
> +	event->datalen = datalen;
>  	event->code = code;
>  	event->ifidx = event_packet->msg.ifidx;
>  
>  	/* use memcpy to get aligned event message */
>  	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
>  	memcpy(event->data, data, datalen);
> -	event->datalen = datalen;
>  	memcpy(event->ifaddr, event_packet->eth.h_dest, ETH_ALEN);
>  
>  	brcmf_fweh_queue_event(fweh, event);
> -- 
> 2.34.1
> 
> 

-- 
Kees Cook
