Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E17A92E;
	Fri, 11 Jul 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214792; cv=none; b=caq509sZPU3PUVU6nAAOU4IF6Gd0UhYVqxFRQXW/2nPpqV+5jnjzWQ6JM9iyFJUyiutnE3MaDr5QVtc6ELPrf6lRtERNwfMWtGDjVE/M0HNZqTmsivr8biNN6FH7CB9+Z15qFfQ3WdjlMMNgW0uLJ9xzNTbyY70c/Jc7oq+H1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214792; c=relaxed/simple;
	bh=DDTc3JrL5x9e5/gEdrehOJ3tYoL+nTiPmbBgqV+kHDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyYzWdkTNnQ4xzNk37ZNDayv/VB34DHBEpR/VKD7mxYFsN3IadCWwstiFpC1O6lhc1oR1+FskhPDy61858Nb1xf3NpRsGSumZ5uLzxAX5eU2W735yatEs4sdzSm5xbbEKJdnPNB6Mx2h+87Fsii7DMsiu1wBf2bbGIeJ0vmhNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jonIpor+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jonIpor+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso1041518f8f.2;
        Thu, 10 Jul 2025 23:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752214789; x=1752819589; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVh9hsjl81v4ae22eJ2co4oKHaNUT7Y20uC96jCSTXU=;
        b=jonIpor+cv5PklQo8WUhe0bHLbr5WrXDdddM9qQNWin9coGLdvx5OEifLPVuLaN+2p
         ydN9X57f0deZf6hpBKE/NfOWFuZTIfcDldPA95mSAA24vCOyK1tlmQ0xzQ8B5+HHanY4
         yxXAtz5ITL9KDOPy2xwA3y3946LDhU2ed7w7TvEwonSUF9g3Qf0G/7CQTBRpuk0yU/ke
         3oZxDej3f6QAF8iuWTSv5ybvzA1nkmVbFY3IATkXBQ4oCAbct5i1to1HwEA3gkltVYUf
         s3/1t4yPRF6Tstg0ZmwHPF+mo8hSbKYcu0jo9SG4K1Li/F8Ql0jaJMZYpT4aIufdkcSf
         Zr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752214789; x=1752819589;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVh9hsjl81v4ae22eJ2co4oKHaNUT7Y20uC96jCSTXU=;
        b=RjhonHzGIh8yhkTQET4w0YoitNNyKGSDU/+GYPNdmz68sHR0MIBVyLYvhvVCgsQcYE
         sZOfSLo+O89kpuHQmCVN6WBGUj0Lta/qGzXkzsielunGcfETtvTa3x/tWTnjT74NMmy/
         EHHwYh0lUKuxsQBxWd6VhX1ndu41LTIMAEYbda0jAPNm9N0hqeSkzYwdt/5LmLjPElvz
         RrUoX93e4rzMSX//2/Ha3R7jxIJdjwJtCbXz4iCojrDDkOC+R6C7P47AFOl07zXmHydQ
         F3j4XhCnsNKkv7Sz4QTLzC4K3Men3OBDk5ED4JDINw/Jn87hFi87au5mB7i6uGsyai1A
         wJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVswajJlzXPz4GhYiSQ1gXdFtK5S1S2KwssxdLrT0Yi0lqu5nfNov+a85BHuxLt+PcfDtoFgR2Ke2ccK/pr@vger.kernel.org, AJvYcCWIFl5WjDTjR2xZeVdcC0dfSWSql5sfOmwqHFvuMZRJzkHkoRmiirUkjW/nPizkyFn1fQR62dkVEpChbLq/jAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVY1B7eE1GeUBR1SX6bzfHF7xCLdo1737iDOa2DKFeM09POgRT
	SlnZzIid4aM2j7ZVqqjOA69g7gaClVkLYfm9qHITDPdRdcqXO+KmalYV
