Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CED26F467;
	Tue, 20 May 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760080; cv=none; b=VXv+HDyZrs+Aig/ganuJU9wTGdAdDiHGhZz3V4wWczdc7dAFJSZQm1SqhggV5JFIYFVNc5W3V08mJ9VCg6cnI8AGQiWKp6I1mWaAsJTR0EMFjCCr6WjYvt2L/LSE7MoCnrmbpqwXnpsar7zg8hklyhPtZg+wgU4i2/iuwSEHvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760080; c=relaxed/simple;
	bh=M3HY+zNWDynah4tI2QSkRa1Jooa51OHDyTdwzMLHbEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsdhPlHGUzLIHGpfqqdSzooWPpibHLfbmeVmzekk6vfEF8AEn2j0hoTSIa7Qdfs0CspmMCNGVjC9IQIqmNWvgIKGEu1LzWS2pNHl46Jza5BzLLnNKtdjjGaWm72hLjW/1HUAD4RGVUX/HcoJNk9gbg/rHaxOMbbjYKWSslH7J7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUZbZK5g; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUZbZK5g"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4769b16d4fbso33035181cf.2;
        Tue, 20 May 2025 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747760078; x=1748364878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B+0IFrW2TaHLKfnUj0NSz4bCh09+7jR+H80Edcxixow=;
        b=EUZbZK5gjZL5UR59rlGm52JBQQrqhrQhMt36VLW2NJ1gOjsYaZSmEtYvO/WkN1gh/B
         Ay6MrdHab0IzmMu7/IFdJzY9jLx05LdDgtMqs5Jvddtclblq0Zf6QYL8jx2Gu4P65+iv
         cDbUw16CUYCC/VKVubfYcS5Y5JFWPKoybHUTdiYhltAxVgDVIJP+5Zz8gVTYvdrZX+Y+
         CSuuXVGtJdfeUnXZn1jTJEYQFxD5tdDXjW3JFWLdK3eor7FgYgH3sMS7ILnrBPr9cFHQ
         dsVT5+enAMgNMWoWJ+zHBLGHB26+3S3rYvlNAVvajfwFe3tL7sV1x72cgcxdCrjmKBj7
         v/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760078; x=1748364878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+0IFrW2TaHLKfnUj0NSz4bCh09+7jR+H80Edcxixow=;
        b=Wt6KviVVBfu1qeKcqlHPi5WbKjLx3uKseowlh4THiyjJA6jUX+43KhzhJBXp/PUyaK
         RE0ydaAlry+e3T02fBPGle8bqIiflRpg2iEthyoB2Uu6ZUeC7thngTHuEY/07cZTl4ZC
         G0PXAqgFj90WZyWDVGz6RPQX3Qn/Wt0+tQHLZOybQ00lGBFPbxFYEXL4dbz3s58fCuZh
         B84dMsGl5gYfkUxvOk0rqMzHOX9DZOeM7t9JWqBS9HyjV0tJ/tJEDXJv9nTS1BXzk4zt
         H4DQqMs3+3DwHs1/zwbXb3JazCQr3+pve6/ep9oazL3VfOh147l5+/pd6eeaToj9QGcl
         SZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwLmf4Ouvo4jWw4sAGcW3Qes4+qH9OCA8gUJi8/Z/rgxYHlCMWi4p1l1L01qJb52RmAyyIKtpVPmA0nKyS2U=@vger.kernel.org, AJvYcCWBSjCHW1kAHAM4ht3tg4YQK9FVEgMj4OPe1Rh3B5gOUP2eIfrtKwaDMqZi78wGgY/rex5Z+L4oEi3D98NkmE8=@vger.kernel.org, AJvYcCXd0yVV6PZWj2C48oi+LSXhWxMU6yjtQqZqnV0hJibsSn56LIBdE98OLPRPZIYzg3/m3hZFeyy9tczmFBG5@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkFWtpo1/tojRzWdgmlItGyKbSHM6NSQm0bdVzVXZaQagcciJ
	aX0gJTUMQ5sQjGNWFTzxce1P4UdlgVjQIKS0TlJuOKJJcnfcDEJ6GP4M
