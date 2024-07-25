Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766A4C7B
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938731; cv=none; b=lX7Bak3Y77ifHAfUSlekbrc7CXCD8lTanAWZBGhd0O/8atvtGlmfNpsSSj2ap9K+G2TDFXon1sGHqaX8LNIiAMktEzaUv4/9KSeFtqgSYpAPuaWkQVv68Yfe60SY273x4yccwGS2N+TDSy2JfLaWeI+WsXDKs+pVmlhqaFHd6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938731; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHqMc57MH9cEEDsYYkUuDA9KpEDzloouwmsdlfZ+c6gCLPBgSmdaEXyWsedGRXzHvgoc61WSgMOxmO1LVhcFvyXWyvnXUx4oXz1omItouA+eZwsWEBm0FhAyehwLv869G6caltwKjfkYARkxAVyqVZNJL09DDkSPFTxFtqiwx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SxjdHvbi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SxjdHvbi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so1477114a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 25 Jul 2024 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938728; x=1722543528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=SxjdHvbiZP0k/dW4+2DJQGC5pmfjxunY4M7Lafi1IGsb+6Yba4cPVs5Gi1A1Qd9iL/
         U3mzS+soLkEfdjA7nMVIfEbooPFr4GimXBceLdNcT4JqGisGuyeJDBCXwGj0NhaRwFdb
         WGdNaiPYdvOYJEte8C5yHbyKp6y88uqkoj/g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938728; x=1722543528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=YX2PX0xxGZlAsp03OrwEtY7ti+dSJvGGZoyZiNn70Hw9cfEdqlJjdEaYsAnCOsnaK3
         JWwCpQHbfVM/KI7KIrpOla/bI6WoKzcXjyWkObk66cY0kL/Ud0fL67mbSoBKulcSAy9B
         VTquSugnlkdlQJZxoOLskCtOn5rOcqLVGuvD8bBOkcVra4y9VxoenVSSSCMoBo2g3fhd
         WTNRCQ7xvX5PeiPQCuDiAMQAQ7F6OZYajSu3IuYebSpXohJwROJRNT9iuDX8JOspmH2e
         1yLt6vtjTPOlRNvxxnf0zhOqioqSGj33/9o27BYAqlsYcddqhnuRC4kLdM/OBKxyo3Fc
         QarA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+TUz6jfzHGLID2dp9b4xtHR4ez9WJgf1sCgAk0Iu6WdHjqCAJoxjRv+8gG71GWOcAgYyU63YRXPFUsmtirWT0h7EjQSrm8Xj5EyDOJVm
X-Gm-Message-State: AOJu0YzdiQoJKttKY0tjcd1NmoLRjJUoKTz4jhqA5IAdDmD6Igvr9oXw
	CcxO+wDGbbS+4ri57rpmKX1ftrnkpt1sqoCv73qQVTgQ56ZTZK+rHyhb7Z6AsongG60l9qWKvHV
	Qst0=
X-Google-Smtp-Source: AGHT+IHbnPYLoGhYfhuwaDtP9aB6sOR9dWJSzZ837eRXEwki8sR9R0Ka8aWZmQeuCc3edZOeY4t9GQ==
X-Received: by 2002:a17:906:fe0e:b0:a7a:aa35:4091 with SMTP id a640c23a62f3a-a7acb3f273fmr225534766b.25.1721938727843;
        Thu, 25 Jul 2024 13:18:47 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4b13bsm106419066b.141.2024.07.25.13.18.47
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:18:47 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso115795066b.0
        for <linux-hardening@vger.kernel.org>; Thu, 25 Jul 2024 13:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBmG8uyxdB4vZ/P3iMc5eUNZCT/mUOAD1ITXXU9Q1wi6xxPAmupJSa9srVvkkKmCqoJQztmAgqO87ZAjdaVwj/PDlmHmTA3rjXEhHJGCZ8
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
