Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51651369D48
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187903; cv=pass; b=dQyo5XBCb80AxsIo+0vT7dzJJ0oVkWjvL5fQ+D/LYtbCs/PnTsybiYGtH5V4a6mP71dURq2MUFsekwF4PdEUNA1FKm45menYwHN7VLgTVbSeW9ewn/7l4w0E0GfEh9SPSrVSWJQMkcpP4any6qwWDOvsE7ntm4OsAJfuOP8wcFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187903; c=relaxed/simple;
	bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t37no7IWdB23bA0ou8Qyei8QCNklAr6TrbOOYGtB3TWipYVlAq1Bq37J5ZIZEiblOoYP2fXiEWf+ZSeOdpPzjQR3HCCy16fD8sw0lFFLtiyOOlqNwZFlTwPEwQStIxd3yeaq1bwOPyrj5rmsaVYHnfnzbT/D+SoFaKCkddSOjRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNfQG1Cf; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNfQG1Cf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so6217223a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 03:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779187894; cv=none;
        d=google.com; s=arc-20240605;
        b=G/T7baoePunxR4MACTbsZ9wkvfRboaMhqs7X/IFJQbV741yvDxbYpxtRnFh6hvGAbT
         Vm/cdH3BcxZpkXHuiuEHr+2sSvRGP8hyZd1d5TlkWw8TSaJmfISfgorsg+iAXhVKmYUq
         69qrdCmVUZSEsv8Q5c1BCr3jjhw6AkVKAs+QKef8bmSRFwIyI91eSwmPGwy9Z87NVhQr
         dthsp/+vWFfzhblb7++fWqlncAaMG3Gs9quwchU9GT8PmOoEd0voUIDLhMmazvS4Uc1G
         cyTJTndqyieKSOIq8P/EPWnrCgEtRY6punhTUc/p+Xezkkn47xmMpDojagF1TlUe7e92
         pL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        fh=m9VKN9SJLtJqh9ROaVprSBu0CxBmijIXbGXrE0CRhUo=;
        b=J18LIx1tp4SaEJgHK5axQfhXoojtZhDm8HZU5oKEGkAlmruy5FfIMpSVluS57L5YuT
         LRzu7QTfV1b06E3o8nS7lBnaWUq/wfjkm0bRobTq19CBmO8KVuVi+GsWBuBJbDAUDsON
         cpEPDBQphpmmJvJHi3pwA+KTfki3/dMwIg72PJeIctnSAx1TkJroXDUQpXtyrhbBXiMF
         rHf9GuxQxfY5wk6giAA5xC2BK/PbM0QZ892QzZktzJ3MXGBZl1uUZ7x1yE2eeBADFXII
         gytIxrbuC/K3vjU7NmQ1tmu/WRcOYtdh5Oj/4TR3iPMLCCTKKNhx3zkFoSQ7uxlE7BJG
         Em0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779187894; x=1779792694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        b=rNfQG1CfgT5ban+PDibQ/+W7/d6mR2Om21tfqvBf3dm44wDQcKOr7K+QaqoqcDjdBY
         e9j3qEg2ZqJaK6PhuC8CE6+n6UhKkLRgjtJ4On8iAoEFa84vpggEAY758ReZDD1v6+Gp
         JSwCMepiaeIXEZtekUiVZEyMRyj/ad15gWuZRcr/ZM0w+53R7Vf9K3B7S3fS8AvzxNA1
         3ihd7DkiAx6GBRasJU4xyDkbyZx/07aZxowePOC3bfEW3tiT5jFZ8gUU5XnhQvD3agrS
         dcWsVbkxooeKuC8rjufMu+RfVaQBNistzUqQnm5h/7uRermXsVvPpc0+2c38gLfwlWbv
         0O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187894; x=1779792694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D09mIwXGgfWvJMWKI8G3+s17RZoSvUCDdrOthBfqo6s=;
        b=DHDVu1ozwoQupgC0ZJtqbl1zkNB4u726zR3UpM0GvedbqnOQp3n2cqHzOpkVCBcgLu
         8vSXl+HoKkY3mjzhhp38JNXGBQc16jYx7HdR8EozV4pJhIdebFHiT3/DvZym6hQnjRKS
         /URi9OJDiAHbYFxGOCf7FyHLFbsxkCmNQDQ3PLMpP2cX4AQWTfkLgtmAOH6iwPxzjbk0
         FVh/Q6aQUSFS0TZdbtR3M2oJc6F+I4ALzDqriGy+h0oZLpW2cbUphPOAutPCW/suEnb1
         nNL920xgyYTxfb+Sw7UbVxekdeKX3mPfX0arMn9GkmrOTfTseoh9nuA66IMZcjE+DHvl
         bP8g==
