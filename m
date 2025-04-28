Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F971757F3
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842191; cv=none; b=Eh/nOtimkAmMgz8aAGN8cCOv85NR9CTBwGGVGcJqs7Ag4uSXQrNSE7ofdx4yQ/pHTqCwv2TL7RymfoSvNmCTOCUqppJTEb5g4cZl+guiD/lGGBdobnfmfHdYPo2FCn/Sx8g9ifI+SdcUS1xvv8sP53CTq8zAntTZisYfJ62o2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842191; c=relaxed/simple;
	bh=TMmQi99kL2+atqpYCG6LfV/8nmQkDwBk0pQNwYV4mE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhHLJKn87ykFHqNGcMwvkiILXhpKuG6alC0VTBjFGuEGXBnGOvTYs5P9rEdVOY8owbryY8nUdyDCkTw4f1gnXYhqaiOEWKfxiOvcpQcGDLkOfG4Pfz98Wmwk0IDjpkhYqhTisTutXESLhPyv0zul460H+C84jLtO9xWYq1rfJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=x+8+Idho; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="x+8+Idho"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efc457bso3324275f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1745842188; x=1746446988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JmJKZuEpq5UN0wmEtOpCzeCBmpLeQy7dV9yrtIP3UA=;
        b=x+8+IdhoIFUboPYxukP9QIORk4wT3AOzni+YA6ts9E2F6LSEb6ViaAmWxn6Eii2Brj
         ovjAt7hVkChwx35f5PVG3lpPa85SdgdmCiRrgrQJ7ROgcAGeZyobMhVhUi2dDJyPI8iZ
         HOmWPSl/hjZdpC6Gcj/kqgpKW6AzZ4U7Vl/b7GqDcUVBJtOBj0OhL6DTj6fUs1ySzBJa
         J+dBwIGJ7Rtud7Cv7T+AhY1cofPgeXdIyUgIIz3A+Ltrs38YK/gQobS7KAzA1Sl8GVsY
         thSWTulg5N4Z0TKFoZrtubIjdG8Wpz+/KNv56WR18CYxNNCl5yZkqNCnt3tKMV9uNS8l
         neDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745842188; x=1746446988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JmJKZuEpq5UN0wmEtOpCzeCBmpLeQy7dV9yrtIP3UA=;
        b=ahnt/NSTUw5Qi0nXVhISBMhC34uaqF5foeQJLHBBORpELGnXhvvbHlAuf+fgAaN9mn
         4A47Z0TBzxiw4Z/S22SgB5+ixeqZ1kAM9kEBg4AUQhuYCPfPvkRWvYlP5HtAs6mSSrJ2
         wmv2ngLr9dVDfjJBT2Md4jzQtAhalRx768hkkhCIesZ27JbCzeUcqufzBns4MORm5OVH
         XTYS5+NyxHT5B0hZmvXIhmbG+PXwXFHVvrwX5gphWqXRFNiQgnaGkgkaDx+d0+coBvKp
         riT7QHbOluF+m75T6BWBqbGcaVVDkIGhButqIyQhnjW6A0b1Wnt30ggSqcLPyhg+jHA/
         wMuw==
X-Forwarded-Encrypted: i=1; AJvYcCWaADYYgQju0/Vj7kFX7uYi3B/GPW95p9Sa5ov1Mkr9iaLsRCfGQPDdG4ihL4jVASnZXfC/o3ieDj9zWhjz4ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOpdxkkK3k5rsbelJve28U9/9Vvo+e7jLILdeB3RWg++X/KTX
	MRu8eJNwAE/jhtfO4fFHAnzOELlxdCTAYoRg+bShIZi68qDtuiTnOTwpcUJ++Xo=
X-Gm-Gg: ASbGnctnRU3snF1eqz/teshFa/V+Mvkdv6AfByegRWFkhiOq5mNulHgJzr932Tk+IuU
	nazaDEZzJ1Njq/TTHbyzx23csnsoVbhP1aMRkA5lxJGKrDuHZN/t7N270Nxcs9tjO0dzmqp5igI
	4+pGIBLgpzhNraEN0oGioi4Wd28eoMzAKO5BTEWiE9mOwifZ6ZB/BQC8p8hagbG3eIwBC92Exm0
	cEON6FpdrhqXyF/NDXFHn3ciQUkC52bVOduwrSPFeq3rPDLxskv9eIuh1oa/iIMLLz5AN6ncbwT
	hoUk69bjWd8Ecf3WNrjf9A2YiKV7yI46YDKcRbOzmDCcFctiYtxKVK0=
X-Google-Smtp-Source: AGHT+IHqEv8cFeHZNO066YOoWB8BFD6tcgESusNCDp7OcqCCqOLYefsxt5CXNgjV3wL2bS4dyhsh5Q==
X-Received: by 2002:a05:6000:1a8e:b0:391:3b11:d604 with SMTP id ffacd0b85a97d-3a07adb1d30mr7133747f8f.54.1745842187842;
        Mon, 28 Apr 2025 05:09:47 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d88cdsm153399285e9.25.2025.04.28.05.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 05:09:47 -0700 (PDT)
Message-ID: <7f1ad610-5a37-4f74-8eee-5f37556d9576@ursulin.net>
Date: Mon, 28 Apr 2025 13:09:46 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Remove const from struct i915_wa list
 allocation
To: Kees Cook <kees@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Gnattu OC <gnattuoc@me.com>,
 Nitin Gote <nitin.r.gote@intel.com>, Ranu Maurya <ranu.maurya@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Angus Chen <angus.chen@intel.com>,
 Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
 Yu Jiaoliang <yujiaoliang@vivo.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250426061357.work.749-kees@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250426061357.work.749-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/04/2025 07:13, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct i915_wa *". The returned type, while
> technically matching, will be const qualified. As there is no general
> way to remove const qualifiers, adjust the allocation type to match
> the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <dri-devel@lists.freedesktop.org>
> ---
>   drivers/gpu/drm/i915/gt/intel_workarounds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> index 116683ebe074..b37e400f74e5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> @@ -156,7 +156,7 @@ static void _wa_add(struct i915_wa_list *wal, const struct i915_wa *wa)
>   	if (IS_ALIGNED(wal->count, grow)) { /* Either uninitialized or full. */
>   		struct i915_wa *list;
>   
> -		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*wa),
> +		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*list),

Will the sizeof stay, and if so, how will kmalloc be able to distinguish 
the type? Or we expect one more churn on the same line?

Regards,

Tvrtko

>   				     GFP_KERNEL);
>   		if (!list) {
>   			drm_err(&i915->drm, "No space for workaround init!\n");

