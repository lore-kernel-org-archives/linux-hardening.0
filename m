Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyEgxNWL"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384A1A1
	for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfb83211b9so19492545ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131367; x=1701736167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=PyEgxNWLeJ3KP8hUS7Ok5YSMoLLYB/ml3itP1fDeV5zzMq6GeWq7Yk+5qYJFlWMz3N
         M2hG48me0XDZH/2YaYA5EuA2ZUobganXhFT3/he5pdHZkDEvHVXNsvUG/6vZqdcAiPmu
         s5ehbXKbSfdq40VxQneA98J3UKPHGyCYYXQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131367; x=1701736167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=BHDNsQcWNNkAE8n5Vl8UctwN/xUNXGFUovo+Xvv9oYPud+4VfcOMUUFQ9OoCHlP/vr
         XFjsINLwJ3Hr0Py2NYkH5/vbFjVOpZlHIV0k+XOaiXOauGa+rpxN2nzFz0SX7eAJh8kO
         UbSMNduw6P3gy5X6YnALuyFGxyIYj95caR5pM6uGjV8sMSjK0TcYcD1blpiE+mdjq+dm
         3n97+t2FLA3p8Opnier2OIbqwwPxa9x1A7Q1LIv6e+Sz0YRzzCIM8I1UTh4/WXz61Ubl
         PuBwnNxCwEFbklQxGi8J1Gx2D3aR1qVkL7HnBSDD6DOT6We5B4xO4HXGBZNQiispR+BX
         1e6w==
X-Gm-Message-State: AOJu0Yyqr8XNGhc+kHAEGdag7BV0wm01ecMqIcDawdmTdpdJEgr5DEFR
	APbwwJ1dQ0SXBrjywoP2sYmBW5vfvusy/7mYoifsaA==
X-Google-Smtp-Source: AGHT+IHfOT26JhpsCCRBM96VOFEk0SgWcQnWOKyzAiCxrKsjcBUu975ao2LlZFeKW0Hd0NQIfUCkxA==
X-Received: by 2002:a17:903:22d2:b0:1cc:c273:603 with SMTP id y18-20020a17090322d200b001ccc2730603mr14361492plg.42.1701131366965;
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm8824250pls.256.2023.11.27.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Date: Mon, 27 Nov 2023 16:29:25 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bill Wendling <morbo@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Message-ID: <202311271628.E5EED48@keescook>
References: <ZWJoRsJGnCPdJ3+2@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWJoRsJGnCPdJ3+2@work>

On Sat, Nov 25, 2023 at 03:33:58PM -0600, Gustavo A. R. Silva wrote:
> Previously, one-element and zero-length arrays were treated as true
> flexible arrays, even though they are actually "fake" flex arrays.
> The __randomize_layout would leave them untouched at the end of the
> struct, similarly to proper C99 flex-array members.
> 
> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
> randstruct: Only warn about true flexible arrays"). Now, only C99
> flexible-array members will remain untouched at the end of the struct,
> while one-element and zero-length arrays will be subject to randomization.
> 
> Fix a `__randomize_layout` crash in `struct neighbour` by transforming
> zero-length array `primary_key` into a proper C99 flexible-array member.
> 
> Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
> Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yes, please. Do we have any other 0-sized arrays hiding out in the
kernel? We need to get these all cleared...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
