Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F33976A1
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366744; cv=pass; b=O6JAjsOb4rESBltd8bHuK+Mc4VPNo1NpBOQpCsY2XgRqtd+Bcbv4uv7xSgtpAkUBL/aEnqCCwSZunPLIc2QwdG3JJ50fTlVFOBd8Po9XeXujyeU1Uzu4A9YE0A9VH5LNtZ3zTa9o4pKN+DdyzpW2lZdcg6L6kIPz0pJ9m54ejGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366744; c=relaxed/simple;
	bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILq7kfgR0hn5KLEAq0QVOjZhY1fmvb2ggodIyTAMss4P4R5V0SBqvbzcuLS2NE/BzL1ccTkptqCwNom/sZeCvRI/mfjYY2pmQXNEQXWj9xjifdX0A1istjcL4h21ZtdR/I1fPuSXh3PVdOQhPfhLcPaiMrfwdEDcXnGCc4IdDrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urpk3HY3; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urpk3HY3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b45bb7548so3935080f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 08:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774366741; cv=none;
        d=google.com; s=arc-20240605;
        b=I0pZYxg6858ehUm5YQQjNxM6rmcVnStS7WA2aUYdZ73REXxviy006zkclCunZs9L/e
         mew7DaH8dRSetz0W17gjmWBrMPbqDavQ+DCB5hjpab1VX94NDrPHEGD/KhruV7vtJ81f
         jaxDCmbMnUDUEh8Ckj66W4S4DR1j151Jvu26ywBC3NPphsC4ZoAdwotXI9zBwRy5gSc7
         lQ0Re2HIzQlDe64FxgfJhcxCVcOL1EHEiR444P1r1PXv9/x8mc8szSP+wWwGoUw+GzTz
         hkx1sPFyEihx9RiRXmqeK6xwPPqERLRd3j3VqtHaUi0V10pxJZn/yCu38901YIaW+pxA
         2VhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        fh=C4hNhUidLEFGCuc7W1CuXfPXtcmzFYz2Hj+0bAk3AHs=;
        b=gX3kq+3Ro8j7YQeIjeMzQxTyGGNnsL98MpTXZRqtPfaWHOWP8aL7UsZ+pGQ4oHdRKY
         fwZcYeeM6R81zAnCOVHfVDlo4myql7f12pIX6Q0VLAPo5ZVOADF9Q9ryGDiatc/2R7Fr
         cd4FF0LezZkpGOeqQNZj/V5VBTBruczdZqhVRsjCbs4jlrlmbeTgvO9EOu9rz3y9EY0C
         AajimTH3SRf7zTtoH11z55vfeNjAKXCqcIonUQHCRg97LxtZJSGlHCipt7je/6R/Xh2m
         kEMEoc6HNccZQUKBgUVe+Ce49hAD1pnBIDWGl923d/ImaNZDoMNa/N1qZg04BfhRO1xK
         9xmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366741; x=1774971541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        b=Urpk3HY3hO+s6dhxrOY1YgEcI+XJuEFiaH6UvmE25ZiGilaOUEXGlagdRh6nfITGsw
         dwvZ3IAqLjY72M4m/rZrAGL2+wL0ZXTZlvoSFstafOfLD8ep+ygP7/aUYboMzeDi+/iC
         Apci4bE5xgkgUSaslgMtjmRLQ9Ql3IJo+WtrfRlmG33HOJEwKu/VHXZWs+d/AdzdMZFL
         bbhp8hkNMpmf6q50R/4w+7Gfrfn/rBNRt0LN37xhfjF1H/lORZyXBO8mR3VN7/0y4Nlt
         aCsmucxYPrIp8NY1AdBJsntEJt9jmZDWOSeWKApeEpEQwacAyEhQ3WN7W7usmfLnKoox
         0xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366741; x=1774971541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        b=cKKv/BwNmApHZiSnPaRBWgXxqm8jiKl57zaOeLgEpUUhzUijKEOW1dMG7UgZ/dM/8f
         cPevPFbzzwOVPVe/X1Nvl3pdkByupFC/dF/es9SLV2XGMUZYaaAREZD2ssis/1WbRs3G
         FM8ggIjwKsa+Jdj21dMFyZJcHomPWeIAYm6/2OB+oWYO8Iv2jy0nDuoQWTcxcsHqgqaq
         p+r7sWDBU/15eg91A7Y31KGBNplFcOkLZnS3dOStFQ8Vvf1WXKpnSRcEw0gKDo+NqJ1A
         F0AkyO440ojhuO99NROk97I2evytsarT1e4LUEoOMR/9vFnpFOj1pAqfHtMgWlImj55K
         kz/w==
