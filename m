Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D79461;
	Tue, 20 May 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745779; cv=none; b=aAs9t+uE06SJhnYbfz0z544EiTt8ym13MhjkU2J0eMRCMgzlEc0Ik+cGp+kH3LCo6cTQzFua0UfdZJct0aIgv6iWUeuDEZk3GWJjrheLBzPagTsNDTxj631JSjrFzJiABMemYG55fnVLRqvGbDtkme4f6Ww4b3M165pSp7XcuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745779; c=relaxed/simple;
	bh=4S8ZauXkXCneFSHnIt8yPad/b3zcMosS2XT+O7zzntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF2D/y5zX0xJoYP9BO4x/dMCsipskV7mEI9XrNDcPMWFplnpgGohnvDIFT6XXqk8J/tC+OqZz6KDwGZqoH0zueF6qIS/qHqnkDPcUmEBTt75t3h9mDHHzXFasRjE6mSNzdHICsPN9npnbBWDjjNj3uC/MMPjvJTWxN3I5F3A+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDppxmN0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDppxmN0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47698757053so73075611cf.0;
        Tue, 20 May 2025 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747745776; x=1748350576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FeiADSmz4HK3l7V7PhgpHIgI1M3PHWKk6zyjdcQyvN4=;
        b=IDppxmN0wyn+tUqnHZgjM3pKhVv2aIdF+T18DUerwO+DDjx/iZwQTmV271dzod0FSa
         WmR/2id9b6zFz6LGrJmTtI4oQCQ9gA0cVg4bp6jd0HiZfvPGldQ1fSgylK0OWRrpQKHL
         wG0P2+fvr/jxgceQfDRl6JyG/P8MkVg82FmbVOxEte9zSMZ05SLxRHAeUeUNikl8XCMM
         ZpSkpGpvA77UmTREq+X9TaexjxirZgoqYy52h820Sfolb4enM1yp/+IONmCeZyL0yGgh
         P63raMkUQ9kqVgZhabBKWn5h+1gAWJmibUvae1214W73lOF6R+b+mEPw4wuQdyrFChH4
         P/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747745776; x=1748350576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeiADSmz4HK3l7V7PhgpHIgI1M3PHWKk6zyjdcQyvN4=;
        b=n1NGknAOHHV+XJ5ROI7+d7IQhLzHn1KOlsagkU7vCIsDmbkU2BJ2It5sOZTsJmWjbV
         futasx9hLWRIIO4UEhFoVYxD6d5jFxIBAru3XBhk93pm54omouey2QbvtPCAEz8V4BaN
         y0TH3W/IHnbS44p1JKqRRFIWARF56BNwMif4ws6rq/dnShjb7X5ocDu9XaHF3cUkZ7Ky
         gMGVa0kQecdyIQTgivwxxdPuxWbq7UscY1dpnULSLb4U8OSBCcY2iKB1oGrUUkp6ubXJ
         zc3xaYaO7JOlReckp0yab3o3frXDrG6WYIH+NvcUkYyY9SY2EAPByHSH/Lr3vKz/oxCX
         wrXg==
X-Forwarded-Encrypted: i=1; AJvYcCUXgqUj/isCebbBnh2dBqrpNqiMN9k5QDm8r9AML2xTw0PSa4LVT6hNiMMfBXs4eBRwA9SjaR5aYj62dAgs@vger.kernel.org, AJvYcCWKvm0EGCp/A2z9KvUPyyiHh2NO+a/UtxtryMYV98s08+I/KW3Z+AvYZ9CwI7d3q4j2H+DqhT3LenoXv9a3Bw0=@vger.kernel.org, AJvYcCWzEWhe9LfhSZ893pQZuwwAzlvwuosaFIFZ2ZHVxnWwDMwQm4amHjZ9yyEgq9C/bRMOfQOoLIpNuROTnW5Tsgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqRTuJ31XfamRwKAnf/197ri5gC0tVCSsSnnJRWwqtVTnb70r
	Uyo1sumb256ulFw1XFPF+skI+i3TgKLq3cAS+XSNb3yQKL/f8RqqRp/j
