Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DF208C2
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TeBWtUDr"
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56C1A8
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:06:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d4372322aso934250a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697828786; x=1698433586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URtsuBkq1PlfP6enjE5/unNQzMTKd3kE7D83R3MqH4Q=;
        b=TeBWtUDrZLa4tHwIIZWcQ40qkXDWrr6Gog33AaiZx/47BkAZqATPeQBQDWt2XJM/8c
         yxK/QKldpIAVz+MmNMXNalMiFG+XjiyKL+gRgxDbhJDjyCvU85TYcMTazX2GWXNNUfAn
         Fcl8Cm6TGP0E/Xmi9SNbBweAbykv6JLsuDN4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828786; x=1698433586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URtsuBkq1PlfP6enjE5/unNQzMTKd3kE7D83R3MqH4Q=;
        b=rZoCCaCxotE3GHbFo+5Gpo/IULKzlJd5ewV0r2HeBP97e87qOR+H6EIyMT2ORXp+tz
         LO7UkkD/d8nhYi04qknjOWEGbgr4s6lQsAk1clDFwKlNOqBXvg5xP9UItN0s2Z+cLcea
         29NMcuEPcS9cQ+YaQKeKXL67wwEhMEM7upQlECvupsaeNb6644FBRfYCaOhTd7Z8eixe
         BeMYgdQX4KN3T5fdCNnBc4xoBomnVje3TyTj9CzeM8TgvLHW0B4A6i6w307YFF2a3oSl
         ymqUp0wcqI8I3z9fVI04zRhV80gLOgsXvpOyJH/39qgtbuKbPxUcaEHSuX/MAX5KQ6nV
         2l/g==
X-Gm-Message-State: AOJu0Yzo7PXedO8PG21zDPZgDz89DjEI6Qoog9sScnqtG4j/ja3aP/xM
	IIHwyzTe8xXUaGjJNVq1h/dlN9LppfvOwnZ0W7k=
X-Google-Smtp-Source: AGHT+IGZAx49Ov+0Y8NtP7+Nd4TtP5zk4M6HLrhjbp3+NqOYbrLuGFkh7nPl2xFTM0kJArIeJmcRgQ==
X-Received: by 2002:a17:90b:3504:b0:27d:60b1:4f2c with SMTP id ls4-20020a17090b350400b0027d60b14f2cmr2592965pjb.4.1697828785944;
        Fri, 20 Oct 2023 12:06:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a1a4800b002776288537fsm1953870pjl.53.2023.10.20.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:06:25 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:06:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2515x: replace deprecated strncpy with
 strscpy
Message-ID: <202310201206.2D1271C209@keescook>
References: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>

On Fri, Oct 20, 2023 at 06:59:34PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq2515x->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> val->strval is assigned to bq2515x->model_name in
> bq2515x_mains_get_property():
> |       val->strval = bq2515x->model_name;
> 
> ... then in power_supply_sysfs.c we use value.strval with a format string:
> |       ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> we assigned value.strval via:
> |       ret = power_supply_get_property(psy, psp, &value);
> ... which invokes psy->desc->get_property():
> |       return psy->desc->get_property(psy, psp, val);
> 
> with bq2515x_mains_get_property():
> |       static const struct power_supply_desc bq2515x_mains_desc = {
> ...
> |       	.get_property		= bq2515x_mains_get_property,
> 
> Moreover, no NUL-padding is required as bq2515x is zero-allocated in
> bq2515x_charger.c:
> |       bq2515x = devm_kzalloc(dev, sizeof(*bq2515x), GFP_KERNEL);
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
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks like a good replacement, just like the prior I2C change.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
