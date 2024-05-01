Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC13956C
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594761; cv=none; b=gLTpL+zzecMrLEB8+1jyHCCS44SNyZRdio6N0BAYqCKUZS4yQCzWjyDM16uB2shId5HsuklMOkufEO1gG7RyFSy41yMGGu5JOvboSMqrDZP3IlMoJuYYvPSE9QgyrYyrRNgJGLxBk/q7npXNmIgeCrcT12vAB8YRCAuH8j0zVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594761; c=relaxed/simple;
	bh=/E3lGZnIdEvkShs7yZGABbxU5GtGlIugqdMHDWd9cxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC/lcU7CWFJd9htRIQntKBPzjA7xsHTtGeKZxR8T7rzQxQx5cXJ/MF5mgF/KPMeOQU6CnQy4LMtnZBVZZzud2Y7aaPddymdDDicfyVQqnkka+2C1zH6lXr2voxkr6RYCliYIhT9vS5U0N8NRWLwf16e7ZqVvkUDgCxws7z0VGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXvTZX92; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXvTZX92"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7f16ec9798cso719495241.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714594759; x=1715199559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E3lGZnIdEvkShs7yZGABbxU5GtGlIugqdMHDWd9cxQ=;
        b=OXvTZX92uCS0NPuRidZukMI+ZLB8ENlf10vWWkfPfaLv9m0O+9XWrJAuk/tgELNntJ
         /kZiDOZfbGGz2sKZg9vxniPUUuVQWaAxaQbh64gi0vMrIqpk77x2E1JGnmCeLqe9oQVg
         vKFwxjf4IcNijPapYJExpQd+VNJQfjdwcesRPP+Roj8bnrkTqHLVCIMm/iBAS+f151oi
         VjWLqqz7OOyDL3NX97RRDuJSUfREAXLeSdGimlApYAM7u6i4RLshPJ7ass4zI2SwKKPH
         8Wb4zW5wzKViJdIm/yZWL0lxzEDzwyJthinZpep5Vium2S+5eE47JQdq5JY5mZ2baGoX
         RKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594759; x=1715199559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E3lGZnIdEvkShs7yZGABbxU5GtGlIugqdMHDWd9cxQ=;
        b=NYrcmIcTe0J1rpaFgtods5E7lMsCSh+I7rqwKNvciCoOkPk3TGSIDuwDakA2dn9BCh
         MDujkbzkuAoR9S2tWLaVgxk5flc6r188sVNos3sYmSS1EpddIrvLTxYj7u1r+6tN81x6
         JN0rZN4frIlbl9ekL+xzhhE/Oe7M6sEjlxfqluPUeiyDsDqIja87LES3Yh++MVo2HTIa
         CetTkiyHOOJYnmmzyAR71dgvoxn59irZYOPryoLLojM4rDjD2qAiMRuaJBDFlXFN1Z30
         r4HCkI18t3A7Tq5qC7Sq9REzhgQyWWjd5k9L1ZRWg9WKrR4gdvVmYE0ITAlqlLnQ5m/J
         WnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5NPHoao63ahkFxaGC79N3aHAXLh282iDR1g6Q+ks5sC7aFyX7PESQaQegG1YXNp85qnlazTxMd7OZ5eiiGJj6nEvE4M14Ltko33a8Hmqx
X-Gm-Message-State: AOJu0Yy/T3NSjp0brAqvbuOJhd3GtunM/9SWYQAWaENXCi63rmDL78nd
	ZcDdtO/K+wYMym4C906pxet1u6Imb0ziu2xigv0oy45eO4ucRaDmIkp41kJ1viPiQh9rx4jQ18R
	nYVZ60YS85F+MSf3dCDjAUEzqZNX0v2uHxQYV
X-Google-Smtp-Source: AGHT+IH3NkQ9UGD1dyq6uplD3kVG/evBVRizXuCAvmSGPGe1sTsNrxTTYgkO13Sc1leDbu/aiyFKSSX1+KnUzI7rDJc=
X-Received: by 2002:a05:6122:2219:b0:4d4:872:c68a with SMTP id
 bb25-20020a056122221900b004d40872c68amr3932462vkb.1.1714594758784; Wed, 01
 May 2024 13:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501000218.work.998-kees@kernel.org>
In-Reply-To: <20240501000218.work.998-kees@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 1 May 2024 13:18:40 -0700
Message-ID: <CABCJKufZ7zXq7-Jqdqpc-Cq8Jb3RyDTXO3p7NqZv0eRUxU9Ohg@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, Breno Leitao <leitao@debian.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 5:02=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Since FineIBT performs checking at the destination, it is weaker against
> attacks that can construct arbitrary executable memory contents. As such,
> some system builders want to run with FineIBT disabled by default. Allow
> the "cfi=3Dkcfi" boot param mode to be selectable through Kconfig via the
> newly introduced CONFIG_CFI_AUTO_DEFAULT.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
