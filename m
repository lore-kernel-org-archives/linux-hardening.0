Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F731A2632;
	Fri, 11 Jul 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213945; cv=none; b=fWHpTLuWkN8l+L7U0GzJTemaRTlR12D/mQi0+M5JYaDKXIOZfaZeVBEUKNxnYpBCh+ckwZ2KfIP7YODHfmIU1uY+uoPpm3XcUqMzjZ9CYn0Pl3r4meltXfvr+E1a6LaxmQD7Ab6ul3sjAUrhralXnRTAX+10aQY/EPf1NQ4BzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213945; c=relaxed/simple;
	bh=MjxfwYEYBr+4mbmREl73sMVm1dodWYzbd02P687uMY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiDAGWbMMi7nhskOHxQsXxItVe3zmMBW/am9Q5pd4w9U715YJJoziyfAsyZMhZwBifFd87hTan4bByoWbSn6aZLXiytuiGzl4u/nmjKyYptD0YPDWr6fFkSU5S4bBlS55nWDyVSXjKAxVffrAwEYieZarvt/fvJqUKgUGau8GCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLew2Tdj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLew2Tdj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so9840265e9.2;
        Thu, 10 Jul 2025 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752213942; x=1752818742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E7DKDfxJvck0LHqqh3ys40NEXmDsPAV+8zsSFbCeAIw=;
        b=VLew2Tdjg1cWOP+vzaijiaMri6FfZAgSouiSLI1l/kStBZyGZFd3fa26FR8LISomns
         mb2PQsLazsUz6Q0C+ABsZ8rEFzNlQ7Q7IhO8q/lMvKgQ3FFfCb3QcHZRakMGHbRbKAVs
         fK/O+2I++JFqyXjXPzXGHzbHAo9a+wDgXr5pCXXHHNwnZYYiBaFS5Ab/Zcy3sp5owP2s
         o/jRPTB26A+Z10dx+RefZnc5eheyLJE65DgwVdPWzQXOp6LDU/Acn4E+rvT2YCFp8WIp
         yXKYaFpfly9wJKhSseB87UtFQYFvxUQmcr1TvSU4ubJYmWuyKCxiH6lBsQZq6lFPr67t
         5sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752213942; x=1752818742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7DKDfxJvck0LHqqh3ys40NEXmDsPAV+8zsSFbCeAIw=;
        b=hEpJ1tnezmYYNqazii4jDTF3ynIaeQlrQC/uglHBquIGKKHjulIWByN1OeGkjJJ68k
         CoOLGRStHa5cf65Zgmrk30Qo9fNnE8c6YBNVuYwvaSJatM5L3faYJLCi79riIwOMUOtc
         LDFLPeeb+KfulSEpqKRgn08KZvAMQDextuWsAms3pMVgMPq/gbERpLOF8Y6nsIPuBG2j
         VqM1F1ScYnF1zwE5cxVfJ+IafYvxXkBBAiPIdQWZfNYu9Ll/S+ahuaU2wVYvqNxlryIt
         0LXNwW2ZYCZyCFFCM0CSJTr6APyeVDSEoejUaYExjr+UBjVzc4o0J0SIlbPF1LhX0ZPC
         qojQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ugfZ5QYSRAhYRZnfRne2ElWSq8WLW4nCtfrY0jnxdTYmtDHh2lE4KulsYU+SS8LFwsh9I1EMdqu0i5vEE5U=@vger.kernel.org, AJvYcCXUD/0GADeg+5I/AB6JhVJTjejM7I00nZFgDcO6WKXmnsOuxf1LBr/Asy0f0x66KNeh5MsbFMTQt2zbiV+L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BOwGARC/s3nQt6yuyf4k7TyB+rvpMdy9p+mpedISSkrYBW2m
	mG4wrGj5YYD0Iwt0HZk4g3LibF4sEevfoprFIFe4aHibHDLFL4L0PB/A
