Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8331F872C
	for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906239; cv=none; b=apbr6Su1BOfn057+A3P7UrFAbee5GuKy5VwCc3eXjcPY42DgrC5WK3yOZYB+MoFFeSSTQsTXHrZ5fpyGlNHQ7ikvcD8Ygm5p1idGER9OzPmAsu+mixcVHJmkJpYW4B3ZQc4RnR7MBnPUrSKfZvVExogOSlHs0uNIY3Z+sT6EZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906239; c=relaxed/simple;
	bh=4gnegoRNBCrsFqsiuh+OxeRr8HeLkK4StvZ+jMG9NHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq9M3OanhSFuQKHD/Ttfpuv6u/Agor/pDdukocWFtpfwGqkHUOQvy1HUlNj8DI6vstnt73J6fgp1deZPrhzDtv1dSvJzYfK2L3vAB/VYVuvRtYS2mh677r7pP9y2zqb0TnO/u0GhmTe82vNPnTVSvF8BH2pYlX4C3h9vPag3L3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LMvEuFuz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LMvEuFuz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72b7c8c8537so116015a34.1
        for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741906236; x=1742511036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYgKJUYIz7Us1Ip4Rvr02J/jvpPESqI3sDoO+UIGHcA=;
        b=LMvEuFuztXX75VJRyjs+s1iC18moZdLrbYAZhhkvuLSJBg3dGqO5HUKr1bNaeqypdd
         rnWJVlMoPJjpP30CnCEm0atski627VjLQ7nyzwMgnHzZTNWBWeLKfn4Akm74qAlSDrqn
         vfc9GJIgBfJVcBZXOZfLZ/k8dVJQJwRtxw5/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741906236; x=1742511036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYgKJUYIz7Us1Ip4Rvr02J/jvpPESqI3sDoO+UIGHcA=;
        b=vo9EeJBFy+LTaD2EY1Pgv+aqYcdoGT/JEmOtdfntCEd3CdwhGprmeL+m9xC9eAxQhs
         ZVZcyqZipZUUFIrlyNvhYb1/NVRG5IBwjUpXLBDl0fXiI6yhDzyFcr/wrbifX6mpKUip
         eU6xSqI5KoG7N4/UX2Uxv+i6/2OTKHYRodSAPVc81rTV9t9YX+hKoOevYmsTCzru5apk
         Gk843WjTMWo8kzCkkRhii+vpv5VtM5U11r1v3+patfBs8iylCcrP4DZApKsg7dZ6MTl0
         vO6CtriCX95+u8q9QYOAZ2VLvH4tgGQZLMmwPAvfvNjdfK3qyCWnIKU46ZEK7TlmEqt2
         D+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNEZM9Gk+k3xb2mPFCVyFRktqPh6cXp3xGRT0vkayii3UA+vxLeLYN8y33C0sNhMilGd1jlJgeHQiRyR1hUSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVAPONsBVmsdsblKhRYLa0W2xskHpGyKSVfpQxTNBIV1ggyPhO
	yRo+tWq4E4SF6NvDDxotDxX31iJ/qyjTwDhXc1SeMbOBXfvK4h+7+bf9P3f+p5sxKwrhsvByBvS
	X7avjOO2Q8/cs2KXc09Wb2ZvdOprLuLaoLV6q
X-Gm-Gg: ASbGncsOYGIxKROEffnHqyqZ4lg7KV9m93UsU75q252dWafA+tvjOSnytDQUDohXfnp
	TCCWxOe3hDT5+JelLshdd0r7qV/4QouGjbfXoQpjrS4wUlHb31CfTijHLIjVZExNQS5wD3mO9ev
	s8881q+cZcw7OPuONP28Q+6WcO
X-Google-Smtp-Source: AGHT+IF2ZaluKLcKINtDeD+yBJJHOOdfDT/C8ffBzy/1eFICkDIbvTuBMV0m/DAX1vP5ilPahvsc58zp7sWYFgBEcnc=
X-Received: by 2002:a05:6871:898b:b0:297:276e:7095 with SMTP id
 586e51a60fabf-2c69124deedmr71979fac.11.1741906236616; Thu, 13 Mar 2025
 15:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312002117.2556240-1-jeffxu@google.com> <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local> <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
 <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local> <202503120931.3BD7A36445@keescook>
 <CABi2SkUs3bXB2jw+1CUQPtWfZ6-kZDunQweOSSw6j_8JALUfAQ@mail.gmail.com> <79b1b6bf-e916-45d4-b20a-0f9041ca36bf@lucifer.local>
