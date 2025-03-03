Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900A1E5B6B
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982859; cv=none; b=gH+ZJ5WZQ5p9BPvafwo49XWsO1E0JwjyXL4IJsXJkFvw0fjw/2ZAFcKTzAOz/yIEbGDqMB3wiKmbyphp7kvcc9A6kPxCoL8P4D3B/sZizPZG31a9m6N55/SVrxnMy3T8T5QxH1hGM5ldAKDTjkAp+E3U4EgSqdFwn3hZNSGwBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982859; c=relaxed/simple;
	bh=ejz2PtWNPFITFdwjeu0BwpoHHMNxTR5GOfBDgb+9ciY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7vLeGQ+g/+VVuMJob5WCQG8n69/NXgrcpOYcVexfZ5YUruOc9vmW5lzUQ/puMtJxpCt8j+H/4hBupKReZ6Poh2BWvwsLNKXJFydV86qiN7nxOh8mX/lazJTW8/b8mI1mHSRZkI9DeM+X7rphf9Ix2m0ljLUa8w8GJycG7da9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U25bkToI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U25bkToI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so824809166b.1
        for <linux-hardening@vger.kernel.org>; Sun, 02 Mar 2025 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740982856; x=1741587656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejz2PtWNPFITFdwjeu0BwpoHHMNxTR5GOfBDgb+9ciY=;
        b=U25bkToIucX0e/cKPxt7KEgaewSRFghPNMexooAerUvA0M6eS7GNOdkLyCCpfwE56s
         BaAGYDDXDjY2CbbpuPrYNVqJFoJyKZ+Scp2E7dUPs/CFdBO20aajkDT3hZZSXgeZ6LNd
         EMXZlYjo90qdjs2KRD6VIa9nlpB64JNADR9HIA20+D5lVntMEO2Zn9PY2w5VVSQiFird
         aB0OfYg1aOC6OZbYR7Vag62kHBIHe4tTWDoCQxZOTj0qEe3BTArVceWCt770WpmOJSdK
         1P/uwQLNLqagHCUw0hiz90g7BOBPkdLRxmMw09ILG/2jnv5O1DFfV7/Df8JCRcMOrMDx
         8Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740982856; x=1741587656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejz2PtWNPFITFdwjeu0BwpoHHMNxTR5GOfBDgb+9ciY=;
        b=a7OFIeFGWFeBf8+2o9u28QEo3aTkId+Zyvkw1rUmif+14LHJ/4JROUI0PHA20cENzq
         Vz7agLUn2aQK9w9O0nqDdCOAi5Snq1SMkuROOcohqUYafPKUP0/jR66Sv0HO4hIdmXgy
         dpiGE7x4hljd1gRQXzzIvlfIfr8vPWFgxbuLyGT2MurEO4x3WI2a5KGwke7r2DuBQxjm
         SqStvo0gkl1aVkUsfHiZDeJWJZ1sZ3w9kJ7wVFZW883L/ji6BKqCUJ2AA1KCGSxJYzfO
         lrHUmkLAYPh6jKTICYy7RlXO2ZfPFKHZ9hac7j6snElwR0MAMJ8/XMpnLeFAasRVDZCc
         klrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1Ag7jen73xf6JhLU9Dioa/HXC4JmT/jGoXm25rfRNhhuWF2kmEQW+LkpEXIMt7yXsY8Qs8QpKa7LsxKjSpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWey9Py34H0CPeEyHJLrKyDAtsX9M53Wn8U62OhMLL8+UZ5Hhb
	hXZ8O23sOImdprjugudSqj78DiTs+9rbfh2IHk+gNlC7k8bZIK6viBEP4TQRn9/2cQvI4hLi7RJ
	R3/nshmbKi/Cn/VCVNp8bZVQ3L1Y=
X-Gm-Gg: ASbGncuMOctgFjmTtknPLjT2T4SQQQjIZt372o79Q4JyJJ3DSOIrbo2j7U0QDbhIXxB
	IECfP+JYcjAcSlv2F7qrC+C+Fy7wf9G8d+y8OiAmAFf+T7TrqaZqpW8T91UbUUbDK6P3wh1YXOh
	AcCfhOUCIKrTubO0x4xXqlhlKJ1w==
X-Google-Smtp-Source: AGHT+IHACSIenOhasEqHFqB0qhwwwZceTvLfDIWydkDBDL9+gfCMsdG0jokaPV60p7Uwj4peIoACShvwOWtym3DDkcE=
X-Received: by 2002:a17:907:2d2b:b0:ac1:cceb:d9b0 with SMTP id
 a640c23a62f3a-ac1ccebdc9bmr123131266b.16.1740982856198; Sun, 02 Mar 2025
 22:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
 <202502281143.149423E53@keescook> <87o6yjyqeb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o6yjyqeb.wl-kuninori.morimoto.gx@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Mar 2025 08:20:20 +0200
X-Gm-Features: AQ5f1Jqn4dEVWirmYXrIHwo4bQXH86r7VhPCKu7i7BhJlbkPYndpysbXFR_1cm0
Message-ID: <CAHp75VdX-ZMf-mYrnA=DYszK8KvjVfi0kz30WfHRN_oYOJR_Hw@mail.gmail.com>
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:16=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Kees
>
> Thank you for your feedback
>
> > > I would like to use string_choices helper to cleanup the code, but it=
 missing
> > > some of well used string pair in kernel. This patch-set adds it.
> >
> > Do you have some Coccinelle scripts or other patches that show the use
> > of these helpers? We tend to avoid adding new helpers to the kernel
> > unless there are active uses of them.
>
> I have a lot of patches which uses new helper functions.
> Because it has dependency (add new helper 1st, use it in 2nd), and
> different maintainers (helper patch maintainers vs each driver/framwork
> maintainers), I have posted new helper patch-set 1st (=3D this patch-set)=
.
> After that, I will post 2nd patch-set which uses new helper, like
> new helper patch for v6.15, each driver/framework patch for v6.16, etc.
>
> Because there are a lot of patches which uses new helpers, is it OK to
> indicates some of them (as sample patch) ?

I am not Kees, but my point of view on this is that you may take one
subsystem which, for example, I can review (listed as a Designated
Reviewer or Maintainer in the MAINTAINERS) and add sample patches from
it. It will speed up the process as my tag would suffice. Also you can
add into the cover letter the statistics (how many drivers are
affected (per subsystem/folder) by each of the new helpers in the
upcoming series.

--=20
With Best Regards,
Andy Shevchenko
