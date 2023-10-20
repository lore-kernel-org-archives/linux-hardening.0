Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4A208C2
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMbyAUTA"
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B71D5B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:06:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ad5178d1bfso855058a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697828808; x=1698433608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUVJcwpArHb7MBkbp3dkAUppiUopD2zQbbvJscJg8PQ=;
        b=jMbyAUTA7kRk7I7iE4WthE7sPQnCMtegi4Ex+tV4XpldKSd1uiEtUFKG/LHovcDxSK
         N+7OMXt4Z3m0P96IHnbr/HDkT5VncS7t3T8oHXW6sc2+ls4WgUjy8uRapMwr+j+FZZ1y
         ItnU9PJR53IA/aizssNDf5tAuA53H4MIPpykw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828808; x=1698433608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUVJcwpArHb7MBkbp3dkAUppiUopD2zQbbvJscJg8PQ=;
        b=eYea1M3okyN44Qboh7U8+dR82PS9Oo7tQszL4olWcmn8wgzJsEpLol5OIwS/nRjQDA
         4xo/duGPz3KrBphmVXMKyN1/hh1MdY4b9HOjJo9Z6YNH2So5TWEqeAFFtedxlu+Ar5Zm
         qrclp+fHQvoxowvhbXi/TPKW1I8QsX+sAE+/oL3kcofb9Gy93CWqnMbDcga9sOe7rOaQ
         rOSPh3+uqDjvANj8M4zHPxIdJKQ4yqDfqWEzSaNmKkKiroBmHo0ITOhgTIehcBwz7DIO
         uPWBNvE1tOTUufaZvVQceedrSsBEuvoZQK6BxEDCFTYs9ST2G143/dg5J/NP69NPMMzd
         hMTA==
X-Gm-Message-State: AOJu0YyilSY5ZQc6b7AI9VfEyiPLRiHzh+HnnkwaseZuvnMCouNo+EuJ
	MZ914jyyKc1K5sbysXeiLjXwJcYmANtGMJzb0Gc=
X-Google-Smtp-Source: AGHT+IEgFtHiGyOoViYf0N8c2I/S8dvVLOWnmh9wYvf5dD2u2G6gwpgPYyPbb6rknXVZIZeLc/dx/Q==
X-Received: by 2002:a17:90b:2ec4:b0:27d:a59:ebae with SMTP id ss4-20020a17090b2ec400b0027d0a59ebaemr2899423pjb.46.1697828807938;
        Fri, 20 Oct 2023 12:06:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090ad31400b0027d15bd9fa2sm3536022pju.35.2023.10.20.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:06:47 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:06:47 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq256xx: replace deprecated strncpy with
 strscpy
Message-ID: <202310201206.428C617@keescook>
References: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>

On Fri, Oct 20, 2023 at 07:05:25PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> val->strval is assigned to bq->model_name in
> bq256xx_get_charger_property():
> |       val->strval = bq->model_name;
> 
> ... then in power_supply_sysfs.c we use value.strval with a format string:
> |       ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> we assigned value.strval via:
> |       ret = power_supply_get_property(psy, psp, &value);
> ... which invokes psy->desc->get_property():
> |       return psy->desc->get_property(psy, psp, val);
> 
> with bq256xx_get_charger_property():
> |       static const struct power_supply_desc bq256xx_power_supply_desc = {
> ...
> |       	.get_property = bq256xx_get_charger_property,
> 
> Moreover, no NUL-padding is required as bq is zero-allocated in
> bq256xx_charger.c:
> |       bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
> sizeof(dest)) as this more closely ties the destination buffer and the
> length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
> Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com/
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
