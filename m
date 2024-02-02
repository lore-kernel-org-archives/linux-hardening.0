Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F64250E5
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917021; cv=none; b=hoRWQSKgod/QN7hYrelQmmjkll6Fn6V8h3xXHGtbLZCI9o20p4vrX7kbA5Ixi+xYxGQvfDApM8wUYqNlXbok2fVgcty/sRpOfH1tbghw/GyiLF1rfzVjGBT0A9D8k3LKajTqBbwAjunRCwGHN/9p9m26RoDz7B9OztPtUQvUAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917021; c=relaxed/simple;
	bh=V9SNWHDZPQxXdnt+QLityMKsnJ5V5efabUBxNJBV1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NUcNStPpz+KbNLVeZnCn0WIRdyWOxkSWyfPaiTHieaUmsA9IpR9a+mAefTeV7lgEfAlniUZ2m4+KwdAKxdpy9YSUyPdw/rRzHECT3neJ/Tt1b5RxZo7E4g0Ef0YgJDJn3Uqy6g8kp/cR4Ip/j+bfg1sRCaKzLGUfP73lU7JjrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=by29GLM7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="by29GLM7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so31953361fa.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706917018; x=1707521818; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=by29GLM7tvnpKNC7qdRZJpmGqjE0/cEzrbl291+xFRtQcN0b+rpWsfnQDYD0wTMOUB
         /QblPDr93AO05VbW7/hMgUWOvdrqn2IaHFv2cQ1VfLNa16sl35dqy4b32qxzjq5w146F
         dZkamgTX45HQqf4bZxUjd6bZ+sWnN9t300Jd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917018; x=1707521818;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=gNmf3pmL3vUlJL71vKae2iZuqMc+zbUye1/Gqp3LZVDvi2lMfmNnwRvWcja2Wan2aS
         n4g4lJki2YNplRpksbhcwmpwvaDpo4xEfH7nez1IFf9iyi0qAaTKpDK2LFwFPtgBMZio
         HONvkz6mLtHboQ5/yU6qJ4Nx8m29zOLX6cFjSxhaW1l+7ALtI98NeQ0kAuyCi2MwOAsK
         NRROe62eLCF8ob3XsqfzMRZFFhRw35pGiQWhWBkBkAhm43a06UZGD1I7Y7USPuGQb0RC
         5Ca25Jg668kcZRXAx7S1Yq9JQm/boPbWHeiEgP58DLOvrdanCNoY1sqAayoeTohwNcfo
         5HMQ==
X-Gm-Message-State: AOJu0Yys1DfbOa2r8YLvxpGkxaEa2tRxRPWPzE5ZRuI4ER2RiIG1c+/P
	13X53TXd9whsaTWiTCMejRyNpXo0HW06rtu23wsySZqB6g+nj/Mgzwz4dQgEKvpWmaCXAF0XGd1
	veML2BQ==
X-Google-Smtp-Source: AGHT+IGmUESxpO9FiBCgMOWfPvle7G6jbeKkObbeecJ84Q/VDWg4pOhDiCy3jIc0Qsk0gIIoVtSSNA==
X-Received: by 2002:a05:651c:1a2c:b0:2d0:511e:741f with SMTP id by44-20020a05651c1a2c00b002d0511e741fmr4930456ljb.48.1706917017921;
        Fri, 02 Feb 2024 15:36:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUa2zRPHF1p5DCorNTH5CQeKmBSghoo72QmjgmUBvnkJiBiVyHpHVDzgGnYaHHdbH4Hd/rY9oBZ3B9OXthdFxEcovzZilF3cDZTkEb9YmhP
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x15-20020a2e9c8f000000b002cf47595e13sm394378lji.120.2024.02.02.15.36.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 15:36:57 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf595d5b4aso32587571fa.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 15:36:57 -0800 (PST)
X-Received: by 2002:a2e:8902:0:b0:2cf:5247:23cb with SMTP id
 d2-20020a2e8902000000b002cf524723cbmr4207675lji.39.1706916996415; Fri, 02 Feb
 2024 15:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com> <20240202211807.6sca4ppezma7cyev@revolver>
In-Reply-To: <20240202211807.6sca4ppezma7cyev@revolver>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 15:36:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:18, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> There will be a larger performance cost to checking up front without
> allowing the partial completion.

I suspect that for mseal(), the only half-way common case will be
sealing an area that is entirely contained within one vma.

So the cost will be the vma splitting (if it's not the whole vma), and
very unlikely to be any kind of "walk the vma's to check that they can
all be sealed" loop up-front.

We'll see, but that's my gut feel, at least.

               Linus
