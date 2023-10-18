Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28B46665
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h3ayC0/i"
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE3123
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 16:51:30 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2e73a17a0so834355b6e.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697673090; x=1698277890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ChR10G5D7sRcff6jQpaXKs4y1Q9gyq3SS0kPO+/cx8=;
        b=h3ayC0/iVrzoFeJsHQxqFgyIN5fp4Ny7SYnReR9I8XP3BjPvW93NDWDe+9IyJIvLAO
         MuOJEVm2vKCbIsy32336l2WaT7r2zrh0Rj7FhG95kpU9M1A85ztCeK0M6m8tpRXoa28H
         CKNzNX5B/PNSpt0QK1ni6cjtQjJF2G4Cu8JmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697673090; x=1698277890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ChR10G5D7sRcff6jQpaXKs4y1Q9gyq3SS0kPO+/cx8=;
        b=a1nIxUzGV05jokG1RbIFTzIjlQqL4jJ3CibdAlP4XSPZZCKkb7g+ogk6jqalNJZBlM
         4kH4fwW12JOgbn2CDmIxYgrx4V8QRn9uY63MJPYM5JXVlQ1YPwG26xdO9HRA/QK/k9mr
         G5vdCJXO3jBHxUgWvn4cafytzFNw11W28zJ1Ti/D17oyavcF5og4w56O+/eh2XQLcIuJ
         4zFzIIL+FC2GqOTvgSAT0qWEceWT7jb6GzSohFdQuXJkllj0wqoZ+4B1qlaXluQfB36W
         EBiqPfz1MgwheP+m9VnS5uvx2XK0Y2lyJNLSL1rA8bBGJ80lzhxmTDUKWsEOe6ZYD+ud
         dNSg==
X-Gm-Message-State: AOJu0YzNh0xTiGT9eCG5CRpE5CyuTaRx9mLh6PBUoprIX8g+f4XyafM8
	IfB9sUpheUBADTgFgvYB3FeXgQ==
X-Google-Smtp-Source: AGHT+IGPt8JkcC74UVt2KOT9gRXdeFP98JOMifoReerDh5QGwGHTdBGZE/K4Tk43G0k5VNDzq/VTPQ==
X-Received: by 2002:a05:6808:7c3:b0:3ae:2024:837b with SMTP id f3-20020a05680807c300b003ae2024837bmr695909oij.34.1697673089839;
        Wed, 18 Oct 2023 16:51:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7991b000000b006b3dc56c944sm3855850pff.133.2023.10.18.16.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:51:29 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:51:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>
Subject: Re: [PATCH v2] drm/modes: replace deprecated strncpy with strscpy_pad
Message-ID: <202310181651.E47F9E32@keescook>
References: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>

On Mon, Oct 16, 2023 at 10:38:20PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We should NUL-pad as there are full struct copies happening in places:
> |       struct drm_mode_modeinfo umode;
> |
> |       ...
> |               struct drm_property_blob *blob;
> |
> |               drm_mode_convert_to_umode(&umode, mode);
> |               blob = drm_property_create_blob(crtc->dev,
> |                                               sizeof(umode), &umode);
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees both NUL-termination and NUL-padding on the destination
> buffer.
> 
> Additionally, replace size macro `DRM_DISPLAY_MODE_LEN` with sizeof() to
> more directly tie the maximum buffer size to the destination buffer:
> |       struct drm_display_mode {
> |               ...
> |       	char name[DRM_DISPLAY_MODE_LEN];
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the respin; this looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
