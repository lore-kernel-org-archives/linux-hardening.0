Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E86021B9F6
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220861; cv=none; b=IMy3oHYR7vhJtnwxxE4qOPydngTXDvaE1tTgBIuXQWJM1RQhCJphp/pNpLUqpi1Z1vK4axyxaN6hgrPNzoGvkNz9rjrCD/G7ph70JnDi6C0mfULUdhNzWtxmtCJ0xmpGDjYqXz1n2volmjwtZe2lmAioLHpEZ4zgFSZ1q0tDqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220861; c=relaxed/simple;
	bh=vItDLPSXbtLWvRm2HNEjajmnGBt24BUC2sxvClu18CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXnqrqPvLMehRdDfvwObpHC2Z70Ge09h3DGhAWu1IVWzf1zMjcv2LZ+SDjrQmGvVrDaZici43BKccxoNdFyS+GXKNVGO2fLy1TP8zp7TOxHUiYvlE5eDKMYhxCu6DIiGYthziXUyPQGCN/dYYPW98+lXkE9Gi545GCsOiGvulwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpl57u1x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpl57u1x"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so2220005a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758220858; x=1758825658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8n7n0vK60RWuyiV5DVvk1iT/Ju170VtB0YanhEI2MxA=;
        b=Gpl57u1x8k6+SH8G56rCgQlJz49jEJu6i0YO5X7sWlmF37kWTcS4R2kfaRGfQ5LMSD
         vwAD9832XiTTDUD2qLL1mSNgq90Bpa7+P1x+tlXnHw7BsRzMrpAQJ08WwKWUvNpqIn5A
         K4ibYEiFciyazHxCq6Z8wK/N1jAe75wJB5fL2ZGVqMsF8Irk5PmYVd5QbavS4ZLrUvLe
         isQMOof/JhRqpgenhcQvZPS48/v2ucyWey3p987wih/IW1FEcg+sTiuRwT8H8vigUYTE
         E4dKAPpbbD8Sn6kL9PPvgwESs8O3lVUgUHafIDUEuWWkE2Bm08yPQ3opaRDR3ecL5guS
         ng5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758220858; x=1758825658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n7n0vK60RWuyiV5DVvk1iT/Ju170VtB0YanhEI2MxA=;
        b=adL0ouryUcqPhr/EpNcZeNCmUYXL0Mh8nNrspBq+Ueq4OWdoLZ9RzRNUcGL+VDbSWU
         Ecx5lzxhCYCvFM9Me5G597kYk6fWTRTRT3Pl8ZbVW8J6/Ahg6h3efxkbk8heyE2lJOd+
         QK1wiEkmX0vE9oe3S6mbBQQ4DT2J1xndOeBP1fyG9BrM6TOjsDpPN5gCIzx7IjVhBEoJ
         4GW1nVWYeOMPg6jGT3vsIQRVULNhEfCXIZ9Ir9imUvEemvsVUdOHIn1fZWeeaWgcfvEn
         BKHG6VGxmsoqXdnAYi/ozzg/v4idTCy/P0+2mD/JtFur4wy2KJY3a9shfjPQN3KO2ENY
         QZuw==
X-Forwarded-Encrypted: i=1; AJvYcCWpzJiyCKRrt0crI8/ivCBClfld5xPKLmYqutMdHOuRd0GC+05qLBDIfy1LTf1UFf6YL3mdrLK3+ZjTHQ7IAjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfwiXe8h8kwA73go1AW2qzyc1ftzk+t75G67TCPYxnbfDa1Ea
	fc2nHxNHrQO6GSUgIAsFZyd2L4BYXRPkqv5hECYOpu0elAElA6gUFTn8
X-Gm-Gg: ASbGncuViVy4nfdtTwJf3KfgdWhBYHV6TxIYTJJCj7yluc9ImJnCsVJnTj4uCyiKJLC
	AdIMBO0YtRdKAoBN2Xonehy5qJ5ogyy+dE5oH+El5Kq5AjOQCoHPkQ+JCJMtbfMB9pFhHI3rvoR
	5cip4/5H/7+hgN/zSz9VLZEmnMyl1wGbs8cEboLIkiBlNUhNYwS1U3wvOedqwLaZHIHfdbxumoJ
	Kne/mt2eLcL80cWsAVViz+5PlVlw9G8VsOPz8WHlhoRd/eS0Dwm0vRyn/JgSvxCbm47C25orOp5
	nuKUF4IphdhDvyHM6OiiRsQ/qEssF3cfPYlCNCgdCzoztDBdfmMfkJjMbCKIjuYpKgtQO2zFAXw
	Y6IOAj6+ccvq3FPRO1ANpJantDkvZ4iqLqB+SeY2MdeAH0d9EnR12mj7X+u1cPaWa7bY78ySTg7
	tcYpreEeHxjGPLInp5vk9u8E0ICf8/kAm+Ow0ImdHAZocIPlCBxDfTHee0lMYInHcj4kzbthGHU
	BKfi/r6iKznlyEm7rXz/RbWb6BqFom+R06dTF4bX4u9taRO1Q==
X-Google-Smtp-Source: AGHT+IHg9ECEZuNbPi88DaBWBUe5ZnJphJSZLCLm7Je1dDPz7Z4rVLrI36loXiRv1DIZyVoiFhL6bw==
X-Received: by 2002:a05:6402:3107:b0:62f:620a:6a17 with SMTP id 4fb4d7f45d1cf-62fc0abf0d2mr192440a12.26.1758220858028;
        Thu, 18 Sep 2025 11:40:58 -0700 (PDT)
