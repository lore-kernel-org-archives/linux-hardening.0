Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1703FB7E7
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369886; cv=pass; b=XdCH3tSdUXgOJk8hUljGGPTMMs8HWZc4/LxrjrlUGO9i8R6JJ8KgxK63wpxvWOSPXThCOCOn5r0S/ykxK1Exp8X5wxKwSPFjnfgCe+0KpgKcDxcBpyEVAPzS9bYMJzVdNmL5O7CM8OSr+PpC3w2rJPhms0rQ7lH3UwscbWAb0ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369886; c=relaxed/simple;
	bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSLOi8idaj5AZ9JEK1meURh/X5OUB5b7txnja+fdgsVmVb1OM0rr/JrLETo3sEspR62acm50fO2gGU/Yi4PfViHk75Hlz/pzfanYRMPQFu37vqKlIyb2Dg1P1wO90cp1Cdd9j6EJlrTQ7ptcMzD9eD/zJVDQR1kblDLRWvX4y6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9I+NXn3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9I+NXn3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so2194795a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 09:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369883; cv=none;
        d=google.com; s=arc-20240605;
        b=kUJ0BjMWrm5NE57sFLD14hG7qMk+i5OURJ9xNbG+ZYvwtJ2OwZOHaMH4i5sy+DkM8L
         ST3yjcT0jhzhYYrc4WoT4vH/YN6CO/DKXeRE6nxDj3agEmrZtdyLL8X2OtwSumxsNaHc
         CWNzE615xeZfZgSTYt0PMPYo4yunVjYbLCbqFjPv8KGJSTqA+r5aEqWly9F+/tLyxp9K
         L6O3YtM1NYHp6VjtL9ATzrOeu6178uTEjkEUZRaPyfBBjx2XHYf/A/vKe1Ts5Gb+5IvX
         +7mK9pb55eAO/OtueVkDmjo7AhSOTIUgkdnJw2+0zgWw26iRcxDxmlO1YnfX3nblv8gU
         6/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        fh=0CJgUgt/N4gG51T9n9SKXCSLAcp5omMtJJRem8ZNuok=;
        b=JvN6wTk0rImkib+r3Bh0JEzd/8IiXzCgvMLU323HmtmkesTIBRDFKFEXyaN0Lzoc6J
         bDNcv1hYA7dXa/0HtO7/Im623K4jt7sY40ZS16HEuyl6X2cfg5A0NifjWSjbontsEJ25
         J6SMQzBYxGpx/xPgk9TF/cKM6uOZF5dIfPFfOHnuVox+MFqmEkHxVqInUNvZxVv8xDuA
         TUOzIOWt1HZkG+Djdi0bFKR71zNls5o/T1mlVtEtoQd+hoAKfRYvkH4HOLb0xskpMov1
         svqctLN2z583CcLmueeSmZY3Ds9j1fHFhQ8jU0CK8ejSPTRRkqTh+nDk8msEi3P0puOm
         y7hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369883; x=1774974683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        b=e9I+NXn3WNy3Bt4ayYOmjMCjBHnS1Xef1WJaaEGJYHlgjykZX6g2vOzLTLXLLWGPlU
         mzmW3UYBo9E1sJn+PerP3zfMn0ajAEXTLHpV+DJd0PmeCGtUxKc+R9UoKp6B/eqARP9r
         9JdJm2y9S/GwguZtE2PP/0bQafXEkwDdG6rwokSluZvOeaJij9QxJkSmqF0OfebcAokW
         MvRv6jYhbf0CfswXpre7iJvjwDWtm/CYyOg0MOtyVsN+K39a7m0Cq2lMHvQhlA5wb5EW
         MrmQnCv35z6I8EGGKI2WfSEvcRE1igQeDlW6747oJ2Qlv6TRwLLZgmvxEqMiIf28h89H
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369883; x=1774974683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        b=mn7+qNnB4bQ7s5ioS96XkgXRqwmuPP/gMMG329B9TJYOqeU/DzmJK9Jd88GvCxpMBv
         0KOgHgw5W8hs/mnG3UQdfo94FxoOX0f+QpjHsVT7PC/k4tVmsPhL6gBqJSD0YBVi0+wc
         bcbM2fVjbxrhy2hviVzL8z4osIiGmUYEZjSll1hrt/tpMdSQW1CXhm7cR4mK4nQ+6MfB
         vTObkQbhYNtcPXv2Q0CjQB+tw0V1DmmwBi2s+6XQydZA0lnVBFRS9lOBhyQDJ2XrMLHv
         Hebx54sOqu/arBZs2R9+sY8Fje62hIViG1pULtMbKTVV/zzI7oZAqaxcUkGf1NXteQw+
         AeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkrhHOpH8+x5jmP8mC9gPcAMrFZZXOziy+u+czJMnL5pmJ0OzuaOgIGrJAv0rJWd9wNhafE+GQaVQr/G3KZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoao0KX0PVOjmtZ2Tjr26e7xCeFjNdLfqDF0QYpuRu1hjzrIE
	LXO5f/EdcLSkwPHFvgjLKT8aBGVs0r17xWoBmbxuvWjeznrz755JxSKOSrWg8i9yMFvAT7pmwB4
	VtZhBDS5xl0MKUgh4ui0Z/XBoFwsfZe0=
