Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE78EEC8;
	Tue, 20 May 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718508; cv=none; b=ZXzb78WV4XBTCpRE4yyjW0lx2hWvyE/ZVySWqOSWSzzoSQzA/KeipxBzd0vBO5xbyNuXxaMBb4btud2dH030fQv8idjUvE6QE33CkM6TUqrgx6jtaU5in9OKBX1TLxM0zAzGcNOhyVaDvq/3N7/dsFxay0qKTmBUOjsd7tVUxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718508; c=relaxed/simple;
	bh=eMt3R1ymDEphmp1/MbbU6HGsAiI3N5XIYd5VgPLk8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRntLCLhryuQAqjHmwWqQ9HrJMgAIRYzaZrk02ZPkGhrnFZiUMkCKPBYoyOqa4ge2Q7Q3lsuNdvRwtpJ2EeTqZeg6cScAyZwVPooLe2bykcan9v09JZHm8MLBP90P6MKH8jv+pv4cR7mZFBG31neM9o0hiB7ahaILIpLygFJ4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGp2JMhA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGp2JMhA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769f3e19a9so35619771cf.0;
        Mon, 19 May 2025 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747718505; x=1748323305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5DazShLOET04NjbcBbV/+7zX6OeCHdiDpgI5bLFBJC4=;
        b=BGp2JMhAfGCuaQvSrsuANPqGpI49IJQIwRChoidZd/m20YrDfWFnQU9ogfh4YuYmbi
         2P4qgV+0TvT1D7Sq2aVfCs9c0bpxc1Rq7SvuQnx/ZXYDWgt9U+ATqaaaeA0XPv+RmDyb
         C1u7yXzdw0/ktjKaMpfXfQ+HCEeSkrOoKGFqIAPSDgU911Raf1WakHV/I5KdffS6beKV
         E70QqqN+SSUftSnnpRWYh1DLsOaTI9A5reFDKoPY4/NZ15Y3osQwFCWiG/YDAgMdf38C
         b5Ouxi9h/UQ7bwwztKlF+JnZNIHHJw9URQg7zm1LOGkXGco9o5EHpFHDTo22K+J8lxg8
         iDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747718505; x=1748323305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DazShLOET04NjbcBbV/+7zX6OeCHdiDpgI5bLFBJC4=;
        b=M1QLnM+rpZmkJQNOO2nwn+k+QTDiRX3qZKocon49nn+XgPylnSf9niUv+kZ3OlBawA
         2ae3/M9ROZM1UqSaigSYo5+2hN6FL/0wPkQM1RUmAk/01cbVP/FJjz/g2Og/qFdAOo3Z
         hSbFf+PKa5r+VgO/QnKTs67V3YyToAOphE1CugZQ8aXVij2sMQF1FJm3aAEjdN0Gco4S
         Cjpg5sDluy4O4iEiCzIwmgyucNJa6rqTIg+RtXLIsQXCzodX5bYwGhakg4z/Q//tDXDW
         vdmwDDygzKSIZOwY/2sKCcBuKcvV/neWKVRRYizHFuTJMEs45LleUyYr25tv59JL2R53
         Nfog==
X-Forwarded-Encrypted: i=1; AJvYcCV4QAC4swjpfTBRmxAnjmt7Kotv/1ueJgfhAnHew3H5L+h5T1i5kT02d2iXt8k0OQFochSOWgeglZy24Mxq@vger.kernel.org, AJvYcCVDBU3HRkhZhxo04X/EpfNBmColfqIk3Xz6tVjFAk9btj96sCVdH7hdLxAtor+dFSTjJZ07N6s0udLB8bkr/u4=@vger.kernel.org, AJvYcCVu8GEjfZl8CQ4H91txFD0XY3Jj0kGarFdRxOk/3I4hVU+M4M/AX8zE271Iz2LsYBdUXy8kBgIB8jTL9f5ucEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNrN9kDiGG1UvLwMtrZoQRJotLpgfoGGHe6rdGowP28IqtzOw
	fWpIsS1tcbnN5mM6GwOLmKGmgVOLmn1GmbrhxNcF2MtxpR73SMcHWT0h