X-Forwarded-Encrypted: i=1; AFNElJ8mhr0bz9bX8s2C8vbSw45uCQhsGmTt78k05lNx4unByWdtPrBW7hVTVnSjl6O+kbGok8zZ3eL6W7cn060BeU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOZHip/ZS/fll7d6RKrQAhD38zchgXVDZKdM3PlModyIk8xp3
	lWIim9r4tQxtqcexlZuSp8SjLqjbjHRp/HQE/m/eEwMSg6+JKLpI9gF7C56Umt2dO/Vy/cev/by
	/q+rUGwlfegffsVaEPMyxLNfCa9FMncY=
X-Gm-Gg: Acq92OHhUASCYu8LcRHfRMALYIFIbF3SoIJDnJR7CpYbPNBEemMqFyhQoD/KXNtjVj2
	FIpvVIp+NJe30NPmxy8ni7KQtT6zprX0N5xCIZpxTBG1u2Lafs63U1pKTuyy0mD/iwxJxTER1Zv
	Pzb3Q/G8VYYeWzhn7Ml37HS8nIwxoiGTlZgAdpDwnEvdA3A/z/MWXgwYBdRmE7JeMbIB+bzpVhz
	Ec5tIWtvK2TIGgJfoqz7br2xHKhKjD+bi3ujjfPg7B+HEXXpk6yF9vC9Bedoc1FwpvyscUhBN4g
	siSnDsSmzq2IfMRcweNSmr6T2ZkY9jk+k1DDBg8=
X-Received: by 2002:a05:6402:22e5:b0:67c:1c12:3ee6 with SMTP id
 4fb4d7f45d1cf-6830abcc48fmr7158004a12.5.1779187894290; Tue, 19 May 2026
 03:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com> <177918418452.771415.4371785688744608623.b4-reply@b4>
In-Reply-To: <177918418452.771415.4371785688744608623.b4-reply@b4>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 19 May 2026 12:51:22 +0200
X-Gm-Features: AVHnY4KxwAsZR24cEVgsWChCgk4fjPFWjAc3-R7St5PMsRGg6TL6NPpS0u-UI6M
Message-ID: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:49=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On 2026-05-18 20:59 +0200, Jann Horn wrote:
> > I feel like a sysctl for "disable all the splice-like interfaces and
> > zerocopy TX" would be reasonable to have? Either by blocking such
> > operations, or better, silently downgrading all such operations to
> > normal copies.
>
[..]
> I think blocking isn't going to be useful as it will make it harder for
> distros to turn this on. So we should degrade.
>
[..]
> Let's discuss the other aggressive alternative: Can we try and
> unconditionally degrade to copy. This would affect sendfile(), splice(),
> and vmsplice(). Worst-case we would have to introduce the sysctl
> retroactively.
>

I know at least nginx uses sendfile, but I never benchmarked how much it bu=
ys.

The original patch as proposed filters by rw perms on the file, which
I expect to exclude nginx.

While kernel-internal copy is still going to beat a userspace-based
read/write loop, this is still going to be a hit and I expect people
are going to complain. Afterwards you may end up with tutorials how to
re-enable pre-patch behavior, partially defeating the point.

How about denial of splice usage or degradation to copy are still on
the table, but based on a different criterion: whether code involved
is "known good" for lack of a better description. iow the kernel would
maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
does not make the cut.

Common-case usage would have to be audited of course, but this sounds
rather actionable and would provide hardening without much friction.

I can't stress enough that mucking around splice (even if worthwhile)
is merely addressing the currently popular attack vector and not the
general problem.

The general problem is that the kernel is expected to be able to run
with untrusted unprivileged users, while it avoidably exposes a huge
attack surface. Of course there is no way around providing a bunch of
syscalls to users, so *some* danger will always be there and one has
to expect that even core code has bugs which will be discovered by
LLMs in the coming months. Even then, there is tons of code which is
currently being audited by third parties and which has no use in most
setups. Instead it gets autoloaded in response to an exploit wishing
to take advantage of its bugs.

The huge attack surface was always a problematic position to be in,
but with the advent lf LLMs any unskilled person can drop a 0day and
the position is straight up untenable. In the long run there is no way
around blocking access to code by default, way beyond the current
splice proposal.
