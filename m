Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AE3090D4
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895188; cv=pass; b=BPmqVZM59OHg6dZBEkyNI1fUYqmlp98Asemw8frItzfXj/b7B+pW+0ZEgruH2rZrB1t4iQHlkjJMnSmphXoDrmlkSV8a7oXOyyonYun5sAilQCrYcVigrSxlaMhpgKnhq/V8twppMQfcUJLi8L7SRU4nZznSKynfBJIN3T/RaUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895188; c=relaxed/simple;
	bh=3LlgstqPwU4W5iW5J6ZYZGwmbQjZNMc6oIdsZa6KM3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbIH5nKVhWv9GqApgVeS17MJYmke1jR+17NpoRKJJyKhnzHqhcHuiXlmiknX6PJXmhJ/Q4h//MyHEvujRKJpRIaBCtMESBmkcz1/WIq+wZHj815Om4Lp+L59dv4AtZoOg3jVWUN9k4qQzykG51ONPIDrKajgTbC+mUBiQtSWxj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1K0dCwKF; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1K0dCwKF"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11a247de834so738c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 09:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767895184; cv=none;
        d=google.com; s=arc-20240605;
        b=Vb+F1wwjMsXgZ+iLgu3mkP8oAS+jD9ixVnhHhPeK2+5Mi/xkS7GkuM+pHQUVpJdhZX
         qXbly0Esx6HjIR+n9l/dtb869d4WA4FBCQYPTZWGbbhuKwWg8fBnjAxgjxhOj/vcxtb2
         KGSHLm4gitw4iFXd4soynXLvYJbteZGPgdCA+QAmALevL43qtqVeFgPqwMvbAJhF8odU
         Vmti8P8oWXvbdaNpt7z5/mHQLmEDwGFQzkdF1fG8S9hkrP9fKVBaxqtze3kbFw0Qv199
         54OTBrETgB+ALdewlKgGhUny592OO/LF3witRVcNjxQSowwsfjb1E5P6/ECcRzvxsZPE
         4HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LlgstqPwU4W5iW5J6ZYZGwmbQjZNMc6oIdsZa6KM3E=;
        fh=6USUvw0QsnvEEXjE/DMHqR3l4NYHkxIstWqeta2J3tM=;
        b=iDeKSVLQS6L1VNxqkcmrQqklk6eoP8+0GdZWyOqsUlxQlCaPw6isPPG3CAc3Ujd0NK
         y/mw1PQq0Pl77UlGGzL+d3OwYfcdVyNFfK4zUDHV47W3vpLbJ6yg2vJTQKmnDyXm7U2F
         4X3fP4bSYNdyBDp7rEsLY0YNlBTvyR4JEzdJduMzzM77ebCNqTmVE7hxBO1bkOnfiqBR
         rONR197CugtQJqaRP0F1/9G0z9W8sBEzqNFmEdZ/Qo79bMG4HSc+hlip44WCeK5G8hnP
         QOkOfCnR9irAkKGSlKtdRFyocEAzjE7sKPPiBGpQPEdzjDG6MZ5qviNg32fJS2yvE8nW
         evJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767895184; x=1768499984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LlgstqPwU4W5iW5J6ZYZGwmbQjZNMc6oIdsZa6KM3E=;
        b=1K0dCwKFSccTppWtqUWdKBLDEcI6D5ETfO5mrfbSVqdC0HdMcozM6/DIROnjs/7VAm
         H3gKWBo4ZSIHJjG+e0L93xu1vCIwm86BgU3eR1mPcpwIBZoH3y+SJ3Kzf8dnvFk/DpLK
         MXFEwWBsq+54+nHmmoj1xg+YQpXCai8n0STfqaI0eSWbEYxArMMK7oLvT6j0zTbwBdTY
         S3jcH+QQI9ykQbRd55GhysnT0r9BppQIYdJKoUkHS3sa6NT+O36+9FpTjkGSwzicI907
         nLUyB7QzeHcirpwrZsx8DZygwW615TQ9z30k2A+KMyHsQ5Z2e7bxKoK1gvINRmxmO0hl
         JJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895184; x=1768499984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LlgstqPwU4W5iW5J6ZYZGwmbQjZNMc6oIdsZa6KM3E=;
        b=dvrgAjO9/LPXvPxLChpdsMYO6XWYXMKDs11mhc3DIna6aj85qpxQo/y3R5RHy6xeSr
         3EB/KT+yHhNICduM5enhnc/y1QPyWBJxWjpGF8u/itA6qc9mzQOUTf1OKzskElo6PH13
         P4SNGavmQBxdaE/aV18GKXbQzDriOKCDnSSH1jQWuT9BoaaVzp9UTZXNWhs0z1UxAYW0
         bQ13F9PftBa9Wh/gNPJHEZ/KyJsnoMxMRBOXJNaOpRDpF9ZjjgdcsFdrdFW9+npPsfXT
         ayOOivGv8EJaWpu7j/aWS3wfXyVk1TPuruRXwhVfaiR59z+C3cI7PG2OdPOsCw2MWPDA
         Ig/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjolK50+OmI2EHLcESQU05A4ewO/yLE7wyh93NmDwMKGQlD4pK0QdvLf4+IZ7b5fDkno8rC0eInuoVyUPaXIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaXGUz7fap2nBSbyyWkIPWw59eCCRmn+0L//3OS3e48/Co0Iw
	tzEKu2668gli3TmkBK4t4Iwvc5HXC7VmjWW7hKHm/eIiFSCVpsIcGlnDXu7Z5FA1UGgj4o9oIzW
	M5kdEecX8aDslVvXG6qUBNwjDe+4bJzc3rk7c0kII
