Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929812417C4;
	Tue, 20 May 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747305; cv=none; b=nTb3fvJpUvyRAF6h0Q7YXIaMQqPdDLJpZZ4ZvuyNddh2fDyDiPTalBPWpkUC2MHyYYNCm5nIMaNVVUvNNm8NSy3yHxKpPKjdf9E6qqMzrYo/QI8Tz+uT4xaocwKrEbRvvX88g0QtEHZFemp9xYdLsFSut7IkLxYVkCB/Q3A87TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747305; c=relaxed/simple;
	bh=xPcWsjMvVvB2NxQwrf7ELeNsjVE31Is17oxYmqeauSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RASEs2+mYdI1+CjBnhNmBflQPbS0+BRQsnxKJo/lY43nx1gP6gQh7CNboWMOqARSEfP5yhc5gavOg94lKP+0cK959WK1Yp63OsZVisIIkWoWJg3p9P+QXl7TA56GKvwfP+y4Lvpz+sXyyoAXwBxs5sL4Fev6r/b3hMbPB9EV6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcUuUWTP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcUuUWTP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c560c55bc1so549004185a.1;
        Tue, 20 May 2025 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747747302; x=1748352102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUz/DLyzwuSl6yyN/08nQR7SoRT73d/0yj2Ep9T5xP0=;
        b=jcUuUWTP7BPhm2kbMeIfIeporBYJnR/bF0g0holZAW14w0k8iGsYwAry3ljQRuUg6i
         ovqmOs9iokca+tRGspga3C5iHSsuolVybmb/z1+SGHcpzi+vrm+IccuLglm0QjgZIjp0
         cSCodBbmjM6PiqR6AMYaTgbLrnHIEgVh//bjQqv5G5m/ZpadushxCF2FKh2qK4LXtgph
         q4TSjKipVYCHmSsp5NxyKRjIC8LE701LH1rRCmtDviiSKYP7u3uxPRxvKtrZsWTDwMU/
         5FPu6pIIv8SLTLg6qoDAJ5HiDwVpp+8wW9qsZdKRbIQsuNhM698AR3LAl2fHfXVQjXO3
         w0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747747302; x=1748352102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUz/DLyzwuSl6yyN/08nQR7SoRT73d/0yj2Ep9T5xP0=;
        b=k20rHFQJbV7NqQ0R7i1lSXi+3FwJv0ICaT4MA5bYfhMs/pVlQiB98I7OjUMYsqBaDI
         8/lcvzSH/BhA18Ab0cKXMX5t4ggJWTEqJlN+x87mLgd5So/8tKlSMnYv+dnIn3JIWivb
         fNdhLmvznPWHuRFPXzZcJ4SWp8GAiXC6w5ciwnIuwjJJb+tbsVLjZDuayk0aWeoBscdZ
         ZR3/tJ9KZOi3oioC8Ix8ae9g/sJ19vriTcsiMP3SB3QMlR0L1ld3K2gg6R688ojxWuhQ
         kRrxgN6uEnn11vXk9WVatV8iV3Asm6eDVmYeX9omNG1UzU7qvO2Y7WuEpVSDOUZ60wf6
         hRlw==
X-Forwarded-Encrypted: i=1; AJvYcCWiKtHOxde76KGj70HzSfH+qUJFIL7ft/MYciGwdkoM/4Tup6VXMGPSqAgyeF9x5O8sMTxmz5Vj/qF7zE3oO/M=@vger.kernel.org, AJvYcCXTbrOX8tANtZBeMKks9CJc5OlttJUduLczDfxqE6sUJcDPRLWaHRBb0WCjwcffmSwZjEuS7TLgVJxz+1VuxrU=@vger.kernel.org, AJvYcCXqWW6sNH9wm2ziY9cTQ+yBanyJEDQw6+qNM8yjZyzKOE84ZBP3lpfoKrCPPcp7PUQ4WDKI7gPlRoRq4KWO@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXSeAldXHgIUbbM02v2t12TBeLK3jA9+KLzinqS9vFiXT4Hai
	mC5Gjld1YlzJ6H8+Q4Iz7Kh7B2/SI1Buhnf3nacaCHayhoQmjwCQKuEs
X-Gm-Gg: ASbGncvE5mgMMuYt0SGSSYLkFFjd8ZZjcfHawexlDzcdrhBLlTxvhLHDNotBBeT2N83
	xK3cy+aUHMuwmZ288IWdRPEYvMn3XoJTcZfk+rwSfnNo6PKRFX6HPczwq5rjGvb8g0rrXzTa1Z4
	D5v8i6YZoN0BgzjQw3NIIc8rctDig/1KNbfUxJ11eIAZ3WE7oy7Sir7oFHMELxqlUuggdhbdlal
	/6KnelU5dXDVHGKjjNBlr+AiYa5p/E2HpLTjBY8+9o/qmDGw3DCihgxoqA1T4gwpw/9ZN8uWrZC
	tYsXruWa7oKP+CTFBgFUxbeFGmsSTEHHsNK43aYUw5qz67hAIb6OP3Ym7lg0UqW4ZUFS9DSnjp3
	qaNV6PQzLu/f2zCQUZmxoXBdCciB6sH79+pQHu6tXxA==
