Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CC2F4A10
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325820; cv=none; b=TJIINByuEtR+ACDXXAD7XqFixMfWBQkTL5MiNyiIjcjXjEWUOsRcQaN6n7tQaLBWrbm1l24PXb3mAxvtYN0Tn0Sd5DexUDlYCGLZ9QRhoZEiQ1mdNvN+TUY61hxSUlPJWPHNc1VvU87/HTW7V+LkVxWQSGuwowqs5k0ZAF04iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325820; c=relaxed/simple;
	bh=/dnp+b70WtKeplBbH4n2SjTpjJwhsy8D29w78HMNMW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MabWlgdr/DiE7hVRUtnpHV4Uk//pEYvQvDCl8ZWFR/Dnxk/1v2+FhIaumWqvlwoPiWR5hbfa5e6pVt+t4tOIPTE3CZpfTE2C4FFoqq9312BVswKndyngOQwvra/fjFTTtwhTARbkzq6QbqqBD+FupXiAz2Dlr+vNE8G8bIU1GZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w59xb9D0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w59xb9D0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so4366515e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Sep 2025 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757325816; x=1757930616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaps07dD7XTryihAK0nxG3s+QduS7EL0qLU4yW3i/2k=;
        b=w59xb9D0QbhiwjGic5IbwqSvzNFg2sA2i+X7c1ZIbrQu9zFglgTl6POcQJ4yythZsu
         cmf5OLptFtMbfh6ls9mnXVHGFcGbBHHEPNr+Wrjiq7LifJn+Jmylvrozuwg+05Y63SWm
         O+jmMHUXf2jLOrbnNvkvdQZWdAqwsT7oT2Q5+qFgiUAw25vOpzac4bYFof66zP3TOP3q
         9fHupeH29NQPUb52G46mQng0JfagPpRkYshIi/zEA1y8OtMDjaVN+EFCKVM8mRoBkPA4
         i+12TliiV1NAX/JdR5I/hJJW5Ndtbaq+g4I/YtW9T24ztgGBNvbQXkNMyMX9A+Yexx2H
         THOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325817; x=1757930617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaps07dD7XTryihAK0nxG3s+QduS7EL0qLU4yW3i/2k=;
        b=TyKZEFgJr1zkzZHyitDHTe92yXDtTgD6HwFXw91y0kVsd46GeMVZzMjibA2y8tqiWb
         R2eBCnHSNJusynpgcxLPOgJByobDzJ7aFeuYELTZX9AZM6zd5oJac5Gdaugn8R4yFyZs
         KZfyyzyHEuVVPS5JQSPQaW7Sbp9Lwx4LodSI/UXvIBlvaamKVpLe+KdH4PEZAN8Oeldd
         RiTgdzQDjb3bYYYKEPI/RyNhphcGeO33JUMi7rJLdQyHWoXJ5mGomeHkPP1P6CVV+eFR
         9Ts9k8BbflBRJaGSfbi6+8Zdvx1qtSaXFfiPFn4qiwPUVV2evZgrqdGY1PwAjauexule
         6auQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAe4FCGup71kLXZR4tYJykq/cvrAOyoOa9LwO4eDf+tXsxri/5aAFbSH4PWzmpLTcVkwaFV3qvG+B30F25jCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBF/VcPgDUwWsKEAeCVwP3JTT2WHZCrhAIUUH/yQZG60P2F9ON
	ZagK7EF1Mh1+AGPDL5/8lHQfhNayJXxAQNnceBN3LLcceyBBXwfS9FyjgsGZGgUEGrQ=
X-Gm-Gg: ASbGncvANu21zumT4QTy4hzVo3ebk4lPYaln4Dm7L2JhUB0AhVSCdyUIesCJunqvea4
	MxRKQB742zfkWNKuD8xVMjjQ35DIGi/Z8qCevnrWUS4JyzFr5jQbb/SHfrJSWdf7biJWodTYRbc
	qTWlKwVwGO9QOlLdzR+0QZdAD0Hts+65c0W2XH8566LJGFpwd1vqvD85Hh46X1F5c6DnBNjE8z6
	KXmkBlLMUqQ5msuibAcS+ZexxVaFvDRatv6+Z99xSvceKW7mPGqeAptSeh9E2s/gAzPqs4N7aIv
	4RRCc6d0ARME4nWozmjhWk2Fd5fXyS/d8LdHdKPm+YjpUO+wfydrzy/eA6mqAZeo97L9WMXezf7
	t715j65bnyWHnate5DZUcdCj7VUM=
X-Google-Smtp-Source: AGHT+IGL5OGrJB0ylbpCgIg6utoXZbQI9spp3FeA2h1mOkfInEYNAHzZhtaFvbEqqM0z7SIbBa3RoA==
X-Received: by 2002:a05:600c:3516:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45dddedde1amr64296245e9.32.1757325816590;
        Mon, 08 Sep 2025 03:03:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dd05faa9esm92427275e9.3.2025.09.08.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:03:36 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:03:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aL6p9P_bfYQsasYW@stanley.mountain>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLv8buzrro0E5CCQ@stanley.mountain>
 <aLxE0AvP63nXxciG@yury>
 <CANiq72kgPKwMdEni7xPOXZ55CDiUk6=ZXDZrx6fSheRSZ5aq_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kgPKwMdEni7xPOXZ55CDiUk6=ZXDZrx6fSheRSZ5aq_A@mail.gmail.com>

On Mon, Sep 08, 2025 at 11:24:02AM +0200, Miguel Ojeda wrote:
> I understood that Dan was fixing the first diff he posted.
> 

Yeah.  Sorry.  I tested it but then I must have damanged it before I
sent it.  :/

regards,
dan carpenter
