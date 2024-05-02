Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543E16FF4F
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671948; cv=none; b=E3i4tfpVZgZK9dTxqVvXGkUlydd9JU1PxoBfGg8V1cLfBUphaMWYyDFQBhT5ixBJxhAsTO8OQuIdZfA60bo8xUHKabylh1H5r71A2yV5/Sl2KZXH4duEPqn41+K+bY2PR9Bgyu1Oj2dJuHcrkGV3O5/o285LoWOGiBshQFyPQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671948; c=relaxed/simple;
	bh=IHxGn1w7e072y8lu8XMZs77quMjYuFA4X7pRPCXprfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psifg5OBog0y2IIDXFEdHAdXNhLZUlGjfErWvy2Mu6mjl6gPAqshFK69+1lLnnpeP714+ESurA0WndnRVylefoSmTam7CIqDSknhSZFS1xUdVLkSpqBBR6Wfmr9K+bC1uzY0vqsc6OBBeiGl1NvxfNdAiIOt3A+trGA/Z3WXmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dJKf9Gtv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJKf9Gtv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec4dd8525cso25401375ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714671946; x=1715276746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exzo1UieylDBJQODCUVqGFbljUasMvDy96izXXeVha4=;
        b=dJKf9Gtv/MQbi9CX6AolyH6LMBHl1/8kbKdX4OcK23Br5xTZPmJcPKhCrzZJF3Pcpa
         bjbEND08crOLeeuwqxTT7/yilYzTRDpf1lpOE48kNoD55Ku9ex7GWNlznvWbygRz0R0S
         BcBKNoxM1eYWlnD8DeRcqlzyixxLIJgAR00bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671946; x=1715276746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exzo1UieylDBJQODCUVqGFbljUasMvDy96izXXeVha4=;
        b=hQ4sCs9yHesk9aw4rkRriA0+lGxMy6ZsjpOxzOKKJF3M365fSMq8ev8x7JgbNLpvOw
         6Tv1OFWUYO6tUMO/UztejWQiOLpNR6Hxo+6LOv46WRrE4BM+21G8yvfcjOHeiTuFXZjP
         bccmP1kOtv9O/7fUsXdxKcaWSLuVXxIKMP4E9T8wkbfbjSOroSDlXkb95u0DU2/SR4BO
         Qc1fg0679KbE4Vx/rh6xWqx05OSEPKI9x7ShHpRofmPZnAsDVrLF8XTrbkdGRu/QuHHO
         ePIQSx++WWZVqUcPYY5GGMw/kl6y11NUc8Dh341eQeVHnbWMOchiig4tYuPo8ktLwAnq
         77EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy+hzWagK3TybBTTvVx4woD96OcCve0r4Pig24fjF3/Gjrdc2xwNyV038s7bHv67larlVDv5jdCacMWFH9XNKXunU2tZ/u6FHNql4raXx5
X-Gm-Message-State: AOJu0Yyuvblicov7ikew+WefTnf05aF1ke0m+UJaGhrH+RiXtOfA7tRK
	tXdpF9e9XitMtjn48Y7oZnwlr2EfPYwcFdNbK9RyoJOdphXg5I7kkGlCZb0zNg==
X-Google-Smtp-Source: AGHT+IHJuvpvzMrm4vn0maKzGW0icLGJ4G7TA0twF54RBTausoyPGzqBnQ+KeL8WeHu9J80IQqyC1w==
X-Received: by 2002:a17:903:1252:b0:1ea:bc:53ac with SMTP id u18-20020a170903125200b001ea00bc53acmr449268plh.44.1714671946197;
        Thu, 02 May 2024 10:45:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902c64900b001e5a5ea5287sm1588059pls.208.2024.05.02.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:45:45 -0700 (PDT)
Date: Thu, 2 May 2024 10:45:44 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
Message-ID: <202405021045.CEE4DCA@keescook>
References: <ZjO9qCx10KUJbK6w@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjO9qCx10KUJbK6w@neat>

On Thu, May 02, 2024 at 10:22:00AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> With these changes, fix the following warning:
> net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice! This looks really clean; I'll point people at this patch when they
want to see these kinds of conversions. It has it all! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
