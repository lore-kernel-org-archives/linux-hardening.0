Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F77C6C8
	for <linux-hardening@vger.kernel.org>; Tue,  9 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702481; cv=none; b=BMfoiLH3wrqDJC7A8CyAD1AIugqCnvo8qjmAs/OPiQq2EMy0OKzA2D6AwtHP9ZJx+c1WvLjr9obxERk3OJlD+FQ92UoZpIJJ7oE5FOIQjsFp45t2ErFykcDtL75vxARN3yHExKPygszNXwZqwNz41Bv6xEGXPGZrZi6EW+7i7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702481; c=relaxed/simple;
	bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=mWIj0dmfklLTGwsoV2k3eFwCyWQdvCTcRK/DqAJBG5xqb84IJvWRdYLGAr13h1TPXCufKy+h7HHXIk3DK5AjNltO7y7VeEjld8lzIT2Eth1hfy0vyloAx0bnrewQoDOd08SOCX31DffCThYBFbPUJbMyO3ajD6BrAAUc9KBhkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=le6yobmN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="le6yobmN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so389475b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Apr 2024 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1712702479; x=1713307279; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
        b=le6yobmNKIk7IcTrMR7Yh1AwzfvsJdsn82Viz0c1EC3SmHM/Rx+55n58Ug4HFiHvP+
         mvLXPVPbToE1zLeMe7C1+f/FOd9XTiMtbuVNSEvBLoed+MtHbbtgyIThSBoEWKXyGwVF
         K7zRAWYmoqkOjBvgpPSaPytSO9wvKW7kAwOeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702479; x=1713307279;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
        b=PXndCQSsmidFnaqO/d4tUqJWMdkHuiADtopRWVc73lXE18u8Gs8PDfrZ+srqAROZQs
         FmgTBQHcD1/35lGhx2AKCWDnNHQDdgJctdKvkLBSUIlfF50yOeM0lKQr3uYDfOqYygB0
         JtQm7NQKi3MEwGn/DuyxiYWwdTmVYt1vGI8G2eEVC9BFYwuf2eRSbf0dN19ohwfrpvkT
         1WofIl67W6vRxS0UcY1+GCUKKEFi+pJaB1h1tS+yCBPjYvQvrpOEaAvxoLu2hLo0jOEH
         ljB/uRL8qAnrgnjTUl5rQp4aD88XmoTQ1ToeZnNpOW6/VIDFvs/RpEY4EKl/H6KjAnUJ
         Ph7A==
X-Forwarded-Encrypted: i=1; AJvYcCXuWCbxKtCSw+PzKfVD+glZr0yo2mm3bB0iewkgW8mVC5hxStPnN3xsMDWVKYMsbYcJGo+2+eXXtJDX672V/Xu90OCp8cGQ51GAO/i2a6uB
X-Gm-Message-State: AOJu0YwUmcdspYJOICdnLFD8E2E+gSIh+rQ98l6KESuFGVPHHRM7jJbo
	9g4kr+ovB8vOmJTpab/fKZWyuZXKn1KpeTLKfpkHDTlWKVkmbjq37cPR0TeaHmo=
X-Google-Smtp-Source: AGHT+IGf7AyQcGgtDnxdEc6zeyqopRNu0tZWpw/6iFI0a7xHNGrXDfFFZjth8bXqtf7pRwJfL78atg==
X-Received: by 2002:a05:6a21:1a9:b0:1a3:ae75:d6f5 with SMTP id le41-20020a056a2101a900b001a3ae75d6f5mr1505619pzb.20.1712702479019;
        Tue, 09 Apr 2024 15:41:19 -0700 (PDT)
Received: from smtpclient.apple ([103.98.78.154])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b006ecee8c8c0fsm7200440pfr.176.2024.04.09.15.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 15:41:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map pstore consistently
Date: Wed, 10 Apr 2024 04:11:05 +0530
Message-Id: <9F1B6537-F0BF-46E1-92A2-92C082DDB573@joelfernandes.org>
References: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (21D61)



> On Apr 10, 2024, at 3:55=E2=80=AFAM, Luck, Tony <tony.luck@intel.com> wrot=
e:
>=20
> =EF=BB=BF
>>=20
>>> I forgot to mention that this makes it trivial for any machine that does=
n't
>>> clear memory on soft-reboot, to enable console ramoops (to have access t=
o
>>> the last boot dmesg without needing serial).
>>>=20
>>> I tested this on a couple of my test boxes and on QEMU, and it works rat=
her
>>> well.
>>=20
>> I've long wanted a "stable for this machine and kernel" memory region
>> like this for pstore. It would make testing much easier.
>=20
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.

If that were the case universally, then ramoops pstore backend would not wor=
k either?

And yet we get the last kernel logs via the pstore for many years now, on em=
bedded-ish devices.

=46rom my reading, ECC-enabled DRAM is not present on lots of systems and II=
RC, pstore ramoops has its own ECC.

Or did I miss a recent trend with ECC-enabled DRAM?

- Joel



>=20
> -Tony