X-Forwarded-Encrypted: i=1; AJvYcCV6V45dETx7TmeJGgqLL23NJtdFvGGythZ/2eQiAR0/MWyIJmj9EiLrB8CNR4sL/qLsAl4+Bo/5DogamDaZs9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVWF5dW+AJQXtqFa6gTABbEey0GBR/6Kg/uB2eN+XSs5ohIAz
	qraNRN5vMPCyoVZb60KHv8A8Y+BNiT8tAA3qEuv5QzfBTeU3R2vmQGtH8o4d1kTXkd6rYpGh32F
	kckCsHUPPFPrHf/CW/whG8m6ZIbjNZk0=
X-Gm-Gg: ATEYQzxv5cigeuOpdPZvkKLQ4cohk9D4nYP8WEEEd0oPJ2Q0LOfPLZKg12nXSbADnsg
	hyXnlv4/wyZcdGOiXAnTd0rsNMvnd+G+ILwmJhZ2owhnX0B1syl0Qi41xq2xnau+e7knQ09UO/l
	J4HWzhSbvumEBxbRkKo9fh4ORtHNAnO/U/OyovsfP7VfSdzsgAU6hfzoqkEfW63WeVtpiZlCFfc
	muHRMz0G7UvZY1Al+TjNWm6XGrIWcQ4c5BoPxDNQQm9TmCasvuFyV+5ii/5h4W36Xo873M61xu7
	0QHpSOr4ggYIV3roRA8bnF+fl51wAcPebfZx2ijklYhdjFq3KWxpfr08sdrcNq5jmzT/gTDnmq1
	ITq4N1N9Y3YVcBc+4n2/s6q5tyQ==
X-Received: by 2002:a05:6000:1884:b0:439:c9e0:83a5 with SMTP id
 ffacd0b85a97d-43b6428ba82mr27243700f8f.54.1774366741482; Tue, 24 Mar 2026
 08:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com> <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
In-Reply-To: <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:38:48 -0700
X-Gm-Features: AQROBzB5DvXY4ZUpivMY_noBYppyOsiLxJF6u2hNM41m4-WOEutqa7thEOTe8Bo
Message-ID: <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 8:28=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
> >On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> >>
> >> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> >> > While the original strncpy() would have copied a full 16 bytes from =
an
> >> > overlong name (producing an unterminated field that the syscall reje=
cts),
> >> > but this wasn't a reachable state. This replacement will instead alw=
ays
> >> > truncate to 15 bytes and keeps the NUL terminator, which should have=
 no
> >> > behavioral changes with the present code and avoids potential issues
> >> > with future over-long string literals.
> >>
> >> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> >> fails that way recently, so I will try a v2 with the "unterminated at =
16
> >> bytes" behavior restored and see if it passes...
> >>
> >> test_progs_no_alu32-x86_64-llvm-21:
> >> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683=
00440546
> >
> >Don't fix what is not broken.
>
> strncpy is broken. ;) This is one of the 6 remaining uses of strncpy in t=
he kernel. But it needs a v3. I'll add explicit rejection of over-long stri=
ngs and validate that the bpf test was a flake, as suggested in the other r=
eply.

Don't. it's not a kernel.
