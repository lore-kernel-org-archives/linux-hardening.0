Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D467C6C
	for <linux-hardening@vger.kernel.org>; Thu,  8 Feb 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390731; cv=none; b=dF3lCvA4JGetebr6y0zCdHl+2Wr6acXJSlwyYRGguF/LJWUpzZ2iA/ih22Joh7cxKkuPDBithn8yvsr5/Zk+eNSxmcV8zFOiqqfOQpeWd4gJdrICqIKW2JuEsmih4uSJJLZoh1kV0eoZuFT7GucrJqpijaQ+cWzBEsM/0LUVvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390731; c=relaxed/simple;
	bh=eM4HqBQZDXDrdOu8I6M2Psw3Wem+dQhghmyTtakzWxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0CRzFEzsGeI0PaYnf2+RLOhDYyIFVRmsPgZDPJnPUEhSXY/CU8OhbVexRxk0M1Q6vK5KcIgKTPZuhVkkqclgLSPpovaMb6f673wINNP5FW4HP/GDzzyCdO3wyytkcJRdBT8a4AmLvjFGioEh4+YaoSJd5RBDPSttG+6xL3lyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dxQzoPKK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dxQzoPKK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a38291dbe65so198897166b.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Feb 2024 03:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707390727; x=1707995527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LaTp4U1LWb5pJxk+3p4oypsyvdSNZ1j6KLCLyUB+gDY=;
        b=dxQzoPKKwoQ1uycJxHQD85OeTFwBSciBZuKjems1ziZ23YKvWhOPoNFwt4eihELiuU
         Z7H9stsLlZu0eCFa88O32jYFhM3URKri8G3tvWGJUU+5G2+0tLH6xPH+1q1Buw0q0ybt
         4NkSUJ69gel/MDfT6rEDnBlB9bpI0LSvw9z4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390727; x=1707995527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaTp4U1LWb5pJxk+3p4oypsyvdSNZ1j6KLCLyUB+gDY=;
        b=p2j7s8+qW0fKK8pfslRThJlLXmNvNUmgc05EYNJvlAExHqOyDtwHcScIUsEzAC3uO+
         sBrXH79V1rDQz6qi5oYkGhv7MGyg24K+Xsj9Ix+DEV3Nk/N0VR5DaLdG2jg6K3PMRzdb
         NXz0RP2IlALG9l7i4sN+Kx6udVEmMRLV/1mrX8fbbechyJ3I1RzcwdzbGPHxObvAHqbX
         DRMoUpHmfmoOwoYp80Gm8o+Qf86rq2FFjsFl1pGdGSjZg0GUs4fQdDapZTmb8gh5NEHm
         smqfLlj9yWe24K3X90C1pLQTg/O8ih4AiFel1h9EXXzBfWTMxmpryWaa0nteVF/hls2C
         UCpQ==
X-Gm-Message-State: AOJu0YxIIHMi86HFHvwQIOFgs+Flt8ZaeuSDqKFusifMyXK8dv5KL1gb
	O7CmDVadEq6GgJYbzXv6zGon7PceknVJ7Ylz0BkNtmXUiRM39yPSLontitcFucb8KmCFzvd+9ip
	IwxrUgg==
X-Google-Smtp-Source: AGHT+IE8SGjDeBjfuiJ2drBxmGKhhnXoKUYTjaXEv3RawJZFnQSW51aDVMpJVcBdYig/mhyD13Pzwg==
X-Received: by 2002:a17:907:78d2:b0:a38:86de:592b with SMTP id kv18-20020a17090778d200b00a3886de592bmr2882867ejc.11.1707390727278;
        Thu, 08 Feb 2024 03:12:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3OF0qcnCKi5e31SSU/WPMP6aKAoFFLBIdJK7rWIUdwjX6TcqwXCao8MYpwWo/tl+AYKgxCdQci0UIHovwqO1ihSSqTj1qrM0VdSOqW6fP
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id tl8-20020a170907c30800b00a387d9d6dc5sm1659049ejc.174.2024.02.08.03.12.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 03:12:06 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so2095755a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Feb 2024 03:12:05 -0800 (PST)
X-Received: by 2002:aa7:de11:0:b0:560:5f1e:f416 with SMTP id
 h17-20020aa7de11000000b005605f1ef416mr5940766edv.32.1707390725562; Thu, 08
 Feb 2024 03:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local> <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local> <20240207153327.22b5c848@kernel.org>
 <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com> <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
In-Reply-To: <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2024 11:11:48 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiJj0AuV930QSxdBPz1RFSdLPdcxbY5KjqevKMAkJdBrg@mail.gmail.com>
Message-ID: <CAHk-=wiJj0AuV930QSxdBPz1RFSdLPdcxbY5KjqevKMAkJdBrg@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Borislav Petkov <bp@alien8.de>
Cc: Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 10:55, Borislav Petkov <bp@alien8.de> wrote:
>
> What about its benefit?
>
> I haven't seen a bug fix saying "found by KFENCE" or so but that doesn't
> mean a whole lot.

It does find some things. You can search for "BUG: KFENCE" on lore,
and there are real bug reports.

That said, there are real downsides too. Yes, you potentially find
bugs, but the act of finding the bugs might also cause issues. And
that means that anybody who enables KFENCE then needs to be willing to
deal with said issues and have the infrastructure to debug and report
them upstream.

I think that's the *real* cost there - KFENCE is likely a good idea,
but I'm not convinced it should be a defconfig thing, it should be a
conscious decision.

           Linus
