Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56D4291B
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwCEvpeV"
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97475115
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57d086365f7so140007eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697756806; x=1698361606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=DwCEvpeVXUfGsrXy6P4VMnQCCoM292F1h7bdgP+n7MoI+9Ue8H61cfhk1B55UBGPHo
         DvpAImZ7KWlgAecQHVASQ3q3ow+k5QBeOk90BwbGJJfr8QA0mD86ww7w0jqG0OC++nzM
         s/yQEVEi9sYbgJQ53lvOwMT7tpvA2QvCIe5FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756806; x=1698361606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=Ie0VKbotnwpQmJ1Q27wsbIFJ3dR126ihKcjMW86w1XxdtusCiYgvyE8BbVIiRpF91x
         S0VHQXTf0MG06WGejWFaf9uy3e0V+G1c02dNXAAm1th2i7RD/GxNcJKsuGRVvKA/X774
         pgq1o+uuz9GHZBM3l9G62Cm2aYXjpGgvl1+JVjXqtTJJU/kMqiW1RcQKpgVVC8a8Qi0D
         iVsAUAyZS0R/gvU5jCuD1mMKn7fPfImQassceDykAZbwDLz7yTNYiO4mlodW9iT8W/Zi
         Fe0YU6NUN07ZRKYuXpCJqoDG7RJhi+FyV2E5IYgqgRMkrbgfQL9ktvxnLdlUmVgt/RA7
         CzKg==
X-Gm-Message-State: AOJu0YxTznbzX8hNDlwk6+dkU3RD1A1f8qlQRhZqKTf1Shb+ARRXTGei
	BOmEA65PcAP3Yq+nzldRikmaHg==
X-Google-Smtp-Source: AGHT+IEhvEBOypzhBvUEC/LxnmQewUkvilNgMww7+1gCzs5lO9zQ2TaPhZ4dkppEJNjjFdom5AnCAg==
X-Received: by 2002:a05:6358:e4a0:b0:166:f18e:e60 with SMTP id by32-20020a056358e4a000b00166f18e0e60mr98593rwb.7.1697756805783;
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7950d000000b0068ffd4eb66dsm301234pfp.35.2023.10.19.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:06:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPI: replace deprecated strncpy with strscpy
Message-ID: <202310191606.93920741B@keescook>
References: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>

On Thu, Oct 19, 2023 at 10:47:58PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know dev->name should be NUL-terminated based on the presence of a
> manual NUL-byte assignment.
> 
> NUL-padding is not required as dev is already zero-allocated which
> renders any further NUL-byte assignments redundant:
> dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
>   dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. This simplifies the code and makes
> the intent/behavior more obvious.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks clean to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
