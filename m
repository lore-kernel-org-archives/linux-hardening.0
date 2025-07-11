Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209B2AEF1;
	Fri, 11 Jul 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256868; cv=none; b=NOtFKLjHxlMQWlpJML8c35gPJx++ik5j+OxDMM++R4ynzmtCZ9JQvqyNT4m0qbElde9oT9pKJmA5sGI5VCJqC2A7AefSPBTFIHaidQTXR0de9gW8DwYqBiHMVfsKK0RTaAtxwz5px/qKzlDueTX/37+8KDU4YFrVKToXzksjx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256868; c=relaxed/simple;
	bh=yAWOwOWD6Mn6N6e78rVFNtfiGD9viVjvLy0ZsakBvDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZIWMU6ye3Nz9P8+yKNNUgUYF/prdQ5Zz2RvjcD2Fw1wQ0Gh4MbMGbKrAps5dq9VeOHEoncq6nGTzRsWbVOFH3d75TdOJcPtWcBJ4VGx/41czj1IjeBBROerIUCDo1dNzpI7/pWZ0DhL60GTiBafKK/v0jDpTBvJk9pR2++hY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3oWdpLw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3oWdpLw"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so4517517a12.2;
        Fri, 11 Jul 2025 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752256865; x=1752861665; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXNOWT6MTv3Dyhe38G7xRW7KYU7suaaUF5CZ16ccYh4=;
        b=f3oWdpLwChr8qqomG4ld98FYNeRzDAAezYdLCyF8guF0wOVAntZG8Qf+TIRRWVSCbB
         sQ25iOdIBFPO20h04GIbP3fVJCVaCZ5Xa0d/deGJ6R2PXzkin4cMtOWaq6eeLZksljDK
         ogSOVYL6RGCrgWuWSyjuxCXVXWLpVzIr/xhna4vTqYbjvH3m6MNw+tJts0iZUHpmz16/
         fpdrYEyaVIdUYsRFB0sVPk9yGcrtTZBO66H/MgH7N5iBE75QtBs0H5qfPtfvymxzgv1P
         Zkb68njgaEGaUEkUwTOmZOSz/rUgb+X7cULb5i7dihvkTxsopno3Z3v218+dl/fWQqch
         VYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752256865; x=1752861665;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXNOWT6MTv3Dyhe38G7xRW7KYU7suaaUF5CZ16ccYh4=;
        b=lO2jqoHMvE3IdXCa/HqiPcYLw1ViJwG+2pEa4qCNTFk59/LDwnu0bEs/2Qw3lYXukB
         +xUAbv4l3CLA7Do9cKMqMywNijbxM9SFIpAGEU/NSx3eOFyJYsRucJZuUMonlhaBtwyI
         E6nytAMzMa8ZNg83IZQHaFiuydIuf97K6vFNbpz14FxRFJgr5mznzrOTgnNfymB+3vA5
         aKVllCx2qmIKPYYsD00LXUcTtNtuD5qHkXAB3/0D6sM60UGCgwbVdQ2GQhzlbqbHzeTq
         XaIfTDtbkwqagEud2KL8t6+LEpMm6VThu/eezcMCbGOtzESgkWeb1puqgzeLCPVXdEmy
         KjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw3pS6Mm8Sy28322qRoJGCI6lVOpzSbAytSaR/oz2jdUEJC720ICQMG/lDusmqFlpbcfAvVbNBaNk4IHRyoIE=@vger.kernel.org, AJvYcCXaqeffsvkLPbstRgtNznjJUiaBw/GuboSrAMRoUFVzbMo4BT5cF8RviI3/8DDNF3ylA4c4jlQdis9LHMqv@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsemMu0469NAvt6uvhFKyt67G+CQbBAnjtljuwGkoYPswAJEl
	Fv/Jg6XS9/55j7rQUSV9QG2RkkiFHu5trlMHEhee7uF8HmDmSkVYwnbT
X-Gm-Gg: ASbGncsZMIzi4w6TRiOkVsONkqWG877Ago/0B75FSSlRQgbw4TNSBmBNmiXqWJ+yLrk
	A5UEFZpMRRKpPBroMtD3f+dUwDgPapkP+GNo52ylUHi6IS4OkTZL0LrHyqnycqSsoi+EwMvt6FB
	oUlh3+LLFWvlUcSYYslEz1Hg/RNEyRqs2O+cEWIZ+f6gCagbbqcWz402fMnt8tWxAaU/rDPKO1u
	eiRffYA1yb6QtXc2iY8EEBKqvBVU+uzbuKyd4QPg7lxNP71lgZglNov02Hl/9cvHsXrK5E8D1U+
	PftwBhf50MZhGxKnZSv3Pjl2G1RAU79ulPaKVN1C6d807/wc4U3ltW3mY8J0HgX1XsTmoU+CW9m
	5sBWQG7pOQNSIbAOKZvhkAJmqKOIPPfXJsKQ0zHEUIOqRRk1HCX0bA5CCEp637lwn3cvCersmeN
	eaeGc05w7ZSkRJAwPJhQ1ieKS2o1ixPtOaJ6kLZJ51RfBfIBA4gXlKVSzgybCVV3rkuw/Vdjbf8
	PEJ5hzv7Foc+lJyKTlLYaauBYanuvHAEihCoe5opA==
