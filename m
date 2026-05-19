Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E03F1ABE
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191818; cv=pass; b=qOX+yOjZlH1w8A4JVsyo3tpgFUzj41dVnyfnEWdXYCH+UAMb7DyGKG+rca/TsqZHUwYxkyEcwB6TprrsYK4HpZ8wQOQE/FzoKrXs0rguPRCIu6M/jDT1Wje9G/3NesKUAAX26UW33eojLaoPmdFtgeG0f9ecqCgWVuBZf729Y7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191818; c=relaxed/simple;
	bh=DH/ieVSMHoHYTt2njNhMnvxGVhQGUzeWidaS1VQLFR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlWOnAIwLrxp2pn0sGADDf9wWhlPMXqt4hfCqU5VkM8pWCdtWRP4tvwbR+UA2mcg1xCj+41XP8y1NJZ4uoKV/jMsgzfm6xL4O7yuCh4ffmgtgunBxo1XxpHrM2suVgHWmODT0LRqVQdcEqwnR2DjyHGov4kPtONtHEKeEVJhkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOxN6un8; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOxN6un8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so7656366a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 04:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779191815; cv=none;
        d=google.com; s=arc-20240605;
        b=EO4CspYsZqT6xnhl5R2vR6gVMiCk36ReC2ZHjjqj0QXxzCSKWOFWnKdJ46TUwcPIhO
         FVQci/iVIE8AeNPNAo+uRS76joz1J2rg6jwS12W5JwmQQbyxD30MpskA97n+10hMwW3G
         GTDth6MMveRKXqGDPtUTX9zhTGd2ETBjv6BEN+nliY0jSrVJPS6m16ErhCuvsEsTN8OW
         1Emr/55BsBzXaKm+ndMa38WRh9YEob/V1gIQRefAG3TEYtlGtd/Y9mMY8QfrIt45/HNw
         pTIeZ+X93O1hXYeeLMCl132R9XI7747mK7RAoumOotL48Sxc9MUW4h+7/fsOwX41tqbc
         qv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0g4M9AwC7lGnFpPCL4o4ENFpxhGH1Xct1yAvGUVVEvo=;
        fh=Z4KddhkxZ1S07mjUKDoynBVGgIqLfaBFQPdZ949ReqE=;
        b=NJldH8xEIEoHJJtn1t4DArLY9uJNnzhimNjMZh26W38aJrfefJycOsjJrB7pJBFdN+
         yV98VE9YOXqFBtJYDEAu4OAHUpEBJrEHMb073t0AODiKn3LF4DNpS38vofEkQxS8dC47
         yh9XJBL94qhhN76fhgNExQKCMSEGw3hKdIPIJoHDNt+gXy6HaYLJqjEK839FjT5pviXm
         zpHxoQn88BVl6gOJ3jmr+Zb+3z+RiRp0Pz2+AeMNJcn0VXBiF3kBUgqRYLQY6W9ijVlH
         b3sI96GvLj9J2zJCoeciwKpQ39B05d1XB/3oSrP0s0CG9903LllAJQSoL0SsEktv/4wK
         hHlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191815; x=1779796615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g4M9AwC7lGnFpPCL4o4ENFpxhGH1Xct1yAvGUVVEvo=;
        b=oOxN6un8zkiObyjx6x+b1c/iEe0ffDPutspRT4J/CijuX7nzw2oWje7GAdKtgsQ5tT
         a2iN28toTRwhQlEO1fMY5AxTQl+9y4duNZgGXH3T+gtA3A3g0zaY9lbXkuR/SCLjltA8
         Z29Qw3UJz4UmNdUvA1OJjLvYayUBBvN6xc63n9r8SXFvBI7NnO7+vyPcZxlhYl0gsd2A
         ahLRil5qff4H3Ij/dZD1Vkqo+GmtL8hviZGvzOFaK7rr/Db0dPtxQ0hHSWqxth2EuvC1
         yuOM9QHFjjA324iHXWgC5uPr1/j2Wc7K9oOLqbcchMWPk7nqJeFuuWTfauj3TfQC3/qL
         00zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191815; x=1779796615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0g4M9AwC7lGnFpPCL4o4ENFpxhGH1Xct1yAvGUVVEvo=;
        b=llTEY+5ry0AHKJ/agKrM5MiCkWlEv0slm/PcRyWycfZ6BNXfCvZih2qeKy2ZngXrr9
         aHmlzJMMqU02W/pghuLwS1L4PzbVa8RKrhJynUw9oQfaTfzFUhAP8KcgrcviN986dfYH
         +VyVueH1gJIC1Ete5rreM35GSCKiqdaV+eK1Yj4gv9shj2f6Bzuhzpz/2sFQlK9Q285X
         anM08DQh8tkhsCJ0V1zUcWLIGaCYwa8FQ8rEgky6Z5SnZ6Zrh71YHFZXpKuLe9LcKjai
         HHiBFGcriEDb1GCAarOBGcwf0w0QlpSK5nhrZ2fnxKZRrLjeJ04y09dNqTKeCIiZc1sY
         p3Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/jhXvJ+S0sJxqBCz1enYqAZDuM0W7AH/A33tiD+IxIdkb+G0cz4hURuR/CyC4aFRpvYVHgLKA6Msnl/DhfVRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocnMvmNMxXXNtswr2LW14QkNWMWVxUO07Hfvmz5hMKtXemR2u
	2Q6DvgLU7Vz0NsFtfFMSsaNT0UJfw43wJjsPNhlsHGuESfQlDrX2It3URJ/3EOwyEfdO08pGwud
	ddmPQ5kHlJQebL9zSktrc6ZqoZUbanNM=