X-Gm-Gg: ASbGncurHUUGo4+l1k8V9FY8tW/DZ3YZ2DOSRqylBTTraazC1Fp/zeG1GAWVScQPkxe
	H763NK/RzvzWUB9YmqTmdyLpTHPEl/D7QzxVsLseUy54Jvc9tb81pHxz6SzFh7xU9g4Du73QFYl
	pLvIRXw2zlIm+pqXF6mQXkif4Te+0cl4H/lVX/IXgrJjhauJiTAtKwQeT9UrGwNZl4Z/kAkpALP
	vZmsWfQTj6TSji/0a+10HZArZI/WW6LHLQuxYfA/YR8NM3eaFtRntRv4HS3P4MARFH3pXCntaQc
	hUntAOhxpx3WQy8mZ//ARb0Kv4N0jfj8TDcRduKZ/lVnZOtoKCcohsNuyYj6WA/6Hptp7Gbw8xe
	mFZIMhDZt/9vHMclJ34nFYCN4rpG4phtOW9pvSo5EbQ==
X-Google-Smtp-Source: AGHT+IEL3+h3BCUV6mXDOV6MS77SPTtdgt0hkDPfNmEKaPC4GDYuj04L6rKR/KRb8XZgyrIXCGEygQ==
X-Received: by 2002:a05:622a:2605:b0:494:9fc0:de3 with SMTP id d75a77b69052e-494ae4662cemr344326741cf.32.1747745776311;
        Tue, 20 May 2025 05:56:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae528f08sm69365631cf.72.2025.05.20.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:56:15 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41DA81200069;
	Tue, 20 May 2025 08:56:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 20 May 2025 08:56:15 -0400
X-ME-Sender: <xms:7nssaLWvxRXQBwUxDE5ZJ-nC1iUCfTTgcxPfb-gaChQanIUN74BxLg>
    <xme:7nssaDmK2hkj2Q8bfWiUx7yT8CdBWeoPdaURNeQBp6zHsA1vTMLH05Bg6FEeqAeVA
    maE5hYquVyG3bravw>
X-ME-Received: <xmr:7nssaHZoKCwh0Op4dZk2QLElTksO0Yd6CCIKFjDHfkv-qmDouo_BoZHd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddviecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:73ssaGXquQALZ7jhoyENrGBsa9cE9sle6x67j2_XC5_tAlTIEf2l3w>
    <xmx:73ssaFlPHz-5oAT9ramwuYajOZkAA6Nr9j5iOLXfyFJ0A14GIH8ldw>
    <xmx:73ssaDdbkdYntKtpIx8s9_NfENXtPxnhHI84sATjvIMiiLjadwOyXQ>
    <xmx:73ssaPHRKC_SI5tVToofsZId8IL5rY4VpyHsyq2CRBhWs_8egavUPA>
    <xmx:73ssaHm23FG2_I0MNE9FRwj_QR1njJLBZQS8kGtioyD99AMbeiCjnxcw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 08:56:14 -0400 (EDT)
Date: Tue, 20 May 2025 05:56:13 -0700
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
Message-ID: <aCx77cCum_b-IR4H@Mac.home>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home>
 <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>

On Tue, May 20, 2025 at 05:42:51AM -0700, Alice Ryhl wrote:
> On Mon, May 19, 2025 at 10:21 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > > On Mon, May 19, 2025 at 4:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > > On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > > > > > This is a port of the Binder data structure introduced in commit
> > > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > > > > Rust.
> > > > >
> > > > > Stupid high-level side comment:
> > > > >
> > > > > That commit looks like it changed a simple linear rbtree scan (which
> > > > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > > > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > > > > scan to an O(log n) rbtree lookup, just like how finding a free area
> > > >
> > > > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> > >
> > > We need the smallest ID without a value, not the smallest ID in use.
> > >
> >
> > Ok, but it shouldn't be hard to write a Rust function that search that,
> > right? My point was mostly the Rust rbtree binding can do O(log n)
> > search. I have no idea about "even so, should we try something like Jann
> > suggested". And I think your other reply basically says no.
> 
> We would need to store additional data in the r/b tree to know whether
> to go left or right, so it would be somewhat tricky. We don't have an

Hmm... I'm confused, I thought you can implement a search like that by
doing what RBTree::raw_entry() does except that when Ordering::Equal you
always go left or right (depending on whether you want to get an unused
ID less or greater than a key value), i.e. you always search until you
get an Vacant entry. Why do you need store additional data for that?
Maybe I'm missing something here?

Regards,
Boqun

> implementation of that in Rust.
> 
> Alice