X-Gm-Gg: ASbGnctYElSEqmdLYcfmKs4i31qAgnI5El2gLJ0G5ivOZEPwryivqQnhCg9jcUKh+Xv
	7lx/FzXn6vwhIMhKBXqvOodJ4aslLjJD3wBpa9GUZojwP0pm7esKQnifGmjrozQ0XdzdDbK6+dm
	pgbFxAZvaaHYiZYBJpA72BfWYxiJ3MTsZwfDFqTTQ+xpQdqLc5LLxqrdwCovpV73UEEgq6YSTwj
	LZGse2PhXbePa3h4TZhwJK3iaaZrh0BaemoqxS48ZR5/zsT8Rya1CI/0+pWo+9uGKKdlEepBWUU
	ocoDb/h3l1lokY1iGZPdgBUMAKV159yUdIFAoXklibFm6CmBjZ7g70AAza1JJRxw7GRPyRoQ9m9
	KthDB1ISebA1jqfQXBD3pKn3yoTWY4uOGRgrEJjSz+NONxpc058axWwzswDsZcc9t6fjwdA2y4E
	i+7avb8J2gXThLS46Okwq7SCHqn09vm7Wrd551ACx43dvIWvJykIq5GICAu5C/+1Kc2lbUXz9Ps
	0DIemCmMhq3fFOwqHS3+0D0xlT90uw=
X-Google-Smtp-Source: AGHT+IEPSi1cBie5t7j4xTlaeJrycuFUQH/Q0RNOKDhAy5xhyS385IO1szs2WDv8sTlLuVuy3iohZQ==
X-Received: by 2002:a05:6000:42c4:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3b5f188e76amr1361043f8f.26.1752213941380;
        Thu, 10 Jul 2025 23:05:41 -0700 (PDT)
Received: from 2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at (2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at. [2a02:8388:e6bb:e300:2ae5:f1e1:5796:cbba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm3597085f8f.36.2025.07.10.23.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 23:05:40 -0700 (PDT)
Message-ID: <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
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
Date: Fri, 11 Jul 2025 08:05:38 +0200
In-Reply-To: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
References: <cover.1751823326.git.alx@kernel.org>
	 <cover.1752182685.git.alx@kernel.org>
	 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Donnerstag, dem 10.07.2025 um 14:58 -0700 schrieb Linus Torvalds:
> On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrote:
> >=20
> > These macros are essentially the same as the 2-argument version of
> > strscpy(), but with a formatted string, and returning a pointer to the
> > terminating '\0' (or NULL, on error).
>=20
> No.
>=20
> Stop this garbage.
>=20
> You took my suggestion, and then you messed it up.
>=20
> Your version of sprintf_array() is broken. It evaluates 'a' twice.
> Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> argument.
>=20
> And you did it for no reason I can see. You said that you wanted to
> return the end of the resulting string, but the fact is, not a single
> user seems to care, and honestly, I think it would be wrong to care.
> The size of the result is likely the more useful thing, or you could
> even make these 'void' or something.
>=20
> But instead you made the macro be dangerous to use.
>=20
> This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
> change anything, but then it has subtle bugs that will come and bite
> us later because you did things wrong.
>=20
> I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
> fundamentally correct, not introduce broken "helpers" that will make
> for really subtle bugs.
>=20
> Maybe nobody ever ends up having that first argument with a side
> effect. MAYBE. It's still very very wrong.
>=20
>                 Linus

What I am puzzled about is that - if you revise your string APIs -,
you do not directly go for a safe abstraction that combines length
and pointer and instead keep using these fragile 80s-style string
functions and open-coded pointer and size computations that everybody
gets wrong all the time.

String handling could also look like this:


https://godbolt.org/z/dqGz9b4sM

and be completely bounds safe.

(Note that those function abort() on allocation failure, but this
is an unfinished demo and also not for kernel use. Also I need to
rewrite this using string views.)


Martin



