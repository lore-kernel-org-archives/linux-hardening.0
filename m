Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DE14B965
	for <linux-hardening@vger.kernel.org>; Sun, 13 Apr 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744585245; cv=none; b=u0nrfzVvn5RcyLqwrS9cJvswj8yyTon5zJDzCZOY9V6FlLpLJ3apVIzjVtxpiByT5QhLmhn+FHvLH/Ja8MS58wLed2xPB9sI6yqZuO58G1eCuwEOyQoIlkP4NRr0rmvLLsY7F6QJvcd+TvUYVXLI6JxmKdPTrHLL9JlrvwItsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744585245; c=relaxed/simple;
	bh=ylMZa6Aq29j5mVRt3GE02Yo6uF53GO98O716dshVloI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DnN/+sSO9Dgp1OAYZ5zF5h8o5iaYbNVOXqPA8AKMseuzFwhaDS0sjzTZvv3b8Jz6Z2wyJfCybOXB4pevt9aU8YRqCUclEh0FXjx1urd/QDddEBx///xfX2PkZx+5Ks5We/gXaB7X7n4++vVC+urKKlpnjtiyCbcqPhLbusGVi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/KwwQ4f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/KwwQ4f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2242ac37caeso234835ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 13 Apr 2025 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744585243; x=1745190043; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcijKGeNWU44eIj2ygDRvcCute3ez4NOIbDwZ6K3fSM=;
        b=N/KwwQ4fi17xu5OR6p4eYhmXVWm4ewdg8Y0Ftd7cbzvpH35bQCpHAevKdt1CDcer2t
         JvjdVpoYp/CqxG8Yhj5f/5CI3dgd2QNcsINovvpGZv/EqXpN3Rcx7OKbBGoO5CjCzAXt
         6IpU7xDeF2+28OoMYNQ/2vXSsYzddVJV0JXKiRXWpj306vcu/sBuy+yZj9lu6XuH/Vho
         picyRm+HwTg26US3D48WFOyA9IMiqOq0YB4ewd56AVq4ngX2RGnLd+hSsUDb4CThS7eY
         OZ/cv8eD5KSAmrjgEnjwgQUyhyjnNfMA1O81hooBd0XYdQgf1uFQwCYZ48PFU3kRz6Mv
         9clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744585243; x=1745190043;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcijKGeNWU44eIj2ygDRvcCute3ez4NOIbDwZ6K3fSM=;
        b=FT8cOnhGlWxbvJjXc+5y28uBqTZ2Ecto7Xm99MqPSuYfl4XOBF+O8t2g1tPFgJk37/
         qAUKL462Qdi3+blHbXw6O/hmButhj+DCMEyxCpdRVk4rB/Ns2kccVRyoN+AcpUPv3L6o
         RY3Wyxj7aiXwZbkDoA1j7paAjO+SIdr0J6hfhK1b55VOEkiD8HI7Bxt2t5B005sxliOk
         j0viYVP/uHYPmQ27BMBEEV1wbKXdeJqYCqODiEVuiN7NEJ0qwUZiQ5B6DC2IRTMXQ3UJ
         DTt5hFdLVGafWoddFSycqmhu5nFDuN/2zRmnlGWYbCgOWzgWcBVJfWgGnz1wtaUFQcG7
         v9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZURHJJGnhkK+hqTLFpJMMNBxjoJilolgsZV62kKAhWykVq6cmnSe4xKanD1PzB/Rp4sp0NWpSfesHmJcwtkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqCp/Xs5UQvmlRi+Ng9VqyWvqmyXjmFXF7tuWQZZSpi6NWG6W
	4X2lMp+Y5vfggtxTN5qhQb3IqMgCWVi1Y9uHPeNgjvWciJw7pbhCJkmfZYaflg==
X-Gm-Gg: ASbGnculHVETjuDhyD/pELX3WiBzYYLWFwOJZYdJ0ErpOcIfIvU2TU730CiqazHg9j9
	fMff+UATMUTvH8ulLtukEx9nO3Rvc7soUhhwOPdlA5Fsrfn4f0RRZ5OErDiyxOVhGWepxO3ddGm
	kJCvnLbMBXs4g46HVGnn2Z9Uk09MHITFLIqMz2bTmTQv6DitjK5CiUYaZ/sBWvU91rosdSqc2hI
	/0BkEBP4ZoHoA6yHghjvsaKBqC7eyMNPBx9obzeHf0a/W4Z1K/KwrdztFHFq6FpN/U9iD4/Afh0
	MJ9AYwy4yQ1O8tuBIHuWZoF93YsAuHMz2BT1lp2uo/IQ/Q1n7dLF1WS1rb+gaT2lUIqLcWphI05
	HIxhR1gi4tyDqFG+eaUZXnV7FVSxyi0Ne0Ec=
X-Google-Smtp-Source: AGHT+IFx60v074gs4AMnQgafHZpx5rGmP/N6w9NBkIiYBjItVWW/1kCo6dcv+AZwAtWyGk9dPOEPQw==
X-Received: by 2002:a17:903:32c9:b0:223:f479:3860 with SMTP id d9443c01a7336-22bf453906cmr2947865ad.18.1744585243089;
        Sun, 13 Apr 2025 16:00:43 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:f229:adb7:460c:4b5e] ([2a00:79e0:2eb0:8:f229:adb7:460c:4b5e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a12c8ac4sm8257942a12.46.2025.04.13.16.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 16:00:42 -0700 (PDT)
Date: Sun, 13 Apr 2025 16:00:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Kees Cook <kees@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Sergio Perez Gonzalez <sperezglz@gmail.com>, 
    Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
    Randy Dunlap <rdunlap@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
    Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
    linux-doc@vger.kernel.org, linux-mm@kvack.org, 
    Thomas Huth <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
    Ard Biesheuvel <ardb@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Decouple slab_debug and no_hash_pointers
In-Reply-To: <20250410174428.work.488-kees@kernel.org>
Message-ID: <f381d2f4-f86c-e714-c67a-1d060b8669d5@google.com>
References: <20250410174428.work.488-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Apr 2025, Kees Cook wrote:

> Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> but do not want to be forced into having kernel addresses exposed due
> to the implicit "no_hash_pointers" boot param setting.[1]
> 
> Introduce the "hash_pointers" boot param, which defaults to "auto"
> (the current behavior), but also includes "always" (forcing on hashing
> even when "slab_debug=..." is defined), and "never". The existing
> "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> 
> This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> 
> Link: https://github.com/KSPP/linux/issues/368 [1]
> Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
