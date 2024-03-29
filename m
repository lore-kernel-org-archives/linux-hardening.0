Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092339FFD
	for <linux-hardening@vger.kernel.org>; Fri, 29 Mar 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685191; cv=none; b=toI8oYZPNodptEiEQR23l73Uj3+VeXOMAo+hma3AMKPr9eFdSVUSbbN3Y3xM/m4In3ZBbyhOg4J96IcWfVtpnhvRbdwyLWY2KlzpmIH0jz6sbb0t0qNmJRNkhR0Y2gzHkbP018gDttqdvYODPvC44qhNPYrg8iJTiHFIR52DoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685191; c=relaxed/simple;
	bh=7Q5Z3h+GFGsGFPfvmakMEwLiWFpW7YiCnjBbtwkQFtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfGlJ6QtgnF7523oV79PRzCQi0Rrgi3iIoG0sB8k3cEXh5EXlN/nlIP2+i3DG1G/HaHlTpaCtItCnZWpee8fKszZ4/9+XfxmtTtSxJjPNt45CG/cFqOLa1E+Hhhj9ox74OCGCrt3yn/PuHoNThwHKtsV58M3V8awzuiSQL9ZJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bMy3Z14z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMy3Z14z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0f3052145so16035095ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685189; x=1712289989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+IKl5jgXsGZi0mbCPhq9hLR3oi5JgzC/vagz7Y/keo=;
        b=bMy3Z14z4OHkngyCwvIj0vGgxhuf/ts6nKWquAa3YhCq+ZEjjVjKI38VkdGUWFJum4
         uLDYnnlo2fuspzTXscg83rq2oXyq9yM1pZrx15t91RpjOZ/6tqymT0oLkd5W86pnj8HY
         Uldwn/9I6BNTICL1Yc9Ti6Z7cV8aCbI5mI8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685189; x=1712289989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+IKl5jgXsGZi0mbCPhq9hLR3oi5JgzC/vagz7Y/keo=;
        b=gD4Wck2pI7yhTt83UTdu9spfd3KxfiUaGBcUTUplxhKVQsJ4Go2anf4VD1YWDeNWAG
         CAmHJU2GmFLYf8ybWopgVcm+MLKG5Z2vGSVhTRIw5UAYoBnHtU7Bbb0AYUhhUJHtsIM7
         3DL+/LPSVFef3MIhwq27U61Wvc8p3BL/sMZhxn34qMXivVg5L758vwzS4ACH1FqVxfO5
         Rqhgj6xjlW2Lr26zr2Ddf/vspL7jVN6MehGhElHENZCibJB8jyI4PrvtejNqcGUR3QnD
         LK9DToRtvo4++KlksGnP23DBBAdTrfnmzQLSOXPgFeKrl3GSgHVbGqnNVZWNGdskeNq2
         lM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjPeSMLSMNQC5o0peBMevruzMU2aBrzdnSIfhs/BGSml/FYBXli6WW8XwsQ6S2ou0kxcf6YNARhAMZSoauVWQzk9WJJvFWkV7gI0+53jL0
X-Gm-Message-State: AOJu0YzhMZYgC6n8hdWwUyrFj2x5fD9gJTn/o4sct6vSSQKHHrU6Ms2n
	U23qWUDx2eKe1I7K1ZkhNEp+CtiTvy+b8caHQ6ycADSzAzM5CcpymdYIeP90nQ==
X-Google-Smtp-Source: AGHT+IExHIZRx4aycuBDHgCgeixTvQb45vK5L7KK3PjbTyeTfdK0wlFMrkIFG+tcak2Z0aNtfOlnQw==
X-Received: by 2002:a17:902:ec81:b0:1e0:58e:88a8 with SMTP id x1-20020a170902ec8100b001e0058e88a8mr1776848plg.52.1711685189298;
        Thu, 28 Mar 2024 21:06:29 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001db9e12cd62sm2470242plh.10.2024.03.28.21.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:06:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:06:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Timur Tabi <timur@kernel.org>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: replace deprecated strncpy
 with strscpy_pad
Message-ID: <202403282106.4D3757F@keescook>
References: <20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com>

On Wed, Mar 20, 2024 at 10:48:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A better alternative is strscpy() as it guarantees NUL-termination on
> the destination buffer.
> 
> Since we are eventually copying over to userspace, let's ensure we
> NUL-pad the destination buffer by using the pad variant of strscpy.
> - core/fb_chrdev.c:
> 234 |	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
> 
> Furthermore, we can use the new 2-argument variants of strscpy() and
> strscpy_pad() introduced by Commit e6584c3964f2f ("string: Allow
> 2-argument strscpy()") to simplify the syntax even more.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