X-Gm-Gg: ASbGnctNdLW1grlRyndxxEicakdXn5V7XNI78R1IIoI+e/7mnreBmPFEPKusNexcEEJ
	rKxTy1KzaIXJ3mL4iud9flRvjlkdNPe2wYvdjXGh/+c85tZih9Nbap7X4HadktU3tRVVmnlX87l
	2IX/KnHVZc36knzJyCkwuwN3LP6TgQeUQ85nVyO0BEwKeWGYqux6uaksS8NpAFFnn9X1HhhoG8e
	QMykI96Qicc4DJ7oEka+GR/YjhGGfDkb68yOXZ5Dr+0fIlKPF3ocWGcx+dhZcb9IS7SYEv9WOw9
	VY4DAdr99IwJN4Fu7V25wjwykfSNZKxDbpfA3FR6c0cedJwPne+H6T6P1EGw/ERQfLryjJopKPC
	cE+hVg9L9QepisJMa0oUgD3vzduKVKtUHlqRVi1Os7Q==
X-Google-Smtp-Source: AGHT+IE3/R7uBhgGgs72BU0Nb0I6mQ1Pqz+HJQVtJWBnKoXI4/6Lk7IwQRlB39FmuJjIJ7cxcTOOig==
X-Received: by 2002:a05:622a:4105:b0:494:a4c2:57fd with SMTP id d75a77b69052e-494ae34b716mr271435681cf.9.1747760077698;
        Tue, 20 May 2025 09:54:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0988e08sm73788126d6.125.2025.05.20.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:54:37 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id B1FCE1200068;
	Tue, 20 May 2025 12:54:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 20 May 2025 12:54:36 -0400
X-ME-Sender: <xms:zLMsaCDDP1sjagN7Bv2LsfplGoy175g2u7ACYNNM54x92LIP31Qu1Q>
    <xme:zLMsaMjw6gwA6gtiILRWojJv76bBYLZQBDSmHjbgeMYFyYorBKYAmnEhvm2THbCb9
    d07zOSExjOJzts-nQ>
X-ME-Received: <xmr:zLMsaFmNHPS4rIh7aLpiVoo1JuR5kGImDStbJXzdXjA6L7Yt4eItR3c5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejheculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggt
    ugfgjgesthekrodttddtjeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeekiedujeefvddu
    veekteevudffgfeuueellefgjeeuvdetteekvdegleegteetfeenucffohhmrghinhepsg
    hoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsqhgvse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesrhgrshhmuhhsvhhilhhlvghmohgvshdrughkpdhrtghpthhtohepvhhirhgv
    shhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:zLMsaAyRFVikYgt91fCMFih8TJ6lG6V-uL3MyaPQ4_I5ySCBFsJIzA>
    <xmx:zLMsaHRO0zyfF17cAwq3mXqrXOpeYjiF4nxgYEKSc0jMRfOwh9aJRg>
    <xmx:zLMsaLY7Syqq7XnV5aRe_ANjG1YG_xG3DeY4r7Ey7977DJLiMIsgJw>
    <xmx:zLMsaASCE-zyDX80lWsSooVJ7IMyu0l5sRyPhJQyB0cRG8WICuf8yw>
    <xmx:zLMsaJDAfmfoc161jmtnvQQAVcwEXVVKF6bET2NMGwhWj276Jnwy5fz2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 12:54:35 -0400 (EDT)
Date: Tue, 20 May 2025 09:54:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
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
Message-ID: <aCyzySveBPZCnpZI@Mac.home>
References: <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home>
 <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
 <aCx77cCum_b-IR4H@Mac.home>
 <CAH5fLgjqj7binVaLDh7Pc7SVKDM-XrYDEDj7GYBX_MnjHgufFg@mail.gmail.com>
 <aCyB4z23VP-3Hmor@Mac.home>
 <CAG48ez32gxwdmQ63XWB8Dz4b5seH7tOhY0yREC=34ubTHZ5VOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez32gxwdmQ63XWB8Dz4b5seH7tOhY0yREC=34ubTHZ5VOg@mail.gmail.com>

