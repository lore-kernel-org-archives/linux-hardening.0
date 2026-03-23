Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784633F588;
	Mon, 23 Mar 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257206; cv=none; b=qGt+JeY4l/xyh923hdAxz0TCkxs4oGfPcpRJTyZla0tBkZq8ttFNlPVL6g+9QvXxrdzi9/tcnpn9CM4kw4pU7bUqEUk3c0EgP6gcG4tcP7qZDSHxpQq5EPzW9obqR3ddO98zs304DlIJZ8ScuF9B41HvtryNSnnMC0+gUbm4iJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257206; c=relaxed/simple;
	bh=HbFcVlLDzr7s8MAShY5kn8xSzlS4geN+9YqgsyUJxLU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ocAAroBMt7R9z5RkGSyEmA/AhtTOQ+PQfwx3TRPD7cU0TATAajS2hKI+28b+3Mf7lrwgiH6qCSn2lYzue5lUArDKTgdMMioU5cZ/P4twgKUHid+b/TskqMIjFjaYwzfMsZgAaMNsKUzTgsfz1Li4GX+TzoUk/perStP0NcDwPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzxHlZuJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzxHlZuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774257205; x=1805793205;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HbFcVlLDzr7s8MAShY5kn8xSzlS4geN+9YqgsyUJxLU=;
  b=nzxHlZuJgZAsey7yAGRHDmuBmk4TtQs46w/e8i1+9k71wh3vLOZ5K2eC
   PwjYOg1/yTY0OKCdYhwjnEOddE6m5K8HcgoD1B1lzg1F7rQSg5L8+V5Wr
   pMZRjTvv2IbayRF/lem7Ue/Ne9aSOgHVHl0STGNLup97fkOstKeA3fFcs
   FEde7XVWnZ6/UTf+wIbgRuymB7SFyztGMGuC0AotMArvFcat8u5ojvhRg
   sf/Ix4k5uK6zTgAL/VT5U+jnI4GXwji+WqenVLBTlz/2GemRV+EzdHwpZ
   f48t5kqKLppX92MMrp5t8YDizrK+BuhHRFhfF3pKJqdsd3Rti8RqrxczD
   g==;
X-CSE-ConnectionGUID: MhkcKoDmQYeIM8tSzAY87A==
X-CSE-MsgGUID: 8vpd/shLS2Os/GYtJlAUVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="62807273"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="62807273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:13:24 -0700
X-CSE-ConnectionGUID: 0zNkQR2ISzG5X/USyEDHcg==
X-CSE-MsgGUID: haIcpTB+QjmLrnT9i4luFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="217490034"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:13:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Mar 2026 11:13:15 +0200 (EET)
To: Rosen Penev <rosenp@gmail.com>, Kees Cook <kees@kernel.org>
cc: platform-driver-x86@vger.kernel.org, 
    Kenneth Chan <kenneth.t.chan@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: simplify allocation of
 sinf
In-Reply-To: <CAKxU2N9fqr8XunsR+=-P8AngLbUbphTq6aFnEJ_yEGhue9d2wA@mail.gmail.com>
Message-ID: <17effdb3-7406-d280-8d9a-e699e54dadef@linux.intel.com>
References: <20260320004928.29914-1-rosenp@gmail.com> <202603201131.55E516E@keescook> <CAKxU2N9fqr8XunsR+=-P8AngLbUbphTq6aFnEJ_yEGhue9d2wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1296920707-1774257195=:1623"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1296920707-1774257195=:1623
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Mar 2026, Rosen Penev wrote:
> On Fri, Mar 20, 2026 at 11:32=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> >
> > On Thu, Mar 19, 2026 at 05:49:28PM -0700, Rosen Penev wrote:
> > > Change to a flexible array member to allocate once instead of twice.
> > >
> > > Allows using __counted_by for extra runtime analysis. Move the counti=
ng
> > > variable assignment to right after allocation as required by
> > > __counted_by.
> > >
> > > Remove + 1 to allocation. It's already done in the previous line.
> >
> > Are you sure this is an accidental +1? I see the "num_sifr++" that
> > happens earlier, but it's not immediately clear why either that or the
> > +1 in the original allocation are needed. I'd like to understand why
> > either/both are/aren't needed.

There's a comment right before the increment:

        /*
         * Some DSDT-s have an off-by-one bug where the SINF package count =
is
         * one higher than the SQTY reported value, allocate 1 entry extra.
         */
        num_sifr++;

=2E.l.which comes from 33297cef3101 ("platform/x86: panasonic-laptop:=20
Allocate 1 entry extra in the sinf array").

So I don't know why you said it's not clear why it's there.

> Looks like a rebasing mistake to me honestly.

In which commit?


--=20
 i.

--8323328-1296920707-1774257195=:1623--
