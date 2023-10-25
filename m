Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932A8468
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gudDxT+c"
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3832AD7D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 17:30:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ea05b3f228so3365726fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698193852; x=1698798652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n87sUffC3jIAj0OzBWNWPGKXdWXX/v+Z+ob+S6qU1cI=;
        b=gudDxT+cXy6mPPgK/JaxC2ja7o1tqiFTSOrZ0XCCODP+5xdE+GmsWHthqvk5JgLtam
         WPyLScPVm3WtFPmtzf8U5e7K+Z+hXQPXRvwHfXV4AqmAwUythEAhdQnUNHMP4VpfuvMo
         bT8yPwpYiC6c7XdEXDJzEv2yViJMt6JIfOP2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193852; x=1698798652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n87sUffC3jIAj0OzBWNWPGKXdWXX/v+Z+ob+S6qU1cI=;
        b=posIg4jKaTe6EkHl3ltPK2Qok+HHdc2eyRoiVnU/AtoFLkuTl5pOXIc6+RMLYnRhQR
         scJgjJJphtM9bYMJ+8VVwWL9ez5pd5N+hQ+PKlfTnmxAe9QmvCPBk5YJDHcmQQdgd8lJ
         zey15l7NgtRK6mVDU42URwdUnltg+FWMygJJz4UVM8/rSH1Qa54rR0LN2Wc5zBCrq9Gb
         p71TFJS+ct7ARRSYaG8/IxoV1+xs+BQpCCio6O8ZUG7fuo6MExJ9zAhgcaYTR0p6C6+6
         Q0x621D6mO2tVZCc7wN0ExL4lmVTRb/umLDVMM1EkJp6k7ozyxEO5+tfF9M534nuEh19
         RcOA==
X-Gm-Message-State: AOJu0YyofmDVqP9I3jdAeeLL+4cjxpebGkr12V432xAAqWdO6aH3nwTC
	lUyocz2KzUiAt1KqDd//+UE0PA==
X-Google-Smtp-Source: AGHT+IHMIcGzMvlGzYich5XJqb+MzqzGw+o2xZJVqCap7MFd+7g+sf/Oe43NAa3axzWaxPoppkLzdA==
X-Received: by 2002:a05:6870:a99a:b0:1d5:40df:8fb1 with SMTP id ep26-20020a056870a99a00b001d540df8fb1mr16097059oab.19.1698193852500;
        Tue, 24 Oct 2023 17:30:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n3-20020a632703000000b005ae776b8616sm1343461pgn.19.2023.10.24.17.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:30:51 -0700 (PDT)
Date: Tue, 24 Oct 2023 17:30:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: replace deprecated strncpy with strscpy
Message-ID: <202310241730.7AA375902@keescook>
References: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>

On Mon, Oct 23, 2023 at 08:26:13PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `hw` is kzalloc'd just before this string assignment:
> |       hw = kzalloc(sizeof(struct csio_hw), GFP_KERNEL);
> 
> ... which means any NUL-padding is redundant.
> 
> Since  CSIO_DRV_VERSION is a small string literal (smaller than
> sizeof(dest)):
> 
> ... there is functionally no change in this swap from strncpy() to
> strscpy(). Nonetheless, let's make the change for robustness' sake -- as
> it will ensure that drv_version is _always_ NUL-terminated.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Another direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
