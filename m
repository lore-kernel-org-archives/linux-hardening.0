Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C31384BF
	for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020761; cv=none; b=SFmuKqO2RwQrsC7WypeoQPJxuWsSMqNKzIzfoqb4QhdSuRgWp3q0K7jd7jGGouC63PegtQfp8bTdOnAvClmW39m7jeieRWBtpR1E3wmTAbH5pEc+Ku3Mx/Iob7S1eHOgr60S1wGRYCAFsUjMyPN4mBSODM919wfjwAbTgxQZWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020761; c=relaxed/simple;
	bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPsaKfXCpLa96l/uIUhCiujnYm3n3ZYFQHb+gvjQ1V+gNl+hooC16JNeP94MEF6dwgznmHEJYJeyr3XTlq4TNisDtODycbARzUz0v/3OzAbSPBwkMQR3TfYQUR6FuxcU9qcQQzool9wWmkjw/9PeQdbb27dRC8h211vc2kkmozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvT4NPz5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvT4NPz5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so6716a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732020758; x=1732625558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
        b=RvT4NPz5IIaqR7prkmVJ8Sgp5VpdKTUwU47DZs+UBZzbbib344Z2g4YntUaZg9giCP
         rVb7hRmfuCXsw/y9rCsyQyTQGsLOqqcNmFDecylZsZnBGJipOpnnQvzj8fJ2JC8DqTEg
         l+Vfo/7gRDqNTSAoqeT3nEbvV7rlHynmMFt94jqjTHeqUN4xueoE8wdzAarJ/jVCJ4Oe
         klkyv/iIT0vaQKaNwKLFHLlW+Kwyx5McFHZm6uoJUieglyAgFdIhfJ89mEACBF9yWVHT
         e4Vyyme71D9eG8SQUXTlyt3YshjSS0TxFvFMXr9rgFTdOrAoCSnXodsCkaCtfkhyHQ5w
         eZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732020758; x=1732625558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
        b=LIrjsgatDiG1EbU8lTZYKFTm5xlQTJvBJqMzwnspLaRZMwO0xnOr7GUtKq9e+99Q5x
         XlbwFYiwrm95H5dPZF2fd52zb2LmifgqtYaAkOlwCHqfD6EKLmPo5rArSoGS/4HH7HXv
         giDRZvq4wbLtLk6Ag6ziHZL07RXAz7j2pW8+f7VvdWNGNADxrsmzhHo9EkYVcwjlJCym
         xr7F/ZJZ2RjJE4Dca8obEaj/nKHXMjtA6yK6DepaOUmsm/LpXcWAzShhzOhMdl4n9LJo
         aAHYtB4J9/+A8qhaqby2JN+GFOap6bwTKnoi6FL/Zezb0L483uaAOztRCHh8FSRaAa6B
         USjg==
X-Forwarded-Encrypted: i=1; AJvYcCVG3ohQfUMuvCKxvGk8RYQgbk9bAJZW/CTXjy2EcpNofD4pc5xllPmQDK/roeaoSnZYIOeKgNlzxRmxicN2JUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEn76ecBzPCBgd+Xx3/Qmz9qEfAdW1PqmtQHuBaqME+8ouGaW
	c/n3Zf2+vZWm0B2gs/IOVInJsMR64SmDCDvE/mZ+nxEloRuzine9Dx2u4IIbeyCR1BVtBa53eBB
	9UAw2x0IYK8k6s21rWW4vK9qrNuUIYSA0e2+Z
X-Gm-Gg: ASbGncsnuwmRtlPIYOJecS6QxrhMJnRJHCQf7GGHpAbUQbW81srcTNEDcCpSOhObVFp
	ZRsYiygWiZawhCzqz3DAaSOSbXixKSlzQuOKqQFGCKB2Tn+uv0D+fB509txU=
X-Google-Smtp-Source: AGHT+IHrO5qfRHSlmQCwNzrJObJ8F+5vL3isZu6sEndbtNy8+TOZx/SUWI/RHP6UiYngvZBnewRWzZBX4xLAvWC6WJw=
X-Received: by 2002:a05:6402:1351:b0:5cf:bd9a:41ec with SMTP id
 4fb4d7f45d1cf-5cfdec244d3mr70875a12.2.1732020757739; Tue, 19 Nov 2024
 04:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
 <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com> <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
In-Reply-To: <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 13:52:00 +0100
Message-ID: <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> > Can you point me to where a refcounted reference to the page comes
> > from when page_detective_metadata() calls dump_page_lvl()?
>
> I am sorry, I remembered incorrectly, we are getting reference right
> after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
> will move the folio_try_get() to before dump_page_lvl().
>
> > > > So I think dump_page() in its current form is not something we shou=
ld
> > > > expose to a userspace-reachable API.
> > >
> > > We use dump_page() all over WARN_ONs in MM code where pages might not
> > > be locked, but this is a good point, that while even the existing
> > > usage might be racy, providing a user-reachable API potentially makes
> > > it worse. I will see if I could add some locking before dump_page(),
> > > or make a dump_page variant that does not do dump_mapping().
> >
> > To be clear, I am not that strongly opposed to racily reading data
> > such that the data may not be internally consistent or such; but this
> > is a case of racy use-after-free reads that might end up dumping
> > entirely unrelated memory contents into dmesg. I think we should
> > properly protect against that in an API that userspace can invoke.
> > Otherwise, if we race, we might end up writing random memory contents
> > into dmesg; and if we are particularly unlucky, those random memory
> > contents could be PII or authentication tokens or such.
> >
> > I'm not entirely sure what the right approach is here; I guess it
> > makes sense that when the kernel internally detects corruption,
> > dump_page doesn't take references on pages it accesses to avoid
> > corrupting things further. If you are looking at a page based on a
> > userspace request, I guess you could access the page with the
> > necessary locking to access its properties under the normal locking
> > rules?
>
> I will take reference, as we already do that for memcg purpose, but
> have not included dump_page().

Note that taking a reference on the page does not make all of
dump_page() fine; in particular, my understanding is that
folio_mapping() requires that the page is locked in order to return a
stable pointer, and some of the code in dump_mapping() would probably
also require some other locks - probably at least on the inode and
maybe also on the dentry, I think? Otherwise the inode's dentry list
can probably change concurrently, and the dentry's name pointer can
change too.