X-Google-Smtp-Source: AGHT+IGpDA+4HBHHqh4dmx5ZIDGvAUDMt9ZXlkczmybBOnusFdSuCzMLHTN5wPsihtJvH01wZXZCPg==
X-Received: by 2002:a05:620a:201a:b0:7cd:4b5b:a202 with SMTP id af79cd13be357-7cd4b5baa17mr1680400285a.20.1747747302157;
        Tue, 20 May 2025 06:21:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467bd3f2sm735186485a.14.2025.05.20.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:21:41 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30D001200043;
	Tue, 20 May 2025 09:21:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 May 2025 09:21:41 -0400
X-ME-Sender: <xms:5YEsaCFpPEf8lJHCru0YYV9U8glJ5Mt1k3FYTRVt8K72jJ6R9Cb0Ow>
    <xme:5YEsaDWFjmvLRLx9agrKf5Fk3O8KTrelOv0KWsf-OYmK4ts30c5V1TFf5UbOVxd4a
    u-mw7RME6C_YKNueg>
X-ME-Received: <xmr:5YEsaMKtmJFqgSxNgwYhh4bh2XTMjn5mj_tNDMqI-XsHrmsmUE5vl6VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffg
    heegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegs
    qhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugiesrhgrshhmuhhsvhhilhhlvghmohgvshdrughkpdhrtghpthhtohepvh
    hirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:5YEsaMGz2dn2HJzJOUv603_3WNxenFexoFc3a2ujAJ2gCrEDkEBzyQ>
    <xmx:5YEsaIWzYKn1QXPScaPt4HyFci3VvrCGk-M1mV9SEEty-BIRNKPbGw>
    <xmx:5YEsaPOJ-FQUUi8WZNmJoElHUpUxGpHnNPFyXHFdgvpIpWFlBc0V9g>
    <xmx:5YEsaP2fZNKI2lsjELj259sv02_MtdYNYN3023rHn15sUuWHj6CcoQ>
    <xmx:5YEsaJU5gujDFQcFCDFVvUTnbWbcFQ9evqUw0cNXX6MlhMDoFSQXl7a7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 09:21:40 -0400 (EDT)
Date: Tue, 20 May 2025 06:21:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jann Horn <jannh@google.com>, Burak Emir <bqe@google.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <aCyB4z23VP-3Hmor@Mac.home>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home>
 <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
 <aCx77cCum_b-IR4H@Mac.home>
 <CAH5fLgjqj7binVaLDh7Pc7SVKDM-XrYDEDj7GYBX_MnjHgufFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjqj7binVaLDh7Pc7SVKDM-XrYDEDj7GYBX_MnjHgufFg@mail.gmail.com>

On Tue, May 20, 2025 at 06:05:52AM -0700, Alice Ryhl wrote:
> On Tue, May 20, 2025 at 5:56 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, May 20, 2025 at 05:42:51AM -0700, Alice Ryhl wrote:
> > > On Mon, May 19, 2025 at 10:21 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > > > > On Mon, May 19, 2025 at 4:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > > > > On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > > > > > > > This is a port of the Binder data structure introduced in commit
> > > > > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > > > > > > Rust.
> > > > > > >
> > > > > > > Stupid high-level side comment:
> > > > > > >
> > > > > > > That commit looks like it changed a simple linear rbtree scan (which
> > > > > > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > > > > > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > > > > > > scan to an O(log n) rbtree lookup, just like how finding a free area
> > > > > >
> > > > > > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> > > > >
> > > > > We need the smallest ID without a value, not the smallest ID in use.
> > > > >
> > > >
> > > > Ok, but it shouldn't be hard to write a Rust function that search that,
> > > > right? My point was mostly the Rust rbtree binding can do O(log n)
> > > > search. I have no idea about "even so, should we try something like Jann
> > > > suggested". And I think your other reply basically says no.
> > >
> > > We would need to store additional data in the r/b tree to know whether
> > > to go left or right, so it would be somewhat tricky. We don't have an
> >
> > Hmm... I'm confused, I thought you can implement a search like that by
> > doing what RBTree::raw_entry() does except that when Ordering::Equal you
> > always go left or right (depending on whether you want to get an unused
> > ID less or greater than a key value), i.e. you always search until you
> > get an Vacant entry. Why do you need store additional data for that?
> > Maybe I'm missing something here?
> 
> Let's say you're at the root node of an r/b tree, and you see that the
> root node has id 17, the left node has id 8, and the right node has id
> 25. Do you go left or right?
> 

I went to check what commit 15d9da3f818c actually did and I understand
what you mean now ;-) In your case, the rbtree cannot have nodes with
the same key. If Jann can provide the O(log n) search that could help in
this case, I'm happy to learn about it ;-)

Regards,
Boqun

> Alice
