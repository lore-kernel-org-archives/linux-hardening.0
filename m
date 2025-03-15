Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D346198A08;
	Sat, 15 Mar 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068080; cv=none; b=mb6jsA5C7D1BX6GiSGl54LWCFHH8bH7hHkbasXKJjMKHJxClayLW+rXLHBv+6Mg6z0Pr37RD6KgQ4r1fpWrKM2KYaDmparFfQT/PUD0fB+s7/TJqfmWXmRDoMglFGxAyfTL7BSUY3GLDU2019xmXiZU2N7ZtqQlyw+NWT/329r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068080; c=relaxed/simple;
	bh=wJ4l6J6G+qyPJ3aBxSxuXZf5GDw9i2YcrDUY7OWKhmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHdWOXQ0rWmoyGoO8C+HhUkgoiiPVNNNSbQqYx+Kiw3TM7QmRa9RVvxwr1YgUJE315ZbXjXutGZ6Y+ROMKA2e5nDAPH0kfuVV6Tumqh2PGoK0SyX61Y7CXNucPC6SzREEruPfrRnDwRopbzMB0CYCffDyAv8ZpUjC30M3V7wW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiHoR6a0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiHoR6a0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so188559a91.2;
        Sat, 15 Mar 2025 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068078; x=1742672878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMChtj/qs0+2j6FZvP0hkcUuVJ7qalGUp9JEm+CkAO0=;
        b=NiHoR6a0NL+5gasW45XWmAYXDQ85mxafGg9OnJjghZVpAp1FNg0COTxm3p2Ihg9O08
         8Q1z3Tz/sb4r+EtOAWstYRu9k9lDeEKkR4LxKdZ185oIvy0G5X1/M+QJOevjHzHgnecu
         a9DwQe2/oFxF3IyxPTq/gL/8GSkee7nMGA1gob0L2fb9BUdbl+ZNQ7ZcPEMv9u1axSku
         /XwY/Rf2odGdKEtS5/2/9ZZ/z/hJW67uppG+TIMGTVnYLr30vxsFR5LFiLYVuyXinO/l
         +Q3uUjIv2mZd6HOdPoHckjmhU9WRrC+6wWZUbUsJA1/2QOKR8wF3J7rbW46P9mxIt6BV
         orfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068078; x=1742672878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMChtj/qs0+2j6FZvP0hkcUuVJ7qalGUp9JEm+CkAO0=;
        b=NAareuXlZcnqp+qDhUXg/umh8aTGHdxwmrRf21dHZGSugAOOc+C9Oj76uobiJn9F1M
         C9KwlpuzUyR51b9Aea1xTI5EvCJvcGJi8SybXksl2PEG4oPqsuDtxGdN73rrZxPE8H92
         BpcnHtt0PQh1pmA6N+gyZ4AJ8IFCXMIzP636asOhUtXuf6Jmd7bzi2Grq8ajFU7oGpTf
         S08vc5mXnY2xrmRkKMiaj+dCuSN5peO8WOA1QR8qu1pbp6t0nCzTQMUKIFuy4QeiXBsE
         ARRvCBZa+xUP0DG/STDa6AwJMYNom8+oB57SubOX5UyfglFoogh9lIFxWZloB1BucWK8
         2J3A==
X-Forwarded-Encrypted: i=1; AJvYcCXUcioZANBkmPjZnlzofe0Ui9fHBrjHkprotl4eil/UYxUqhLlG1hstu5E2ZefceJR0+KVtplFPlEQ=@vger.kernel.org, AJvYcCXX3fhN7s2OtKW4RUdyLBnufjEMdk1m4V8V1+AywLJI5w7ILl+YxDpxDESexcBukTgjbT4xoVXMlb2nhzIJ@vger.kernel.org, AJvYcCXwnqVroRYk0akTFTw4zEDO9vSk8iOMXjGLed6dTff/0b4qKexbb0HQltSuLI+j80Zc9Q7OL825cin+e7+pOKg4@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHV+UMJGuprT4E8aHlM259Y27ipChB25mb0kZnCOXvuTWhlwr
	WuRizrKhXDm5mz4uZoAMjHDGvmhIFFm+o3BJh920+KNanEHbWqADC59Gp05IHcU+6BX1DKY3zGG
	IAMHP0y7aFAUBDnAgw+Qsj1Qy70I=
X-Gm-Gg: ASbGnctH9x+XX21jAsbSPLENwYjzvsHHAF60CjSirORffaTZLIMbRjhYxqOLiJZJpop
	YWcIm5WnEingxfQKJrCwo02MXDmOLTMpJ9a5mQHXNAzzreZjeeC/htuN/HasmTP7qlEdnLKWB9H
	PSZjGHZCK2EsFf5ghRnLvCthPSs5T77F3M/IA3
X-Google-Smtp-Source: AGHT+IEdSuV95kVoV/AdTuJBpKGMb2i9LnB/HhcT8qPMxQn66E6o9ceqOM1QpXD2UnRrMI7THra8nGM+kEBtkK5IxYQ=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30151c5dfd6mr3410961a91.1.1742068078596; Sat, 15 Mar 2025
 12:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-1-kees@kernel.org>
In-Reply-To: <20250315031550.473587-1-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 15 Mar 2025 20:47:46 +0100
X-Gm-Features: AQ5f1Jpcv2jHsvKdPH3ud-Cw7eDilZMZWJEW0e1jOqoBRQkpg0FQvOZE9YOPiqI
Message-ID: <CANiq72ki=h4YWBWpoTpZz6525Cdt38aFN0kFwW7dJNPcVi_m2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Marco Elver <elver@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-hardening@vger.kernel.org, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 4:15=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> + * clang: https://github.com/llvm/llvm-project/pull/102549

That is an unmerged PR -- should we link to the merged one?

Or, better, to the docs, since they seem to exist:

    https://clang.llvm.org/docs/LanguageExtensions.html#builtin-counted-by-=
ref

?

Thanks!

Cheers,
Miguel
