Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6422172C;
	Mon,  7 Apr 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051938; cv=none; b=bUm9hMUsmchF9/1L6XFlNMZ6QRMSP3/gXEQi4g5JqDQgBBh/aJhG3HnaO0igPuZ8liel2wDJvQuDwkTt/SCXm+YrDvXhORqFxH0xGiu+Lc8/FqvDI6Fkc6GOFho1iKFtuS3lVw7z46lxAtFosSus5mH7LayDVwsBFXB5p2rHb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051938; c=relaxed/simple;
	bh=/cjh5PTdngsV2rrZrVQpnhYg1pc1i3/7ohYYCmKkUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsCK9/kSuFzYE6zOqHOBNVXoTxHZv0Pn/HUqdW8x07lpwRBxsUc2kFwi8Or4UVsCOrTrJ+6Vz0MX4XWY6n/VEuo1yqfs4YlFCzKaYSI2pzfkBnjjWH+UKhYa50/qNghLzLKEcca+52WiHwftnxfICi6vEok4Sjq5MV37i113VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJUIBZbg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJUIBZbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6D7C4CEED;
	Mon,  7 Apr 2025 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051938;
	bh=/cjh5PTdngsV2rrZrVQpnhYg1pc1i3/7ohYYCmKkUDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJUIBZbgzdqsmwDFK1kzCKIdu3zeLbwBgM12jT2a46x0KSiib2ka5d8S4fV8IMWIv
	 P5sf7L+3zfcobE4jo65DG/gr/AubQ6Ed2K47vFYL5JaE0kYl/zRd01qgKV1VoxxuY1
	 IXpBiFFYwjDCaa/p7omVQuKtuXvzRl6A2+7tmJ/5JDb7xWFe9DoXtn1YuXe8lgDOqb
	 yPIOuRQHw69LsH4mK8+oyBpHo92g6w3hA28dtnnAFRWHpnPhbrSrgoWe6C6cRQVwnx
	 b48AT4yMQOVSTqgSXP9DoXWSivY+2W76PaS05mRC0EgDbdSHjp99V3diSD/D0371wG
	 rLjeTS4l2SyIg==
Date: Mon, 7 Apr 2025 11:52:13 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: gadget: uvc: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071148.6F55B7AF34@keescook>
References: <Z9dyY7_ydJiGqh_d@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9dyY7_ydJiGqh_d@kspp>

On Mon, Mar 17, 2025 at 11:22:51AM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct uvc_input_header_descriptor` is a flexible structure --a
> structure that contains a flexible-array member.
> 
> With this, fix three of the following warnings:
> 
> drivers/usb/gadget/function/uvc_configfs.h:77:57: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/usb/gadget/function/uvc_configfs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.h b/drivers/usb/gadget/function/uvc_configfs.h
> index 2f78cd4f396f..9391614135e9 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.h
> +++ b/drivers/usb/gadget/function/uvc_configfs.h
> @@ -74,10 +74,12 @@ static inline struct uvcg_format *to_uvcg_format(struct config_item *item)
>  
>  struct uvcg_streaming_header {
>  	struct config_item				item;
> -	struct uvc_input_header_descriptor		desc;
>  	unsigned					linked;
>  	struct list_head				formats;
>  	unsigned					num_fmt;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct uvc_input_header_descriptor		desc;
>  };
>  
>  static inline struct uvcg_streaming_header *to_uvcg_streaming_header(struct config_item *item)

This looks correct to me, and may be fixing some bugs -- I can see the
allocation routine for this is already expecting the bmaControls (in
desc) to be trailing:

                /* bmaControls */
                *size += h->num_fmt * UVCG_STREAMING_CONTROL_SIZE;

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