X-Google-Smtp-Source: AGHT+IGcUXOQL27BoWlYQg1iU+Z/FJ5iU0XT8uYIRTsmnYUn0qBz2IUxxAJ1wnfWaogLaUnbGHNcDg==
X-Received: by 2002:a05:6402:40c7:b0:60e:404:a931 with SMTP id 4fb4d7f45d1cf-611e7c0ab1dmr3697521a12.15.1752256864591;
        Fri, 11 Jul 2025 11:01:04 -0700 (PDT)
Received: from 2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at (2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at. [2a02:8388:e6bb:e300:2ae5:f1e1:5796:cbba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c952b753sm2472335a12.31.2025.07.11.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:01:04 -0700 (PDT)
Message-ID: <7deb2ddcf0f3e6cd196b7520ad19e0d2ce07c639.camel@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
From: Martin Uecker <ma.uecker@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alejandro Colomar
 <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, Kees
 Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>,
 shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry
 Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco
 Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, David Rientjes
 <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, Andrew
 Clayton <andrew@digital-domain.net>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  Michal Hocko <mhocko@suse.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, Andrew Pinski
 <pinskia@gmail.com>
Date: Fri, 11 Jul 2025 20:01:01 +0200
In-Reply-To: <20250711184541.68d770b9@pumpkin>
References: <cover.1751823326.git.alx@kernel.org>
	 <cover.1752182685.git.alx@kernel.org>
	 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
	 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
	 <20250711184541.68d770b9@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Freitag, dem 11.07.2025 um 18:45 +0100 schrieb David Laight:
> On Fri, 11 Jul 2025 08:05:38 +0200
> Martin Uecker <ma.uecker@gmail.com> wrote:
>=20
> > Am Donnerstag, dem 10.07.2025 um 14:58 -0700 schrieb Linus Torvalds:
> > > On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrot=
e: =20
> > > >=20
> > > > These macros are essentially the same as the 2-argument version of
> > > > strscpy(), but with a formatted string, and returning a pointer to =
the
> > > > terminating '\0' (or NULL, on error). =20
> > >=20
> > > No.
> > >=20
> > > Stop this garbage.
> > >=20
> > > You took my suggestion, and then you messed it up.
> > >=20
> > > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > > argument.
> > >=20
> > > And you did it for no reason I can see. You said that you wanted to
> > > return the end of the resulting string, but the fact is, not a single
> > > user seems to care, and honestly, I think it would be wrong to care.
> > > The size of the result is likely the more useful thing, or you could
> > > even make these 'void' or something.
> > >=20
> > > But instead you made the macro be dangerous to use.
> > >=20
> > > This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
> > > change anything, but then it has subtle bugs that will come and bite
> > > us later because you did things wrong.
> > >=20
> > > I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
> > > fundamentally correct, not introduce broken "helpers" that will make
> > > for really subtle bugs.
> > >=20
> > > Maybe nobody ever ends up having that first argument with a side
> > > effect. MAYBE. It's still very very wrong.
> > >=20
> > >                 Linus =20
> >=20
> > What I am puzzled about is that - if you revise your string APIs -,
> > you do not directly go for a safe abstraction that combines length
> > and pointer and instead keep using these fragile 80s-style string
> > functions and open-coded pointer and size computations that everybody
> > gets wrong all the time.
> >=20
> > String handling could also look like this:
>=20
> What does that actually look like behind all the #defines and generics?
> It it continually doing malloc/free it is pretty much inappropriate
> for a lot of system/kernel code.

The example I linked would allocate behind your back and would clearly
not be useful for the kernel also because it would abort() on
allocation failure (as I pointed out below). =C2=A0

Still, I do not see why similar functions could not work for the
kernel.  The main point is to keep pointer and length together in a
single struct.  But it is certainly more difficult to define APIs
which make sense for the kernel.

I explain a bit how such types work here:

https://uecker.codeberg.page/2025-07-02.html
https://uecker.codeberg.page/2025-07-09.html

Martin
>=20

> >=20
> > https://godbolt.org/z/dqGz9b4sM
> >=20
> > and be completely bounds safe.
> >=20
> > (Note that those function abort() on allocation failure, but this
> > is an unfinished demo and also not for kernel use. Also I need to
> > rewrite this using string views.)
> >=20
> >=20
> > Martin
> >=20
> >=20
> >=20
> >=20
>=20

