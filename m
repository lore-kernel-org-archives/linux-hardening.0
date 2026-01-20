Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC65451079
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934747; cv=none; b=MgCWNVWHJoo/eFPodZAE6hPqqsb8PPg4ir5dc/r2UY/G6F5Ww6t+IweJaLc6wjromSA6VM6LeqR9jGUKccPsk5akvIyhMugUG/OQBmAg/aZgt76DlxiiSdNMylHBYgmMw0qur6TtU3EMjTsNEBDU9vZczNYvx1q9X5vhPTn6zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934747; c=relaxed/simple;
	bh=yDbiboXvrRh+ivSKcybv8FalD/6w3BtuEBLuaJUmJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTvujJSHhWUJVf8TdCs1/DsQ7b+RJLBA0ULOsGKruw/a9wSisior0qMoe+/96wuZhtAvWB6ywEZajgw0QxgiztBISPhEEEkF8qgVGmrV/ceAP8VBGpTUlYvr7OdmzR+Hh0mqShGPbJixHgPxV/7ft8A6y5MtK8H2bsa2U3cLstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV/ELTjQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV/ELTjQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43246af170aso79254f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934743; x=1769539543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thnE7Lerq2YAOWgwctI0eLWWpc+gSu6vXOqPs3mAkT8=;
        b=AV/ELTjQ1q2kuPpOal2LcflAh8YWQ0n/W6YBPlugIgwvsrq2Sn8td5EZTtyGf5LG5Z
         aE2A6UTUU2ExQB22aU73V+hJay8yMrTXF+a0y9kTl7rSaNzpOzepQ0O5ABciIIfNSIFA
         rSLVpZj60j94NG/XkcXTJuyQsq6VOD4Z9rRIHGrpw+kVFqax/WWLO/EyuruEsHu/To+U
         Ii+iwTzt1DGIfytCSvXKGvBt/4GsvDQOoeGTJnl4Pz9fVaJ8uKAG5D05pNt366oYAmdu
         tOyQAx6bR1z6iiWHbPw2ZsIfBlBAlys69iWGylIk8e4ToINaSrZW7B5OyKM+Se+/6FH6
         523A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934743; x=1769539543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thnE7Lerq2YAOWgwctI0eLWWpc+gSu6vXOqPs3mAkT8=;
        b=DcQppw5bLTz2QQD+60yjwzb0T1ADMaLLgOdpDuY6bJseZ2MX8hzPBD2L9xzj0sd6Qx
         uewoTSHK/tWOk9cUa4dSci1VBA5wIDdzwh15rXa7EwQLQzkREEUB8lFoDUBqYSvLxR6Z
         sZOJm6Jg4w1XRq8OkefWVQAcYZ39bbwt087n3p9wyULw9WDKTMjqpQkQOXtlKrPkEynx
         gBHk61CDshDU8TPxBpUK0MUr2y00gpvv9DKcsNfcekf38+qrb2PJpgY94OKWG1hzCwgL
         NHchXZTf4tLb5VisSLUECDooL8JZ8qdZzsBJHHhTV7ZKuNiiPuZMc042te1JWGjpxoGq
         MKdg==
X-Forwarded-Encrypted: i=1; AJvYcCW89ja9fdCiO3/Oc2ZPbUKpy6ipiGUdSLXzFpA9JboSznXr96t/34a1g+IhEFWp5A3yD3xFjby3mgt9cmx2YH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6NJHWiW2daEqg8AxfWJkGW8jPgAO6hia62ckgqIiDOkKx5y8
	fAYp4fEJMyYwKxk3si8mMtozr4bdmblZ5wIcQjiMsoZHQDQJufESBQGq
X-Gm-Gg: AZuq6aLaclR7l52kC9/q8GxRwVMtJeTcCA71jh8xAZL/8E6PPHhV+ccRL0GNzV43PBV
	HTVZU4G057gTCNWbaY9fHFqFBapvbCvobNB0zRibz1hVvamxqPIURTfJ79EQly+EI/H8WUMq1yB
	Okv9N5hIK64oprTizXSxuL9JjGmhLp5qLDBjN1lqwTesInnteZpAV5tithpe9S8zRG6l/1nLXMT
	rbayY9cFgNbPcHHQTLm4LWAOX4kdEUI3TZJ+hfJQBXz0CMvLvDO3VPsV5LlmRLCnREsvA/quzzF
	tAMO3/udtMLPDq0VC6ns5Gcp8gki8L6mKPE9LEFPF+kzc6Yy6KsIke6zQ/hGTVrdrKKraIK0tce
	RretHaOuy5ijTCN3uqchu3B0IyQ9VWjKvCAVu1IyEIOu7hVQIy/T0peY3hzna7ned9Y0OBwgYP8
	hXKRUOOnXfJMOIpmYICw4DTvZqa+J0Rc8H4Yq2/p/glCFobPdmSvqO
X-Received: by 2002:a05:6000:2484:b0:430:fcbc:dc4a with SMTP id ffacd0b85a97d-434d75c16c1mr25592154f8f.19.1768934743113;
        Tue, 20 Jan 2026 10:45:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm30869735f8f.35.2026.01.20.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:45:42 -0800 (PST)
Date: Tue, 20 Jan 2026 18:45:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard
 Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix bugs and performance of kstack offset
 randomisation
Message-ID: <20260120184541.0a463cd1@pumpkin>
In-Reply-To: <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
	<20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
	<C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
	<785a7d90-babe-43af-93a6-c220c1877bcf@arm.com>
	<a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 08:37:43 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 1/20/26 08:32, Ryan Roberts wrote:
> > I don't think this question was really addressed to me, but I'll give m=
y opinion
> > anyway; I agree it's pretty binary - it will either work or it will exp=
lode.
> > I've tested on arm64 and x86_64 so I have high confidence that it works=
. If you
> > get it into -next ASAP it has 3 weeks to soak before the merge window o=
pens
> > right? (Linus said he would do an -rc8 this cycle). That feels like eno=
ugh time
> > to me. But it's your tree =F0=9F=98=89 =20
>=20
> First of all, thank you for testing it on x86! Having that one data
> point where it helped performance is super valuable.
>=20
> I'm more worried that it's going to regress performance somewhere and
> then it's going to be a pain to back out. I'm not super worried about
> functional regressions.

Unlikely, on x86 the 'rdtsc' is ~20 clocks on Intel cpu and even slower
on amd (according to Agner).
(That is serialised against another rdtsc rather than other instructions.)
Whereas the four TAUSWORTHE() are independent so can execute in parallel.
IIRC each is a memory read and 5 ALU instructions - not much at all.
The slow bit will be the cache miss on the per-cpu data.
You lose a clock at the end because gcc will compile the a | b | c | d
as (((a | b) | c) | d) not ((a | b) | (c | d)).

I think someone reported the 'new' version being faster on x86,
that might be why.

	David
