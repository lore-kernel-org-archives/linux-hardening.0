Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QaHHYymG"
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE61716
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:51 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58d08497aa1so872605eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381651; x=1701986451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bHceCWW/FNIBqL0qlF7bzPuAbLJU4rZ5dawH7WmBGM=;
        b=QaHHYymG5QTpGaPRydqT47f0CStdwRTvS51rLZPUkYmKyZRv/4PTlAuaHvK22CLJLW
         yuKqnBc1o7tcT2dmNOfbblun6EZMdvzfpinhlnWlfZPhs8n7+4Bz73ZmDzXYQEJGX+LF
         cAu5oojBgp/MPGvW+QVpdp01+dwEZ9sINSWyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381651; x=1701986451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bHceCWW/FNIBqL0qlF7bzPuAbLJU4rZ5dawH7WmBGM=;
        b=uWSEajJMD3JXkNx5pImJwZGWIezuI5o9IU33WTesFOxm8r2YgG7hixC3AvBvpFIKTy
         d3R/8ya75+s9rgFtZvlCk4f81DfPf0DFx5eXbrhh88xVC3Po4kfLBBzTe/U9KcmxqNq6
         oc35fF5cU0xcN6LYfM00naSxsafuApMlAUokKZgSBk2Uxbwdg5yhrNCumMGKjvF/ZDVU
         kLxOq3IG0WyzOenxk+Tju0hLlh2Ocr3x4yQ1/iHJifBIg9rbca+cziyyzPEKYDe16KWr
         Z1v0S5nBbnFr+HxfhwayxKiyXuJd8rlCMwU3vVw5bglgjLGXSENFLLgokU75z+NoHFye
         gYMA==
X-Gm-Message-State: AOJu0YyZ0szv41ImOYvDtT96mKK5gQ6gGfCrPFzxWjAjfFTNnkpatXkI
	0M6UJ+1SDuQ+iG4j2dse3OUfHw==
X-Google-Smtp-Source: AGHT+IEQFIZgsvOW9B+t/qw8hIsRW20br2f9U2lUT1U8gzzUQdVBFmGZapUJihQN+NpvBHrzAyjJ0w==
X-Received: by 2002:a05:6358:7206:b0:16b:f555:4c34 with SMTP id h6-20020a056358720600b0016bf5554c34mr29347624rwa.1.1701381650901;
        Thu, 30 Nov 2023 14:00:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 1-20020a631541000000b0059ce3d1def5sm1748288pgv.45.2023.11.30.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:50 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Xu Panda <xu.panda@zte.com.cn>
Subject: Re: [PATCH v2] drm/modes: replace deprecated strncpy with strscpy_pad
Date: Thu, 30 Nov 2023 14:00:40 -0800
Message-Id: <170138163824.3649248.18015700667277399745.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>
References: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 16 Oct 2023 22:38:20 +0000, Justin Stitt wrote:
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
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/modes: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/d8d273c595db

Take care,

-- 
Kees Cook

