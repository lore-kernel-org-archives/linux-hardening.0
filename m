Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391440961E
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208139; cv=pass; b=oq0J/sEnkqqV1S91D2Hsl9u7AZV9q4M8fCiQPzA2qD86Mn29cLD0LceFV717/Rilcgi2EKH263fl5DVdd7/KV//gpIECX9f34zyp5bHnIvkM6pifDBk4QeBf8hqXVDo4Bh1med1H9lfJkWqR389J3SOaWFpiXcgAALVZZpEUxGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208139; c=relaxed/simple;
	bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5UAoITihzWUv3wGJZKaXs0xBy1afNIDqWcCRX/9VKgY3nngX8JPpKXNoWX5hNKD+bUPfOyJMo7OViGh6P9sZlYpc6FQoE0ijLICbdUEfFhjNIk2BGnNHxmQXJoDE+I8DdZiUxLj52SIJZaN4++YkxTCjaGxrGjK3bvD55klbtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ6s1aDR; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ6s1aDR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso477a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 09:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779208136; cv=none;
        d=google.com; s=arc-20240605;
        b=In5b+jBfLKm2CvDcmpIRrofzeJa6FnOYPn3Sz3zmt1fKjMfVO7oE1KD7ubrhVlvr+v
         IBnOLwfsVi5FLUKndr/h5jNv/3JZfXaPqVtHh9U+azRud6WMiJSkOxtL/Of1B1AodmE1
         eYVktl71cse73Mxt0dFEiRomwqIH2JPbLJGGksoKvoUgQfVsWXBpg5Hff4/pArNLc94p
         pmpI8aMl9yzJh+WFHg/EYMIIWw5brZ056SGVVaPGDuoPH7kJlrvY0ZQOIUEbjaka/nUG
         3T4paSrJU1UoDI8ZpVeIArcvR1Jneyy7ZN7zfsAsZarGItgIpefe2UrDjA8dWPods6nT
         5s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        fh=tQfzgkBQmYkaFhiyStHsJGPMS6r0mRkjHyIGUL70hdU=;
        b=DhnheVv3//3KgcBfGtb4Vghe6PZHru90a0+Rsa/pDe/s8KB+FFcVY3XJwTqIBwCXtv
         j9JaAJe2shbrD9ZtwtfFfllS257S5v7UakuEdrSztDL7XjTLsUtbOOH7i1GpFhofClLs
         j7Ds5kvOgKfj6JLdnZvMj11nmhRTK0e4uo/Yef3blTPNd7ymi0eny46R13ZRs0aBeOTI
         N8nSVd/gbAZFlKWBad5iT6g5mzeaj35hEjoTbJXN4X0+GK6TbWWgYgsFclsNV1Agz9Hf
         iZd48kII799LRdWTLuVtLyXlAeiMu3nT34e6A+8oVM/mqQ1e2zWYL50LnIClnnKpOxR9
         t86A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779208136; x=1779812936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        b=YJ6s1aDRD6a0PChTjnEP5x/EkLSMoTLVNwujSt6rF2+ZhN9h6DRSRai+946Td+GI2G
         NkeTBhseY5Z9OaFZrgMk+WoaKD1a+t9IiB4vFUkoHaymTeBBA4aTaV39WAC+TWotvT5Y
         s2Z9ez87T3Q0SzRduyxnCL31WZLhXZprdvI6P/GePNgH8mZlJZKb9B5fkJsxymZkQdb9
         LOYhbn0WZ0YnUyl4iqE8sDAUP1KVCGNuNKvEQ17D93JL8R92V0AWP/YFF7TCWDcXGwQJ
         D0oTn71c9Tzh8qtsklcW40tG+qBE5pOPy950ESdz1ibiEQ0NtcZf3UzHCHwXuqbt87O2
         RUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779208136; x=1779812936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        b=Ox6yGvAs6CBb2Pfjc6YXcO7lts2qBdolse4a8lch7tEL7W98LgiNRm7sGWgJAFkL/P
         jW9WeUzP409fso9OqvG9e6dU2IUQ0gDbto3A0Cw+NZaIAl2jHvySUeqTZV4PiCV0R6kV
         cjH+dPcCdflYNsW4HGTVtEQDkpUixX5boxO5jo4onvrWmJ8Kn9W9SnF0HBjKG+8hxh3p
         ks/jcWXoZUx2FrOoyPDSxnBuqTUcFheOmh0AyoV0FgcUzjPU9GE/WnYjJJfDjOovEE83
         /wYnqf4uz9CUMnx0ZpMW9WhVEPj8V8XVKmoQJ45ixVRMTGmiNPK3CWPV9+DkU3lBDFzs
         1/Mg==
X-Forwarded-Encrypted: i=1; AFNElJ+OxauoY3LobuWUIorXWTf4VhGKrsti0P5Hcw8afZ2XvkV2ogLVqUF9cxkzKllv8BkawCNtfu4aK1lCuo62VeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbzVsERz1xAVnwbUcpYwUYzxbE4ZZFroNCUxmQXcJaP32ALYc
	3BHA/R3bhV9tEBKjRSMn9pkLFXOU1UuJVLOCHCv61YKwiVxP5q6tm0BTfCiUUIVVye9Kd+cLkmw
	buYOogboYOJ/OoJfH/c21u4SKnmN6JqUF/4VBcyOq
X-Gm-Gg: Acq92OHPSHFE2hzNyo/TPyRpb6tMp6u76x2vY/A3UiLh2f2eV9RyHqgKohKKvI6mTIR
	vuTnkQ0Jf9VmJlYWbMoiYXx0ABwjtUyGFQRVH/q3c0SEIwukcCMASv8VU22yMyX0iBwEn0+GLfa
	4WKaHkB8VQGHPFbRuk2ZnSlSxaNkZugJmfZPYx94xCcPMFisuUx3CVd/Fy+DL3IqLTbt9BZg5We
	H4eBO1H74dPnvKVv6NP5hZsA17rNW/xrYrR0D+dzf3wcQNVy/QVd8D2mGIrLChs+gleRFEeOC40
	la+S6TcPiHGNZzkFWkz7Sxw8C1hByb5nX7U9LX6lUvBagu2w
X-Received: by 2002:a05:6402:a143:b0:67b:8283:6240 with SMTP id
 4fb4d7f45d1cf-684986edae8mr162870a12.7.1779208135980; Tue, 19 May 2026
 09:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4> <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
In-Reply-To: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 18:28:18 +0200
X-Gm-Features: AVHnY4KItrX90sdPIrOiWL_DdFaddul15rGgYiuLpLDe6wZbCoeUuSPEm4x5pzQ
Message-ID: <CAG48ez03iWJteZiUvRe6o6_O9N_G4BYwgBBvAXF2QOJvXkKELQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:51=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> I can't stress enough that mucking around splice (even if worthwhile)
> is merely addressing the currently popular attack vector and not the
> general problem.
[...]
> The huge attack surface was always a problematic position to be in,
> but with the advent lf LLMs any unskilled person can drop a 0day and
> the position is straight up untenable. In the long run there is no way
> around blocking access to code by default, way beyond the current
> splice proposal.

Sure - but the path to that is putting restrictions on the
availability of individual kernel features, and this proposal is one
step toward that.

These splice/vmsplice functions have been part of security bugs in the
past, and have contributed to making other security bugs easier to
exploit too. I think it's a sufficiently big problem area to warrant a
disable toggle, especially since this is more or less just a
performance optimization that we should be able to nerf without
outright breaking anything.
