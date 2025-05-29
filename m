Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988C1DF25A;
	Thu, 29 May 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549247; cv=none; b=WPCt/p9H6Fibu+Pg29YNiUp94o80dWd/FI2MhF9l/dDPDMeBDAFufvqTENRhVYGD5ZqpVkjDCxlC/QBsf0JDWX3KfB+9X3GlKOtAk7hdviQdQVGbuWwkhl/3c5y6S6Ctf3Bj7SiGOD03ot3rcqFWccbCBIaGhLIoOgefj7oVNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549247; c=relaxed/simple;
	bh=V+63zwBPJyHJfrDBfO59YubIuHOFc4L9zktiNz778PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECIAaAglkMaacwiXztQxBi5kTjh/0klj7I/f8N1BbYvu06UzrBKYxrbXJvkIDH3wcyECZcpVed29XVUUVCuHSNs2JVk7f2xvHL96wzYEpqshv3BKuZaHCXyPw66nW1ztTUWEmPpFOFX+MjmUe//uWiRE/WIKVD1W+SfvqOTUlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUxIr48t; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUxIr48t"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so129943285a.3;
        Thu, 29 May 2025 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748549245; x=1749154045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx2TOYqTq4iYC8QW++typpV6X5x3RQELnAWWO2BJ/Z8=;
        b=EUxIr48tNSg/Jdi5hJKyCIkMtpWmQceUIg4CqvgK/7Jx86/V4HoUGWFoB9sfuSwgBh
         oej2jEaerNwmpvQZDZ/IqErbRma7uRQb6Q4WuMlf9UXCK2gUT1JuCVF57M5XApKyfUWK
         Z0TgrnEmre8N+1qXWumjVGrB0YvqDcbk5ZVp8ABxYMVmnulMWwQ5PMXYyCXCbKpAVDfy
         Zg+QmGeZQiYfpwWUPMKOVyKav7xezlA9YFY6amFFb3lJuogmLoLhzVlmfWVmn2Ep1+me
         bG4MnTr4L3J9o6Pj4O93JkvDDF0hECPXNtqohG5n26pl4Ihk5lw9Ihd4A5Ku7zyeV7hX
         WplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549245; x=1749154045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx2TOYqTq4iYC8QW++typpV6X5x3RQELnAWWO2BJ/Z8=;
        b=SlsvbyPOAPM6U0u0ESk8YdxYEzZlvuNqyK+8+RQ2fI0IdimQ7SGT2wmv0VF6bzvxO9
         riJvrNPu8XoQJvrifcSRB7P7jzHN7CvVSlENgfTivpn5eWFPCjeNJf5tBrmniauyPMCW
         iEBGkQpHMfGYln2B6mxhlnYdNWNOrhJUg3rOkJst0LOaja6MMLzTcrR70oBPVEggDfNj
         8lGFRme5MmbOgpj+Kg29kxqnAa2ZTp6skUNPCNX1/MhfbR4b7VGBzORKmnDnh808dxVY
         goPZFSYgbwRueVGMISMNBlFoTGkmn2EGvRe9e3urIyZwp0HHw4diH2GrZWgcCWtv0g76
         w2XA==
X-Forwarded-Encrypted: i=1; AJvYcCVXYrEK56ZEuiWefEucvix5DTYYkceeaXRSOdbpqkO1GFpl95pToAzTEAoUfNNnY0Yp77arBlK/hBUdB3rM@vger.kernel.org, AJvYcCWBVdBb66PZIFKu/SNBPGEIPBO+dpjY5e/IyyXB1zs7PQowl0BH3FTLufH+ZhrtO8cWSvHB5brZWVtSwrbW6cQ=@vger.kernel.org, AJvYcCXIrQVtfdZySEiK+sYbQBuWvt3/7SKWJO6eIcDwec0cCOv1fwWo0GBvQbakDyJPt7TePCDUjkby4mssRBpBd0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5s7S+sr8Zxtq3w5XIy6GsNbvvXjF1TWvxiKukz534V9ii80oO
	vGshXgHnU4JHHSTYQl1tCXUZ2flarU8hETb7uMdKx1ol3rp2cARbKz0R
X-Gm-Gg: ASbGncsm9t/xbv8VJ+rIfO+aSoOIamLfSAAeV9tWO5jOiPzxkoZWexFhOZ0JyMdggyy
	csetKRS+vWChiugKizr16s4BKj2f0CZxVe53bks02Ww9+sa24FgwqgvtGJ8fbyFpQ70VhoRfz94
	GLZRB5/7AzZWw0Qfy13a9NkbkiixRvNqMT4eqhz/AFTAnbnjx5gSvYjWdeuhkUVtBMyh8K0kN33
	c9kv567wc4UoncBNBtIOWf4SVDvVKy1Dx4pCRGZpwdPFEgnICz6a3oA6ccrSEmUbwBXUAvr47Fz
	qMJdpmc/wgUIqF970fOZyviFC9LGJWgfoOzF5BKt2z8cDhWQuMrS4zOSKaLFWoadrbAGRNg49bV
	S7PkYt2uf1Ui1gc2zz2nScINp0wTUNt/LjfbjJ/lCXOaEGVzfNKdd
