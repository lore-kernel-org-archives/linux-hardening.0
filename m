Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056892AE66;
	Fri, 11 Jul 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255947; cv=none; b=nSIYMAMdVDmwq6lj3yW3m+mywUhhefV/N5heJ76H1zLycAuCME4SuCnnUGIMmAIC+Kt1pLSoH0kfU3chFyf5UeR43ucXNAHGCQcGzXcSVMMC0xEIXWloCJxxxRiKL3PJYTxH6LF5sgu19cnwXa8pPibfMNyn1HQ5EkFknHrMrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255947; c=relaxed/simple;
	bh=MdvErocQVN5X5b05F4uHIQIzS7VEosmmDN0AhrV9v8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pwzw3Qqf+wJKzlGsK4XGAUnwQrRmhYt97c1OjUENnkis9+/jRDvLWEG06qMDGVDhub8Xx9qBDGGr/aGiyw0t/q4lQqdImS1ruIhLIZsZOMm/Dw+wTsbC6/2tMlfgBFa6keTsq6xGAIUS/9j/fQ6/lNOWuN/dfzP/UrcJNKLbP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR++HuE8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR++HuE8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso2356218f8f.3;
        Fri, 11 Jul 2025 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255944; x=1752860744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHz90J7wv6UCluJ+wqVTBlJ1tKvrIgBjMeUDsq9gFZU=;
        b=FR++HuE8u6m+gBJz/phoINEKT4MxxZaG6f0QDKBDMtU8j7W7x6ZcvdUcrTm/WgLwJk
         eiTUr40Vf9xr+U3h6+vnLk/D/N9Zoxay5EtwKH5Y1JgHXgNtV5pasF6UXA2w8QDBPVE0
         DFjOmdHW8jNOM7ljoHpZbCLwrhXK7yGDsv+OJlbfD8Upd/Zjk8/r9Xd1uElq6PAd4677
         epa/QZbaRxEx5azU1b4gBVtUOqkFnaFTbFodhoQERqmvLfcMm7rbWmzRFcOyPBpckuZn
         h/9IGs8MzzHujbfa7qOGb+mxTFD+Gxl0wtU5WIOli/iFdDRIT9SQlrgOY+F3Wmh0YnSW
         ziAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255944; x=1752860744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHz90J7wv6UCluJ+wqVTBlJ1tKvrIgBjMeUDsq9gFZU=;
        b=esFj72mSSq5R+giTN+4cZVmtgrOLUTSx4BjkwCjhFpgvYfh+w0KjOXKqz/LLGvs6Zy
         Qd2zDY+wP58PmMjcvw8Q728v4xTgNFtVtUBeGV0L0Ru0+lUJwgyf3uZRfDC7TBGp3LUp
         0pJRLauoqomBqj4XbVwGFasIUaW202YF0mnBr641ku2GvDD/D7nn56Ht8QJ76vqgokw5
         0vQPrzBG97o/xTayrWXLj8DDDcIs+bFeIOZc8lWl3Eum7Ik0EBKtYQVfbcok9I6s3xc7
         Cw465zrAnaVgUiAMqVx//2lzTX4WwIEJ2Ls3A+VFnn7n6/92dXT/NGvgAJWtnC/Rutpu
         E2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+t4UF7Ps5GpTp0N/jlaExUCb6ttLcE5iZY3J0YBlO0GYwgT5jC/e1uNXZ+qYRQh3ETBjF+Dn0/uthLhF@vger.kernel.org, AJvYcCVHMEA18t816SujrC3kPjg7KFrS0aIms0axHk1mKVxLz+REz0cqUmBPC8FkTCFjOOul3+Q1hqmUznbI+l3942U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt334lIcDE9SUH0gzlOfC970EGFYCMPEs0Dr/adk36nvGlSFrQ
	DImWZBwToVIM5LGrYQTBnJqGDP+XFAIyxRcGAB2BEAPjSknXzqRJ9O52
