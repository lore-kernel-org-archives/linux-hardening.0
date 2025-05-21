Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45357081C
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799884; cv=none; b=em7XBuMsK6I98mlSFJ2Bu9XvmRTqJaUpZhvw8QI4t1LKAIskUD3tfVZTaFeam0So8CmL68iLTfEFiYgVUS96g/oFs1nEfMEP5vCsvMaaiCO6OQRgyIsIq9wpV/7I6Sq4decgYeqw2oAhPwkr1ZUME0+TyT6g1/TtNf6tnzEpEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799884; c=relaxed/simple;
	bh=wlsjQW0Yibuw5qncy8R7Cr0VHmy7PGLOqqCXs10/zxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAgstDnmw/6xrK50WFkAPLAGFFTqZ9UwJK16TBt4rzjGJaGcEidHeME88v1BhnDBcz84g0HnNR+drVFeZkglMQf9QkwoVWKhfszp5y3bUdHFbPwc6xkQEb36/ilTyN31XUP+jyMvGdinjXb5BzdLz4B3n9uwqOic4njgA7pfkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9RjlIqh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9RjlIqh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231f61dc510so932465ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 May 2025 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747799882; x=1748404682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wx3hoPbcWp9uiaTRbvdc0caMEO1HJqfQgmTjdqGLG4=;
        b=J9RjlIqhzg7D73WJIPD4oKMWJmMdqZW7laCBqyfzWAD/1qObsc8Rf+mP0cI6/laBS4
         7/w+LtT5qG9RzrPcA8A1AYJm9hASl45remVFSS8IX7sWcBquSc1gYKMuZrE0y1OubZ3s
         jAigBpyxkNmSd4O4OiJdN1MyliGv/OcDlyAm8YtUMMQ/4ipqbLBCgPw47F6vEbz0ZQ9v
         gNCHnro0NnYl42bx6GSAW+n8dog1TAd+zX5fxvi2M4hgBsX8GK5LasoTK7XdFl2OSkwe
         MrIY/I97bSeTW7PpIkqf3UzuesyerEoRNubd/cuNrMJq9b2D6Q5oyfAOxAPZACHiBk6X
         hVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747799882; x=1748404682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wx3hoPbcWp9uiaTRbvdc0caMEO1HJqfQgmTjdqGLG4=;
        b=W55z6j2vY1oIVmR1qMfFRrlzkFAamvNkafHeHP4hVPkkRvJhKjwZ9gVZmO38snWMDT
         XeMxuwIplk9VTJcMVpI96+LxfYdH4YB6YcYRThW2c+csm2RI/sLEmXgN1Z4Xv7x91F78
         oIBTiods+M4Iz0a9x7XaQn5xmKs/HvWqgUS2NLhPh98b+LltdRCVtiXJ6eAbavw5lN2b
         wjX5W2+Si1XiO4ibD+SC3qEFhH6vN2aPTwYGvuMi68WmMdWYK+QeiEAGc9aJJZk+rDw0
         ubvQW1WPjTx5HMRgglk22RTrtSh7Hc/HYqGtZ0wpa+Q9qhi2Xs36Lc5KMIz2ECPNqulJ
         0PnA==
X-Forwarded-Encrypted: i=1; AJvYcCX2fFS7QNKYZFrRJnLGDd7/je4zlT0nKrMjyJjV+jOTzko0uodqhjRIhfPPyDtqY275Yyif19EusYGpo5jBWK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDU7GghEetlnHF0/dnZt1sFKF7vCuciQ2usAmM2SBecJeLAnPf
	/iaRgoC16SF+zKySuKaYTDhhBCIDq86p5cWtyzyfCf1I7RV+qJPjbkFKrThLOgW8kA==
X-Gm-Gg: ASbGnct2Ly0BU+fi3AArofFpq7aTSAi7vRP17kw69KM1aanaAXW0bUQV2yxKeMbhzFD
	UcFJBaERssLSDyzO/+GcgSjA1/fEFpm2aerRn2M6+h2MAur0ui6f0HYsSoODOhO9LKKcdPX1Wde
	H9dlUspf6U0kq0aVRMOANlp1txcxdPV65wvWphHmFrAsVwTatUks8bF0oXIpQ4iti+YHBOcoDCl
	u0nn4+Rgkyhj5rhHyrU5kY1gDk2J6otNrX6wCk1v75jkugfHlS4czyOMAOtItkRg2ZkXAuQPV2i
	gcU6yYQpXCPfhFfsTPBWCipukgdn9+/Gu6zJM59TU0WGUhGyH5PKECIb/ja9K0VDW9Huv3N7ZMi
	3h5rGrn2w/8Z7GNMj19Y=
X-Google-Smtp-Source: AGHT+IFCRZkwpnReRQWrGPg1IKtuRs98lKF9l3e5qmq9BPLVfG4ZV5CokuhsO8rtpUNOuqhM4g0RUQ==
X-Received: by 2002:a17:903:228c:b0:224:6c8:8d84 with SMTP id d9443c01a7336-231ffd0ec4amr10032895ad.4.1747799881655;
        Tue, 20 May 2025 20:58:01 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b9basm8660405b3a.49.2025.05.20.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:58:01 -0700 (PDT)
Date: Wed, 21 May 2025 03:57:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jann Horn <jannh@google.com>,
	Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
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
Message-ID: <aC1PQ7tmcqMSmbHc@google.com>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <aCvTYHMtuWZZizn9@yury>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCvTYHMtuWZZizn9@yury>

On Mon, May 19, 2025 at 08:57:04PM -0400, Yury Norov wrote:
> + Carlos Llamas
> 
> On Mon, May 19, 2025 at 04:56:21PM -0700, Boqun Feng wrote:
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
> > 
> > [1]: https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html#method.cursor_lower_bound
> 
> Alice mentioned before that in many cases the whole pool of IDs will
> fit into a single machine word if represented as bitmap. If that holds,
> bitmaps will win over any other data structure that I can imagine. 
> 
> For very large ID pools, the algorithmic complexity will take over,
> for sure. On the other hand, the 15d9da3f818ca explicitly mentions
> that it switches implementation to bitmaps for performance reasons. 
> 
> Anyways, Burak and Alice, before we move forward, can you tell if you
> ran any experiments with data structures allowing logarithmic lookup,
> like rb-tree? Can you maybe measure at which point rb-tree lookup will
> win over find_bit as the size of pool growth?
> 
> Can you describe how the existing dbitmap is used now? What is the
> typical size of ID pools? Which operation is the bottleneck? Looking
> forward, are there any expectations about ID pools size in future?
> 
> Carlos, can you please elaborate your motivation to switch to bitmaps?
> Have you considered rb-trees with O(logn) lookup?

Yeah, we tried rb-trees. There was even a patch that implemented the
augmented logic. See this:
https://lore.kernel.org/all/20240917030203.286-1-ebpqwerty472123@gmail.com/
IIRC, it just didn't make sense for our use case because of the extra
memory bytes required for this solution. The performance ended up being
the same (from my local testing).

I'm not certain of this but one potential factor is that the rb nodes
are in-strucutre members allocated separately. This can lead to more
cache misses when traversing them. I don't know how applicable this
would be for the Rust implementation though. Take that with a grain of
salt as I didn't actually look super close while running the tests.

I would also note, this whole logic wouldn't be required if userspace
wasn't using these descriptor IDs as vector indexes. At some point this
practice will be fixed and we can remove the "dbitmap" implementation.

Cheers,
--
Carlos Llamas
