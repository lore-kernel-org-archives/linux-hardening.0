Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8857C6C9
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593842; cv=none; b=rggN1wRX0uKQKSj0HPIBpmfjpu3jX6r2p8neS8V8vLgRNpMKUpvByttmKR5TtnMN9ODF7yL5Ob219SogtmzW7v5sQOpZY8L4RWmcysGyCcZDmUt2XVobZkaSz9yucewDKcqGmykbXvspHjxNs0KAsRRRyO/2PargYO5FDeO0AgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593842; c=relaxed/simple;
	bh=wMZzStv0WI94dHIupt/3qTiQCvxmwKcJlo5DxooTw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULKVTei3ei1psuHUUqTJWTDcEej9yXue8foJMh2zsWKAiyr7jDqRqwhxqO8MWP6/js6T3w7FXdHePtjZYw0SRa3VAm5dBoZjdYUXh/D1mTHj6mxT1tYL6kYT0Tc4Yh7UFoqfmKkUU4JX7Ij/AaczckBsjOlm/gnSEbwtpQ5l1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dfEtAnKm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dfEtAnKm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4437034a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709593840; x=1710198640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9msUTwBa3XNDAwjjPAvGjEpS0Gd3hVi8Z81nRq0fsvc=;
        b=dfEtAnKmFSMK5QWlit8fTzTecWDN5ME/pgJL4QkLqSdE4mkkS77SfxSbjBmWp1hkAh
         J/EecDWUnQQ7w62Utyq7enewe3MBG1fb2R5hF6butE1B6l7qkt/6So861QHDjisYX/Kc
         0MU731QMcrPf0FsM5Lx3MHnE/Hc/Zkxm9/ylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593840; x=1710198640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9msUTwBa3XNDAwjjPAvGjEpS0Gd3hVi8Z81nRq0fsvc=;
        b=b0bJp5sB/JAm2pYn1mhShcOUQWm0VCBX6vwsZ2wWAfULuC674CtwArpsQjuJXKFmkr
         /GeAjPIMucnXFEcZ76EVNr9XFUYOxybU8cSZcMHFVTBLsX3U4ct6sTL/SVfqfNw+dqgY
         Wizca4BdQXtQku3ymmrxK0yfLwPXp3qx8y9abMYDQLt12KtpS4pPnzY/xOdcX7kz4zKl
         omVP8H9m6UrLSraaVD/lUo2vd45TkmOmrFu5vdhiVSZxnv3VNla0E1VvX/6IzsR0JjxX
         uXQK4gtGcj1U5+LETYnS2+/OiD5sWrzk1wf9xwVkLsRzMBW26RWQUdCfbIfLI9SDE5Qn
         KP4g==
X-Forwarded-Encrypted: i=1; AJvYcCVaBI3X3v899ME5vkZq/RCN5m3jO9X2VLjm6Zh/59B+fSojuRB+5npb24dI6+khnJUp/2r589j4VkQ7F/1XoJvMPi4hdagBSOv5qOt/50w4
X-Gm-Message-State: AOJu0Yw1rW6m9ckoVvvor1MzJZVPVKsjNO02NItSLcZQxG3ilsTlo+Ql
	Hj3wRuM722MAjbCREaOXwltWhKZhFhXwmoU4FDoY3itCSevTGdcfhCLEeG/mYg==
X-Google-Smtp-Source: AGHT+IEbAr3Hucp75eD8JSPbmT5fSEjkHtUZ6q2D8D6DXvd41jaoEyXkI1zB44xifF8tsNHZEQjQpA==
X-Received: by 2002:a17:90a:e548:b0:29b:1bc5:cfda with SMTP id ei8-20020a17090ae54800b0029b1bc5cfdamr1080411pjb.16.1709593840120;
        Mon, 04 Mar 2024 15:10:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b00298f2ad430csm8380840pjb.0.2024.03.04.15.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:10:39 -0800 (PST)
Date: Mon, 4 Mar 2024 15:10:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Alex Elder <elder@ieee.org>
Cc: Alex Elder <elder@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] greybus: Avoid fake flexible array for response data
Message-ID: <202403041507.BEF59739@keescook>
References: <20240304211940.it.083-kees@kernel.org>
 <1c5ab1e7-ac66-438c-bc49-0785810e9355@ieee.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5ab1e7-ac66-438c-bc49-0785810e9355@ieee.org>

On Mon, Mar 04, 2024 at 04:45:11PM -0600, Alex Elder wrote:
> On 3/4/24 3:19 PM, Kees Cook wrote:
> > FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> > code base has been converted to flexible arrays. In order to enforce
> > the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> > destinations need to be handled. Instead of converting an empty struct
> > into using a flexible array, just directly use a pointer without any
> > additional indirection. Remove struct gb_bootrom_get_firmware_response
> > and struct gb_fw_download_fetch_firmware_response.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for adding the comments!  This looks good to me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> 
> 
> I want to call attention to a few other spots that should
> get a little more attention--related directly to what you're
> doing here.
> 
> I noticed that the GB_CONTROL_TYPE_GET_MANIFEST response
> structure also contains only a flexible array.  It might
> be good to add a similar comment in gb_interface_enable(),
> above this line:
>         manifest = kmalloc(size, GFP_KERNEL);
> The definition of the gb_control_get_manifest_response structure
> could probably be replaced with a comment.
> 
> 
> The response buffer for an I2C transfer consists only of incoming
> data.  There is already a comment in gb_i2c_operation_create()
> that says this:
>         /* Response consists only of incoming data */
> The definition of the gb_i2c_transfer_response structure should
> then go away, in favor of a comment saying this.
> 
> The response buffer for a SPI transfer consists only of incoming
> data.  It is used three times in "driver/staging/greybus/spilib.c":
> - calc_rx_xfer_size() subtracts the size of the response structure,
>   and that should be replaced by a comment (and the structure
>   definition should go away)
> - gb_spi_decode_response() takes the response structure as an
>   argument.  That could be replaced with a void pointer instead,
>   with a comment.
> - gb_spi_transfer_one_message() is what passes the response buffer
>   to gb_spi_decode_response(), and could be adjusted to reflect
>   that the response consists only of data--rather than a struct
>   containing only a flexible array.
> 
> 
> Kees:  I'm *not* asking you to deal with these, I'm just mentioning
> them to you.  My comments above (without someone else confirming)
> are not sufficient to dictate how to address these.

Okay, thanks! Yeah, I took a look at struct gb_i2c_transfer_response and
I think it might trip the memcpy checking too since it's zero sized, but
it's on the source side, which isn't as strictly checked.

I'll add a TODO item to track these, though.

-Kees

-- 
Kees Cook
