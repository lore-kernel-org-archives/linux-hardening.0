Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B73ACEF4
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125660; cv=pass; b=f+bFJNcp1av29vQ/UOCd8aNkKvXs1JrJ4epsxuM3BaZNz+BH6ugd4HhA5uHkYnjvmAdhEdjDzARVQbbZ3ZDEgJxCa21rup0J1uQIzRrLIy9gjgqAIdyEbAoPEED0DdhJE27Xs/8iiRudkAZ81c2pYGjUrd1s/iBOh4JDLIp/vis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125660; c=relaxed/simple;
	bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghVN/3TT0w+Tsh7w3uBCjKazwufzuWxgYSvPUZlDSbM3TjcerioLysOMHYVEbw6uRRezQiJ/nP9bjUzGW8UAEdc9TRz4ewTK7Lx7m9NTkEoES3exPFB/nnhz0/g3gjnM0a79Ck3uI0JQL3Tk+zPvu52pZ1jVNDKDGHMaKR/U3S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+lg862M; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+lg862M"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec3f69d343so1101849366b.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 14:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125657; cv=none;
        d=google.com; s=arc-20240605;
        b=f2+Ec53wNkqPOufBNugve6sujYfP4oZcJgCvQWCm/hecyq2VrjT1Kdo5z5g9K/m3EB
         PF0fnpFMU+t0Q+2GWGXu5yvEFCG2c6jRwxlYBkIKrO9gQFz7FcIpGxuUgJZ9VqCb8G/b
         +TKXw3gB+yCRJOSNHLRY1fpRMOFlSEYmBiw/AH4r/bqHe1+bch7IccuOjzxAI69PbTnv
         Y/GJhsZuRDJT3Yym7vebRBBXC6gNBS0BibTEhppceRmZNfdhQmz3/1bVvQ3c2SO+GWNM
         M6e/HPf60j0a4XG4kDrpk/biGsA4mTA50KPflKpAGEL9CWaYnlSvsaD2EtJvTYYFAvtV
         q46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        fh=NXoCqp00LFIKbMf9m3v0pScQxL7V70g/M+Gid0rdCs8=;
        b=g7T7XKxe+Z+K3f5llv4KKF07CdmWaHFKwCYHLIOGrUPoj3rNEiuaVeQeBQgvy88ZAE
         IB/hd+akMNDpVK83Mobs6HbY2nmXUyiCRYHwdWwsWgwxSGz3FvJs/5tJE+MGegZKsZDZ
         HtJS3U1vSIuviN1ThUnaqrvUW1exb+osGsU3qU89ZtJXukQYROaVc7LDBWETkcZgosud
         1YZp6VDz87aaOx8OO5R88PqqK46j+KCvrEyTnknGMiIN6Y5s6MMnAO2CwuxbJbCmZoPA
         x5ozv1VKtj4q2DQe34lI0gyAKnmy6ajvlHh4sKQVk81yeckV8lKYzLt+p9e19bWnVdaS
         YMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125657; x=1781730457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        b=S+lg862MLGLRUnxuNN1YE2H6+AG87TCJiBkG0EKCPCOEzQ6PgRWGYFaEsQZz33fF1F
         MHG0cCbifm+kSG85kNkS27sOSZ7Er/Sq+uHbScP8rJQvYVarAnZaO0DRCqLNgqiaQSfG
         7gMdIKEcfM633FtgupZbB2I5dyraYzSNx2/J7yg5uQ1fgYAV+D3FCcLZ++mJKT3UcU88
         y4RNqFRYRFAZleZHvehZMTupSzkr0hbJLcqF4Nx17B5VKQs48L5R/sOjHyuIEaNah12t
         2hYfJi7jpvvLzTUPaycx9GSai/RB8Rn5fwU+wunZkK+NPw4JEtV8FVkjoCADNbXHIQSM
         kaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125657; x=1781730457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        b=F1R1spsxghMZQ0Fk/lren6d0RAehj+ie4un/R8Hg6V5FaMoKqZFzcWGNCof6x58/3T
         cYvIo7bYOvQFKJCI6hX1JQdpuTP4wHuWtipCAh4xb0PJb4YuIMTsa+1FhzrkqI8KXulp
         4+qvNStiZDFRkbqSFMl1L8+F5vwVeTANBl0HPA6gQzJ8QID83g9NGHQ++YtMFYvitPHQ
         QY0SCddju4yB65Q2/5vJANiRCvtw4ZSSFFvq9/twR98iGHxH9Xk/B/v22B58sWNaeD0C
         c8So7go98qWOOz4MWzMMYg1VthcLfVJ0VywVH0NK4bTSsS6o9a49KuPeYf801nAixGAD
         t8zg==
