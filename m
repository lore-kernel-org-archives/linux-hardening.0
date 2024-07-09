Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD414D2A7
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jul 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559017; cv=none; b=kvr8BmZGxRNKSn+uARBbxBJjdrDOqxCRv3qOAsVLkRjRDILNsM7DtcrhR/8IN9ypK3ZZzX9PNO2fvZE1U4qC/JnUZ6KUjBDoqT6qm7OQsPWZ+1SPjXaL40/STv0TJSjUi391XLCnhC5/1tz5pmHW0Ryf8M+4AmHrMY9n0tBw1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559017; c=relaxed/simple;
	bh=gaP6XG2rMSS5IJkfuqSil8ethRRMLbIOHXoShahWYwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf9jGHq6QajmIU+4jDh13zUi4u5RQiuNnoa5IyDhudVKKjm14/3M15Tm50MCD6rPDf5aUBATOY6OXddmCJd2u4ZWIUoOo2I1lcY8+U+6nlkt8Gf86mmN0p5sAEnTvFV6APQ4Pz+LU8njeBRhiK7QKTbCKzrUi6+sraAeVd7xd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x7Wwh3H; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3x7Wwh3H"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f319616b79so943516e0c.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jul 2024 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720559015; x=1721163815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEEVtKYtkpBGMMntNLgt1VflFU8iMiYE2mInhS30FFw=;
        b=3x7Wwh3HjGW8b7VMJt8SLWxc3vhpDb9wSGmnCuvG6eBlSCgfsTQTF0fg64JOfxk6sl
         aC25f4Xw9tkDKwLI6eM/6UETceecVHhhsc3EZ2wXEm1qz18J17spg8q7nL7lNK21xUKH
         EOBhk5B3R/GNBXjCexxIPSwMMMSWK8CrtvH+CbPmL1i+qyJOavtOReIgD3iNY8vUfka5
         n7geqCAn4BMib5AqIKhdvOguSS+k5Ohd/H+Du2uzDaCloGzD5Ya1RAMjqJnmnlHOlv/f
         a8fKLQOc7KW9PHt9p0ox6TDW7ghv/U725yEokQyamslf0u8LE1JoZvcVKqc/66kluu1k
         9KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559015; x=1721163815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEEVtKYtkpBGMMntNLgt1VflFU8iMiYE2mInhS30FFw=;
        b=A25Hv2Lx6TqCdjHPRzOcN34nSpBdwNJVO8dCbXT6wsDrjuH3NMIEvOXLlT2gaxLdiU
         CQwbHRFBM7bCW8EEa0SM33K7F89EaMfOx3CNmURswGnB5bzwsfVokgLtOpsYn/3cPs2I
         jRB7W2Dtvrqk9Q2ha5iGA6rYRucFPOsUtJQezYWk8UG2keBfjlQ9HV6aChKITInEbixt
         c7p5BLoh66lVmb6VY8igVi1jyecGMjvoX4SZSIfvJ00s8jKbqJ1FkqZ+LkiYDkM+MkvU
         PrDY3hDYwja9d5manaAMJneT+iojDtx+tmn/qoZXrUFvxp/hq+cSBZ+IkyYgwaeVqS6e
         6mgA==
X-Forwarded-Encrypted: i=1; AJvYcCUXNK16QsNGMd8+bOWEt9ChpYvVnOYzzA1jYJ9vAatF44EZl70O2teBfKyFSmTtUm3pxMLEnV84e/DLOM4L48CbeCJAk9hiusiHZjWtR6Xx
X-Gm-Message-State: AOJu0Yx1CQ+wUGsUUdNbgetD3GsxdXSm8dUD+LpiHyf7CitnQOivVa3s
	8Ib0ibjPgpeO19iKMa9lnMxtbIRI7fJB6zqRpHmrQgHixzkVsjGaRIm6XC3WQ4/6X3Kn2gNBfg4
	+QSyPG0LPoxvODgVL4S9x2+l0NF+QdchfQ/X7
X-Google-Smtp-Source: AGHT+IHU1E8fzuJxDgkkRa8V51Zp91URQNvMI7d/QwIPp6TAjb2CXGR3nGBcdKh6trunZV3PhvoQJWHyJO0iWBgRnhg=
X-Received: by 2002:a05:6122:d13:b0:4f2:ea44:fd2b with SMTP id
 71dfb90a1353d-4f33ef758a0mr4208200e0c.0.1720559014412; Tue, 09 Jul 2024
 14:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708190924.work.846-kees@kernel.org> <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
 <202407091327.AEF6C020D@keescook>
In-Reply-To: <202407091327.AEF6C020D@keescook>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Jul 2024 23:02:55 +0200
Message-ID: <CANpmjNP2BEYV5Yp80yS6+x90YFpdAUyYSR5mxoj9q7JZQWy3UA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during allocation
To: Kees Cook <kees@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Tony Luck <tony.luck@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Ambardar <tony.ambardar@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 22:28, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jul 09, 2024 at 10:26:32AM -0700, Christoph Lameter (Ampere) wrote:
> > On Mon, 8 Jul 2024, Kees Cook wrote:
> >
> > >
> > >            obj = kmalloc(obj, gfp);
> >
> > Could we avoid repeating "obj" in this pattern?
> >
> > F.e.
> >
> >       KMALLOC(obj, gfp);
>
> This appears to be the common feedback, which is good! :) And we can
> still have it return "obj" as well, so it could still be used in
> "return" statements, etc. I will work up a new RFC...

More macros like this only obfuscate the code further. The name would
become something that makes it really clear there's an assignment.

  assign_kmalloc(obj, gfp)

There may be better options. Also ALLCAPS could be avoided here, as we
have done with other language-like features (vs. pure constants).
