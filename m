Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD9219E4
	for <linux-hardening@vger.kernel.org>; Fri,  5 Apr 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335057; cv=none; b=AH4STwiQrSfMEomtg5NA5As+CgJDvECDlqUAkZV1DGgj2y5p0ztRejXjZXFp3sCzmnLy1J+qYmf7EhYeiYd78tkL9zu02NU/EgsqhwuQ5VdOd3QImGTGrWkIDKeS/Ct61rsHI/tMPSvYIhFAtmsxvxMWkgmWEX69iZTJWf/AvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335057; c=relaxed/simple;
	bh=TwC7u7kRLVrvNcf6B/odAd8Zu0CBkmKdy6vVGMGRGnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeP5QUSO8x5CgsSDZVtKElqVm+I97mKQD/ODA5+0jzCGe0FhbMoUnX+9SE7BAHjNncq4i15JeHFRHGLpDJxoWDZulBSihK5VqMb8GeVPYKUuAUsgzxjnbNIyDL5f5+zzgEGIBklZeSXFzUtpDAUfRosfVtELPIEh2RJJvR4W4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rbf24eoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rbf24eoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712335054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhqXEsjcQfRnbT+Watd5B6B0qa6OPofOH0VzzxL2RKw=;
	b=Rbf24eoCLCCZ6vI1g2jlsUNPJriVqLxF6KAAtu4aQEDpwnsW6jXo38qJ6u92J6P3RXrv0S
	1lp4BIWfwEkMukyuQ5E2ZFzQkbd/qHydz4I0CLuWWrJ2tVpQaVPombg4TPlfKM4nKRFR6z
	W5Kt8nR0q3p5I7Y1O6SGQP8Gijl/k0E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-M6jxGgzAMR-cWZbyhOFW-w-1; Fri, 05 Apr 2024 12:37:32 -0400
X-MC-Unique: M6jxGgzAMR-cWZbyhOFW-w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41545bc8962so12115145e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Apr 2024 09:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335051; x=1712939851;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhqXEsjcQfRnbT+Watd5B6B0qa6OPofOH0VzzxL2RKw=;
        b=CEoj1BM4DXMnNBB/0OSvhq4IhBW61XuY7VjY3bXpb6aDmYG9nxzdcEtur6NDJigcX/
         yGT5siRrtdUq+XVuLpVzBvxApwPvlUM4SToSMK6tVCA1SUCxlPgdXi8DfjjMbZntXeP4
         0gtCVh5ErnfhnRkrELEVX8HndEL+WUW0IVtYTJtwaPyJCD2NyaQsZ/RNsoOSFfZqVqZV
         BeoKa2Uf036K+NEGfdi0yoUpt64Ig84aOMlq8fKDIPszaG3VYFcQGvowi8BvzsDAuGZp
         mFgu91SfRsFBLHaP09OgT9YwytCgebDryaMXoMEgdL6tCwmXBFIOIK1tXsWsMKkglDT2
         PYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGBt7uVbgvsBtgUWgIvhvHNOoI8swLzylaFvNwdjrBxzfG4vaOU3lUh3OQJE/fqTdAoqVdDinnMgL6UG13iN4r6ZTmnIzV4i11yjqJwJ6m
X-Gm-Message-State: AOJu0YyisQAqddy9aJZVUrYl019F3AkB3o6UBSCPwmaKLvH4NQxW/f5F
	YrpNX8aCxDxk/2KjoCcOEqppykH1oDu5GE+Vg87IrSoAO/XbfDvedsdvzh4+mlMlnUSWmNDpT5Q
	/a8UQI6ZzxWL72021pf/3ukIYlAs6ZiPsPT52lMfePocFKrTMJqzqDmprO1msOgoC8w==
X-Received: by 2002:a05:600c:4510:b0:414:767e:6e76 with SMTP id t16-20020a05600c451000b00414767e6e76mr1596288wmo.21.1712335051637;
        Fri, 05 Apr 2024 09:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDPCc0VTMBhL7MNqvTz5tlRMoWQPFY1L2zr/0sqh9d3YOQmi5yQiu02UsFqppTmlfZ8bZ/Jg==
X-Received: by 2002:a05:600c:4510:b0:414:767e:6e76 with SMTP id t16-20020a05600c451000b00414767e6e76mr1596272wmo.21.1712335051297;
        Fri, 05 Apr 2024 09:37:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b00416306c17basm2328956wmn.14.2024.04.05.09.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 09:37:29 -0700 (PDT)
Message-ID: <593a8479-741a-44de-a52c-8d34810bfb3e@redhat.com>
Date: Fri, 5 Apr 2024 18:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nouveau/gsp: Avoid addressing beyond end of rpc->entries
To: Kees Cook <keescook@chromium.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, Timur Tabi <ttabi@nvidia.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
References: <20240330141159.work.063-kees@kernel.org>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240330141159.work.063-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/24 15:12, Kees Cook wrote:
> Using the end of rpc->entries[] for addressing runs into both compile-time
> and run-time detection of accessing beyond the end of the array. Use the
> base pointer instead, since was allocated with the additional bytes for
> storing the strings. Avoids the following warning in future GCC releases
> with support for __counted_by:
> 
> In function 'fortify_memcpy_chk',
>      inlined from 'r535_gsp_rpc_set_registry' at ../drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1123:3:
> ../include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    553 |                         __write_overflow_field(p_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> for this code:
> 
> 	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
> 	...
>                  memcpy(strings, r535_registry_entries[i].name, name_len);
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to drm-misc-fixes, thanks!

> ---
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> index 9994cbd6f1c4..9858c1438aa7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> @@ -1112,7 +1112,7 @@ r535_gsp_rpc_set_registry(struct nvkm_gsp *gsp)
>   	rpc->numEntries = NV_GSP_REG_NUM_ENTRIES;
>   
>   	str_offset = offsetof(typeof(*rpc), entries[NV_GSP_REG_NUM_ENTRIES]);
> -	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
> +	strings = (char *)rpc + str_offset;
>   	for (i = 0; i < NV_GSP_REG_NUM_ENTRIES; i++) {
>   		int name_len = strlen(r535_registry_entries[i].name) + 1;
>   