X-Gm-Gg: ATEYQzzBpPud3lfwxmmzzU0CguebKjOLYZmHQbozpbno2jzhEHlBm0vPCKCRsgpJ/WW
	1s5ZhpSygJfW5KZuGpQPz8ueIA5s7ip8/Twe0dcaiy3xjqrTRBR//fhbZeRLDR4luMwJEDuJWP4
	O7E872m+xxLQ0pgsqDWhx3YGlO/1tYfhzQdjxxMWc8ITQx3HdvDYA1SHAi1KiezKh+Szlji64Ss
	b+jE/mFutxEeDA3IVQ+uOuwTRgSLQudNNrJpKXFvgVJNyprcRWNvoxvq/B/gdR0AVd8OiBRLtNC
	9Y8m1WHxEhFDcfoBqzLf0GNh3QJGT1O7rqry+tX+ZB4V7EsW8n7YGHaEnywHWk/BE6mqOgimCmu
	1ja3oN6ktGey8+5ZuQoewbiWKWQ==
X-Received: by 2002:a17:907:3d04:b0:b97:dc00:fbc5 with SMTP id
 a640c23a62f3a-b9a54240a7cmr3046666b.36.1774369883169; Tue, 24 Mar 2026
 09:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org> <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
 <202603240919.D248D71B48@keescook>
In-Reply-To: <202603240919.D248D71B48@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:31:09 -0700
X-Gm-Features: AQROBzASv0QmnTOBiLnFwggIWYp4faS2JWWpkEK-CmA9ksB48jHotIISoc63fGQ
Message-ID: <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:23=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 24, 2026 at 08:38:48AM -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 24, 2026 at 8:28=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > >
> > >
> > > On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei.starovoi=
tov@gmail.com> wrote:
> > > >On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org>=
 wrote:
> > > >>
> > > >> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > > >> > While the original strncpy() would have copied a full 16 bytes f=
rom an
> > > >> > overlong name (producing an unterminated field that the syscall =
rejects),
> > > >> > but this wasn't a reachable state. This replacement will instead=
 always
> > > >> > truncate to 15 bytes and keeps the NUL terminator, which should =
have no
> > > >> > behavioral changes with the present code and avoids potential is=
sues
> > > >> > with future over-long string literals.
> > > >>
> > > >> Hm, I got a failure report, but it *seems* unrelated? But nothing =
else
> > > >> fails that way recently, so I will try a v2 with the "unterminated=
 at 16
> > > >> bytes" behavior restored and see if it passes...
> > > >>
> > > >> test_progs_no_alu32-x86_64-llvm-21:
> > > >> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job=
/68300440546
> > > >
> > > >Don't fix what is not broken.
> > >
> > > strncpy is broken. ;) This is one of the 6 remaining uses of strncpy =
in the kernel. But it needs a v3. I'll add explicit rejection of over-long =
strings and validate that the bpf test was a flake, as suggested in the oth=
er reply.
> >
> > Don't. it's not a kernel.
>
> This is a very terse reply, so I'm not sure what you're trying to tell
> me.
>
> Do you mean to say that this header is not used by the Linux kernel
> build? If so, that's a misunderstanding. I found this case due to 0day
> complaining about it after I removed the kernel's strncpy implementations=
:
> https://lore.kernel.org/all/202603240325.rd8gRV6s-lkp@intel.com/
> https://lore.kernel.org/all/202603241330.vmNnBWvZ-lkp@intel.com/

skel_internal.h is dual purpose.
In that case it's used by "kernel light skeleton".
but mainly used by "user space light skeleton".
I guess it's a grey line whether it can be considered kernel or not.

> (I had originally ignored tools/ since normally the files there are not
> included in kernel builds, but this didn't seem to be the case for this
> BPF header.)

And please keep ignoring it.
It's not broken. Don't fix it.
