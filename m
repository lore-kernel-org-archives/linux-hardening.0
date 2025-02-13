Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951021C84C1
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490265; cv=none; b=aKcfoqsX9WLl+GKaCoEknevnNrSiAlXZsO0OooH4UlmY54WAiW9vauz1Xf8Emlr88fiHwE+ScBrkUak8HPppwoUQCF2E8vjFtYdI6t2Cq7aQv/AFYtbG2qkInHYCjCMp4ORPPTQgYWedolisgNJH3IPJj32l3Y/NtP2rsLd+T+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490265; c=relaxed/simple;
	bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R64OhxGSeAy79xciYY9971WfhtMKbbV7i2iPwFQaONsGfTsyr8f0uApFr6mUzRv+QMgvjIpliuQJ+jnuuzDj8ulHxURfsLHGXGDFwqBV8FQaPYBIVSIEWELNDdQLgnjVbgdXTAVHz9AXICW4+/iN5xN6Bb2ZGM+R8DH+ikeL7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNFqPc/t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNFqPc/t"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded4a3bf0bso3846a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739490262; x=1740095062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
        b=GNFqPc/t4R9eJ+Akpw5Q0Znt5xaQLAhuFutp2SqDQMINuiiT+T+V+EM1lbcA7tjCzI
         Pu41FArE4kR3EscwDlzVZz3PeMgQLN9iNJECXd78M8iEY1EmVh1vJQd+rbOnQ+t7ODVA
         o9s/dRoqFTC03tbtP9H2a7nwj5LFVBO+ax9zJindgPZRiZxhFCoZIqC2kbOVs/ZHjNVb
         l5QofNNFls8EFsD9kJSXR+huLVVf3oo364zbayrkhcAbFKN/r/CMg2JPhmDLLcvV9utB
         KEXWkrjzajoGxgchfXeojRjem0BEODDzsEjUuHlA4vQj0qbxN/T9XggrS2VzlgNaHx/N
         /R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739490262; x=1740095062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVsGZ2QbNBgEEQsJ3N0ct2PlyNRGV/u4n5QHhnEVl4Q=;
        b=egYRnpHbKeGZGzC45ZgJ9LGXWSLEjptdz1TcUhIfqnnd99NptZffS9sXzTN023mUEk
         kfivarVlVrHVkWUL57IfGRUwkL+BH6cOmkafNF/X7dyU+duTjEtGEC7pszmNU2gMakci
         tRSY6TwQGwxY039ybUcLKzf8Qn4p4gOttZFgxAUNGCMn7try6a+0+vrPppPaCKAZeIsw
         pLnL9Z9Fi7c78pKeeyU51bFtPzA5zwrlRjhK2aoe4ZXXiHUlhbdMh38/sevGeI0ONaob
         B304Btin07PekMI+Fwy8g4pov9GxEsKJEAfZq9T9q+zWAy/4oajoIsAo/gblxmO6ITrr
         EqZg==
X-Forwarded-Encrypted: i=1; AJvYcCVSNXkOrb6KOcyUl0zrg7qFO5BSkirPsfA2W8iyPnPwJZJyRnVsJjNIaoYQa91EH008TUyuneg9ENGMcZs+fBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oCA/kjxbcqWVAasQxfLMUi8AjCuZan1pTQkfk8rgzl07fexc
	Du4xua1JUx442gmoKmc7ge64Dvir7A7NSMe9eudEdwdgQM4c9fZfnypyBEO+8MDtXzo3XJK9s2k
	Sffw3NI02J4smZ0Revgvrjrg8ZLBt7kPNMM3E
X-Gm-Gg: ASbGncsJBZTgr7EcU/XNpZC+OdGUhaL1i4jeYWRY22sVVMB3uH1LGQmBPOgsN2mOHhO
	j+SJiINbATiGDitDzh9ppBQLShXS9KLVXFvgUbZNd1JzjxVaDqJxoFYovN2dEQYj+pfOwvduK7C
	UCEVTSAxOFZH+Z1m+iD8bOy9E9
X-Google-Smtp-Source: AGHT+IGm01cg5lXnPENJRNd1+C48PQ9hSvIItt8iMZjfD3EhZKk+sWrYBSUTQQY66x78JL+AuJZJK5wE7TfflEc6Pf0=
X-Received: by 2002:a05:6402:c15:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5dedd20e5a3mr42098a12.4.1739490261366; Thu, 13 Feb 2025
 15:44:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NwR4w/28Z7XUa@ubun> <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun> <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com> <Z65/Fpd9cnUk8TjE@ubun>
In-Reply-To: <Z65/Fpd9cnUk8TjE@ubun>
From: Jann Horn <jannh@google.com>
Date: Fri, 14 Feb 2025 00:43:45 +0100
X-Gm-Features: AWEUYZlPPC-C6uIAwuBtVNNECjbeEq0SMljhE-c1JcoBtUnN4mOI8Tinx9IpsKA
Message-ID: <CAG48ez20UKXNW0jy+eO9_DT8aYeKZu3GBE6wU2xGFTBwo_ChzA@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>, 
	linux-hardening@vger.kernel.org, kees@kernel.org, joao@overdrivepizza.com, 
	samitolvanen@google.com, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:24=E2=80=AFAM Jennifer Miller <jmill@asu.edu> wr=
ote:
> On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
> > On 13/02/2025 7:23 pm, Jann Horn wrote:
> > > How would we actually do that overwriting and restoring of
> > > KERNEL_GS_BASE? Would we need a scratch register for that?
> >
>
> I think we can do the overwrite at any point before actually calling into
> the individual syscall handlers, really anywhere before potentially
> hijacked indirect control flow can occur and then restore it just after
> those return e.g., for the 64-bit path I am currently overwriting it at t=
he
> start of do_syscall_64 and then restoring it just before
> syscall_exit_to_user_mode. I'm not sure if there is any reason to do it
> sooner while we'd still be register constrained.

Right, makes sense - sorry, I misremembered the details of the
KERNEL_GS_BASE overwrite proposal, I had to re-read your first mail.
