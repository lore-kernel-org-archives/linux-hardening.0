Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCJi+iSK"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E111A
	for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 08:37:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so638843b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702571835; x=1703176635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytGugjo0G0b+BPvqCI62+RFEO79iMDy6vjEWkwFFqNo=;
        b=GCJi+iSKpjqkkNglOX7WPB7/8KITsstZp0kPuEDUMvK0hDP8P5OlgM3DvnT1kZ+Ht3
         qD4TydnzFsFH4nERqqpXyGSovEHKbC72lFZVKreji5eX4kcfOz5hXq9m14gDXYNVVeji
         /lRcyO7zCIbtqFnCH78mjwSjhqOdfo3BNPNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571835; x=1703176635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytGugjo0G0b+BPvqCI62+RFEO79iMDy6vjEWkwFFqNo=;
        b=JiiKNlf6JJPxmGaeCh8puvMZF77ry0lyLhTUp5uuT1Inn83KiOS4Lv4wBMwlvsvHAQ
         T9tGs0CwBF9vB/TM5U6SUTJxa+gEUIIbtA9vHQSoh8goB4+pASmpibZOSlfrDvwFNate
         H/KAdhNBi4qT0tc4+p8l/vDGsCnWOCwBpBgYkub46uKnNnUpAds0YOIIJHDGE+JsTagC
         gKkbwjb8MjQfGm/gPQ2MyamD0LjBUuh+zuHYQyJd3lLxdr2sP8r+Fc5j/RzCaAh9N6Pl
         nx3DFGYzDL9W+FI/EcQfOv0kBjcLNf2na9vZilXKX/HL8hYsko+S0D9slOjC0LCV4Xj/
         bw1w==
X-Gm-Message-State: AOJu0YwMGFrKGRoHDJqglMHgijISTeQknrNrL3cH2wnoa/Y9wsHUz2eR
	TixR062G9W3J7hcC2SH1BlQFhw==
X-Google-Smtp-Source: AGHT+IHCcgxq6RgAT4BqOXPUetDHHLYdNS0fny6BFi7+klsE9cZ2F0ubu4OKof7NjbKXCrj/xdfJ9g==
X-Received: by 2002:a05:6a00:2d9e:b0:6cd:fda4:b57c with SMTP id fb30-20020a056a002d9e00b006cdfda4b57cmr12902654pfb.15.1702571834799;
        Thu, 14 Dec 2023 08:37:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006cbb71186f7sm11945039pfb.29.2023.12.14.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:37:14 -0800 (PST)
Date: Thu, 14 Dec 2023 08:37:13 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <202312140836.5AB528D54F@keescook>
References: <ZCTrutoN+9TiJM8u@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCTrutoN+9TiJM8u@work>

On Wed, Mar 29, 2023 at 07:54:02PM -0600, Gustavo A. R. Silva wrote:
> GCC-13 (and Clang) does not like having a partially allocated object,
> since it cannot reason about it for bounds checking.
> 
> Notice that the compiler is legitimately complaining about accessing
> an object (params, in this case) for which not enough memory was
> allocated.
> 
> The object is of size 20 bytes:
> 
> struct ec_params_vbnvcontext {
> 	uint32_t                   op;                   /*     0     4 */
> 	uint8_t                    block[16];            /*     4    16 */
> 
> 	/* size: 20, cachelines: 1, members: 2 */
> 	/* last cacheline: 20 bytes */
> };
> 
> but only 16 bytes are allocated:
> 
> sizeof(struct ec_response_vbnvcontext) == 16
> 
> In this case, as only enough space for the op field is allocated,
> we can use an object of type uint32_t instead of a whole
> struct ec_params_vbnvcontext (for which not enough memory is
> allocated).
> 
> Fix the following warning seen under GCC 13:
> drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
> drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
>    36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
>       |               ^~
> In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
> In function ‘kmalloc’,
>     inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
> ./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
>   580 |                 return kmalloc_trace(
>       |                        ^~~~~~~~~~~~~~
>   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~
> 
> Link: https://github.com/KSPP/linux/issues/278
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

FWIW, I think this is the right change that disrupts the code the least.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