X-Gm-Gg: AY/fxX6wnfqCsiLdHcySsqjoOYRrWu9IhOfXfZ6pHL/CD1TC74zY3zeLc4I4nRtRZft
	xstpXfQrrZTJDS3UWDtUdgyMc+bBlzRmUNkff8uQFjfc7owuN4C6Sd4+VqwvprunM3d2lS+Vgn9
	ictpYXKlL88/KiH16ZGLKrPd3jvLuxgkFgP6QjzrANBJO74nAbILxFGT5Ivk3HyUGa3OJ3FyW8g
	6oOGhIUqoHvMc6siShVuC86KBEtP/x0UHGxtCy193yx8mgtD66X8ET1HRJIrT24UzgqJ4tWtnLY
	U/iZ405sFCDa8M1pVEe+e76o4zU=
X-Received: by 2002:a05:7022:6284:b0:11d:f460:faa3 with SMTP id
 a92af1059eb24-1220541f92dmr7209c88.13.1767895183796; Thu, 08 Jan 2026
 09:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211040935.1288349-2-ardb@kernel.org> <CALxfFW4gyv3gSc1JhkPNqk4LL6S6gZbDRJx2y21PFZ8-8_9s_A@mail.gmail.com>
 <CAMj1kXG+6CYVSV-2ZSqrEm+B=az+54=fNwHpC_6qQZ-z2=3Zgw@mail.gmail.com>
In-Reply-To: <CAMj1kXG+6CYVSV-2ZSqrEm+B=az+54=fNwHpC_6qQZ-z2=3Zgw@mail.gmail.com>
From: Seth Jenkins <sethjenkins@google.com>
Date: Thu, 8 Jan 2026 12:59:31 -0500
X-Gm-Features: AQt7F2qG4JZTpgmrUvet927wRTzPR9uXVxSlElEKagdXfemplsURFSWd_27Hphw
Message-ID: <CALxfFW4nn3RMWfQHZ8yExhznTZyCAMm1Xj7J7ZALooan2eUNfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Bring back linear map randomization using
 PArange override
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, Liz Prucka <lizprucka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Any thoughts on the desirability of this feature wrt randomization of
the placement of vmlinux in physical memory?
Even with vmlinux randomization in physical memory, dynamically
allocated memory ALSO ends up getting predictably placed. If I
allocate basically all physical memory, e.g. with mmap, I can predict
with >90% accuracy a PFN that was allocated by that mmap with the
caveat that my testing was soon after boot so that reliability may go
down over time in a real world scenario.

So I think linear map randomization is still relevant in making
real-world exploitation more difficult even if vmlinux is randomized
in physical memory.


On Thu, Jan 8, 2026 at 8:33=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Tue, 16 Dec 2025 at 19:14, Seth Jenkins <sethjenkins@google.com> wrote=
:
> >
> > > This is posted as an RFC because there are obvious shortcomings to th=
is
> > > approach. However, before I spend more time on this, I'd like to gaug=
e
> > > if there is any consensus that bringing this back is a good idea.
> > I may be a minority, but I do think bringing this back is a good idea.
> > It has now been 9+ years since hardware side channels for bypassing
> > KASLR were discovered, and it still appears that real-world attackers
> > overwhelmingly prefer alternative strategies - such as this one.
> >
> > I'm under no illusion that if we just do this one thing KASLR will be
> > secure again, but I think this patch would still have a meaningful
> > real-world impact in terms of making exploits significantly harder to
> > write.
> >
>
> Thanks for the feedback.
>
> I was hoping to get some other views on this matter, but sending the
> patch during plumbers and right before the holidays probably didn't
> help in that regard, I'm afraid.
>
> Any thoughts on the desirability of this feature wrt randomization of
> the placement of vmlinux in physical memory? AIUI, the main issue
> being addressed here is predictable placement of statically allocated
> kernel objects in the virtual address space, which could be solved in
> either way. Or are there other concerns here?
>
> Just trying to elicit as much input as possible on the list, so the
> maintainers can make an informed decision.
>
> Thanks,
> Ard.
