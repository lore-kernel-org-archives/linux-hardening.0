Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413815AF6
	for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909878; cv=none; b=r27PvJTO4BudpP8JSO2+BmKhx94kG+el4Rvp9YsZtcyus2Sk/U/qGo/mnlU0qsXZ7H3/AK7mNBPGRlv0BJUn0EnBPqpFYPr0cKBFIQXi7G1ApLBaGEX0XEyU7+r26ueC/vGc6BZpfhOO8FA9F2si4hqXTUYK6Rvn7MCXAWQAlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909878; c=relaxed/simple;
	bh=iTaxrum4RWbRMxEoY8krvugViqTvIJqlx4xVF8pjTSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9njk8hOAH2ekaLGECpZcrAxhoh3U3lJ/HNDk3AY6/G4UYo4by9mCiejSvbGqwn5i2gWl7oWk5wY4WbGp4jOcRRyvQtlj11TuaJdDjARLvvtGy1gc9YsDWyMVRzYMftjk/ymUdlGIwmvLFGFbozAScJav98Tb71HDH6F0O4yHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPukD1hE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPukD1hE"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so18394a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732909875; x=1733514675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DakFNAdlgvG9kZOIFDKFoMmE+nLP/gOLaXT7j6tD6Ds=;
        b=TPukD1hEcRv0DfCGzbfzmMtoR5/TOxiXK0f2GkXHLGD2CdQHsyQPTBw5A9BcHXmihu
         rnOGNQBYJ11UDjbbKzVNraUsD3fX5oG2BY/aPnD2L0rhKdOqQOter38/WIsY1TKBkD5W
         mRmNk6CnPNf0UoYxQxhxd/FHY6xeZnB5Bl3aQgZxIfQcE+8f4xFG4K740XH0XYGqOZmJ
         NcrPWQrJHJy0yPMxRmXX/KtVZeOtb1mgIYOYE6kbQHgR0klwWN4+BAn+FR4m3DHFzO92
         +Jw4foDz9+okDsIIgwDF6umEBfWyxfER6HDDIu+o9W77WsqKY6aaYj9ypKk7E4RckfSj
         nS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732909875; x=1733514675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DakFNAdlgvG9kZOIFDKFoMmE+nLP/gOLaXT7j6tD6Ds=;
        b=Fs5Sw6pPlNaIFtSw+Oe454e4JlHhhoUitG32+pFIN0dEOlDdlvcvirXzLWnCujTr7m
         Sm7NbJhtyFR3z5FtptWvXVAkgQ2jnFJEYuvteTTP+daX17c6UHU+Yx6E7Pl1X7Glgc6d
         pe0E/zV+Di3MgLCV8AdqLPqYpD+fAAUDiNu9cTTwrI0DUQkUYUg4U0z6DMzg3K5V8KvB
         yqaSb1z6xZekiaacS/K3ylqyp6QKLQlVTJHJCSOPQW2sWPl5YUc9hn+7abA1ZoLRw1/s
         u97WQa2PEo7zQNh8GwUkKvoL1qMKTL5y+wNlDp522ti7z78rJGoR2dg/c94nHIUDPlpe
         AEFQ==
X-Gm-Message-State: AOJu0YwbYGmB4xVpGQF2N99IpPXrOcJRpAiZ8tef1W6wTMKfSZpsixhi
	JtiUHwKh42NTetxQl/paq7qc3gJhL76jKeJTbnPbe7GhdVH8luU9M7ihAKlM2vcRF7D0e/eY+VY
	a2wzogdgsALadYQ+ijITzma6fJ7/cQA7cVPGo
X-Gm-Gg: ASbGncuCAwElnC6B1tM1KxG9KSLejdSQTNE9TtipYM52f9kaM8rKvqGHsHo2NJC0q6h
	8qcl5sSWzn3wr07bH5SGp2X2JuHVjlZxkvI3uCPj1NJ43y66GCy3ePjuyc5Y=
X-Google-Smtp-Source: AGHT+IGlaSsjv6kt+38Zjk6dLy2h4xxAeTLK604DNvrzBYzm9ozC/f76QckgvNB7y/dBp8gVjL8EAn6TLInXBILZe3U=
X-Received: by 2002:a05:6402:35c2:b0:5d0:a982:91a7 with SMTP id
 4fb4d7f45d1cf-5d0a982a46bmr75993a12.6.1732909874361; Fri, 29 Nov 2024
 11:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
In-Reply-To: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Nov 2024 20:50:38 +0100
Message-ID: <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
To: Jared Finder <jared@finder.org>, =?UTF-8?Q?Hanno_B=C3=B6ck?= <hanno@hboeck.de>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+regression list, LKML, maintainers, patch authors

On Fri, Nov 29, 2024 at 8:38=E2=80=AFPM Jared Finder <jared@finder.org> wro=
te:
> The change to restrict access to TIOCLINUX that was added in Linux 6.7
> breaks Emacs rendering of the mouse pointer. This change was previous
> discussed in
> https://lwn.net/ml/kernel-hardening/20230402160815.74760f87.hanno@hboeck.=
de/.

This landed as commit 8d1b43f6a6df ("tty: Restrict access to
TIOCLINUX' copy-and-paste subcommands").

#regzbot introduced: 8d1b43f6a6df

> An associated Emacs bug report, bug #74220, is discussed at
> https://lists.gnu.org/archive/html/bug-gnu-emacs/2024-11/msg00275.html.
>
> I wanted to ask if it made sense for the restriction to not apply to the
> following three selection modes for TIOCL_SETSEL:
>
> TIOCL_SELPOINTER   3 /* show the pointer */
> TIOCL_SELCLEAR   4 /* clear visibility of selection */
> TIOCL_SELMOUSEREPORT   16 /* report beginning of selection */
>
> On a glance over the selection code, none of these interact with
> vc_sel.buffer and therefore are unrelated to the exploit linked in the
> original report. Only SELPOINTER is necessary to be available to fix
> Emacs bug #74220. I imagine such a change would involve moving the
> capability check from tioclinux(), case TIOCL_SETSEL to inside
> vc_do_selection().
>
> Note: This is my first time emailing a Linux kernel mailing list, so
> please let me know if there's any additional conventions I should be
> following here.

FYI, for next time: There is some documentation at
https://docs.kernel.org/admin-guide/reporting-regressions.html
specifically for reporting regressions (with a focus on what to do so
that your regression report doesn't get lost).

> Thank you for your time.
>
>    -- MJF
>
