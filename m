Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B092EFD86;
	Mon,  8 Sep 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323457; cv=none; b=ZFzv7Mw7iRgh24HdYQl2+atGmJxM9fzYutImMaW5OZyFLM8Oxu4M54srRM+SWbv8NYKB0/nsKXt+4oYH06fQW2twgBC3qEtIlHeboRheHcNPv/basOlJIvTQZfZQJ0ukLrNNFJaQLyS337iLM+n0r9laiuM0ephEEwQX80zLwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323457; c=relaxed/simple;
	bh=v3dlqERGRDL4m8fp41FJcfC4xU4qarrVGpLQtiajWqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLWi6gxmhKZDq5wAT/r4io1QWdDJ5VBBoph9hb0QfZieN2xYvS7Ldvz84IkWJNsx2ymRpG2lVZ9YksxbKfTYlu+6KKFZV5e0rQJ2ZObGz2hVTQVkn/akPajgPUVnCJYm5qws+BXEq82qOLczIGhl65lzDmDfKwHQIMZMczrsnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6uF9bVY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6uF9bVY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24c95f20117so11532525ad.3;
        Mon, 08 Sep 2025 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323454; x=1757928254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3dlqERGRDL4m8fp41FJcfC4xU4qarrVGpLQtiajWqs=;
        b=c6uF9bVYlbcnTbixGzfQ6+PVHpe9I2u59TQOuLG9OhYVwMstdl0KE6Kf/dBdcvmiek
         LugGoXgr5tR3EKIVdIF9/PafO1YZ8t8vwMC7OungLG3nGv7enWxq/G+wG5gdyAZKNFQN
         is+ruX0yvC+ccZWQFAcWyl2PGyMo6lGDSxTzrveCoNrqMiLKpJgc9r0GHyKQ9YfRtALH
         Ls3PNs1k+eOdqXi/JMnLl4cRD1pLZ7c394bjNpj1nQVgmpBDQPkHSXN8E344wx90gmVc
         t2SQ4hCNWfpQgBRYv0JYg7oVa8So/8+RVaMFWYNzMwNpe8zQDI+gC80ja5WhwRNvjFYd
         Qq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323454; x=1757928254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3dlqERGRDL4m8fp41FJcfC4xU4qarrVGpLQtiajWqs=;
        b=dGomlyNjcOpt2valxn6TjSIWf3ZPk7SbGs1RUHF/0tN+UyR0bvKP0LOiW7qiPyPxJN
         b1pb6/OyNhoVyxcj6Orqj5Nc3xqtAE660VvrJuIVdSulbZG/rrlqWYdcBLvIn0/yO+Lc
         u4aKNeUvHQqGg6/NkpnmXUcfwjTDva8+IGOLzPKrgsXvGT2NLLmAoBZUki7fVC57LAnb
         J019xVfbVWrNESY7N8sVXHl4OI41QKWXX6ievpBG1qcAKg5AmNaFoft9btDwEe9tUR5f
         FeRKySbtl4aL0zlC3U3wVky5urm5FD39pKf3kphyKxWMHm+suioJYer2CwfeoVU128wY
         pVKw==
X-Forwarded-Encrypted: i=1; AJvYcCUanoIBn1os98XUMJ7vCQTRqNAFXdAm2nizLwjjWlsyoF2MhaUUuY4uONAUCmoYzgaQfxA6D5KXz2HbxZfXGKk=@vger.kernel.org, AJvYcCUrYHuEkxXGxEWjBh8FVnbjYBnw+ZBtQ+nX2JMomwD8TvIZD70imv/pUrcTDbffKlRbLzFVTwZujtC6E8vF@vger.kernel.org, AJvYcCXI5HGfM46gIGzuxFcrpeMZ0VbXEFFV4IoHEhkOo5jF/mwkxdOgu0xIPJj/p7P5cqEwcL48TtcZ4HDwxCTcTik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/thhacoLeUCcUprGzCz/2lmA8T67k31XESI0duE2UZSi1S9vT
	p3EU71S5z4egyWD7eeGzVw1SSUWi23aF/wLXinLrik23mhW+CrjNsERRsan9CG46bpZoqmuNqDk
	JktRrtVsSu3yDAkAfrOIgv9dbdGqViGc/OnKNQy0=
X-Gm-Gg: ASbGnctIUZUJWpfOmvV7ois4pDxidOQqETN7QGZlFtSRAyiJVKcw0B2d002PFYNbP/8
	apa6fCy2jNEwEq3+dWmOVbLbvPSexbWuUNcqx0BRtavlOxu9qkjh1dYQg9MCB8I63gCAsND0lK/
	zR3r7R8FBpAOmkG05XvRkSEGaXd5Qi5qEomvmx6qeWDsSAmPX8E5tVhhtEQRmkyfmAcLhC9M8Hs
	+dd7ts4Hx2ZTauYQDTw3tfjoLprHp+cSSegkZwYOJs/GKzU0zOxQzabVv+2ab46WZY/wA085rfz
	ArFnpkzN4in0wP8ailv8bnOdWA==
X-Google-Smtp-Source: AGHT+IH3Gr7oVCqBIAnNATl0EoGUq7kQiG1tPMocBmGsRFGtwomtz84mwCzDwbsMfMN8eMm25iZwuA+Y9HzYfquRIE0=
X-Received: by 2002:a17:902:f684:b0:24c:e9f0:1e59 with SMTP id
 d9443c01a7336-251685b49dbmr56309285ad.0.1757323454414; Mon, 08 Sep 2025
 02:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com> <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLv8buzrro0E5CCQ@stanley.mountain> <aLxE0AvP63nXxciG@yury>
In-Reply-To: <aLxE0AvP63nXxciG@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 11:24:02 +0200
X-Gm-Features: AS18NWAHQB1VDxmGeZ2zMhz1LhIMmPNgJ_kOliRNdZzXxMItpo-uGt9lw-n_Jok
Message-ID: <CANiq72kgPKwMdEni7xPOXZ55CDiUk6=ZXDZrx6fSheRSZ5aq_A@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Burak Emir <bqe@google.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 4:27=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Alright, the testing is definitely failed. I'll drop the series and
> let Burak to send v16 with all fixes merged.

What failed? Or do you mean Dan's second message? I understood that
Dan was fixing the first diff he posted.

(I am asking since v16 seems similar to what I posted.)

Cheers,
Miguel
