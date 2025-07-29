Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637A263F4E
	for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830979; cv=none; b=W4rja1WaKAlF4qAyJgUJiTjCPVXb9bBFQ4vrDZ4t5q1F8pLOBQ7AkN3Fn26m8AQ0A4va6mMySBOFtLu19jeQL1AyG15+cQF9batCxxRzTACmsUVPIOHYdMUDlxf6dnJ5YAxzTvUwqhxEIQXyZ4AQQPTFtX4g84jCGISvYpJJKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830979; c=relaxed/simple;
	bh=89oO5yBwKXogRnHzKM7W3myuaKHzc+gF2Cis+Twd0oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsVYnTMEAorhlSKxnDt2MKO2Get1AGPvQ5qr5KYzpqgq7H/TE62PwXgCCBQsgUzmV7p4RG2yTvIzgWCrwUTjkdRbnX9HwCvnLdNC8PNeIeT6wuSNbwprfq8gkEFSu2kG/wPjlEyO4x2vhO1oOf5un6kh35mEUK4yFlwlURbJCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVF6d9wt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVF6d9wt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dad3a179so1021624366b.1
        for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753830976; x=1754435776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7MELq/l6D9hMY/qV+9sozKMnnecRDmbGpZ3SGFvMEw=;
        b=RVF6d9wt8XFYsUTKn0XL8Fp1/rxjN9X/nPyCWNfueggrXDin3SfZNbkO322Idvca2a
         +fTSlVzcQ2yKilvUrIqbVRoegK0PqOHIdikxzVRtOasGAjXWU19bmXTCYDm/GFybkqkC
         Sn0oMtB/ArOHKuXM54YHoY8crYMys0/rk5+y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753830976; x=1754435776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7MELq/l6D9hMY/qV+9sozKMnnecRDmbGpZ3SGFvMEw=;
        b=OSiDV2laFLRfThcKaqSq499gYiJPDG9B1jtPDAG73NjoqS8juRLMoSJv0DJ+2qCB/w
         VXl+1aruuEWGzh0IpLYiyBzSTPmPdU3e7/tQOX+BGCUWKwKS6md2liiqDaaUr2Rri2Ba
         B32rHUK9HSnvuc4Vxlo6qWjfVkBHvvVIiU1z7pKWpwdMs2QnGLgJoQOZg+5WHXvJeiiy
         WE8eFhVUfoo2v9uLb9f/kaELZZGfKw+ooVPDrjZTHHtBA9342C7iBhgKrtAzveak+DyV
         TqrYzk1LlrHkE2EDmkBE/Yfx3YxXTP4lSq1pIdkb6+VizyRAM5/W3szNyPUACcQVDvjn
         2yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxgMcGdka3ZR89o/IQatfGM3TES+YG1uvjVw617VQ62cIvom366oIcCFW0nokYuTctlAvTTXZkasrSPAO0r2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlMlfovw/PYhy3M8pk9zIV3c01xT0SRbNJ2AbsI4KuX1zVa4u
	DT8Ek5IPqGgAhyiuP08pVgP1F9f2NqpWetdIaoXcVfe0vdz3O7HeGvNw4iDFtf1t12ymXf1cgFz
	U0GYGego=
X-Gm-Gg: ASbGncsLFBhI8PqcK5FIm8bdxHX3H1Euo50J0cl+pMQR8CDJhFwlwDZOEX1yyBXuirH
	m2P5f16b1yzy4SOPn662cpRM3Yh0bQzPFhRGsbDSXf/xQ8I92NTw+AQQfdLhdZEz1N1YkKHc1S3
	/+noJpPWgOImojKRFe3MfTxTqo02u3WK2t8pxAOExmEAu9IQdkRvRHOT/Q9zmFdInvyradlsfyY
	i6w+Ci5fm1hBwYat+F57M2PUNDjVke0VUFvQlpOPDqx+nN0C3MSP4wZ/nqVd3D3Wvr11FSm9iZc
	QyprtnoNlMt11t9J4qnHvIVLwQLgz7dNOlGaE5D2n2hiAZu06o6XYTiGwi46x9OpHZf0N7YGHBJ
	pcTHf8XHeTXWkshyEy+Fn61qRUHG8QLQjBYa3D8iybXuycJ2ImIpypjoHvhsouBR2b8srrkd19P
	IKBwL9KQ==
X-Google-Smtp-Source: AGHT+IETS3m6AVfR0WfzvM1tFPd8EXjT6pVrPbfqMKQ7gVVKGrM5BQ5gdZs/SNhpHf1FqzNj2n+mNQ==
X-Received: by 2002:a17:907:9691:b0:ae3:65a7:5621 with SMTP id a640c23a62f3a-af8fd98a011mr132566266b.37.1753830975621;
        Tue, 29 Jul 2025 16:16:15 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff9fsm657810966b.19.2025.07.29.16.16.15
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 16:16:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so1282649a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 16:16:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyMLFOtrUWQSlAy7zr1DGgqtGsl97rSJklfQ6dn3q8ynwRAJfHHg6WS6ZyDxoxGO/PPebkE/UHBuXb1TQx2R4=@vger.kernel.org
X-Received: by 2002:aa7:c558:0:b0:615:684c:c2d6 with SMTP id
 4fb4d7f45d1cf-615870b6891mr1084772a12.22.1753830974956; Tue, 29 Jul 2025
 16:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729224325.work.019-kees@kernel.org> <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
In-Reply-To: <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 29 Jul 2025 16:15:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9qD2tY4+C9mjPviAZLHJ+Bix3KyBfKKYfYbP1XxnUVw@mail.gmail.com>
X-Gm-Features: Ac12FXwyykh4eQS4aG6NfTaU_pPeuzIhKc2c8ZPYUithrQ3wXc60zMPaSd8W1iw
Message-ID: <CAHk-=wh9qD2tY4+C9mjPviAZLHJ+Bix3KyBfKKYfYbP1XxnUVw@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, 
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, "Kirill A . Shutemov" <kas@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 16:01, Marco Elver <elver@google.com> wrote:
>
> I think this belongs into compiler-clang.h, we've typically refrained
> from ifdef CC_IS_CLANG/GCC in the generic headers.
> See __nocfi for an example, where compiler_types.h provides a default
> empty definition, and compiler-clang.h provides a non-empty
> definition.

Yeah, I think that would be a lot cleaner and matches the other things
like this.

               Linus
