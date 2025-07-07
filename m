Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EB23027C
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915853; cv=none; b=qlCWwCjOm4o0uWsnq3kRpS46ChKjpevYnH618emRvdHzXyqy1fk4Q6OLcZTEoTcd4ozthUs88TDpj/y5I6XcPRxSHVLYT5Hdx0uFxZw0kgXTS3GZLI7QGMZNeJ8q9sQUU9rLgxURQoqNHZXAyGYYZD0eN23pCa7j2gnnaoxaSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915853; c=relaxed/simple;
	bh=uRFpWHfbO2dbX6V289e+RsPoJGGkbhxPuKlvbG4Uu90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUUtj1RvuBnlmPYmpcOLDBf2W6A0UrnUKTplsNZ8d9S+CY65cT1aE3cjYz11VlxBS8o7YTVWABhsHx7iMJ5P07j0BhINuVcgH335XyTW3qftcrhBX6TIUqREu8A99hN4X+ltP89Z2dDWQJw8zQxTV4VdosGKCVW9bVrRub69FIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JDzpl8Y9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JDzpl8Y9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so6888467a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751915848; x=1752520648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORZDLd02UGkkbh45cfJ5kZRWnBYJOZszPOFyiadW67g=;
        b=JDzpl8Y9bWNZrquhgFUy5IDOwtDMZvzrk5595qcVDJeq9yIxwE04Q8PsW0QGwKiR40
         Bl9OhmHNrW385lVOoeOEpTMY89sjTVdGw0mwEgVDP3H3CJiGCC8uOvFRhthMUXrb8VQK
         ACxwm+era/xuTHk5o/Oee4LfGU0kNkPl/Te7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915848; x=1752520648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORZDLd02UGkkbh45cfJ5kZRWnBYJOZszPOFyiadW67g=;
        b=WntTX1slyqHZLQxxI8R4KMvY+locATwgG/wFBBjnwjVG0ezN/hfPObRJHRi7uZhHmG
         Cw5Nlt6v6muSwBuQlA4MrdtWW7ERFPXFN0plQknUf0qNmgfO+hS7sh3zEdos5q2qYyTC
         SlIzrKFbEBVRN8YV3j5sLPzS38kP27ILHPo2LktADirRJmDxLxvJMOnbMZwWelJf3fHY
         +dLLdbp8nVvmQVb5u34r1EZ5HXycpMXhg1JinnbyAwTs+gEVrAuOoz9zvuqs9FWvyowV
         cbLdgmOfWTHTiXDgrXatdsdA80Ek1Bz17g+Ow33VSLziPwlux0tP5k3CqFIbze6yXH2D
         Xcxw==
X-Forwarded-Encrypted: i=1; AJvYcCXQNMHc+++bERboEk6xnDOaK6KQxgXK0p79TgMVluMNtwsnWB1BqwqqskliQfN/gCx+VEWIB+IJjFUVkrOmeys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfPYcAYWwbUwpDOG6YyZEke0N70ZalIXhSPuD/SEJBn879UML
	cv3Ryfv7LZP3LP7VVDLgxHJovxestlVfVAHBFgH0xsTFV/vf6EdAeaGTf0UXh+rtJVmbZlzZ1aA
	/0aOj+Sk=
X-Gm-Gg: ASbGnctEN2WeVOtYa5SeFvEDUooYGNbUijQ5GZM4pAjzfk4oV806ZvugvC+rAXyJmZj
	YEtNFmicwMmxC64UkIeitZqZ31N7I7ozP+bNmfvNtwzhKyrpTFg286nQSxmdc/yTvPo9fl/t6B7
	/6zAaOe3wgYVdCpEJuI4U4+TwZx2jh03V8M2ZKMlnI+cOi6NUHVRuK47hTolf4YjsRUNNd99w55
	h4QobmD8KuxJXfbistjoB8h5PngE07Vmnqygq14iWPTupR/q3JkMUkq23sKrh7p9Dh08MFi7ElA
	n3bSug/7gLbejJbn1y0uFs8feKXtPWpia1k+ycPyD2stRRENLseWHn3B5DW8IiofM6qZ5D8MqY4
	yj+dLoOuHynNcrbNvlRNz1vNGz/Y9E5qGSvLK
X-Google-Smtp-Source: AGHT+IFoBURSyDINs5Dnq5+1TKCOUaaNr6VJlDVrhs2Z2tGEuCd03kYmwDjj/iZY9/06Ddwvlwzwng==
X-Received: by 2002:a50:99c5:0:b0:606:e754:62bb with SMTP id 4fb4d7f45d1cf-60fd34b7375mr9133272a12.28.1751915848463;
        Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fa9b8sm5925241a12.54.2025.07.07.12.17.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso5877015a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNo2G8l6zywW17hztKvMqxz6cFN/dJJkZzKd7XD09wTPK6Q9LVB5qXSR6B6FPNTjJOzUDLYcUOtuG9UrFyumE=@vger.kernel.org
X-Received: by 2002:a05:6402:430d:b0:607:5987:5b90 with SMTP id
 4fb4d7f45d1cf-60fd30d6669mr12436985a12.11.1751915847772; Mon, 07 Jul 2025
 12:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
In-Reply-To: <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 12:17:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
X-Gm-Features: Ac12FXwOfsR2-wc3VkxaTo-SkUQ3qs88-iLy7sw-vzL7AWJu7PpVDNuYiHFuVTo
Message-ID: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
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

On Sun, 6 Jul 2025 at 22:06, Alejandro Colomar <alx@kernel.org> wrote:
>
> -       p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> +       p = seprintf(p, e, "%07u", s->size);

I am *really* not a fan of introducing yet another random non-standard
string function.

This 'seprintf' thing really seems to be a completely made-up thing.
Let's not go there. It just adds more confusion - it may be a simpler
interface, but it's another cogniitive load thing, and honestly, that
"beginning and end" interface is not great.

I think we'd be better off with real "character buffer" interfaces,
and they should be *named* that way, not be yet another "random
character added to the printf family".

The whole "add a random character" thing is a disease. But at least
with printf/fprintf/vprintf/vsnprintf/etc, it's a _standard_ disease,
so people hopefully know about it.

So I really *really* don't like things like seprintf(). It just makes me go WTF?

Interfaces that have worked for us are things like "seq_printf()", which

 (a) has sane naming, not "add random characters"

 (b) has real abstractions (in that case 'struct seq_file') rather
than adding random extra arguments to the argument list.

and we do have something like that in 'struct seq_buf'.  I'm not
convinced that's the optimal interface, but I think it's *better*.
Because it does both encapsulate a proper "this is my buffer" type,
and has a proper "this is a buffer operation" function name.

So I'd *much* rather people would try to convert their uses to things
like that, than add random letter combinations.

             Linus
