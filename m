Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D004125AE
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902597; cv=none; b=FAGTch8eHakDqwKA8mwzKknfRS6jncUzAFpiMFpUs8EYgt9XNpui/kT6342ELqJsvXe7LH4mAHfqGEZKmRA2FeqgqhQJPmfenaOkU0zfEry76aJWbZ+V9G0D5kFK0zWBId0nPd5yp2a3Wqd6I6LCJf4ENgB0xgVWC79BSyQLzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902597; c=relaxed/simple;
	bh=78eAdLWYs8wwvbK9BciCfjdMEEABSf7QMrNnx8TDQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdao2IzZuPCU2CoQTM3TPa3Dz7EkbWyKnJ7oXFOaiYheDmLsiFSX/T1BrdP6BlIR1lLYnKzK/yg9dgfSoXvKCF3PNRvs8q9qLhoVj5EvIV6Q9l+77ZKRO/aJPwPgKDKsrPbVOG6CnQB+dU2HnuQk7HGzfYXJsI1qCkFKS0h/DTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nkgsiLel; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkgsiLel"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso4290869a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 19:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902595; x=1711507395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl3MfsEQolD8Nt3URRB4l+12pLmNtTMn/BYm+Iehbxw=;
        b=nkgsiLelw4DZ2MxSXVM4r6LHpFDe8V6cKCPp10ab6I/n2/F5fzdoy7s9bSKDSScqu1
         eua2yOKwjTc+nkBRKUK3GGB6Anv/LiOxDzbE4/EBzZW9eILuXDhH6kRdp7n+/lq3F9BW
         KUs1/6BOGjRfmaDQ9PPWka9IiG6CqzXMRLDIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902595; x=1711507395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl3MfsEQolD8Nt3URRB4l+12pLmNtTMn/BYm+Iehbxw=;
        b=SBFq74lhBAlgDZKPEKRB4rONVtwa/lLL9BavoH+KpOVxyafhkFJQ3DO1nvAWUC/IHq
         YFEKjVf/RqkIvqntGpEhGqValNYTqq6ITwwJ/05r9qqUHMnttK4+1JdwUwnkwVdyGJys
         45o4Ak1JP3EDY3NPqv2VUkaNky4Y2f9WtGOZvWtfDwjUoqB0TvP/QxlWH4qF8Xm4k4z1
         eyEHy5QTaNMcE/X1gnINPD+VllPS3xX73I+pI3Q6IUnPwl52WqU148W3+WRFaUX7TjUO
         bOeMD/1b6R2+EWF6VnR1HiZ86PD2H9+CfugtbNBMRMbk7FVulRCYYao6yEGfUqGIoRsW
         9Tlw==
X-Forwarded-Encrypted: i=1; AJvYcCWue5FWBEE4QYk+iVKaU8BDJ6PFYLT0lG+XOWF8bthFoa3nd2aY09KLItEDXv9g+TBq6Ocwa0IygwlcNAoR8Inbw0jzqqvGGMjtBHKsOc+c
X-Gm-Message-State: AOJu0YxfRPHZ6pXArgo28UDPcn4CxmlDSoPVMRacQdW3gAmsn504gwCS
	caLlM93awjDOvTaH5dmH+bDoYOnrCYIR2S3037MDTIytvi2LZqhLVxzIbv483wRpJMaRvGlP4kI
	=
X-Google-Smtp-Source: AGHT+IHSdhN4oJ83ReMTrtiLGx9DZo48f9RSwLPHgCXKWMgJYzIj42lDSWD/yZnIWQYlaNfyBJMyJA==
X-Received: by 2002:a17:90a:430b:b0:29c:6c79:7e92 with SMTP id q11-20020a17090a430b00b0029c6c797e92mr4024106pjg.19.1710902594823;
        Tue, 19 Mar 2024 19:43:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a164800b0029de1e54bcesm364496pje.18.2024.03.19.19.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:43:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:43:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: replace deprecated strncpy with
 strscpy
Message-ID: <202403191943.3F041A01CB@keescook>
References: <20240318-strncpy-drivers-usb-gadget-function-u_ether-c-v1-1-e8543a1db24a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-usb-gadget-function-u_ether-c-v1-1-e8543a1db24a@google.com>

On Mon, Mar 18, 2024 at 11:10:34PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's use the new 2-argument strscpy() as this guarantees
> NUL-termination on the destination buffer and also uses the destination
> buffer's size to bound the operation.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