In-Reply-To: <79b1b6bf-e916-45d4-b20a-0f9041ca36bf@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Mar 2025 15:50:25 -0700
X-Gm-Features: AQ5f1Jqs1hIETtPSyGk_sCZon4T9X6zdTCjgSDXBMaF8XFl2bJPHN6hU06SYWXE
Message-ID: <CABi2SkXO_O0E5EfB0VaoFuyJ4WG-n-P62wBC801Jj1ki4Tk1Mg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, broonie@kernel.org, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:29=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Mar 12, 2025 at 04:29:50PM -0700, Jeff Xu wrote:
> > On Wed, Mar 12, 2025 at 9:45=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Wed, Mar 12, 2025 at 03:50:40PM +0000, Lorenzo Stoakes wrote:
> > > > What about madvise() with MADV_DONTNEED on a r/o VMA that's not fau=
lted in?
> > > > That's a no-op right? But it's not permitted.
> > >
> > Madvise's semantics are about behavior, while mprotect is about
> > attributes. To me:  madvise is like "make this VMA do that" while
> > mprotect is about "update this VMA's attributes to a new value".
> >
> > It is more difficult to determine if a behavior is no-op, so I don't
> > intend to apply the same no-op concept to madvise().
> >
> > > Hmm, yes, that's a good example. Thank you!
> > >
> > > > So now we have an inconsistency between the two calls.
> > >
> > > Yeah, I see your concern now.
> > >
> > > > I don't know what you mean by 'ergonomic'?
> > >
> > > I was thinking about idempotent-ness. Like, some library setting up a
> > > memory region, it can't call its setup routine twice if the second ti=
me
> > > through (where no changes are made) it gets rejected. But I think thi=
s
> > > is likely just a userspace problem: check for the VMAs before blindly
> > > trying to do it again. (This is strictly an imagined situation.)
> > >
> > Yes.
> >
> >  We also don't have a system call to query the "mprotect" attributes,
> > so it is understandable that userspace can rely on idempotents of the
> > mprotect.
>
> PROCMAP_QUERY ioctl, /proc/$pid/pagemap :) I mean hey - these are somewha=
t
> diagnostic-y, racey, un-fun interfaces that we'd rather you not use in
> anger when mapping stuff - but they do at least exist :)
>
> (an aside, been playing with PROCMAP_QUERY recently and very cool - we pl=
an
> to make this useable under RCU lock rather than mmap lock which will make
> it _even more_ useful in future... exciting times :)
>
/proc/pid/maps only has a subset information of vm_flags, e.g. pkeys
is not part of it, however pkey_mprotect can update pkey. So the
suggestion of checking for the VMAs before calling mprotect won't work
for all cases. Besides,  the checking then updating pattern also has
the perf impact due to an extra syscall.

> > > trying to do it again. (

> It's possible, but it seems that it would be relying upon it purely becau=
se
> in some cases it would be modifying the mapping, right?
>
> It strikes me as very unlikely that an application would be looking to
> modify the attributes of a series of VMAs including ones that have a
> security feature enabled which says 'until this is unmapped do not modify
> the attributes of this VMA'.
>
> Yes it's _theoretically_ possible but that'd be quite silly no?
>
> >
> > > > My reply seemed to get truncated at the end here :) So let me ask a=
gain -
> > > > do you have a practical case in mind for this?
> > >
> > I noticed there were idempotent mprotects last year while working on
> > applying mseal on stack in Android. I assume this might not be the
> > only instance since mprotect gets called a lot in general.
> >
> > Blocking this won't improve security, it could actually hinder the
> > adoption of mseal, i.e. force apps to make code change.
>
> Thanks for the explanation it's appreciated!
>
> But I feel the drawbacks I mentioned previously and elucidated upon in my
> reply to Kees outweigh this theoretical concern.
>
> If we encounter actual real-world instances of this we can reconsider,
> presuming we are ok with the asymmetry vs. other seal-protected calls. We
> have this shipped with a uAPI already like this so there's no rush.
>
Sure. But I honestly think that you are overthinking on this. The
security benefit of mseal for pkey_mprotect is that an attacker can't
modify the VMA's attributes,  and this patch does not compromise on
that.

Best regards,
-Jeff


> >
> > -Jeff
> >
> > > Sorry, I didn't have any reply to that part, so I left it off. If Jef=
f
> > > has a specific case in mind, I'll let him answer that part. :)
> > >
> > > -Kees
> > >
> > > --
> > > Kees Cook
>
> Cheers, Lorenzo
