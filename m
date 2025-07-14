Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEC23717C;
	Mon, 14 Jul 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479852; cv=none; b=QwKgQW1OptEJhtmGMW8JmiEtir0WYcw769WUORneo66HatUoBTq0Kb87aecLaTpxBF8lsmH5Gpq7XKBs+spKu5cTG4eYGAyXvRtRdtz1QZfkBaHH5xDTkp2ZGSmUs8XcwHscWU6otH9eo9SUXkx60cRb1buOXNe2fS4hBKGgxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479852; c=relaxed/simple;
	bh=RJo37Nhq5FGYaUxA8szx8YT34lqZWfDk4CzEZU4+yD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4hD8nnOViHhESVfuAWsfjCn+6zASJdWaVaS/Kqx1XD25x8NPMUvIsmF2qozYau5midSqdp57I4wnrfNokeh3aNYWgqCA0N3136n81dc6Y7NwfesCTTR2hwSKKCb5W7VFFhkXAVKdn6GafMQFWMB45lFLk3F0lfun7xhrOsvMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJddh72W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJddh72W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ef62066eso58796855ad.3;
        Mon, 14 Jul 2025 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752479850; x=1753084650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roSjWg6cHsmiMCH7MqmdlcAQ72VjQ3ISK0vUZNe2l3k=;
        b=EJddh72Ww+hOHmbwguJl1AZc7UaUBiYZECOiCj4tVdtXqfO7fqMWaI45RlAAnIbb6p
         ajMxtaxw8bXir+50jxXwVxgrBqputtLoz2Pjn/TKazFs0AbP4XS3WeDXlxcshprlVNDX
         Uu6zItjm/da4yT1JyttL1rE0dpWa4eW1bfWHKWmgHfAQUeW+uH/VXaY+mPWr7NCbjssY
         u1gN+hqa/IlfrgKFo0vjzZHFCegQ7XAsljgD4idqvDYrNXQX/UFOxCTH1sZ1FQYCXZDJ
         8XPfCXo6Uud8RJS8GXV46QQ7lGOGvwKdoTIolaC7hqfMTJAlQTnjT1fDFMbsh4ua+k4e
         +NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479850; x=1753084650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roSjWg6cHsmiMCH7MqmdlcAQ72VjQ3ISK0vUZNe2l3k=;
        b=CamLI5zP9tshMQdOI/oNIfF72X4un4OgfqTuFAxkJqtxchqiR5GLaL17+YMMv7frkQ
         KqkYEFiTpAKYzPOO3ijb8WayFxuvuZoH0EGyQWt3RLNYak75Gby6hR07EyYmJYBbtXhS
         us7s+qYnnN5AYmuNH/eIgfXdJACK6zhf4Ct8aw4ufxNOxfAGdyyGWXr85urxJwllGlsL
         UtaL7NOd8EujcR44j5UQT0pbc+35CWtE5H8Zm9YIXCr/svM2fR9UE0oy+qkPpvH5Cp/P
         L1q+xFwchmvF8n+nJyF/XpURWCCWy1jy8O9yaSDllZw3r54aL78U4aFWkG1Kd3h1bFGI
         bHhA==
X-Forwarded-Encrypted: i=1; AJvYcCW5HiO4CvL74IgLOa2a5gvCPjJVaRk25qaYOY/tnrgLy0JB86Z1qhrXm08RInyYP9NVLrktrMyb4BhYxIliJ4o=@vger.kernel.org, AJvYcCXCRLjbXoGhmOfdvbqP7JgeQ23QmAim46ZkKuZiegoMZthFZwrAx0Ix7Ic8QSHFsuKrl3eLyNnf4D6GRRb+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xeZ0M+dYu5QtQJr8oPtG2trUiSUc4SjqZq4Gel8hCfrR4P3n
	zCeGbmrb2FSR5pFy9qZpjQu30AIbzinbzOO+g9SrhSflEnKTq0I8s207v/i0y1VEXyfuboXPoko
	Y8pqSWJzyMeUw9jrwISBeMsG6ePz/veA=
X-Gm-Gg: ASbGncvhjrSdj2sKZTQHsbBRB26NI44WIl+RUokQpHQ2r+yzoKH3Ds3xzgP3Fu2aDZj
	6dxTsj/ECJDiOmHg1dBPLTHbhEwLQShTxKzOeBdSM99SoMBCVRRqkVSAljDinOL7R46yWUd9Zo3
	NLLDHfUdryfgco89yo28iyeUVFqm/IjUZ5Alzt0LCIKF8/VYme5OC4sjoN18TV9TL9b+Q5Tb/v0
	q8uM0DIlhe04XY=
X-Google-Smtp-Source: AGHT+IFpr5pAueYHXrM1OZmfYU3/Tgdvg6AkbcDgwTXNPQu6TnItlBsyNVYApKSOI86T+XJ2I5iWvpVjvSs/hjFYFWc=
X-Received: by 2002:a17:902:f98f:b0:23c:7b9e:1638 with SMTP id
 d9443c01a7336-23dede8c409mr132835185ad.35.1752479850537; Mon, 14 Jul 2025
 00:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com> <CAEHU8x9UKFWjuE2JPd99CS7wY-x_0kE0k=K3rfYUCJ29uzOSOA@mail.gmail.com>
In-Reply-To: <CAEHU8x9UKFWjuE2JPd99CS7wY-x_0kE0k=K3rfYUCJ29uzOSOA@mail.gmail.com>
From: Christopher Bazley <chris.bazley.wg14@gmail.com>
Date: Mon, 14 Jul 2025 08:57:17 +0100
X-Gm-Features: Ac12FXyCl2UVr3KuLV2X3zg5b49uXMIerI9JyvxvwFjPX5uWMA4vnuopNVK3Pd8
Message-ID: <CAEHU8x9+_9VdMCp2j20hQJFTmCfD9_R8yacGg67JeQYwo3KPww@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 9:58=E2=80=AFPM Christopher Bazley
<chris.bazley.wg14@gmail.com> wrote:
>
> Hi Linus,
>
> On Mon, Jul 7, 2025 at 8:17=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 6 Jul 2025 at 22:06, Alejandro Colomar <alx@kernel.org> wrote:
> > >
> > > -       p +=3D snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->siz=
e);
> > > +       p =3D seprintf(p, e, "%07u", s->size);
> >
> > I am *really* not a fan of introducing yet another random non-standard
> > string function.
> >
> > This 'seprintf' thing really seems to be a completely made-up thing.
> > Let's not go there. It just adds more confusion - it may be a simpler
> > interface, but it's another cogniitive load thing, and honestly, that
> > "beginning and end" interface is not great.
> >
> > I think we'd be better off with real "character buffer" interfaces,
> > and they should be *named* that way, not be yet another "random
> > character added to the printf family".
>
> I was really interested to see this comment because I presented a
> design for a standard character buffer interface, "strb_t", to WG14 in
> summer of 2014.

Ugh, that should have been 2024. I'm getting old!

Chris
