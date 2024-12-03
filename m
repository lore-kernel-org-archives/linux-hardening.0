Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FB1F426C
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234884; cv=none; b=U+ZTqJAJqi4VUjhNU92lgMa5auq4LCTdtgSMt1NgfxHCTKdf6V5Xk/74BJBgxP5lM8/oLHYy5xrTj7474MroQnXkVkTSBTvXWx8VglmdZGCRrKI7Std4Juirsnbq8ODWqYNk/yJLy4to+b+436yV2SyfM8Pj7YCyT7r4a9ZKwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234884; c=relaxed/simple;
	bh=dkRPz5hCP91YP+K/ZzeXcVdSbccaZFfQZLPNFXn+Ooc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVjXeEU1XcLhvFkLKRjFXCTHjvNVEzmMhHuR3BMdqntT50OVRJ0HKtPx7i3x1QIMRclypWEyf9aawE5UsGlAD/jhBq0MjeK1tX9KBEiS+/vPrXbX0kS0lQOg9zoplsZWe0zShQmi7oBuiMaR6YWlM3XUQtQtqUP/ec7xnj3oMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8Ao7fen; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8Ao7fen"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0abcc9c6cso3295937a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 06:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733234881; x=1733839681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgJ5Ld604A5Q3ZbtbqRhmhZWPfDB0owJn+W381THr6w=;
        b=i8Ao7fenx6CZkLIhelDjr0ehgwqB26BuWvAOoXEDkM2FGa54kDsEG2U0bayGLE5ZHO
         xe2nl4lpgy9repW2nMNOa2Q4yJXXGN6zJLf0MI9syKCNTV0W72V21l2EzW/ZYLW0qQqJ
         T8HfrHjybt/rmKXE0Bb0kDiQXnxRkXJcvRu2m09ybL+TKaBbbrjXPISQqYbduLJRpx1x
         nok1jQQX/LvWg9a/G4Nr4bgOpIT+zo3vlsC5h40R8r6Dxk61L/5m7b68rHwg5bJTHE5B
         SgF9lUqPmREvFTCy9gY1VpILalxQ14xA4gFKmALRzpJ91MQQnslsIjeQlKnpwb9eUZ18
         52nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234881; x=1733839681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kgJ5Ld604A5Q3ZbtbqRhmhZWPfDB0owJn+W381THr6w=;
        b=XUAzs7jURdPJD1R8CPmpK2dnm1LTyniPtCKIlIiX8Ow8F4o68Afh3lmSDtIxzTfdur
         s4kxN3LPZAXVOeBrwdhDyI3EBy7qUwvOioWAaXZ8y0p0RCiDF8xP8E8b2IgocW/zpsb5
         INOtdiQQ1gyi7OEc70sn8xwvlKgDyUeNJZPw9+5/0DEn+lrRP5viOIdXDnBRu+VC2u9n
         YxLr15upn9BQteiP/XYOoOIB2RiOuncl5RJuqcsmniGWQEfwRf3E2/wCRQX5wjbZPJuV
         sEvZsR/f/mxh0KMaqVOrtAsVPF7kCkawnxrE7DTFfJpYEUODVKwcmoYZOHazKdvVKX34
         CJUA==
X-Forwarded-Encrypted: i=1; AJvYcCUJuGrVX9Xz78/whe8O+A8imYpuS+34ff5zVwYMx0+907AMiWdW3s45y/0zlWZMcABXlzIhV/FHAtPUBxOOYNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+DWDCoJprEtHaqzb9jOZsN338S9EgYxS7EwsE7uLMudiqJ+l
	6Bnpb1xWA34/1K/3sjyWyiXbx5zC4+fjsKYuYg29d3VFsW9X9flYbGVCxyGWEIzBtPZJo98w4ep
	QUw==
X-Google-Smtp-Source: AGHT+IEaY8KyMwf/CJRU3fMSCPPQTKC0ZN/MBI985OtghEJefG+CwM21x0l4ouja8k3Nx433ZCD451zKp0s=
X-Received: from edxi12.prod.google.com ([2002:a05:6402:54c:b0:5cf:d3d9:308])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13d1:b0:5d0:b2c8:8d04
 with SMTP id 4fb4d7f45d1cf-5d10cb5cc5amr2112502a12.18.1733234880753; Tue, 03
 Dec 2024 06:08:00 -0800 (PST)
Date: Tue, 3 Dec 2024 15:07:58 +0100
In-Reply-To: <Z08NV4Z-L0anDxGk@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org> <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
 <Z08NV4Z-L0anDxGk@google.com>
Message-ID: <Z08QvvfLSWGIDfBD@google.com>
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Jann Horn <jannh@google.com>
Cc: Jared Finder <jared@finder.org>, "Hanno =?utf-8?B?QsO2Y2s=?=" <hanno@hboeck.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 02:53:27PM +0100, G=C3=BCnther Noack wrote:
> Hanno, you are the original author of this patch and you have done a more
> detailed analysis on the TIOCLINUX problems than me -- do you agree that =
this
> weakened check would still be sufficient to protect against the TIOCLINUX
> problems?  (Or in other words, if we permitted TIOCL_SELPOINTER, TIOCL_SE=
LCLEAR
> and TIOCL_SELMOUSEREPORT for non-CAP_SYS_ADMIN processes, would you still=
 see a
> way to misuse that functionality?)

P.S.: For reference, some more detailed reasoning why I think that that pro=
posal
would be OK:

It would protect at least against the "minittyjack.c" example that was atta=
ched
to https://www.openwall.com/lists/oss-security/2023/03/14/3

The trick used there was:

* ioctl() with TIOCLINUX with TIOCL_SETSEL with TIOCL_SELLINE,
  to make a selection (a.k.a. changing the contents of vc_sel)
* ioctl() with TIOCLINUX and TIOCL_PASTESEL to paste the selection.
  (The implementation for that is in selection.c/paste_selection()
  and is just copying from vc_sel.)

So as long as we are protecting the change to vc_sel, that should be OK in =
my
mind.

=E2=80=94G=C3=BCnther
