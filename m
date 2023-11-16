Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bw1+HklB"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA41AD
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 10:28:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc30bf9e22so8578025ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700159318; x=1700764118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7reBGJiccGvFEPh84DNhsMy+d8d0VEfZ803Vs8wYx6A=;
        b=Bw1+HklBx24qQvlrxlGvf87SNTxgtB2H7RSTrdsZR2AFH/KEUZU6rNkusOea1sCbaZ
         6s+REsEmrGSJdW+777sPyeSg/94oYl4/QHj/FAyXh8+M8PfDWi6pDCAEIkfxgQFMh9np
         TfsUBXnvkRI3p21iy2fFS/mz0lThRZHYoOrjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159318; x=1700764118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7reBGJiccGvFEPh84DNhsMy+d8d0VEfZ803Vs8wYx6A=;
        b=I6vErTgJY6ZK3bx8MjACEKDIdAAWeGjV3/32YX6ir+jRQQvDFkRT9qpW0k/s6qUe1/
         yY4PwqdSd+Hg3cf4Qkzfbf9gOCBGHw5LjK92G7zDig9bcIdPyZmykmwDcZJ5Iu4ozQbv
         SpVaio9JEiNFSwWGEkcQ9i1uIzyO3kpK36UeMuZ5E2AFrDfiJ4TiCCUSXKyIX9Hz3ZBR
         eYsstvG/57oYdRwfnMlsY0/V2KftSf13oOK2frOMgzrVirzFcsaaYhKKHu/psTEfJsCc
         9bVNKT6Wt/MReNyNfLHZoV40z48bA+6kGoLb92fwrYYdbPDO7fsvSaviEBLVNmKAugsq
         qtew==
X-Gm-Message-State: AOJu0YzSJDfxOKf3wQbysgrffAnDNO/BgYVuxC5B6tGE/nXy1AhXQEIQ
	aO2wjjKuYB/rxl92cqvoMK2q/Q==
X-Google-Smtp-Source: AGHT+IGAIJ1flNjVNFt30991BeOzVwdm7nFOpSj7aipBLifSRgBzIDb+/MN7TcTVw7PDSnp4FgwR1Q==
X-Received: by 2002:a17:903:485:b0:1cc:38e6:f097 with SMTP id jj5-20020a170903048500b001cc38e6f097mr3076987plb.7.1700159318125;
        Thu, 16 Nov 2023 10:28:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709028c9200b001bdeedd8579sm9514614plo.252.2023.11.16.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:28:37 -0800 (PST)
Date: Thu, 16 Nov 2023 10:28:37 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nouveau/gsp: replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <202311161028.E780FBB146@keescook>
References: <ZVZbX7C5suLMiBf+@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZbX7C5suLMiBf+@work>

On Thu, Nov 16, 2023 at 12:11:43PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
> and should be replaced by flexible-array members. So, replace
> zero-length array with a flexible-array member in `struct
> PACKED_REGISTRY_TABLE`.
> 
> Also annotate array `entries` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
> 
> This fixes multiple -Warray-bounds warnings:
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1069:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1070:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1071:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1072:29: warning: array subscript 0 is outside array bounds of 'PACKED_REGISTRY_ENTRY[0]' [-Warray-bounds=]
> 
> While there, also make use of the struct_size() helper, and address
> checkpatch.pl warning:
> WARNING: please, no spaces at the start of a line
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks nice to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
