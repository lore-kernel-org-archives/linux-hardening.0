Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCA26A0AF
	for <linux-hardening@vger.kernel.org>; Sat,  6 Sep 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149540; cv=none; b=QESJM1wRpMJP0+BW+7VGRUuF6Tg6kmSsHN+1/ySFotg7tqebbUWpeLb06A3mJ0+fT1bHgCHvdAkzGSN6VCRvsUzQCP+DldaKyxUAffzf4wNAPd0lnM1buPhTno0jVMIqlA6DAz6AEjiRMAqlea4mHFSWlCSmIMqmruo7UHwN/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149540; c=relaxed/simple;
	bh=3iQcrJcqfq++ZTQeqS1T6YrLPIp3lL5wLcHB28bWo/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGnJX3JwZXT9UCwRbQHix0prRTIrVuUTM6abUkPMBrgnREJpJKrjBdKX/dvDV5KuxDWrHPMK9aGIURQ4lYgzDSLtW3B05O9XPmK3mAMhhVkfdz/lpKmY/nUVKLK42S5+2bX1TMm9skFYStMMnrhQF02p1CHRZtVMGk9STEiwwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2XEgIu9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2XEgIu9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so1041511f8f.0
        for <linux-hardening@vger.kernel.org>; Sat, 06 Sep 2025 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757149537; x=1757754337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hki8HdhvXHfU2F+7OeXOSp1xyhvTQ6nvom6Fvz3c+mw=;
        b=F2XEgIu9MzE/3fAFKvS77wTQGN9yWWe192O0RjSu+oLz+iEm2JKeatNUKOwCi9JAHl
         35JjnqLADAAt35gXBMNPk0BAHRMuRPyAiQD0LChmZHYyjYqoqq5f+FpLszNZEXl+o5gT
         /XtmvN/gu7eMjeWvB/T/JKOmaQY+HTK8tYB4IiDE1KghjIRZtVXOHsBZysfdLNV40dxc
         1eYYgUfHGBmUvCgL9qj196c4GxG+G9XBuhwwa2kJqritAdnt2scM3uGEL77W9ZTtXMCA
         Hy8JTKBXn0njjsCDXMtLC7n1L25uheu5GktVPv/GoacDP5N1JgtpSJk0oX6X/QurDWMS
         KuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757149537; x=1757754337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hki8HdhvXHfU2F+7OeXOSp1xyhvTQ6nvom6Fvz3c+mw=;
        b=uWNAX+wKup818Hu3xajjAPHOfzNXSTBu+Feqbf0etNNX6ocuD+dyZ1jp15tvDnMArM
         mQIx3W/Ru7Kok3Fjrn4kfte9rW1K8qdqftvOzwq2j7F4XhR5Anf7AYIydnOf0yBeYRSz
         gYoIkMCDq8Wy2tTJqYCmI+nv8V9Ot7Ar6PDIu67tVKjkwdsMhVHLNVvqwSgwfJfKKgFI
         Tge86VNLCwarjOSSoPlcQjHjoY0OGH38NLIA9h4iOniapI/zIEGwvG9JOwUZWPuExTn4
         sHrzRAG9dAyP7jZrMAUyZ7sq4FbOOnSGx30/DEsuy+wNaqr3I7+gwYV5F2bUqK8uteZv
         sFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJI7tPrFt5hW/YCAUWbltMyK3pFENepZH/2OMRLd/s0RPaLnYNknrp8Lf4zUW4WuydzuWbwF+3yztlTtEHUW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/3x/FjSuC2PYncVA6bFfC9uJmP3kyqrDPo+mJUrHs4zAb9up
	/dsH+wadPXN821yrA2Hyw2OZW6mOXhFpvewM2inkxfLj64QwTfqvVPBTGh36TkSYxbQ=
X-Gm-Gg: ASbGnctxTvRm2dwypq8tKAjwnoMiWFsnl4ipvsfK4WUDfQal+pRGMeHsjDxuVXkxFQk
	6rRDF5cb8CLDEPMhvPj7nbx+sr7MuDtfBnFHFAFUUxGlc147lw0TLaLgCLVcPY3s+Gd/ObWFF0n
	EbVFTvxbQnqJzq5ubhjkHx/3lHkOHK4H+Eng0MzyNP58roXCxss7DPiBnhPppdBGqPKypX2gIjX
	h1vBDmgdSBJI/GfnQpb4SUIbDuASwvzeVi62dc/lr/f3JcIQB049A3ldfw3jL2ZcZzX0jVwVIYF
	3ZSdgwzJU2v2AZMD6FihLdA9/4ahplqamFbMq2hmifYFVN/p/dp/3FC+VsdSQX5ol0gIYMPAcxJ
	MJUPRdpS5D4NaG04h3ZDNVhxrJ1lpTr2W3IUjKQ==
X-Google-Smtp-Source: AGHT+IHOiFBNtbdh+ZPHcW0eh5OTeyAVCftx5e6W3o7t6l/2O0QB2mqkLdjfjU9NIQo/lpGZbryoNw==
X-Received: by 2002:a5d:588d:0:b0:3d6:4596:8a29 with SMTP id ffacd0b85a97d-3e643e0a48emr1185814f8f.44.1757149537170;
        Sat, 06 Sep 2025 02:05:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3df4fd372ccsm12287698f8f.32.2025.09.06.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 02:05:36 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:05:33 +0300
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
Message-ID: <aLv5Xce6R4ofalnf@stanley.mountain>
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

Here is the patch so people who want to build linux-next can just apply
it instead of needing to cut and paste and then %s/    // or whatever...
Hopefully, people aren't building kernels over the weekend and it's fixed
on Monday.  But just in case.

regards,
dan carpenter

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

-        b.set_bit(2048);
-        b.set_bit_atomic(2048);
-        b.clear_bit(2048);
-        b.clear_bit_atomic(2048);
-        assert_eq!(None, b.next_bit(2048));
-        assert_eq!(None, b.next_zero_bit(2048));
-        assert_eq!(None, b.last_bit());
         Ok(())
     }

