Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C0358378
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271154; cv=pass; b=IMoKMTcNGa1/2ub6FGA94Iwr5luBDcWqF9XrgxKWB4ieJuRTomn2WCk2lrH43r9k6g8/jmwcduXIsZ7hm+mrJqfZb6PO8Q/K7oomus1MKRUxzX3DPtC9HQVIvytbY9YIjTAeS2EJxg80hpqTZH+tqFV8YGH5Cjiv5mkrKZE/xf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271154; c=relaxed/simple;
	bh=S0Kwnud5iFtwr69z8VPCi5ftaPUGlvLcKnXUDXdBOFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8XX6RK5qgq4xcy+IBt8mSApjXnNFZl3UoebaAbqkJqv599vT9QoP8+03TVmJVhHxyzLmGOA3Rfc6n3FffJ/u5DHPK8VjL7xaP5J944NzEaH04Tdx6e/yXDP/7/Lnc28bf8xaRniYAzwBjmd1ufMTjCggHHWMf7jySAmm/vgck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR6X86Qw; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR6X86Qw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so622973a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773271151; cv=none;
        d=google.com; s=arc-20240605;
        b=ZyjTRnwK+J2Wr9Rob1KAAFek/Vm46inFf9Xdp3A3DNqXl4R2iZxIDQMjuUfDXyjhhl
         0a/GtC4nDAu1iaxNkJYe+JwreM0Bx2s5lIczeMXTnsvjyXx85raJiqCJZor23Cyb6OO1
         IH/BPzEeVonhDYSNIl3gJ+ui4hEmwHsNm7b1vJ7HcsrUedi/z+f1TwFV2pRISg1RDqZG
         zWO9/mmkixlk7iqY8DrYM6PPpjyQysjg8Ym+vK5FdqVSM+sTh3WVKC7SHIxHZlbTHzJ6
         zixG2p8n7frymhxqhUnSUCpeIuAU2xp4rH5jPqsan3mG8UNJGI9ZfVS+NzCVr5JygR7a
         iRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p2a6wuOjf/7CEde44gCvKjhE0f4d1bD1oCKGRhA0Nds=;
        fh=QWSnOtYyvucCaKs/xwaN6LUoAAVMN19sY0TiQZP/BR0=;
        b=TRg+WmscGx43WniYtJTnwjFgMJeCbFyoBcQSpK2FWRPZ5ZpcnoIGH7wLGc1ECt05GR
         Iaw/CD5jdM9rN0tY8kRo7sbc+YfK5OHoKJ/Fq5A94xC4dfJ/7UeCufaVQ/Tt1blve8Z0
         jcJbFGo+vHondVC6aQOboRtZWmH3pbTmZ0JuaReYzw8tb04Usl70vlceh2p89YPJFDda
         3QXdRw+1slswLGJb0llQV/IifWCrjebUSVo4Mjm9cQXwK7MbdkJAfr9sTnRBri51h7PT
         1xmmccXWBM5dwbjceWiS786M5NKYh6xAuWtFQl+HXD0pf3NHdET7F4fwpkD24IG1jjh4
         aI3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271151; x=1773875951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2a6wuOjf/7CEde44gCvKjhE0f4d1bD1oCKGRhA0Nds=;
        b=cR6X86Qw+tvhbwCWZryMP33vE3ID5yNEhPeJ9uDPyp3jmfbOEC/zfGnBAUOv4ccqee
         2S7CdhAjVVm/9nfFDN9vUuw3tMZmWC4Nx5WhA1WshPPZOuPX6so3IM/6Zlxb/hAtc5Ht
         7uKX0244lcNW1mgz2vJlfTrJcAeilYMPGMH11iS0L/YnShPoGFReBp9utk8FFdtN4WM1
         DxSUNopaqcn04xV14HHHgqkAZGKL60Qx9XiTdW3vcaxRZXCwxhIuwPOP80EfqMIQzfCY
         TA37K3/1QO95Poad4Xg4Rdwn3Ki8GC35rNvNuZsD4afsaQL4DxPOn1Pu+nogV1/FdoX3
         d4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271151; x=1773875951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2a6wuOjf/7CEde44gCvKjhE0f4d1bD1oCKGRhA0Nds=;
        b=GFzo7vAoWAbzv1ACZPe8/NXAEg/ffuuInDlKq3lPVvNqvdDd1mghF0sw94cCLf2P//
         /tmlKo8SU2qEvXg4duQgSQ8OY3inv8Q0TZMqrXMkyH1dsVZI6Lnsy5yDBPwUKsZdGUOB
         dm4b1T0/boG9DXWqPLXl0M8lr1Qkv3VLZpaMPnThZP2ahKm2FqGlZT/H7lQdYa1wnJUD
         2RKDuuUXdYCRPDzBhee03XCIQSfGXoShWcL3Wk/7OPVF9JJLSIdM8i1LBAc8wYDRi7lZ
         QTiHxqCAjPiFl3Hz9aemloYWROjWnxmstvF9zmZCgOT8SGZxo6DyzReDKwfa2NU79fi2
         gqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSW6X7QlEfQ71na3SgrxGZqXQqpk46ZjeDbbIVbtzNQAXv1eSZieNEmK9W6H+eLlVsCswvvAeAS7wK0KLZnvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBZAfIiTsgC8AG0z6SF28F1EfeN37L5BIJWt6TrzZQc6MWU2S
	/VtUZd09u/O6nD3we5ymCypLl33ev0OuXSFQIyiWgUKOfgVPd28KLRl13sNiUmCBy6QSl04pmxZ
	+ASXlEBLZ9ZueXsZ8mWSOkJaATYNJP5c=