Received: from 2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at (2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at. [2a02:8388:e6bb:e300:2ae5:f1e1:5796:cbba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d196f2sm1867408a12.13.2025.09.18.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:40:57 -0700 (PDT)
Message-ID: <a1c086540742c8adb0ce35246d68e01629d7e93c.camel@gmail.com>
Subject: Re: [PATCH v3 1/7] typeinfo: Introduce KCFI typeinfo mangling API
From: Martin Uecker <ma.uecker@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Richard Biener <rguenther@suse.de>,
 Joseph Myers <josmyers@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
 Jan Hubicka <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>, 
 Richard Sandiford <richard.sandiford@arm.com>, Marcus Shawcroft
 <marcus.shawcroft@arm.com>, Kyrylo Tkachov	 <kyrylo.tkachov@arm.com>, Kito
 Cheng <kito.cheng@gmail.com>, Palmer Dabbelt	 <palmer@dabbelt.com>, Andrew
 Waterman <andrew@sifive.com>, Jim Wilson	 <jim.wilson.gcc@gmail.com>, Dan
 Li <ashimida.1990@gmail.com>, Sami Tolvanen	 <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira	
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>, Bill
 Wendling	 <morbo@google.com>, "gcc-patches@gcc.gnu.org"
 <gcc-patches@gcc.gnu.org>,  "linux-hardening@vger.kernel.org"	
 <linux-hardening@vger.kernel.org>
Date: Thu, 18 Sep 2025 20:40:52 +0200
In-Reply-To: <202509181009.CBFE970D@keescook>
References: <20250913231256.make.519-kees@kernel.org>
	 <20250913232404.2690431-1-kees@kernel.org>
	 <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>
	 <8d93c033c8060e79d2f0374a97827172f79ebdf8.camel@tugraz.at>
	 <202509181009.CBFE970D@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Donnerstag, dem 18.09.2025 um 11:09 -0700 schrieb Kees Cook:
> On Thu, Sep 18, 2025 at 09:20:52AM +0200, Martin Uecker wrote:
> > Am Mittwoch, dem 17.09.2025 um 17:56 +0000 schrieb Qing Zhao:
> > > Hi,=20
> > >=20
> > > > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> > > >=20
> > > > To support the KCFI typeid and future type-based allocators,
> >=20
> > What I find problematic though is that this is not based on GNU / ISO C
> > rules but on stricter Linux kernel rules.   I think such builtin should
> > have two versions. =20
> >=20
> > So maybe
> >=20
> > __builtin_typeinfo_hash_strict // strict
> > __builtin_typeinfo_hash_canonical // standard
> >=20
> > or similar, or maybe instead have a flag argument so that we can
> > other options which may turn out to be important in the future
> > (such as ignoring=C2=A0 qualifiers or supporting newer languag features=
).
>=20
> Can you send me a patch to gcc/testsuite/gcc.dg/builtin-typeinfo.c
> that shows what differences you mean?=C2=A0

I can look at this in the next days.

> Because AFAICT, this C version
> matches the C++ typeinfo implementation.=C2=A0

> There isn't a need for these
> hashes to be comparable in a way that they could be used to, for
> example, reimplement __builtin_types_compatible_p. It's called
> "typeinfo" and that has a specific meaning currently...

I would want the hashes for types which are compatible
according to ISO C to be identical.=20

What I want avoid that this is used to implement some
run-time type checking (which is what KCFI does) and the run-time
check can fail even when a compile-time check according to the
usual rules of the language passes. =C2=A0Even if this ok for the
Linux kernel, I think this would be surprising in general.

Martin


>=20
> Given:
>=20
>     typedef int arr10[10];
>     typedef int arr_unknown[];
>     typedef int *arr;
>     typedef struct named { int a; int b; } named_t;
>     typedef struct { int a; int b; } nameless_t;
>     typedef void (*func_arr10)(int[10]);
>     typedef void (*func_arr_unknown)(int[]);
>     typedef void (*func_ptr)(int*);
>     typedef void (*func_named(named_t*);
>     typedef void (*func_nameless(nameless_t*);
>=20
> C++ typeinfo(...).name() shows:
>=20
>   int[10]:		A10_i
>   int[]:		A_i
>   int *:		Pi
>   named_t:		5named
>   nameless_t:		10nameless_t
>   void(*)(int[10]):	PFvPiE
>   void(*)(int[]):	PFvPiE
>   void(*)(int*):	PFvPiE
>   void(*)(named_t*):	PFvP5namedE
>   void(*)(nameless_t*):	PFvP10nameless_tE
>=20
> This __builtin_typeinfo_name(...) shows:
>=20
>   int[10]:		A10_i
>   int[]:		A_i
>   int *:		Pi
>   __builtin_compatible_types_p(int[10], int[]): true
>   __builtin_compatible_types_p(int[], int*):	false
>   named_t:		5named
>   nameless_t:		10nameless_t
>   void(*)(int[10]):	PFvPiE
>   void(*)(int[]):	PFvPiE
>   void(*)(int*):	PFvPiE
>   void(*)(named_t*):	PFvP5namedE
>   void(*)(nameless_t*):	PFvP10nameless_tE
>=20
> What would you want the "Strict ISO C" builtin to do instead?
>=20
> -Kees
