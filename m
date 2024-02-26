Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884D130AC8
	for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979370; cv=none; b=k1xQBQe2G8MRNKdN4EHpH4+NJGts6YWMARlof65rhJP4xDdVvd+cDS4CPC11xiOe5RiKI/uqyCQZdPV1+g5tLNhdEU+yi2Rs0P7Aj84ZhGQj2VyDdPFR/AcLQdDeDXBFPkXm34RftNJYh7LTQ2cZgymv5Jw68iU5+8zEDyLo2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979370; c=relaxed/simple;
	bh=QxHMa8tXHRVUnwvw9mD2wDd93p39Q3LXyym88+LBQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjRcoJsuser3Fw9vKaLzdBW8BJg8D3dJw04tE8CVtsaaumsDkIZ8XIMA8yJCzahvt3WTBvyTcS0Hnr6gpryP3JeL3oxeQXU1VY10BbLhBNXoyKzyS9uvrXGbi0BQwvy0Y5CBQiqIf0PEyCha7wsg3+SCR/LGmYirF1x+L/Vn3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXUH4LYt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXUH4LYt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso4346258e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708979366; x=1709584166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=kXUH4LYt0O+PcJSbQibj7bUR7GS3p3pHNY+97jePEAWM6mstU1LXPsKaj0lU/+8N7C
         a666jEF++XwzafrndzIg3MCT+lqXplSbXR9Q5dOEtP2fyWl/TmEoEor3dDLM9Xb9UiFG
         a1kxSmGodbTYdmNgGzzjy8k4nVrkFm7FRnGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979366; x=1709584166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=UzFkS/JUDs4Q5oyoLMbSUHqr/usk5k+c9rOTic+7+fzKCvUyKwMf0ImRoI13QsV2gT
         wybnCJlrio1TZJAb3s4BDmvS7sc9xVh3ZoVhqJOBxFRc11PaQiinA1JKXzkb4kEI0Sm3
         CO3C8MIOmgwV7n2DypLK+zRFhOSgC5ngAuftXnm8J/qhG7DJXm3Ztjln0vr4DVgs6L2O
         z2m8hxl9LSNKexvRAMRgKaKNIH+Q6KVoJ4cC59nneIx1V8d8KfZJC0btHc7CNbu2Ya5o
         FKcIlSzoYMX0vkz3bpML+fdYZCVOqjLcf3pyZPewnIQMBJ9mlMb5ivrp/CVRMnrVNMh9
         A5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCEHC4Ahau/IzxonwVy8jQWjg5b9WwX2pV4avNdpcR+VFAWxh9maEfRYkYiibft/77WBRU8wAYmuw0ObIfHmWdgoKGu3g5HdsKnyLzPNv
X-Gm-Message-State: AOJu0YyLkk7+Qqf4Gf3eqAGnvKs0K3PHs8Z7Wb2/pNvOCQmWUjG5paoU
	732QZT8/JbzRPQKR/UrsGMkComWZ7ic+DNcfZn/E+A03moY4+L/ar+NuCQ8vAC1758mzxYU1s9z
	lH46eMfpP8XFHzDe2Bw7M8YLV58j0G6rGsylA
X-Google-Smtp-Source: AGHT+IE4y/QI5ASnYlnv6FmbjUzGGENEjUwIiTvu+iC22zSP9/uqeaEIobfef09+sc2WB6Z9VlPhm8xH62y6EUnNoXI=
X-Received: by 2002:ac2:5d4f:0:b0:512:a4ce:abaa with SMTP id
 w15-20020ac25d4f000000b00512a4ceabaamr4861210lfd.48.1708979366487; Mon, 26
 Feb 2024 12:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook>
In-Reply-To: <202402261123.B2A1D0DE@keescook>
From: Mike Frysinger <vapier@chromium.org>
Date: Mon, 26 Feb 2024 15:28:49 -0500
Message-ID: <CAAbOSckyxGka1vWTpuYwA8eH=17sJbGMUOuCwHs2gE_FPnXG3A@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com, 
	Doug Anderson <dianders@chromium.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(lemme try this again as plain text)

On Mon, Feb 26, 2024 at 2:24=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> > On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@coll=
abora.com> wrote:
> > +     if (ptracer_capable(current, mm->user_ns) &&
>
> It really looks like you're trying to do a form of ptrace_may_access(),
> but _without_ the introspection exception?

to be clear, we want the check to be "ptracer is attached, and the
process attempting the write is the ptracer", not "does the writer
pass ptrace access checks".  the latter opens up more angles,
including shellcode self-modification, that we don't want.  the only
use case we have for writable mem files is for debuggers, and those
should already be attached.
-mike
