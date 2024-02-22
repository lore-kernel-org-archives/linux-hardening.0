Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE44321D
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561835; cv=none; b=S2wbwr6mAY/1dKhUFnVtoy0utBhRHEboXV1UTHThkuOaSEgBgMuuasfiLTHXyHw05rFIgHBiIq/g5mYgOVXkJge9RkFv1FjLk+xBgZ0KiS/IGJsrIbU31VyBXEj1LhiHTTPw6V8+INVkfuiGG/7FOcvtKQfcMGSlW08WGNn+tQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561835; c=relaxed/simple;
	bh=0a+PXUr4/M4QxUhsk3p3ht76EXkTT/vUlf3xCYroLtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7GkDU3WLXOJ0Htv0czbRRq3ZV8RvHe1FPpzUmUz7af3JUnTymKsoP0BcrzUt1yzpH0qndFwlHQQzjGJJJ7PRAFfnzbGLvXjkYBaPr5t0WCs7XeOe3Cmmw15syqiFXEY1HA13DXSLlpg3JnQMXkxgSYB/Tr3G+82uTgyUQ4dW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FewjVpXr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FewjVpXr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so873547a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708561833; x=1709166633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cphzXha2ug67Fvg8bHldw5MnRmdUMWu6AQ/eN1G60FM=;
        b=FewjVpXrIrXCAek5YMytycaY9A9MQ2RoFd3GLoRK2WyUbT57vK63pWTQjLE7j7ugiX
         nPWzTjI6JiIvnZ6HIzDShW6NbJYJs2Qo3e26peOn8PjRFSgB1gIlF5l4r9fFkVB11kVU
         N9pxagOfd4lKZF/jSVOGF/q8qW7XLoBsp1oRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561833; x=1709166633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cphzXha2ug67Fvg8bHldw5MnRmdUMWu6AQ/eN1G60FM=;
        b=ChyGYFOR+Nw1n8cNr1LUMnF2rOQiReIa/6LsUzuEnQIwd1GrbwbB5ABjehIB0/7yx4
         CvXUm9ltyL54siWLxJ+0NILhNBrF7KHTWxVRcV1fY7J/yqeg+IUts8AjgR564WjExVrU
         md1xZD7uy4Sf4Ga3ZMqBGvncDYECs+mU/xSLXeUo9i+EB1f+3WgOPXnvpHsptbv3TLcd
         UxN9SmIktlsDzk1ELq8aHvwYVanwvxGa8L5AY0fNsjTJvV65j/+gvVjioz6eEiodBj4s
         cFYjkLWxuW1pV2k+uhFmyIbWGLlDRJVtsJGy4Mk1ylreyARtv8uo9pp/8kiAcTVtkgT0
         oxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXYqVZR9mivX91neSOGiV+mb58PkkAvlSIdPOEpmJ33Dnb68RD6jeQAc71hkw/Ke2MgpPkjOI5aVJi+b7JtC4sAlqbU8BJnVTXeYjflmb2d
X-Gm-Message-State: AOJu0Ywb7h34zpzNUGYVLyc1CKCjUjX7gmZpSGDrgflL+OQFnSz7RBrH
	gruuNQTfAbcrZ94eeS7j0GHBtrxyjgh2AtkpVI6pGER+uQ+f1hZjotoTpR8+cQ==
X-Google-Smtp-Source: AGHT+IFPk//p0bZSwagAp3iX4U/EP6BCxupu6BvHEFS6IcIIUIlmW54lKSp/YxG5QTnQKWBq6j+csA==
X-Received: by 2002:a17:90a:b902:b0:299:3258:4053 with SMTP id p2-20020a17090ab90200b0029932584053mr14295400pjr.15.1708561833583;
        Wed, 21 Feb 2024 16:30:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a17090ac21500b00298dd684b8csm10445951pjt.32.2024.02.21.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:30:33 -0800 (PST)
Date: Wed, 21 Feb 2024 16:30:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: libfc: replace deprecated strncpy with memcpy
Message-ID: <202402211630.184FE822FB@keescook>
References: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>

On Wed, Feb 21, 2024 at 11:50:26PM +0000, Justin Stitt wrote:
> strncpy() is deprecated [1] and as such we should use different apis to
> copy string data.
> 
> We can see that ct is NUL-initialized with fc_ct_hdr_fill:
> |       ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
> ...
> 
> In fc_ct_hdr_fill():
> |       memset(ct, 0, ct_plen);
> 
> We also calculate the length of the source string:
> |       len = strnlen(fc_host_symbolic_name(lport->host), 255);
> 
> ...then this argument is used in strncpy(), which is bad because the
> pattern of (dest, src, strlen(src)) usually leaves the destination
> buffer without NUL-termination. However, it looks as though we do not
> require NUL-termination since fr_name is part of a seq_buf-like
> structure wherein its length is monitored:
> |       struct fc_ns_rspn {
> |       	struct fc_ns_fid fr_fid;	/* port ID object */
> |       	__u8		fr_name_len;
> |       	char		fr_name[];
> |       } __attribute__((__packed__));
> 
> So, this is really just a byte copy into a length-bounded buffer. Let's
> use memcpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the refresh! This looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