X-Gm-Gg: ASbGnctlZNx57jom4YGT4q7xTp1X7ViI401fdZ0qeMEvx67G2uDX0ZarRsxcYF59J79
	thcwMH+AZJvAJeDPbNV9ynrVJ0A8wPRW+MIsuYWZ62vjxVNmHNKly4fGNdjSMnD2Ikc0fEHMJY3
	KAUaEhR2tE9NIxO9SgAqJQ1vdNMy8Jso5NEEfc798NPRn7y362eD3ou3kt283UvrWFOhOO6UI6T
	dHYPZHEGTPE3J3IeYyjHrwESVlFLFDq+76tWdltAmcs9JvrIZ0JIvpCFp/XbHb4sZhRlptnjpGl
	MKJOUuf15OT6hTtSFbkYEyP6PT5eRWRWxooXCinS/3o1Wep0Ifr2KAqZ+WCtzJM1HX+Xw+Z/VQW
	mKu2ei0718SluGal0d9TOVpDIOmLB6MESQSLpgAOfGtg2lqh2jPqKsxiN3zAlkMCgFOpJyZzK50
	wI+nspixpSE45vpVaUxTdH7roBQrdM4LsYA2ytHedbIzXghEqTRX4uKkRcEhdQ1bLggjpfGaBaM
	gdwuyHQwgEcT12JmO+b8OIncKJsY7A=
X-Google-Smtp-Source: AGHT+IG5gmT2Z5CmKkYsqChaThq+JaG9rapQ1KiS6taqexfjAtXJ7e0m6bSjCiyRWl39uWz+ystjGA==
X-Received: by 2002:a5d:5f52:0:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b5f187ebaamr2048139f8f.17.1752214788443;
        Thu, 10 Jul 2025 23:19:48 -0700 (PDT)
Received: from 2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at (2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at. [2a02:8388:e6bb:e300:2ae5:f1e1:5796:cbba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21fdsm3608080f8f.33.2025.07.10.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 23:19:48 -0700 (PDT)
Message-ID: <bf3eb247c98cd96c602653bbec8c8e34a8c718ec.camel@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
From: Martin Uecker <ma.uecker@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Alejandro Colomar
	 <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, Kees Cook
 <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow
 <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov
 <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Christoph Lameter <cl@linux.com>, David Rientjes
 <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, Andrew
 Clayton <andrew@digital-domain.net>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  Michal Hocko <mhocko@suse.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, Andrew Pinski
 <pinskia@gmail.com>
Date: Fri, 11 Jul 2025 08:19:46 +0200
In-Reply-To: <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
References: <cover.1751823326.git.alx@kernel.org>
	 <cover.1752182685.git.alx@kernel.org>
	 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
	 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Freitag, dem 11.07.2025 um 08:05 +0200 schrieb Martin Uecker:
> Am Donnerstag, dem 10.07.2025 um 14:58 -0700 schrieb Linus Torvalds:
> > On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrote:
> > >=20
> > > These macros are essentially the same as the 2-argument version of
> > > strscpy(), but with a formatted string, and returning a pointer to th=
e
> > > terminating '\0' (or NULL, on error).
> >=20
> > No.
> >=20
> > Stop this garbage.
> >=20
> > You took my suggestion, and then you messed it up.
> >=20
> > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > argument.
> >=20
> > And you did it for no reason I can see. You said that you wanted to
> > return the end of the resulting string, but the fact is, not a single
> > user seems to care, and honestly, I think it would be wrong to care.
> > The size of the result is likely the more useful thing, or you could
> > even make these 'void' or something.
> >=20
> > But instead you made the macro be dangerous to use.
> >=20
> > This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
> > change anything, but then it has subtle bugs that will come and bite
> > us later because you did things wrong.
> >=20
> > I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
> > fundamentally correct, not introduce broken "helpers" that will make
> > for really subtle bugs.
> >=20
> > Maybe nobody ever ends up having that first argument with a side
> > effect. MAYBE. It's still very very wrong.
> >=20
> >                 Linus
>=20
> What I am puzzled about is that - if you revise your string APIs -,
> you do not directly go for a safe abstraction that combines length
> and pointer and instead keep using these fragile 80s-style string
> functions and open-coded pointer and size computations that everybody
> gets wrong all the time.
>=20
> String handling could also look like this:
>=20
>=20
> https://godbolt.org/z/dqGz9b4sM
>=20
> and be completely bounds safe.
>=20
> (Note that those function abort() on allocation failure, but this
> is an unfinished demo and also not for kernel use. Also I need to
> rewrite this using string views.)
>=20

And *if* you want functions that manipulate buffers, why not pass
a pointer to the buffer instead of to its first element to not loose
the type information.

int foo(size_t s, char (*p)[s]);

char buf[10;
foo(ARRAY_SIZE(buf), &buf);

may look slightly unusual but is a lot safer than

int foo(char *buf, size_t len);

char buf[10];
foo(buf, ARRAY_SIZE(buf);

and - once you are used to it - also more logical because why would
you pass a pointer to part of an object to a function that is supposed
to work on the complete object.

Martin




