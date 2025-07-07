Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F713597A
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921191; cv=none; b=ss0dzXJHS8vhlgzNk1GJcL84AFQxzqnO3wQ4wf0fG4obKT8EsgefREwppggUoP/Fisdy/TkEPnNOeVD26/9aPL7jt53f1/APiDii8VyV8IB69S3fPrE46Tq3hZbx69C8eTwEgiluOVAp9wcSEa5FuXvEu3Yi9lXRALb0hDv3C3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921191; c=relaxed/simple;
	bh=xq5+8q6Hq3wyNqK6vOVdbDr6xhABcrkJYe13gKuBWi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7c8X5KaeAoTHGKKpIIliNEiJuayQDkCED51CqM72tmn6CKS1tp0wrSA99YAUv9X/H/oQ49VQbt0EhF6Ms36vVVqHkBaqEwsqZG0Jlzw7tGh+Ds3ms9IMNFwf7e2OjvQ+RZWIATBiS4LQpAs8nwU0l3B8Z4pPuF4wnLkbaQqOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WknI/HBo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WknI/HBo"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso720782266b.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751921187; x=1752525987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEDgBaUeWk+QDb/AaNEeMgvkFy6FrKw47awCwo707GE=;
        b=WknI/HBo21Y6/JsxTaKnVm3H4pp6lloXYvh2Iymbx8lCE2+3EBpQrQ8wr3b2IFg6UC
         PH2SlN6eY13U3VdsCjmnLeijIMNWFRa2t2hNJb39dJ2xAA1t50+XLvM0FTd+gMsDh0GO
         fmPrc83BfOb4VPNAEC5ck367J1H3f86n1iWB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921187; x=1752525987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEDgBaUeWk+QDb/AaNEeMgvkFy6FrKw47awCwo707GE=;
        b=aflDhos6y4xTSh+XWJ486zZk+xATwaiyDeO6yJF7uDaHrdMz0AQXyX8/sXbv90gqxP
         XYL+hpPWLfK0n/E4FvEV4CuYRiKmkDHb2AHxWuXVflolN4OGVdmobXNRbGqMWUf8hJR5
         Pbf7vEdjTQwCLEVgUNuFsqCZBg7VuV6TyqXE6Ydcvst67cVe2aMN6+u9Op74W3+HlWLk
         XdO+NjidysmtMuXkmzo9ycXveC7ORNuRRym6JQnsRo+Isk6Kb7K+UE6JRixFS08IvC6f
         nzlOESfD8bWKiiv63fOYX03fbBdJU/GF6jS06ZLtfsgpDXBSdd7OqBm52KqLp3F17zOj
         g6fw==
X-Forwarded-Encrypted: i=1; AJvYcCV6GbNwu0537wOFGyP30/pSFLXSe8mz5ugmODxOKGyTuvifMV8HpP4xDmE55TZFcxh5cGzhRgsPB7Qvw2Jn5Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvUYcGlyZwpeoeilRvOewK7VLDU0JhYs9pzWWEPYum13Z00Oh
	zBI8EeuWzQ7Sm5YsTEC284fnlFo7sAtBhduhleC6uFcQ0+NyzfDGNjiFGB2QUjZ9QIOsCLtRDfW
	V0szvgd8=
X-Gm-Gg: ASbGncvnHO9t7IGHT8swA4S6gPn+rt9EZMorUw3dij/CAn344ZE7ihhiw3b2cy3y7gv
	2sdgi2tEkETh7xYI58WY86bPMZU16WePr0MPusoKg+YGi6gO9I6nVnNplJjHJnyjx3vYQiUxyY2
	+l+o9z6nTtjfofBR7P2pUselWku/H68bkxgA1xtC1VFNziB6QASa8ujum+9vUxJJ377lOVZf0DJ
	0r5XVzPFMEt6mVbc7mTcPrXjGsSAZNJ+g7OGqP9P/aQYX8ZittxGOKkjwZSmJZQxXnIouzoLJDr
	fgwNLNhzNUn/w2v9EjrbldHvVyDz7NyU5T2ui4UV9LP47WAtVK27bOh/4p1uT6QnJpZRPEayd2r
	sAF0dj+SMD/1r/vj2BEEYYj1uTw1jo546oVTgB8l/ublLT2E=
X-Google-Smtp-Source: AGHT+IGNok6pMg72mERzwmEMMd0IS9onvPVbCbXXKXHZdhXD6fGxj4gbFkuXf+YvT24tVbdKmepaMw==
X-Received: by 2002:a17:906:ca82:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-ae6b021b96emr45244266b.44.1751921187304;
        Mon, 07 Jul 2025 13:46:27 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac54b6sm757730166b.82.2025.07.07.13.46.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:46:26 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so7537252a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 13:46:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQxUaEHYjBbm2mzhkEelk50CDdEKqade/uHFMtjlksg6rCW6T7zTJZjbxBbH0n5BUQr6odF9n8E+FHxLJTIi4=@vger.kernel.org
X-Received: by 2002:a05:6402:3902:b0:60c:3f77:3f4e with SMTP id
 4fb4d7f45d1cf-6104680323cmr886164a12.22.1751921185468; Mon, 07 Jul 2025
 13:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com> <20250707193521.GI1880847@ZenIV>
In-Reply-To: <20250707193521.GI1880847@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 13:46:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcyA9kdWUc7HL39AhBoGzP90ntOzbBYpp=Z9M29bMPoA@mail.gmail.com>
X-Gm-Features: Ac12FXyTJdvBtSzuEgvvQf3FBl3I6foxcrWvzU70QsGHoB59-IiGkLMHShqelF0
Message-ID: <CAHk-=whcyA9kdWUc7HL39AhBoGzP90ntOzbBYpp=Z9M29bMPoA@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 12:35, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Lifting struct membuf out of include/linux/regset.h, perhaps, and
> adding printf to the family?

membuf has its own problems. It doesn't remember the beginning of the
buffer, so while it's good for "fill in this buffer with streaming
data", it's pretty bad for "let's declare a buffer, fill it in, and
then use the buffer for something".

So with membuf, you can do that "fill this buffer" cleanly.

But you can't then do that "ok, it's filled, now flush it" - not
without passing in some other data (namely the original buffer data).

I don't exactly love "struct seq_buf" either - it's big and wasteful
because it has 64-bit sizes - but it at least *retains* the full
state, so you can do things like "print to this buffer" and "flush
this buffer" *without* passing around extra data.

              Linus
