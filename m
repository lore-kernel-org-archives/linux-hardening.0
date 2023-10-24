Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A63F4CC
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UrsQHYjU"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC1186
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d407bb15so41623675ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183242; x=1698788042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzgFevCEBoy3uNYPrdTwG0cJ6YSSUpVWwwpPOjVEOXo=;
        b=UrsQHYjUvTU6nRO+F5HIbo8Kn7YlSd3bp723ISocx5x6L4bdujmvKLROgdZd45Q7Iy
         NdpqM/jt2T8bnu5ZwkK2nQW3gB74zD3lBep5PN5XtakssfDl1XKDDA/wRDEaG2JzDudJ
         MUTWT2bPaPefwDrYxxWqHZXq38l2yaxJKzhP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183242; x=1698788042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzgFevCEBoy3uNYPrdTwG0cJ6YSSUpVWwwpPOjVEOXo=;
        b=EFgQYyS88HpCADUOVkNmdZWtGMl9C2Y2+RpOP57wuqmlI2x7YEDBOsAe+ddLStpSta
         7AXHGhoojLMq/WFtpb7mGQwbljfvs5eum05xPVs7X2a3SsBfkBrY3a4xCeNpPLx8n8Tt
         ypw1afDaiTR3BEciJ1Tc1u8EyVWzfdTD96UCkjgSHYPQbHsGUVqmuBXtBQ0j4KYgcwcJ
         +PcVMKuTeKmeRBrPoIG2IuMZhRUaFLGEhXNuXmGQGIGbicq7hORrcjIOCCycG69uw09/
         bwVH1nKkNVcWBxkI/ui3fGKaH8oo10zCKUZ34h8m64sPY7R0W9AWd6giVe7OmJr1VWvy
         QHWQ==
X-Gm-Message-State: AOJu0YzXJxfV41mZQ7V3s/ImzJVX6/8RxG6lon9Y/PB3+MCwz+kNQd0k
	DEC9KHfuhSsyvha9rbkS3oRxcw==
X-Google-Smtp-Source: AGHT+IG3/Sv64oN0pEa3F6T3eh9NZodgI82qw+e4xbTTKbOvoIpbPuuv5YdPvBGTxmOD/WWxRQbn/g==
X-Received: by 2002:a17:902:e5c3:b0:1c9:aac5:df1a with SMTP id u3-20020a170902e5c300b001c9aac5df1amr16061797plf.51.1698183242169;
        Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001c625acfed0sm7857910plb.44.2023.10.24.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:34:01 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:34:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath10k: replace deprecated strncpy with memcpy
Message-ID: <202310241428.0AA7B80@keescook>
References: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>

On Tue, Oct 24, 2023 at 05:42:16PM +0000, Justin Stitt wrote:
> strncpy() is deprecated [1] and we should prefer less ambiguous
> interfaces.
> 
> In this case, arvif->u.ap.ssid has its length maintained by
> arvif->u.ap.ssid_len which indicates it may not need to be
> NUL-terminated. Make this explicit with __nonstring and use a plain old
> memcpy.
> 
> This is also consistent with future copies into arvif->u.ap.ssid:
> 
> 	if (changed & BSS_CHANGED_SSID &&
> 	    vif->type == NL80211_IFTYPE_AP) {
> 		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
> 		if (vif->cfg.ssid_len)
> 			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
> 			       vif->cfg.ssid_len);
> 		arvif->u.ap.hidden_ssid = info->hidden_ssid;
> 	}
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - update subject to include wifi
> - prefer memcpy() over strtomem() (thanks Kalle, Jeff)
> - rebase onto 6.6-rc7 @d88520ad73b79e71
> - Link to v1: https://lore.kernel.org/r/20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/ath/ath10k/core.h | 2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 4b5239de4018..ba9795a8378a 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -607,7 +607,7 @@ struct ath10k_vif {
>  			u8 tim_bitmap[64];
>  			u8 tim_len;
>  			u32 ssid_len;
> -			u8 ssid[IEEE80211_MAX_SSID_LEN];
> +			u8 ssid[IEEE80211_MAX_SSID_LEN] __nonstring;
>  			bool hidden_ssid;
>  			/* P2P_IE with NoA attribute for P2P_GO case */
>  			u32 noa_len;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 03e7bc5b6c0b..f3f6deb354c6 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -6125,9 +6125,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
>  
>  		if (ieee80211_vif_is_mesh(vif)) {
>  			/* mesh doesn't use SSID but firmware needs it */
> -			strncpy(arvif->u.ap.ssid, "mesh",
> -				sizeof(arvif->u.ap.ssid));
>  			arvif->u.ap.ssid_len = 4;
> +			memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);

This is a behavior change, isn't it? i.e. arvif->u.ap.ssid is no longer
zero-padded. Is this actually ok for the driver?

-Kees

-- 
Kees Cook
