Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lf0Tbx4p"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC41715
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 14:20:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58d5979c676so3240472eaf.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728405; x=1702333205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+WzlKb2MQSHfnGqBE/e5O7OA37FmS5jYCRCA/LLsH0=;
        b=lf0Tbx4pZSpplXVE+zqYxKYOIwCE2xAIUgcZiK3fCq6WNOA8asMjsl+yN0MHxt2eDn
         rbaiZLPUY41HHiP3/HfHTDEMuBNSsqFAfOwLCszTWL335Aat5ZHiNUr8kTLUlWLeMVgK
         Ko4WxPKFTphxd51BX4j69weJgwWn21SSL2GP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728405; x=1702333205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+WzlKb2MQSHfnGqBE/e5O7OA37FmS5jYCRCA/LLsH0=;
        b=R1aoqAjZ2EzUnj5MGZoV0O1BGtz1ih3FILXkfX/JhKt6E7k3H6aVUGzY9nAzBHIYeT
         bIUbWMXKgCCHAqbtos9veeepdMVNM5rOLCazkxKtBlEaUx77qp+3Dzj4BNTeRxsT3X8H
         Sxebzerj0KANn6fGVV6gi9URnmS7A+LuMK4lx01oBssfwFri3rTJS5kDb71li1AZ5Cj2
         FKT+/jlmMS9UOuU/EWSRRF4QjOm+fgkCzfCxqUFcKA2qdtoLTg/YeWa1w+7dF4nS3hy4
         1FblCl4dMKrIu6iGbsyneGRkXVSVVuf+3e32vGDUwrWSackBGjkBhDBywpplwU1YP5Ei
         n8IA==
X-Gm-Message-State: AOJu0YzzEBGI5CCT/cGs+cuiMwjL9/opsdnuaFZbVGNMKlDAHa8+2BYZ
	4WGX9n2Z3+3GFJpxpJMb1D9Cpg==
X-Google-Smtp-Source: AGHT+IGC7BzaBQCIfZe1vXo4mx3JRiDIzetuPnC9oVZ29pkisPeQ4hM13pxSUb9WDQN6k46hgaEL7w==
X-Received: by 2002:a05:6358:9106:b0:170:302b:545f with SMTP id q6-20020a056358910600b00170302b545fmr2543842rwq.56.1701728405319;
        Mon, 04 Dec 2023 14:20:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ey5-20020a056a0038c500b006cde75646d3sm4718759pfb.179.2023.12.04.14.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:20:04 -0800 (PST)
Date: Mon, 4 Dec 2023 14:20:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Song Liu <song@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible
 array
Message-ID: <202312041419.81EF03F7B7@keescook>
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>

On Sun, Dec 03, 2023 at 08:48:06PM +0100, Christophe JAILLET wrote:
> The 'multipaths' field of 'struct mpconf' can be declared as a flexible
> array.
> 
> The advantages are:
>    - 1 less indirection when accessing to the 'multipaths' array
>    - save 1 pointer in the structure
>    - improve memory usage
>    - give the opportunity to use __counted_by() for additional safety
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This looks like a really nice conversion. I haven't run-tested this, but
it reads correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