X-Gm-Gg: ASbGncusWEnuW9IG1ZV3rpJzm8W+ZUNggnZ9VmUvpREcpqiWE5AZ4nfWgVqQ32hEGPm
	D8T0GhzGtYxPQhlgu6frONAtlLITyOD33wfDOojxHPEd+i/Mvx0StmNd+K4zp3Atb03CkVZ+vki
	Fn1h51zOpGPRbHaP3XHeRVTRZ/FFQAWP5WsA/JwHmcnrwKiGmhkDHZquW7NCpQoPScSF6rB/a5I
	T/+DAfWCSkYsajlOBfZuzHDJ+l0W1qFsPe6XNqCUPN3tzJ4+uCGNKc6yfbf/7x/ocb7koDGNQnI
	h35G4PKVEGE4yl5R1opLXmoFyRu+yDz5pXE/WhcHX2eLH9V6Exx4i+glZpW6Xe8/t5pW2VcboC6
	9r72JeV5yctjPgCPXkGoN7TYtFHqbsmCW8cZQjyUWUwpnaKpsX8hutQ0HEThH4KN1
X-Google-Smtp-Source: AGHT+IHYLFoeIiLxzKNpx2oPH/zTSNxUirXDFPit/qWyQBVz60uAIgugFu6p75MsyP67wPcmrHXWjg==
X-Received: by 2002:a05:6000:645:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3b5f188eb07mr3981761f8f.36.1752255944008;
        Fri, 11 Jul 2025 10:45:44 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd18ffsm4957337f8f.9.2025.07.11.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:45:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:45:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Martin Uecker <ma.uecker@gmail.com>
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
 <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, Andrew Pinski
 <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <20250711184541.68d770b9@pumpkin>
In-Reply-To: <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
References: <cover.1751823326.git.alx@kernel.org>
	<cover.1752182685.git.alx@kernel.org>
	<04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	<CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
	<28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 08:05:38 +0200
Martin Uecker <ma.uecker@gmail.com> wrote:

> Am Donnerstag, dem 10.07.2025 um 14:58 -0700 schrieb Linus Torvalds:
> > On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrote:  
> > > 
> > > These macros are essentially the same as the 2-argument version of
> > > strscpy(), but with a formatted string, and returning a pointer to the
> > > terminating '\0' (or NULL, on error).  
> > 
> > No.
> > 
> > Stop this garbage.
> > 
> > You took my suggestion, and then you messed it up.
> > 
> > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > argument.
> > 
> > And you did it for no reason I can see. You said that you wanted to
> > return the end of the resulting string, but the fact is, not a single
> > user seems to care, and honestly, I think it would be wrong to care.
> > The size of the result is likely the more useful thing, or you could
> > even make these 'void' or something.
> > 
> > But instead you made the macro be dangerous to use.
> > 
> > This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
> > change anything, but then it has subtle bugs that will come and bite
> > us later because you did things wrong.
> > 
> > I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
> > fundamentally correct, not introduce broken "helpers" that will make
> > for really subtle bugs.
> > 
> > Maybe nobody ever ends up having that first argument with a side
> > effect. MAYBE. It's still very very wrong.
> > 
> >                 Linus  
> 
> What I am puzzled about is that - if you revise your string APIs -,
> you do not directly go for a safe abstraction that combines length
> and pointer and instead keep using these fragile 80s-style string
> functions and open-coded pointer and size computations that everybody
> gets wrong all the time.
> 
> String handling could also look like this:

What does that actually look like behind all the #defines and generics?
It it continually doing malloc/free it is pretty much inappropriate
for a lot of system/kernel code.

	David

> 
> 
> https://godbolt.org/z/dqGz9b4sM
> 
> and be completely bounds safe.
> 
> (Note that those function abort() on allocation failure, but this
> is an unfinished demo and also not for kernel use. Also I need to
> rewrite this using string views.)
> 
> 
> Martin
> 
> 
> 
> 