On Tue, May 20, 2025 at 05:55:47PM +0200, Jann Horn wrote:
> On Tue, May 20, 2025 at 3:21 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > On Tue, May 20, 2025 at 06:05:52AM -0700, Alice Ryhl wrote:
> > > On Tue, May 20, 2025 at 5:56 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Tue, May 20, 2025 at 05:42:51AM -0700, Alice Ryhl wrote:
> > > > > On Mon, May 19, 2025 at 10:21 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > > > > > > On Mon, May 19, 2025 at 4:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > > > > > > On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > > > > > > > > > This is a port of the Binder data structure introduced in commit
> > > > > > > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > > > > > > > > Rust.
> > > > > > > > >
> > > > > > > > > Stupid high-level side comment:
> > > > > > > > >
> > > > > > > > > That commit looks like it changed a simple linear rbtree scan (which
> > > > > > > > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > > > > > > > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > > > > > > > > scan to an O(log n) rbtree lookup, just like how finding a free area
> > > > > > > >
> > > > > > > > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> > > > > > >
> > > > > > > We need the smallest ID without a value, not the smallest ID in use.
> > > > > > >
> > > > > >
> > > > > > Ok, but it shouldn't be hard to write a Rust function that search that,
> > > > > > right? My point was mostly the Rust rbtree binding can do O(log n)
> > > > > > search. I have no idea about "even so, should we try something like Jann
> > > > > > suggested". And I think your other reply basically says no.
> > > > >
> > > > > We would need to store additional data in the r/b tree to know whether
> > > > > to go left or right, so it would be somewhat tricky. We don't have an
> > > >
> > > > Hmm... I'm confused, I thought you can implement a search like that by
> > > > doing what RBTree::raw_entry() does except that when Ordering::Equal you
> > > > always go left or right (depending on whether you want to get an unused
> > > > ID less or greater than a key value), i.e. you always search until you
> > > > get an Vacant entry. Why do you need store additional data for that?
> > > > Maybe I'm missing something here?
> > >
> > > Let's say you're at the root node of an r/b tree, and you see that the
> > > root node has id 17, the left node has id 8, and the right node has id
> > > 25. Do you go left or right?
> > >
> >
> > I went to check what commit 15d9da3f818c actually did and I understand
> > what you mean now ;-) In your case, the rbtree cannot have nodes with
> > the same key. If Jann can provide the O(log n) search that could help in
> > this case, I'm happy to learn about it ;-)
> 
> Linux has the concept of an "augmented rbtree", where you can stuff
> extra information into the rbtree to keep track of things like "how
> big is the biggest gap between objects in this subtree". This is how
> the MM subsystem used to find free space in the virtual address space
> before the maple tree refactor, a complicated example is here:
> 
> finding a free region (by looking at vm_area_struct::rb_subtree_gap to
> decide whether to go left or right; this is made complicated here
> because they have more search constraints):
> https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L1841
> 
> But that requires an "augmented rbtree" where the rbtree code calls
> back into callbacks for updating the subtree gap; the MM code has its
> gap update here:
> https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L261
> 

I see. I was missing this part.

> And associates that with VMA trees through this macro magic that would
> probably be a terrible fit for Rust code:
> https://elixir.bootlin.com/linux/v4.19.325/source/mm/mmap.c#L400
> 

Well, not sure that's true implementation-wise, I mean it's just
function callbacks while you insert or erase nodes from rbtree, which
could probably be described by a trait like:

    pub trait RBTreeAugmented<K, V> {
        fn compute(node: &Node<K, V, Self>) -> Self;
    }

    impl<K, V> RBTreeAugmented<K, V> for () {
        fn compute(_node: &Node<K, V, Self>) -> Self {
	    ()
	}
    }
and we change the Node type into:

    pub struct Node<K, V, A: RBTreeAugmented<K, V> = ()> 
    {
        links: bindings::rb_node,
        key: K,
        value: V,
	augmented: A
    }

and _propagate() can be something like:

   unsafe fn augmented_propagate<K, V, A: RBTreeAugmented<K, V>>(
       mut node: *mut rb_node, stop: *mut rb_node
   ) {
       	while !ptr::eq(node, stop) {
            let rbnode = unsafe { container_of!(node, Node<K, V, A>, links) }.cast_mut();
	    let rbnode: &mut Node<K,V,A> = unsafe { &mut *rbnode };

	    let new_augmented = A::compute(rbnode);

	    if rbnode.aurmented == new_augmented {
	        break;
	    }
		if (node->rbaugmented == augmented)			\
			break;						\
	    rbnode.augmented = augmented;				\

	    node = rb_parent(node);
	}
   }

probably works? However I guess we don't need to do that right now given
Alice's point on xarray or maple tree.

Regards,
Boqun

> As Alice said, this is probably not a great fit for Rust code. As she
> said, an xarray or maple tree would have this kind of gap search
> built-in, which would be nicer here. But if you're trying to do
> insertions while holding your own outer spinlocks, I think they would
> be hard (or impossible?) to use.
> 
> If you managed to avoid broad use of spinlocks, that might make it
> much easier to use xarrays or maple trees (and that would also allow
> you to make the bitmap API much simpler).
