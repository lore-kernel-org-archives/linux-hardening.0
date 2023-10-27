Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335A374CC
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLUjGzOX"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC010A
	for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc0d0a0355so15585685ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698423538; x=1699028338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twpA4kPTjPdlQanwemh5B6a0NpYFUbg/0uFl1vufWFs=;
        b=OLUjGzOXJ2tw9AcnRVY6HY+c8Xs70HO3JLR2kVvG7dWhrTHHcnUklj2HFTNULvzvwk
         FhFnjmSeUkeeOmZBO+1x+aRCIsJJyVNdk9+XAdWyO7dBnWuxph23C5AaQ6+ZvYkjKArS
         lrmeuvubU+EWEmAh6j9xfqWACO8HPnDfb4UkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698423538; x=1699028338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twpA4kPTjPdlQanwemh5B6a0NpYFUbg/0uFl1vufWFs=;
        b=e3AcoLzwewuvBYQ83UuNIMIO5z6BpHoSwBJbysrw9uyOmBvBsjmf9KxRscPh+lKLa9
         KLNagKfHAfpY+92HIwTZyYbZjJj0W7Z+ws8nK0bUVqtL+GYc8y9lNc4AWEo/5UmxBaOV
         FS6GwQ9QQ3SX4Yyrw7K3iiLu9QtT9TOb8BX0FFgk5TYkcHVffTWkYjsHr+kdKH2xv2r8
         Yh9bYyG1nL46dn7NME4Dyxn8pA/0cL4lK2ua/rsSFPnLNUXCXNAaC2DIGmE52+suJgMh
         WYJ4RtSSANFEkDrJYgvuklO4KdmvOuXvw+njkugxctWp3mWeRwgc33ASshBE7YmceV/0
         brkg==
X-Gm-Message-State: AOJu0Yx43uWqQPkAir3JUBBcM31q7hPV7vCSiXLabtf9r8CpxBg66gdR
	1bmJFMUGiDR7PHlWUlSEZruQ9A==
X-Google-Smtp-Source: AGHT+IFwV7PcaIlnwoiOO9E2bXJCkNVNwxIGikMfCb5e1x9KlANhbH020bPHG4aLV7W6zssgNv+xCQ==
X-Received: by 2002:a17:903:2309:b0:1c9:ece9:53d2 with SMTP id d9-20020a170903230900b001c9ece953d2mr3515237plh.61.1698423538314;
        Fri, 27 Oct 2023 09:18:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170902ee0500b001c625d6ffccsm1759643plb.129.2023.10.27.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:18:57 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:18:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
Message-ID: <202310270918.EDE919D348@keescook>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>

On Thu, Oct 26, 2023 at 11:53:28PM +0000, Justin Stitt wrote:
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
> 
> For the case where a format string is used, let's allocate some memory
> via kasprintf() and point prop to it.
> 
> This also cleans up some deprecated strncpy() uses [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a reasonable way to go.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
