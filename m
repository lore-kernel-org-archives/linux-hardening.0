Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C32AE7F;
	Wed, 26 Feb 2025 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538562; cv=none; b=FkLSEwixytbGdl04+DZWLvukcZXwN5jJnoh//ipO0qYtS52aLIPxYT5VvM4KN2T2B/EJQiQ9Xcqta/o0ClLUtZKBQWy6C4ytSG5D28OCEIkOxpedpvreH+b2UE5KnTceyKuyoQIpmz0jwaTzueVOv2b9aw5jpOnEk4x1bgosqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538562; c=relaxed/simple;
	bh=0QrH2Zd+D5Gfx52FrY2snKkSglnbNxISIbI0Z4qrDzg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e53oxT72RkCvS8gx2xyJVqWX2ATTv9X0Um26jf3HxD8irVA/bVphYWMXik/yg/kxVWDmmfmKoiWh6sji7aI9J1RqOak+t9lLZrQ4aSNGNsNPcx6K8p+Zl5UBpZkmz2ZgDtFjRl45LzjXKadNB+HhC7wO7D+JbAfpbSwQDchbhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBw7aDFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBw7aDFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B73FC4CEDD;
	Wed, 26 Feb 2025 02:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740538561;
	bh=0QrH2Zd+D5Gfx52FrY2snKkSglnbNxISIbI0Z4qrDzg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VBw7aDFlLfoIsY52a+6ydG8VMiyc0pTFo66YhF8mJSN06vLgLxpw+8MjxxO32U8an
	 1VVrOKR6KsB/+Cg2P9rG7pEv5uZlr+Fd9h5vyg/Ngi9ZJtAM4VSMAccJ9UyiIO5ccG
	 2Vuw5TwryLQCUqT8mD0lOE+k/JiTrRQGoRlrtwUiV8huoFfba81+pZHQXc7quO4ven
	 +Nj7HgYljgiHN6VsdRIL/vaOcBRNopLF37jAvmyM8rBDPLwnd4a3IfhftjLDGdK0mT
	 fSCtWBkDBe/7j8i1XYiPH/lJbWXZ2jMDoD1a6PpJQRgO3Vnzd8LYSyVC3MbnPo/pm8
	 oE5Lttk8HIBVg==
Date: Tue, 25 Feb 2025 18:55:59 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
 Rudolf Marek <r.marek@assembler.cz>, Jann Horn <jannh@google.com>
CC: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
User-Agent: K-9 Mail for Android
In-Reply-To: <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com> <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com> <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com> <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com> <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz> <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com> <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz> <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
Message-ID: <7D503F1A-42FD-4585-BB4F-D8D00C303BE5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 25, 2025 1:14:01 PM PST, Andrew Cooper <andrew=2Ecooper3@citri=
x=2Ecom> wrote:
>Peter Zijlstra has added a FineIBT=3Dparanoid mode which performs the has=
h
>check ahead of calling the function pointer, which ought to mitigate
>this but at even higher overhead=2E

Was kCFI vs FineIBT perf ever measured? Is the assumption of higher overhe=
ad based on kCFI filling dcache in addition to icache, whereas FineIBT only=
 fills icache?

-Kees

--=20
Kees Cook