X-Gm-Gg: ATEYQzw2PdS8OEumKpXLHSnpMHF23Jycj843CwYxOC/sBLOdeUuTfBoU8gu+dnCkS9B
	1P5xaKKkwUzYDawpFWTNfXzv9F5PitJsm3phHklUDoU8dZopxQEwKFamUJmdj2MKTyCJF+LBe87
	AtPB0/bEyAOk7TdlrW74Xe56T1z+mH5pzuSAx07DCXVdEAkKM6irrHg4Y5zsduP6Ut3tQ9kprAa
	W4wEcbK1ptoBBgF/O6fTvhqtYCt1d1eg8BrafBFOYc3XeOvSAh843/B7SJ+d5s8BB5sRKux2Pao
	5/8jCvuW+kFsd6EpvStcEtes/Cln83MbV3r9A8Sex+4KwhpE4ynOCIrOJLE25O3V8uFkevrnu91
	X4/bPFZe1RkVLB35B
X-Received: by 2002:a17:907:2d0e:b0:b94:b5b:4370 with SMTP id
 a640c23a62f3a-b972e158c2emr286633466b.2.1773271151254; Wed, 11 Mar 2026
 16:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310222040.10324-1-rosenp@gmail.com> <CAD++jLmR8TZHMbiSBaUmUvPYvP9bPOmr0a=yq4M7FNRFF4EzcQ@mail.gmail.com>
In-Reply-To: <CAD++jLmR8TZHMbiSBaUmUvPYvP9bPOmr0a=yq4M7FNRFF4EzcQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Mar 2026 16:19:00 -0700
X-Gm-Features: AaiRm51bcB2GD8hEt0KZsTqrJJEU2s6nszH4kDHUKTkax9rvTUDLGCQS6er_THc
Message-ID: <CAKxU2N9fExr=72E6ZPs+VqCe+eSzyxS8zbcCU2PPcqKjvqiO_g@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: ljca: reduce struct allocation
To: Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:57=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Tue, Mar 10, 2026 at 11:21=E2=80=AFPM Rosen Penev <rosenp@gmail.com> w=
rote:
>
> > +       size_t num;
>
> What about naming it num_connect_modes?
> (and unsigned in as Sakari says.)
Too long IMO. Makes the most sense to match variable names.
>
> Yours,
> Linus Walleij