X-Forwarded-Encrypted: i=1; AFNElJ87XkjBIpNgirMx+XxUyML+Rn4EdRIGsUqsajOvspMTef3KllxgVzwZ7GIVhTjB8qjWAYY6mIkJu+0fT4wQrSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3e6O6BL3+PACqszHGRgxtU+y3J4dWP6+ZnYJgZjLrbFiTXfe
	MdIjzlHJTpryev5PgUSdaJMjHD5dJiqYNnwcGRZbRzbabfbs+Se+a9Jev2aBcPrwTciI0fijWFr
	41PQKLqgcZa2eiUtvLmOnIELDotdYSg==
X-Gm-Gg: Acq92OHexyu6QmVz8vpKcjq5oDTrMY08KG7Q3qfCLgbWALuDXrkRcC10xZ2IQkDmUOd
	hzuNYUgYFMsbgQqWeAwQk0FKRNSBAYbtIBOQ6hHJIw3X45M9D3mZIQ7SFgWmuPj6ullAZS9zrf5
	pI6xgIePRYJb/QRjomE7V2ZcTpcEX8w6yz3TsD4l+bIRzap3LoRT4QaStV70WA240HY9tA/YGn6
	2uo11v+cIGjuHtJBWNvcQy09l3BonPTte3t+5dm4bXV2KG7Vzd0ZgTj2fQIve01VPIZwTO7eLMi
	3b8q+wR/6cf0hMzHWCFDMCJGDJn1UopJ2HM2bAJF1yi9dqBZcFehYfqmcVzR4QZ9mDDI6nIGXSL
	KA/H7n6pT/lHYr8A/hVdNV7hmt49H
X-Received: by 2002:a17:907:2d0d:b0:bce:a1fc:6877 with SMTP id
 a640c23a62f3a-bf37234ac00mr1411412666b.24.1781125656562; Wed, 10 Jun 2026
 14:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606142558.13809-1-med08elkadiri@gmail.com> <202606101345.D1BDA8BBE2@keescook>
In-Reply-To: <202606101345.D1BDA8BBE2@keescook>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Wed, 10 Jun 2026 22:07:24 +0100
X-Gm-Features: AVVi8CexcpNUkSZoUjoSlVmZRkJORhumHl_-Zdg3yMbOvv_FzO0i0GVcjft9kEM
Message-ID: <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Thanks for the review!
Following Vlastimil and Jarkko's feedback on the key_jar patch, should
I send a v2 here as well with similar commit message modification:
removing CVE references, dropping the skbuff comparison, and framing
it as hardening?

Thanks,
Mohammed

On Wed, Jun 10, 2026 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> > The cred_jar slab cache holds struct cred objects, which contain
> > process credentials: uid, gid, euid, egid, and capability sets.
> > Overwriting any of these fields is sufficient for privilege escalation.
> >
> > On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
> > in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> > slab pages (object_size=3D184, objs_per_slab=3D42).
> >
> > Cross-cache heap exploitation relies on slab cache merging to achieve
> > type confusion between unrelated kernel objects. CVE-2022-29582
> > demonstrates this technique: an io_uring use-after-free is leveraged
> > across cache boundaries through page-level reallocation, ultimately
> > achieving root. struct cred is a primary target in this class of
> > attacks due to the direct privilege escalation that results from
> > corrupting any of its identity or capability fields.
> >
> > Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> > so that freed credential slots can only be reallocated as struct cred
> > objects. The memory overhead is minimal: one struct cred exists per
> > task, and with 42 objects per slab page, the cost of dedicated pages
> > is negligible. There is zero performance impact on the allocation
> > hot path.
> >
> > This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> > and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
> > isolation requirements.
> >
> > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
>
> Yes please. :)
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> --
> Kees Cook