X-Google-Smtp-Source: AGHT+IEQhxvS4fviQ9fWQLLYYymkWpu+u1gdQfMIDt2Yz9c9GWNFLcR4cW8Hm/aebEPpJSsbc792+Q==
X-Received: by 2002:a05:620a:2913:b0:7cd:3b02:b6e4 with SMTP id af79cd13be357-7d0a1f91386mr144330085a.1.1748549244868;
        Thu, 29 May 2025 13:07:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1a7003sm128489285a.91.2025.05.29.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 13:07:24 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id A563E1200068;
	Thu, 29 May 2025 16:07:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 29 May 2025 16:07:23 -0400
X-ME-Sender: <xms:e744aCpBqPmMw3INVtm5kw3Mnn1LySgp-SH9Z59TQ8YBgvL9Hm4OwQ>
    <xme:e744aAqX3T0MlxgsOhY4cWUcF97IONnPUk23KyxQ1Vb2lxrS6oP4TLlCtaxKd-Maz
    m7iYxrnGs74e3EA3Q>
X-ME-Received: <xmr:e744aHOjpE2WiivxjApQGXVLPVBKP7qMFpC6-rAk0UXsObdMoTdcgb-WLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfduffff
    teeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvkhhkrg
    hrrhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsghqvgesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigsehr
    rghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtthhopehvihhrvghshhdrkhhumh
    grrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:e744aB5W2qZAWf93QtrTv625Ka2yD9fvtJiLgy8XzUvgQlYAr-pa5g>
    <xmx:e744aB5jQdgmIMaMno0Ofx_f44-sbZKERur9eC7NBgWnrDGZvCmotA>
    <xmx:e744aBjEcreGWI_qbCaq5XqfzGf3I13ytqUTv2t9zVSRIRw-oGPBow>
    <xmx:e744aL6fyEA3cTXb0WAYZULq08JvHVSUdoShqJG9CW5z791tqAY3fQ>
    <xmx:e744aMKEyeQ6-hZofgosUi_lZd8AkIgrpGGiW9K-AtASPiyjqCqBmdP4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 16:07:23 -0400 (EDT)
Date: Thu, 29 May 2025 13:07:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Pekka Ristola <pekkarr@protonmail.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 3/5] rust: add bitmap API.
Message-ID: <aDi-edjArUXl7Mq6@Mac.home>
References: <20250529193850.22210-1-pekkarr@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529193850.22210-1-pekkarr@protonmail.com>

On Thu, May 29, 2025 at 07:42:09PM +0000, Pekka Ristola wrote:
[...]
> > +    }
> > +
> > +    /// Copy `src` into this [`Bitmap`] and set any remaining bits to zero.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> > +    //
> > +    /// assert_eq!(None, long_bitmap.last_bit());
> > +    //
> > +    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> > +    //
> > +    /// short_bitmap.set_bit(7);
> > +    /// long_bitmap.copy_and_extend(&short_bitmap);
> > +    /// assert_eq!(Some(7), long_bitmap.last_bit());
> > +    ///
> > +    /// # Ok::<(), AllocError>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn copy_and_extend(&mut self, src: &Bitmap) {
> > +        let len = core::cmp::min(src.nbits, self.len());
> > +        // SAFETY: access to `self` and `src` is within bounds.
> > +        unsafe {
> > +            bindings::bitmap_copy_and_extend(
> > +                self.as_mut_ptr(),
> > +                src.as_ptr(),
> > +                len as u32,
> > +                self.len() as u32,
> > +            )
> 
> Would this cause a data race if `src` is concurrently (atomically)
> modified? The C function seems to use a plain `memcpy` which is not atomic.
> 

We need some better documentation on the effect of kernel C's
`memcpy()`-like functions regarding data races, but in general a kernel
C's `memcpy` can be treated as a volatile one (or per-byte atomic), so
it won't cause data race.

> > +        };
> > +    }
> > +
> > +    /// Finds last set bit.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let bitmap = Bitmap::new(64, GFP_KERNEL)?;
> > +    ///
> > +    /// match bitmap.last_bit() {
> > +    ///     Some(idx) => {
> > +    ///         pr_info!("The last bit has index {idx}.\n");
> > +    ///     }
> > +    ///     None => {
> > +    ///         pr_info!("All bits in this bitmap are 0.\n");
> > +    ///     }
> > +    /// }
> > +    /// # Ok::<(), AllocError>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn last_bit(&self) -> Option<usize> {
> > +        // SAFETY: `_find_next_bit` access is within bounds due to invariant.
> > +        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.len()) };
> 
> The C function uses non-atomic reads, so this might cause data races too.
> 

Similar here.

Regards,
Boqun

> > +        if index >= self.len() {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> 
> Pekka
> 
