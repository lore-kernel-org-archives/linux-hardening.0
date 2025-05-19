Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80A4317D;
	Mon, 19 May 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698987; cv=none; b=k2CkC6GpgpvT5shzanCGoJOdYlwgybLo3QpohGntbTVlBFauuofu+V3/gB7yz1F7Lkg3LMeco4jqfq3tT0hOZPX/siW83hulD/OXahvn2wBuIqb8fOXMPi5KlAWjZ//HDJV+/BiaWU+TREWeJz8eE9wlghot92+YqUrj43GD8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698987; c=relaxed/simple;
	bh=MRpEHT0Aj8NPgofmlBKIiaHmNmVlxyIY1DN5O55M6ow=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duiyd2h699zVlJ0EfQC2BA6FeGlb/pxfLHe/H9RDaYPFk7fWigkH9XvtJ6bso9gV8ydG1fA1BC7pxXwI9X+OELu4Dh//9T+5olbmWi2+OWRohcSFk++m6fRnFLeGVe6NS/rp+jhzsQlAupowVIDBDZLgkKsv3ItaK/1pGvJ/bKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF6vG/tR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF6vG/tR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476ab588f32so75437681cf.2;
        Mon, 19 May 2025 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747698985; x=1748303785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PH2VgzY/5BEaj0T/YAEp7MmgJEQhgRf5xUTgav8kQlY=;
        b=DF6vG/tRfppbas+wogbaBcsYBB29I9EzS58iaU+YSUBkoNUoLHpysLYYS9bP6O53Sq
         rs5XQzq1IRJjZh1v9GoNUTTUcXHjuSukdTY2ja3C5XsV12Yuev2rJvTc4At2QK3Vg+Pu
         ZhXkp1gEfQAQ4wqx+pNW36yy9kw7LW1/M2vA30kayFDg8y7dZSU2hxRohO2oylLn7jfP
         PUD2HPPSp9WCWE/v9V5732SXmA4JpU4q3fjUCF5Lcm2Xd3XZkZLDBA84WjlZQ838XdnE
         FbjbTKXvbEZlZ2eLKXlWpP/WEMIy/yvfvgjlimfsiy7CtKBhp+lngZJBuezugdfrl8qX
         24Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747698985; x=1748303785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PH2VgzY/5BEaj0T/YAEp7MmgJEQhgRf5xUTgav8kQlY=;
        b=GL5M6q5B0zWsX7nPPbEhvPVU5xph+DThZ3o3sSrZRMzaOK/bA5WDP5jLWGktMjFHOC
         alX9Hea5fc4B1iS4LhQgSkvFIEHOCLk40lknITGNvffwjh0Za312BBQe8QL3rjsb3zOb
         lKt/WEncfRdfARcFgVtxOxOeRdK5bDAcTuirUqNCEZwh3ymqctrVhZZYN17aUvi2p+DP
         PM4J9OAtgUmYcgCh/hTUvsopQtLacveK6dEzKtjU/hPBeWFb3L1nlQzB95ppov8frERY
         Jt8R2Ep22T5AA+aoASYp2b+LeynGoNmhJZ+2KnU2eE/5commdpyiOEcjVUkieuX1MPUU
         xLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQrkqSg/RXOYBFNYQ2KzapyE2HY+Or00EpNaZ639JJTS0ry2lJU5fL6fs+0htiSa9nca0w7DL7PrEVcYkyPTU=@vger.kernel.org, AJvYcCUoLgbhUeDWYED/1zAMdFtls8jspigFbhc8H/ATKTnOq/IGJQBV4Nq6GBKO3l5GCM2rK/BsjwX+cB4pc04K@vger.kernel.org, AJvYcCXeAoaIamWSq+2QLD5zlSWR/XKX7Bkidmx1LyaAwGYqHzDjVSfsV66Rs5z5CGs0Uiw4IdLQVVC5GQcCcWd5U64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUnWlmxRzxGw5xjJ6xaRxztOybCVX7ujoBJJ9TTQJWgSx9afU
	WAxljiUZhNszDJUHNzQg3/2uuVHEA5BF2AW+2mzVmV0xnuaYv65uXFNH