X-Gm-Gg: Acq92OEmBTlb2G45Qw5rW2LhkE4wHQ7zFGtG9VpWkJObl4FyqISPggQn9VmsnJINJF4
	1WT/LN6+lXB9SBeCr6nkF5eVu4HTtNicti1oit4/SH0RCOhLUt0YHPLNa4J6E5zoOELK0QisZzx
	EETvYp2vFuOJpNz83xzy4auFNbtvJDZA4GTJW/1kjE6jZni0k3kFcibGFxtJSvJNm6dMF3kfF7/
	9WFt+OQXD6IH2OHJtXZMoRbHJQ2gydXpiByf3FAE6eM/Mbw996gYY2wigr2v8j/h9d0PuX0qUbt
	Fefk+SqJl1d/sZUgCnsSxaA6CBn3qT6k+Xq1IwE5n6dOzh3M3Q==
X-Received: by 2002:a05:6402:26d0:b0:67c:1ed6:2793 with SMTP id
 4fb4d7f45d1cf-683bd19552dmr10302017a12.22.1779191815146; Tue, 19 May 2026
 04:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4> <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
 <177918837114.804096.3977912252785122973.b4-reply@b4>
In-Reply-To: <177918837114.804096.3977912252785122973.b4-reply@b4>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 19 May 2026 13:56:42 +0200
X-Gm-Features: AVHnY4Ix5KXOgZ3E2Av7fgjFxYK1xF4MB2dvKOSFH7WwrtZC8ogQ-bsbWF-pc4g
Message-ID: <CAGudoHGSZOEzbXHOAGqrdp6D06JQQ5Af759TQ+HiQx7=ruQa-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:59=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On 2026-05-19 12:51 +0200, Mateusz Guzik wrote:
> > How about denial of splice usage or degradation to copy are still on
> > the table, but based on a different criterion: whether code involved
> > is "known good" for lack of a better description. iow the kernel would
> > maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
> > does not make the cut.
>
> I had thought about that to but I felt a bit iffy about it. You could
> envision an FOP_* flag for this:
>
>   /* Module may use splice-like apis */
>   #define FOP_MAY_SPLICE          ((__force fop_flags_t)(1 << 8))
>
> But that doesn't address how fundamentally broken vmsplice() for example
> really is and that probably no one should get to use it in its current
> form.

I never looked into the area on Linux, I am willing to take claims of
breakage on face value.

In this context I'm saying the functionality is used in the real world
for performance reasons and just whacking imo does not cut it.

>
> > Common-case usage would have to be audited of course, but this sounds
> > rather actionable and would provide hardening without much friction.
>
> And that's the usual problem where rando module will just raise the
> flag. Maybe that's fine and we will keep up.
>

If this is a genuine worry the whitelist can still be introduced and
managed by one person (Linus?) very easily. The implementation is only
mildly cumbersome to get going and trivial to spread afterwards.

You could have something like this:
struct file_operations funky_ops =3D {
....
};
VFS_FILE_OPS_REGISTER(funky_ops);

This would call into a routine which checks if the ops at hand are
allowed splice support, so sneaking in the flag wont work.

The vfs layer would BUG out if unregistered ops got used on a file.

It would take explicitly malicious action to bypass the mechanism, but
if someone is doing that, they are presumably in position to introduce
vulns in another way.

> > The huge attack surface was always a problematic position to be in,
> > but with the advent lf LLMs any unskilled person can drop a 0day and
> > the position is straight up untenable. In the long run there is no way
> > around blocking access to code by default, way beyond the current
> > splice proposal.
>
> I see this is the "let's become goat-farmers" portion of the message.

I think this is very much salvageable, but action will need to be
taken by a real team (in turn meaning a buy in from a real org). While
one can boast about some mitigations, nothing beats not allowing given
code to run in the first place.

Poor man's initial solution would be to check lsmod and block
everything not currently loaded.

Longer term *something* will need to be implemented to fine-grain
access to code, including stuff shipping in core kernel. There are
some ingredients to do it already (seccomp and the LSM framework,
maybe even some of the currently available modules).

With that and money spent on auditing the stuff everyone has to use
anyway (vm, vfs etc.) overall stability from security standpoint would
be restored -- a 0day dropped against mod_nobody_ever_heard_of will
stop being an emergency.

While I'm just handwaving here and wont taking part in any of it,
restoring stability from security POV is very much doable as far as
engineering goes.
