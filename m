Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1412DD96
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682735; cv=none; b=nx3paU1t0iznaeJaFSxWXwm/XcA9fUpiLs8eSaEztvXbhvI9tDrsNxvwXRU1/gSjrqAtPJc0DopMf30vxi0zxULNElqQvAJRvnyQy8eUryi5VOiaD5LvJ+m99uOD97qIQyQsPmUBj41KxoBKquTocUlQS292voZ7I0AGhAvFQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682735; c=relaxed/simple;
	bh=jad1ZTuPBnQnVhyAUaIXJ0sj2KmNN+XpvGPh1Z8NAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIE9RL6FEKg9xmEUInQgd0XBzrZnIzuwS5c9QVRVwoGB+wmA/7Wls8+TSMP9dxDI82w57eOYDv6gqZYwhyzBkYvNiLzPkkchisXLLmRD0o/nV7ppbLbSvnI+uGmb5vaIYsyjj9cI8IqEBXuWSxCG8G9/+KykfWJ9DJcitTTNUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hWQNwmko; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWQNwmko"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7232dcb3eso46487455ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709682733; x=1710287533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=hWQNwmkoP6X9trL+mOxnNbMVV5ZgU4F4xTCcdQhzKJqixqNrhe/FaY7XPOdBZH3Wfl
         sZ6wD2ubgEZpJnJNcab0ofM/vJ4mW3tPl+Eojwwm/m7YFpU6nE63s6Yi2AQqYGPU7tk0
         KIfQUPpcg0mZ8Bd8PXd+LPnMZvYWnhgE6gu7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709682733; x=1710287533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyoc6sqBdOY+7wLmmpdaiPXTvskeQaEAskb3Q12WvtU=;
        b=Kf3/AgEKsF0hjJFkHWhy/ufwZQ1IYAu7fFoDW0rGsCr/jy6tmVHKnA2w2GLC8xSMzz
         nV7MUt3cTJeo+SkIzJzYoQvpgnwNLZZbBTz7oRjdhLUqttjFNiq7sCpSYZr19SfFNnoM
         UwcsUOdE1/VeG9p6z8RuNvaKdRCd68+uCQMLomW7Sz3qh6luNtH8j6ZI+3kPOlm+LfFk
         HNK+Q4V/MpslOeG9px9W7kMqm09KMs9/7by1GP0tp+eiAdmu7HuVAyoqUQWjh/vpp8/X
         WSKeaQloqJMIHz85WPdZgGIawXmaJ4o6wHILrPx/8DdDSDHhswbCk/8/ZAcDwcaU8KM9
         qgGA==
X-Forwarded-Encrypted: i=1; AJvYcCXKT+dVS+tlhw86ledHB9U6JaqaM4WhYtsnoEytFlpUPSlnwbviq5ebQwXjktebLksnJsKGRQEsVnVUnmWMIQ/Yg2C8uGHhTCcjAJlmxD/V
X-Gm-Message-State: AOJu0Yy6lvDZToLbknD/9085+SgGABXCOoOnNgGEMHGwP3Gpn00B7J5b
	QEOxh8O7Hb9Atg5Ihy1y6hOk1fwzucqedHAP1M4WOpi2qB5gXbE0QL0FZmgsmg==
X-Google-Smtp-Source: AGHT+IHSAi/R0Z+FnSnYEll+Jdzr9evRXwkkfto2W7u2LIJBRhmtHvsvuWPYgTohLmHE92SmGPwJxg==
X-Received: by 2002:a17:902:a514:b0:1d9:7095:7e3c with SMTP id s20-20020a170902a51400b001d970957e3cmr3152769plq.57.1709682733364;
        Tue, 05 Mar 2024 15:52:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm11089065pls.224.2024.03.05.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:52:12 -0800 (PST)
Date: Tue, 5 Mar 2024 15:52:12 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202403051548.045B16BF@keescook>
References: <ZeeaRuTpuxInH6ZB@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeeaRuTpuxInH6ZB@neat>

On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently a local structure `f` that is using a flexible
> `struct file_handle` as header for an on-stack place-holder for the
> flexible-array member `unsigned char f_handle[];`.
> 
> struct {
> 	struct file_handle handle;
> 	u8 pad[MAX_HANDLE_SZ];
> } f;

This code pattern is "put a flex array struct on the stack", but we have
a macro for this now:

DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);

And you can even include the initializer:

_DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
	     = { .handle_bytes = MAX_HANDLE_SZ });

I think this would be a simpler conversion.

Also, this could use a __counted_by tag...

I need to improve the DEFINE_FLEX macro a bit, though, to take advantage
of __counted_by.

-- 
Kees Cook