X-Gm-Gg: ASbGnct/zdg7nwywWdZfEZIAFUBNb1blxJnJYmmrUuLLsQxNtkPadhhUkki+Jo0dXKq
	fF+XpklKJriPJsjU+oGwdVxaAXVqTsud/Fx+Z792BleO7EE3YDBVc9jQHSTG1z//oWZcBZpjhbW
	B1GkL5G01Pjcmu98InpV5SOCI0hyAuvDvywb1pCo8tY5GqmPy8lHvO343CjkV+NIX7sEjgTEJi1
	qJk2tPc9AtvzETbDehwNrwE6rEMRlzzmozkfB+CZcROq5+RX9uo4OtbWewIUj6adtRCytR0RQv1
	jMQoxJJG0WXMMtOfNfk4Nwle5RJsxoAySqtUSV71LvlFleaMZcYuwhKraz32HteSABHbKmJjz5L
	YoTJeVYrgidpaMhoPyFreG4nzSqs4HDIbDwjPs/gdTQ==
X-Google-Smtp-Source: AGHT+IGGQ22Fxhiq41h2TGXux2TQUhBaRyuMzu3p1dr6JWQqE6tPFG6VPGwZdjYis6/v1x4kVy5raA==
X-Received: by 2002:a05:622a:5c96:b0:476:91f1:9e5 with SMTP id d75a77b69052e-494b096c63cmr301354431cf.50.1747698984812;
        Mon, 19 May 2025 16:56:24 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd7f0sm62122281cf.57.2025.05.19.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 16:56:24 -0700 (PDT)
Message-ID: <682bc528.c80a0220.13f632.9ec0@mx.google.com>
X-Google-Original-Message-ID: <aCvFJYt_Qg69nCVP@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id BC41B1200082;
	Mon, 19 May 2025 19:56:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 19 May 2025 19:56:23 -0400
X-ME-Sender: <xms:J8UraPEPv0ib_w1GxDKXaj91ipBMu9ByfOTZYsfT41KbZ0Vuv4CYvQ>
    <xme:J8UraMVrzpl9OfKUybaWWZxbi5KrbqsPIfITS95XXuK4xgU9kByOAMRri5vTlUd72
    niL6f_S8Uj81Xvsvg>
X-ME-Received: <xmr:J8UraBI5sxjEDnOQLg4F7J7c9p1XMAu_8U8pSFNH-6lGTc-O3-2WxbDrZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfedu
    teelgeejledvffetiefhleefhedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsqhgvsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    giesrhgrshhmuhhsvhhilhhlvghmohgvshdrughkpdhrtghpthhtohepvhhirhgvshhhrd
    hkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:J8UraNHkEAenxCFwvnJnQqws4ekhqQ7EluIO7AGKc3KmTdc3mSzfSA>
    <xmx:J8UraFX3tJp5ubAadnCutjYSd_PGTDPp3u33H4xi7R-HwgwB6kzH1A>
    <xmx:J8UraINJhq7B9FoEiqnAni5AtZO4EiJ_lWpKjOd7iiXrSoAipIZfCA>
    <xmx:J8UraE2QmsZtEIdU49t1NNrAosM98NM6--4pb6Lty945qMxNewz0bg>
    <xmx:J8UraKVrIUOVBHj0_3pRXEkXN4Dmg6c42M8-hKEgejR1OiS-Ic7mpik6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 19:56:23 -0400 (EDT)
Date: Mon, 19 May 2025 16:56:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>

On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > This is a port of the Binder data structure introduced in commit
> > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > Rust.
> 
> Stupid high-level side comment:
> 
> That commit looks like it changed a simple linear rbtree scan (which
> is O(n) with slow steps) into a bitmap thing. A more elegant option
> might have been to use an augmented rbtree, reducing the O(n) rbtree
> scan to an O(log n) rbtree lookup, just like how finding a free area

I think RBTree::cursor_lower_bound() [1] does exactly what you said

[1]: https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html#method.cursor_lower_bound

Regards,
Boqun

> used to work in MM code... That would let you drop that ID pool bitmap
> entirely. But I guess actually wiring up an augmented rbtree into Rust
> would be very annoying too.
