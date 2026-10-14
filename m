Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4055D88D
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=AEW5ronnXNXFv5AYR1LSKSHMGTf3MWUzSUtnfADcCCmqhFdGGDi83GKBAvRsuLLmydrwA5UOYJVq3uN2Ip7AJzYcQGWel/Ur38L9eQMK1tEvfywHjP0zPTf0UabGUo8ZTYGX29YvCGgiuzJvDnZX69GXtUdff3DRIHvoih4cHrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5LMeCX; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5LMeCX"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34c522572bfso548258eec.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=o6FV5V9O7KNCoFZPmCSSzIoXAvdMNnTFYx4luSrD5E4wD0uHbIuMIcN0NBYtmj2EAA
         vOcJ8pKqpe140+5u2fJcm36l/hXEzfLDZWTolXEOo9AH8SItQTvd4i5ftZzqwfJZm12x
         8xQLsFATMCEZFfQqZdVd/8poLq3cla0mnAZ9Mc0RCNb7HePtGTNu452OlOFjNj7RCgUz
         +WG2Fb4h95ZxM4/CsRV9y/fINHVCl3cQ0S0BpkHyRXZ9KH3jHEJNdDiPXNFSGhAHco5P
         YenBSfqBWogLi0cDwBESlO0NfYS575Tn8zPHHvwGcWDbuPFomgUuF9Ukqs8ttS2UHMKW
         aLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=kRXyC3Mu9+sW0b+VyG7+HydcOjYgbmrBDurOESBifZA=;
        b=i0d7nyMXsb2Ht0W63ZSLr39G1g8qy4XvpnkzF7UBGPhPaB5xlIzInDciN2aJjxyCto
         h5lU+ZUvXA+rF8BpPIsgH1cJxWQ8ZxG5dBsSLZFBTBD51KM9BPJr130wUwHp8YtmQFr1
         9YtFp584/U6YLLtEtbpg4TReqO5Tm57RJ5CnhuyXLOy4coXBQIeJpB0VDLvIx/5TBysY
         sn8xQCIJCJ5Q8keefIPJbjrfy7QGrw02GJph01IEjyDiwUnVTu/ZSbfmuX2+g4JmSCw0
         1xyFVbpeWUQlo5JkS9ElpNMtxRkSiIqW3LQ/wkkf1E+qNCPvmVzCbkbVf3pvIr4dg+L2
         w7og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dG5LMeCXSiSbpubk/BTMkvWJ2dvIK7jFfkGhSVKuiPvEccVQI9eRP/pY4aiG8kSDk8
         sybScDEKYa9pUjoob3fVfnbNdFtdkBXsSjpfjP+bPyBK5Chd00x6HJJ7X+HteLAY7JfU
         o4429zXiiE7e1UOccLBxgzcZh+G/nI2B8bjb9YKWi7iAEGL16Iblz9B6MpdkbUl3G+Fk
         3lPFokI++jDRZ0Cwvj1/64bOOygK5BR8VGYFxRHD7siF53FrkARVocKqUOcShcj0hkn2
         gYiKlI7ykCQvFk94TVoBL/XLbOsKN6gefpMbeBOS/eufSnZP21bV5ckiClL1WUdGnm6v
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=GutCx534iRFLBM8XeW6zzYkj+0b+AO4+HuK/wTv3UUeyO0RIa63rBB1A2OWimsNkMh
         jmwrQo3rYqmAYq2kvICwLSiiSsKLp2/oWBBEOcqn4hLy/nFWQaCK92O4fiXwdT4jQSQ3
         ZvUK5ZMGVMU0095WUQlIVwGvVsvRoL/7UpRs6fmk19XdW4WBrwLRJY+E1ax/fB+zXaRx
         LMaCdarck3acsDTvKAb1joMXQlThrXKLX7tjYyrR61r/4Qi6MqrfxXMaukPrUuOIXOLB
         56OqgUliIjxEXgYl8j2SFG5QcbtjuwOPgyKAujASl1StJhZGi+imzLt7I6vfTfp9lRiw
         rtMQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0ZxO+XrEA0soX8TsqzarPIKgMlmu9QFD5emUTrwdSMK80v64ReJM1ytfhfOIyKfc971pdmFaQiFlBDtAVTM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR5tM0EQ7RD1+mC4wdor69JqelG53HHAJd/381+hJE4O7Pp6WM
	oM70vzN8TRWdhX9KsVoBYIdPqtg+iMBt4IthHnut1HDMiq8wYZ+/fK9r70zzn7wenAN95GS0wmN
	xJ4754ykhvJNlBNnF5YnB4zJAwX0tpHk=
X-Gm-Gg: AYBFou1cXZAM7fD+nRwAZLWBdwAdzIA8E0ppgcwj8SpVjQ8HFIkKUdykzAIsICu19+3
	noosv2J91MWdS2wNfujXk/F4SNpCKH117XXdsYm1g1YNMIdoCy9MB1KkweZnoI9lgKq34RP7pz8
	rFDz3vIzFdaoRKfQaxzYmNHpLvziz0165sX9KlQclAkFGtDWwAJ40FOZA3Yl3AvGl4QwBpiRXU2
	6EwzHqcAKCHMui6oFCejYI6USxcZ7edoEjjssH89tI0jRukk+HMCWrwIcvf9juQHtEP6pZJxC1l
	z0iaKyv/7R0sF6O9tIKpw9op2/Nn6FGIngxRWvKxztKgOvG6SvtfHBHUrBLeqeu6Fi/Dr0sBbbU
	xNzQau67tdYo1zFab7+SV+1TNf8c0GxYa+0+8IA2jGrxXaJjf7t9qEahWg6i6k6upoIIizBKSjj
	y+/5ta5nrgS2UUessKRYDDEpV3G6O27WZVM4gry8HS+7j0A1Y1oX4=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