X-Gm-Gg: ASbGncvmMDUGrQ9JQYl97VX2vdKCHKNhdExQwiWlnr5XGjx2eT5f+vHlzy9pKXCtaRo
	kLmImC+hJHhGlZcJoifim/s0g4i3hxC+sP0iiwtEVMz672Xk0VQn6xefSmeAWK+eX0N1QPOK0yj
	sDscs4K230OkYL2ixVuw4GwufGdZaaKzKfxREgDvkyVZefajdGMnNA1zbbVVGSsikQGiNOlpbTX
	fQXpKjAxSl+JmPBII+D3OCKW9B74EbmbtgodiGB4RXxq1aL7PvOwDPz1GwAuyt4UNixeIgUFy2a
	AT03KxqFwE5wdXENrmuqMQkBnsfgXk1BD9mKG5B8NWCTjZZR62HfDwSQu78e+qrThF1pa+mw1/L
	4rDLR3QkwmdRO1AC73ZoSbYgE405jxdgupQZiwgcDsw==
X-Google-Smtp-Source: AGHT+IHuvScXl/XtbQcvu5t+umcjUvECwlv7yyBXTCTW1QOH5ko+4BAvMBX/n4Kqn3YgRXTt7fZ+cQ==
X-Received: by 2002:a05:622a:4c8a:b0:489:7daf:c237 with SMTP id d75a77b69052e-494ae494085mr278788711cf.45.1747718505279;
        Mon, 19 May 2025 22:21:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm67958821cf.48.2025.05.19.22.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 22:21:44 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 317C41200068;
	Tue, 20 May 2025 01:21:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 May 2025 01:21:44 -0400
X-ME-Sender: <xms:aBEsaLIy616ouUPY9idg1FDDA9Ae4Pd3vXTv0XH49Xt8j7EJ9jJggQ>
    <xme:aBEsaPKdvhmto9bTgr5EAcEMvA4GJcO-iWH9oaX0OKYPIPV2Mbg2O5QtYVU3ExVtt
    U0oWgkefUl0_kIpkw>
X-ME-Received: <xmr:aBEsaDsEiaaQVwzMMx1BiQ2qlhNXCMO9GokpN4FqFqeqjcnQv3gAI-ZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepsghqvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtth
    hopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:aBEsaEY7a1fWMlI2-49VS2Az0O2_fQPYw1rNQFkFd9xn34OX6t_c3Q>
    <xmx:aBEsaCbltCQDGqToOXn1q25o8CSVQiRux-JPFx11AaK-q537T246qw>
    <xmx:aBEsaIBR1NqU50qE-O0j0xUeBKGx5vQCUym9At6cgIH8e2KQqTSeIQ>
    <xmx:aBEsaAZFPYLp2ES064XUniOuZGvdw7hdiDruVrkGot387Hem8fZReg>
    <xmx:aBEsaGqUUl4fKBzgGdgWPYEtxPw4BaCFour8zByh2bSf3u4gV0ydL4Vy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 01:21:43 -0400 (EDT)
Date: Mon, 19 May 2025 22:21:42 -0700
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
Message-ID: <aCwRZlkBWekRmDg7@Mac.home>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>

On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> On Mon, May 19, 2025 at 4:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > > > This is a port of the Binder data structure introduced in commit
> > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > > Rust.
> > >
> > > Stupid high-level side comment:
> > >
> > > That commit looks like it changed a simple linear rbtree scan (which
> > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > > scan to an O(log n) rbtree lookup, just like how finding a free area
> >
> > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> 
> We need the smallest ID without a value, not the smallest ID in use.
> 

Ok, but it shouldn't be hard to write a Rust function that search that,
right? My point was mostly the Rust rbtree binding can do O(log n)
search. I have no idea about "even so, should we try something like Jann
suggested". And I think your other reply basically says no.

Regards,
Boqun

> Alice
