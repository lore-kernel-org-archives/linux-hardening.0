Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A223FC66
	for <linux-hardening@vger.kernel.org>; Sat,  6 Sep 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150326; cv=none; b=fTN7877pbADcMSTtkdKvoCyux5tea5TivzUmqsOnVO0iLfdQLvV5Ft4BESrGjJL76N0vvBkr8Gd4TEg9jrh0s2MLl8LeYvsl8GuS+CY4/rjA42aK/i5eoTahgzjkhcNAQZdaxKa1RkiF86ds5QNpNiL/hX6jh8zzxBzZFZE9UoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150326; c=relaxed/simple;
	bh=ZQ7lpd1XT5N4T9SMoxnjuRbAVrF7J7a9ednn2KbopRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Wjz2T6P8gY2TCQnPuydOsmYpy4STJhnQbOx41jymBPpVpzKiSsXwyEvhpoLF4NdtUhZ3rkTp5nbyBxbrbTNdt4RcPRCcMfvRD5a/RVSdxY1oTbLaqW9v+vpmBlR9G/Q1R7veUHUxdDtfvbQPvS9dclxA7QiWrtttvYFZUfZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWzTRbNJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWzTRbNJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso27208555e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 06 Sep 2025 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757150322; x=1757755122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAca1bJIuquQIcM0fzX3WTDih75xluTXBl9R1BvXLgg=;
        b=NWzTRbNJQGFdUqlR+wnuQnBNbeG0Igd6vr1GCkn9S+k6nVn2Fr34WemVB62OF4Jkcb
         1CU+BRojGfqpVvve+ABOeFbKsBemG9izn3lGmkYLFIsvxgkImZmq5ZISIouBNlCGnJsC
         NfoR8KnZBoPaaTkGO3Ek9P5DKyyeZ8xy1lxCkC/tO+EJkOs5mlNsT5hXPP5c/AheVFEb
         dDGWd1h2YcjL3QkP+WMDJ1z1/1IHyDir+xOLOM0Yf/xJcQOkDE+qifwHKyQtFhJPVvAG
         /c+oufGhlbuEqIkQd7D67WAK+v1YusPuGizqCklWuR7bgM6wHG03iWLjcHTxDz/48Zla
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150322; x=1757755122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAca1bJIuquQIcM0fzX3WTDih75xluTXBl9R1BvXLgg=;
        b=ev92q43asuFRUCXj25ajEQJuJlMmxhnf/AYnN56S3obHLRQghcUIbqqnAL3r3o3riM
         qWYzdvnNURO+U9oJZD0Sj82yieYGokeTw8pkS/r8j3rxtsRcKS9hQHLXXnepOAVHnOw1
         CSVt88bJtezfZK5sEhrwDOSrsrUF4ysQPQWuK4UXgoDzUTt9cELWYeDNukn7cfx78LER
         BRz8x2tTkh10J4G5X3ztWhQyXTn9AjSU6w9ZGEQMXcL+GpJywT834MZhACCQbnp+DO1m
         jqynDo06mXwiR7a0S0oikpibLlz38KckVPr7X80sWArE8hdI2yMEIhCVpp0qiGGE0gYH
         iR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyPJAaFk+Or4AEJfqVlmPgWiG58xH+IRYZMKWHnpqefzwBsk01asVeJjIHw9paVnAG/6tFyGvxu6qXsWo+auY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4ly+nWLK7Na6WCKF0t6sLjPRljJZvH5aXMmgvXfqbQFYELej
	soXMQtZoYdyS5ncJe2UZ+d9eKWYpXjLk4JrhX56ZkQpZLwGzwEgijb8bEJ7kBziCpsw=
X-Gm-Gg: ASbGncunyk8LtR/muPm2GqiWkaaabJ2Hhya0IyJcRN6Ke3vq5+oawCLdlwYo4Vv2/oB
	ONgeKtmBE7Yf0NxIPP/5FAyWkoutYwvlxhjh3/yoTwVqc0g6hpkTb0K7/25jrsZ0UaNPMVjR/NZ
	jL1edcz1XG53r1Krznbi9LcgqyMczNX4kM4Eh/qSRSG0oVxdKoSAhxh9S21q605mCXz28NgQOxs
	QwsSI8xmvn56Xhvam0+2x3pBQvKxSARnKvRzvQ+DAsxoRg7p/WMmbOjF4hhD4A6IvwyW/8iRl8F
	Ahy+Vl1eUs98MYV3rxI6fQ58IHvNywMxihmqBHUZhQLl7Eaw1PNM9bZb7mecWMNj+YpHJCrz5Fw
	Hw10zXYJAaE8ZnqS2GR6T06jV1VV5Xm4InEwNWQ==
X-Google-Smtp-Source: AGHT+IFqp1h9ELb+FvrQR7wCwtJrfM0BwFm8jLXPTni+jjcYpKHWVl8UfYcV4E9Yyt0+EtOgeMcByg==
X-Received: by 2002:a05:6000:24c8:b0:3df:1a8b:ff60 with SMTP id ffacd0b85a97d-3e305777eabmr4744914f8f.23.1757150322499;
        Sat, 06 Sep 2025 02:18:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45de18f4824sm2997995e9.10.2025.09.06.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 02:18:42 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:18:38 +0300
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
Message-ID: <aLv8buzrro0E5CCQ@stanley.mountain>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>

Nope.  Try again.

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 6e0824579781..2f00e91e9c35 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -551,18 +551,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
         Ok(())
     }
 
-    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     #[test]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        {
+            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+            b.set_bit(2048);
+            b.set_bit_atomic(2048);
+            b.clear_bit(2048);
+            b.clear_bit_atomic(2048);
+            assert_eq!(None, b.next_bit(2048));
+            assert_eq!(None, b.next_zero_bit(2048));
+            assert_eq!(None, b.last_bit());
+        }
 
-        b.set_bit(2048);
-        b.set_bit_atomic(2048);
-        b.clear_bit(2048);
-        b.clear_bit_atomic(2048);
-        assert_eq!(None, b.next_bit(2048));
-        assert_eq!(None, b.next_zero_bit(2048));
-        assert_eq!(None, b.last_bit());
         Ok(())
     }
