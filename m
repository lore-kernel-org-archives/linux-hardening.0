Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1353B52E9
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746973; cv=none; b=TLGtqC1suGFLuBWKNt5t7T/C7iYtZyMxJVc/9gO5ueiJG5uAXThojRxK8rfKsDwjE+f06vAN5pRkKEYYcYY6fdOTmYC99ulNR7Pn8wjfiHHZfvQo4YqC4tBZbNLiwRR+FfF2MOzZ7EfuEQ5hfYzTj74JSlYcoFIFeW7WpoMMnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746973; c=relaxed/simple;
	bh=3WjDEzCHsM60UDSdPtY66/xViUYjVkKVnCvLEkxbKG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeRGsL3GA17Q0W+9K8uR2LUTfZ+Vm09PROmBZMOm5V9HlVZ0VcS7dWe/MRuat2KKH+JqJI46Ja1Kr8iTN7zOLjM9Pdx0Q0eEQgKDHNt/UjMP8ZMwSR9+CNKjp3c1XS7d26M3v7ddiZns6WZB2FEaC6qBoDVWEKq5W5X7AhOmWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsBzbse7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsBzbse7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e5624c053so4302924f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746970; x=1779351770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnnqbs2N6v6CmeDw57e03ve8ioJE3EIg9PporZt60VY=;
        b=jsBzbse74tGfrnjDhmHYu9SXtq2DJ6g/z5074656Zu/s2BfB0mS3jiL36gfNpdtRJw
         lAj7RWTmmk2NczHARYwE3FJ+2bz+cLlN9G2V2R6Vusl55TbgG2AUM+ZvnqGF6QfeEHec
         ESfT3lMpDLbeZwUnkTua/rY+ksxEzbLC7rWtTiE4ena39cijI3koGQU6l5h78QWatU96
         87I9Ifg6dQuDqMjk3NZanKuabqVIVNmHlHjcxugww4WbrSnJyUxyqajdHnwrPjNDtATW
         8elV7rIq5CpXwexbpZyZkK0ZMUHvOekzXtF6JoCIwejCnO7KY7Xg2SuzvBMZEZAC1ARZ
         FIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746970; x=1779351770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnnqbs2N6v6CmeDw57e03ve8ioJE3EIg9PporZt60VY=;
        b=G5a/4NJPE5WnFz2XTeHgdUB2F07w9IQku0cFEtuK1tmmQ2f/mo1JSDUkz7LhRozo4Q
         HNInRDUHI/uQOurC94XtzLsthnS9F/pxJcdfGmGSg8eJt564swn2IwUAb2KzzhERWSEm
         SMFzD5OwL1CraogGFJsWm7Ki9A16imksd0CGYK0dsfWJNhVIiaOkmiWxUE9twUiRR1zW
         MrtTRF5pGaRt2rryxrbLqM+gbbMipTaL4ZrNNKvx6jj76cdb4V6qDYagZWrZAXp96vCj
         CaHRJIN7+6oJyG3KBegZyapEj2dyrpGvi+BM/HIKk+Sd1F3qfgeFbeeb199MMxSWILhG
         cSkA==
X-Forwarded-Encrypted: i=1; AFNElJ/yfQadOXqnjNhpDwUUouYj7zPNsSsVbuWNMNf/3EVIADUlD3BVLjVQQFo2rEmHT3KUFTG95oOr3/RQBzoL65Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvDIkacOpMlu0wyYMYKFfkTo2+P5ciJq+ZN00tjgkI8ET6XiZ
	/vLusJk/55aPS9ovZDdY7E22W+pZ7wvizYBJ1ZNSvHfUSyJa7p7bzm/V
X-Gm-Gg: Acq92OFpOVremppeaFmH8qEXRKyYQaO7cf6qfzWvceJ1SgZO9KafV3Y4sebyejjHqWk
	2cTQK0XQt+2txGvIOhSVXEPyBVkgoVvcaLBIfn+FtHaH4R3fMU6Um8YIECCIknJUBWCwaXvVLQs
	dZe6/9f1g1bWUBQlT3eQyAVoDQ8NXxI0f+U9EdMabQUOxHfmTesjHcSC8czarFz8qtMc3tYNULZ
	dvCxsWuBxvh2ZRon+qpJHnJVp/BfNggZGflFr9/1EBjkFt7iOFnmP2D0lUAgP2mjwzLpV0mg5Db
	pvyvkqk03LUrqny+g+bmCpXAPAt+i8PUE5Vp7iiQZ1+YgQQ+LZosJ/ZRa/K0FoHqmB9INoydbJe
	8VbtK685l8tEGK57wi4Ed58eqAqgVUXnGgPu6HgC5A5d7YJwPlnJStaTS05nejVdrHzWwgewBD/
	KPmSLIDTkjla9Q+P5G/H7Yk6zVQcZb6PzhH8Smbe5yC7swjymZFCxMRMBkaSBL
X-Received: by 2002:a05:600c:45c8:b0:48d:35e:84a0 with SMTP id 5b1f17b1804b1-48fcea151fbmr93519065e9.28.1778746970041;
        Thu, 14 May 2026 01:22:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64a22a9sm49882335e9.8.2026.05.14.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:22:49 -0700 (PDT)
Date: Thu, 14 May 2026 09:22:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, David Hildenbrand
 <david@kernel.org>, David Rientjes <rientjes@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, Jann Horn <jannh@google.com>, Justin Stitt
 <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook
 <kees@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo
 <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 linux-hardening@vger.kernel.org, Nicolas Schier <nsc@kernel.org>, Dennis
 Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko
 <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM
 randomness
Message-ID: <20260514092246.12b7d1ee@pumpkin>
In-Reply-To: <20260511200136.3201646-2-elver@google.com>
References: <20260511200136.3201646-1-elver@google.com>
	<20260511200136.3201646-2-elver@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 22:00:49 +0200
Marco Elver <elver@google.com> wrote:

> When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
> to identify the allocation site. _RET_IP_, however, evaluates to the
> caller's parent's instruction pointer rather than the actual allocation
> site; this would lead to collisions where a function performs multiple
> allocations.
> 
> With the generalization to kmalloc_token_t, we now generate the token at
> the outermost macro, and using _THIS_IP_ would fix this for all cases.
> 
> Unfortunately, the generic implementation of _THIS_IP_ relies on taking
> the address of a local label, which is considered broken by both GCC [1]
> and Clang [2] because label addresses are only expected to be used with
> computed gotos. While the generic version more or less works today, it
> is known to be brittle. For example, Clang -O2 always returns 1 when
> this function is inlined:
> 
>         static inline unsigned long get_ip(void)
>         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> 
> To provide a reliable unique identifier without breaking architectures
> relying on the generic _THIS_IP_, introduce _CODE_LOCATION_: it resolves
> to _THIS_IP_ where architectures provide a safe implementation, and
> falls back to a zero-cost static marker where _THIS_IP_ is broken.

Doesn't that mean that all the other uses of _THIS_IP_ (which seem to mostly
be tracking lock requests) are basically broken on everything except x86-64.

Would it be better to actually fit that?
It isn't as though it is hard asm, you just need to look at how gcc generates
PIC references to static data.

-- David
