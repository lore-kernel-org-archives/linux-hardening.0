Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3F2EBB9E
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162757; cv=none; b=WLL0iDj70fpqU2hgZI/3J82rpLPgouFKoRpuIeUtV3vZAtNakWh03GjH+AgN+axGq69qfTT7L8xzupU6Qjm568OhjanuRC8S2DUoLZ08mwlUGwDdPdD+3wMlTjeDt7PKOrIvx9C5FNvVl/mUlz+fUpLwtMdYfwZs1tQ0S/MMHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162757; c=relaxed/simple;
	bh=Fq+vGXveryc48qb/dm5aqfzxb4eLCfFILKMVI9bcams=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPFW9sRyNiryNHG1LczcCoGYOx/t7mFO5Wf2lDa1b//rjCQqCeFZSy3vfZdbyQ/fYHxz4veqX5KKgvCpaixdljfaveeUBsDQfV5N2wBpkxHwOEoci6o7D+GV4LQ8YUDYkcuRUsAcFdCfqS0zhC1oftkJaMAL3INpn6WZV1LdULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KWSx9MQA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KWSx9MQA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so2180156a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752162753; x=1752767553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCLKwFa0neCTBla2iQUvszaIW/YcUeww7BNmMA0A/10=;
        b=KWSx9MQApm0/R8ncy4FyHxbmNUAjq/bct/8S/X6FWLmistFbvyYc0tywaZKKfNxsRa
         If3+KRRaoxpiDWucNVNZrSoyu8WzGCG0O70nJWqb6xHSEE5QgrluSKR3m5AlWILV8LYy
         groKziG7PdpVHu3/l/ygc9TOfCcbl7dJ0XjLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162753; x=1752767553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCLKwFa0neCTBla2iQUvszaIW/YcUeww7BNmMA0A/10=;
        b=SxEq5D076BVd56Fizze6GDJa/2DzgxQGcwUHCPqBSwQ1wyjEvCDOSaBZCOmUFkSX4R
         TNhRTX4fKF3SpQmL3MFiM3WhRfXBAt6XPhoPC3Cr/3AWsmwIOYPKWs+cFGeeKBbNg195
         IPoqI7qjopJ2wfhOGJEHzpzTYUaYacE3x2cYYra9Pksw73elrcWbJTdYmoIFFZ3g/LUg
         bjBYsMMwValASbD0NwSbi/4o9UZYNrnhyhslj8aPOJGWn5G7Z8BcduJmx7DMa9XkLMq9
         pYXH828Njx/5W1vF6rnqr+AQWDUvBEGpSvchFWyqXYRpV7UuyOqVh8EV3t4EL3wI21E3
         PlSA==
X-Forwarded-Encrypted: i=1; AJvYcCXbCVx5IruhbbZg5fGEy6FLWyw0NIz8+SKJ3W+codAMUh06ixZmUkEGLpI871lygY4XPI48PmJGDUh6NKcw2qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSbDoE0UTyFj5Q37eT+IXImxAxnHGbuqSmgeCgp4LgFfe+Gj/
	8rV17EbqLAX8hVEUg1TnUueCV6HFCt953QJm18LHvzztdR+dI5V9qRq7tUaDOQQtZQWlrhMtJ3J
	GRpAwyz8=
X-Gm-Gg: ASbGncsMOqFtZKMQWOr6iTLifQYOZ8a6NrA5HkTt7EV7pOSznTZTh1AERYV/e+OtLqx
	eRIsESj50FO7ZeeOgGofk2DFZTEFEQDxwvMDiR4jYiHp/fTSSOH4qoxp3A/2Jd4fmBVVTnflyv1
	Yz04UpxR6ow+K5EWXGc7L72Q+ShSmwtwmaUITdd6X3QqXxDF7qTpym6DltLsIxcadO6KxFvB5x/
	IHv4Trkj9iExCV3zqO7jwL5+xLH81Une315fnUvE7BJoULeApc1RM3ubkPhwHaQHSMAHr1oibcn
	wN96bJw/aM6WQS5MaZBJO3Z7MxqNS5DyqzUWNGfwWnP+iMwBZ3iijfWJUUAFfh+nXgG+13vmpax
	PC7WKdkHnCfccJuoAG7lVKiLwVijCTakJQCy4
X-Google-Smtp-Source: AGHT+IFl+9fIpD8U4c+GYXU6sBR25H1n2dA60o9pixXz8HRWx9FIiQD0q1fBCGzaQgeThLNyw8ZYBw==
X-Received: by 2002:a17:907:1c10:b0:ade:422d:3168 with SMTP id a640c23a62f3a-ae6e703aaa8mr339634666b.37.1752162752849;
        Thu, 10 Jul 2025 08:52:32 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910c7sm155837266b.15.2025.07.10.08.52.31
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:52:32 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso2066704a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 08:52:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVprxJ/fY0lYUdL278am63mh/NnLsNeFFEMqpKh9NbuZq8SrdlbwmKhis7XjwRLC64+CbjiLCokRS14nTnD/0I=@vger.kernel.org
X-Received: by 2002:a50:9e0a:0:b0:605:878:3553 with SMTP id
 4fb4d7f45d1cf-611c8507641mr2264146a12.16.1752162750681; Thu, 10 Jul 2025
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
In-Reply-To: <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 08:52:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
X-Gm-Features: Ac12FXyZN9kxQm0HXniuJ3TdAUc1hQKzCbrnbibn7oPEnjnUTOgpa2jjfvxQ0Ho
Message-ID: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 19:49, Alejandro Colomar <alx@kernel.org> wrote:
>
> +#define SPRINTF_END(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
> +#define VSPRINTF_END(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)

So I like vsprintf_end() more as a name ("like more" not being "I love
it", but at least it makes me think it's a bit more self-explanatory).

But I don't love screaming macros. They historically scream because
they are unsafe, but they shouldn't be unsafe in the first place.

And I don't think those [V]SPRINTF_END() and ENDOF() macros are unsafe
- they use our ARRAY_SIZE() macro which does not evaluate the
argument, only the type, and is safe to use.

So honestly, this interface looks easy to use, but the screaming must stop.

And none of this has *anything* to do with "end" in this form anyway.

IOW, why isn't this just

  #define sprintf_array(a,...) snprintf(a, ARRAY_SIZE(a), __VA_ARGS__)

which is simpler and more direct, doesn't use the "end" version that
is pointless (it's _literally_ about the size of the array, so
'snprintf' is the right thing to use), doesn't scream, and has a
rather self-explanatory name.

Naming matters.

                Linus
