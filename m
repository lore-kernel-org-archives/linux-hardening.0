Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03437158
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XmMbTyk0"
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CAC9
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso615806a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698422373; x=1699027173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIpZiRguR5ztX72Jx9GSG1nVMOc1X7wxd/73UnubI+4=;
        b=XmMbTyk06xcZR+tb63HhYGNsnuXyNpdeD+oxiGcYlEBWG7Y8w2DJoGlW5jlDrdV51d
         Ibj+XFKXfgG3v09VjMIpfVdZMwqxXTjJd5vgUMkjVLl8G7OaivxHRFT4X6z1Cvh+IBw5
         HGjzV7wMw6apQn30K/22vXi6/UE3nkrKEe4DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422373; x=1699027173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIpZiRguR5ztX72Jx9GSG1nVMOc1X7wxd/73UnubI+4=;
        b=hZXPoWYol9HZGyOEkj0/jELYp0AgDwPKhHyF8/4CfI+wUV7BiKczYwgfTWymc9Z/Eu
         MLAbFUIcRB35Tj65gCa49Hv/YZJImCo8VOSmK1zTRVGKjhXwqHPn3FZdbp7X/91b/wET
         2wYl2IjjxA9mME3A+biEPK2dcZoaD3mJG0N7tBa1DzLD6i9D6us5kujwGZKBLAmePJkk
         JE4h/+RKzeBbr9GPPrhpYs0vjxSZhi0A0QzX0Jmn5Ri7l3DFx8c+AMRepdOAahCt5eQ8
         U6QhddeYsv63qQZ/oown12fHgGitCGM57RZ9NoV9tVoWsiS75Qf54l7d+EyPla+KeDhJ
         BCjQ==
X-Gm-Message-State: AOJu0Yxg7b6ErSkkRElvkXYaLcPpdIwtVPMwAcBVUaBNFOeOs2ANoUB5
	l5pdXJNDn42Xc6ktn0o/8+JEZg==
X-Google-Smtp-Source: AGHT+IHCPZdNAcRG+t1M2xwWBMvbdltKNplZZ5qGLIJGn/zQD7Qk2n9PkgKPFNuyQusVj5VdP5iidg==
X-Received: by 2002:a17:90a:4ca5:b0:274:7db1:f50f with SMTP id k34-20020a17090a4ca500b002747db1f50fmr3784895pjh.15.1698422373079;
        Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a2e0200b002749a99318csm1376715pjd.26.2023.10.27.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:59:32 -0700 (PDT)
Date: Fri, 27 Oct 2023 08:59:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] airo: replace deprecated strncpy with strscpy_pad
Message-ID: <202310270859.8EB5599A@keescook>
References: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>

On Thu, Oct 26, 2023 at 11:19:18PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `extra` is clearly supposed to be NUL-terminated which is evident by the
> manual NUL-byte assignment as well as its immediate usage with strlen().
> 
> Moreover, let's NUL-pad since there is deliberate effort (48 instances)
> made elsewhere to zero-out buffers in these getters and setters:
> 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
> 6130 | memset(local->config.rates, 0, 8);
> 6139 | memset(local->config.rates, 0, 8);
> 6414 | memset(key.key, 0, MAX_KEY_SIZE);
> 6497 | memset(extra, 0, 16);
> (to be clear, strncpy also NUL-padded -- we are matching that behavior)
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
> because this function is a wext handler.
> 
> In wext-core.c we have:
> static const struct iw_ioctl_description standard_ioctl[] = {
> ...
>         [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
>                 .header_type    = IW_HEADER_TYPE_POINT,
>                 .token_size     = 1,
>                 .max_tokens     = IW_ESSID_MAX_SIZE,
>         },
> 
> So the buffer size is (strangely) IW_ESSID_MAX_SIZE
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
