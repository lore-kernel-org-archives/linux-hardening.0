Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A212E40
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581612; cv=none; b=ejfBqv6uBGbRZofEJUHs1rV0Y7dnwUmM5fRJjaALmS3TXXnmxRTQnr+Q3Tqk5Om4v8Jb5qF1oWhORupcol//dGriD0mcWloHnhgNAyE1UKyjZH4v41ocsXsCTbg0vdF27qY4P9yhrCQcd38jDVATBr63Y/9z7M8SXkSyRLmXZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581612; c=relaxed/simple;
	bh=jfydpiinpYlW5lz/CxxcHMi0x0ZILrRNe4+Fx00kgU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8GeUicNvZg07IIxJp8fPBuVtMUzgbdDTziYBsEMacPlZeub0R7Qq4yRU+2+NlkyV/+nsdeE45yOge8pKsZHobdK3YICpt4X7Eydrya0vwiMfUVKBcsvCaD4IsaGlCiRewHq2wpM3qbiyZCOfoX11VKJ9nrrlK0wSJCYwjm2s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DxLgGjNg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DxLgGjNg"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so1377631fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708581609; x=1709186409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=DxLgGjNgez8oxjwtcWaW0FjseG5krDVXuGyKU+t8vjdKbVEHBkEHhIXIhYME5fm7q0
         pLD7u0DkmYWV7beYRUUz6ikvN6bQO5gpUCl3Zyt9sF/QLR5UagiR+/9itQHman3UQnHP
         ABY9Q7boT2pMHHg1/JprYzt2jx1co2eBzOBho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581609; x=1709186409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=rUeALxH10achR9NhLI9WuwI9CyWEXqY75mEuXL5OCL83YB+4aXZrmh+fAUxj0vMR9r
         4Yj96SEtXIFl+0ezZyuIit7RePZR7YGzl0fDfOXSQ/dDjPiUxzItDe1caF0gyNoZEiBp
         il26HHt5iY0Cg0fFzLffPPtR0PwbhrUh8PAM9j2UpCri1Iu1UJUChMqK8Q/0sGCG7Jj0
         RYVcqPwdx35cW5S53dtAjK3gyHV7rM5A0tqpQiRvbD9PZVBpw3xRUu44hgWYzl0wnYbF
         BcPqrMtUJ6rHQ5vlLXaYVzSmzqB0jp0f3G8Pkfe/KhFrLGJicWAJNZG4Ywh3lYvY7W6K
         QsdA==
X-Forwarded-Encrypted: i=1; AJvYcCXnYbjMcl4dcBfd42blUM6GJl8S1FBHp4PolO+WcgXJpHnAVzF5z+l5N/bguCjXpn6wL6P65TB3qzjDBJGrfHrpZC5bTJuN+KeNiHRpMiAn
X-Gm-Message-State: AOJu0Yyz5HZvaHwK+MaJZfD4lYifN+VcsHo9W6tCft9RcyPFiBqmZHce
	Tq1a7lRMFjir/vlOiFzwfmAaAx54Z/ooK15SSyRBtsIgPPruFlq8KE/wAuiIwt287T5Ox012eSt
	9lKY=
X-Google-Smtp-Source: AGHT+IHf+nXTTY62mALGd9y7mJP8DZfLsIU1h9qf2fmiqx00eJfhFhVmkmFjhRqbC0DX994Mwcm/rg==
X-Received: by 2002:a2e:904d:0:b0:2d2:31a8:cb1a with SMTP id n13-20020a2e904d000000b002d231a8cb1amr568925ljg.13.1708581608912;
        Wed, 21 Feb 2024 22:00:08 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e92c3000000b002d0aad9dcfcsm2128324ljh.59.2024.02.21.22.00.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 22:00:08 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512d6bcd696so500367e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 22:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZdMfo99sxauO86Uc+7RveFKIB+lc9znDN1H0eedW1a7DJOMpp1+SVmUxWtf4VLZCpImdiVMgHfmxDoOUIL8dw3fuN19PTreTvam5++L0V
X-Received: by 2002:a17:906:f0c4:b0:a3e:719b:c049 with SMTP id
 dk4-20020a170906f0c400b00a3e719bc049mr1321213ejb.28.1708581587292; Wed, 21
 Feb 2024 21:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-9-davidgow@google.com>
 <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
In-Reply-To: <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2024 21:59:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:05, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> this has a potential to cause conflicts with upcoming work, so I think
> it's better to apply this through drm-xe-next. Let me know if you agree.

I disagree. Violently.

For this to be fixed, we need to have the printf format checking enabled.

And we can't enable it until all the problems have been fixed.

Which means that we should *not* have to wait for [N] different trees
to fix their issues separately.

This should get fixed in the Kunit tree, so that the Kunit tree can
just send a pull request to me to enable format checking for the KUnit
tests, together with all the fixes.  Trying to spread those fixes out
to different git branches will only result in pain and pointless
dependencies between different trees.

Honestly, the reason I noticed the problem in the first place was that
the drm tree had a separate bug, that had been apparently noted in
linux-next, and *despite* that it made it into a pull request to me
and caused new build failures in rc5.

So as things are, I am not IN THE LEAST interested in some kind of
"let us fix this in the drm tree separately" garbage.  We're not
making things worse by trying to fix this in different trees.

We're fixing this in the Kunit tree, and I do not want to get *more*
problems from the drm side. I've had enough.

               Linus
