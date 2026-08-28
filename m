Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942C2EC090;
	Fri, 28 Aug 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930216; cv=none; b=c1/fiM6bqW5S0bwgzPwb2Y/YCBoxArQPjC00fmawa2HtFeqQH8fh79odjAR00ZaYtzEkYjvWCwn63FUETflg9x48eXQyIZ6GZ77xet2wbkF3AuLMWF8m71ItQWikcMoo6jUQuW2uYs2lbpPTCFhTCdUPgG4EXduSctbP8e5v1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930216; c=relaxed/simple;
	bh=Q59T3pNM7f250DsuM+zm4cYq+MejOdXE3S0WDywQ3EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Ia6RzGBuqBoLWzUIQAWOhW/3KVbr48bLOaAWVZw36ZMRwmlEOj2KKSSp8fX19y+FQfSmNldRONbPTnrXWHqU+5S4suK3fJNT/H1c7WcVtNi0hocDLAriEclMUyK7zS7VVWLfuaqCt5Q8M6mD1zljjgVbLQQJNB+YA2AqExJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOPNhXbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOPNhXbw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 888B01F000E9;
	Fri, 28 Aug 2026 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787930215;
	bh=tEb0OHpSN5AAL9HgLZnc75ThezeOxsQzDLYZJatUxac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOPNhXbwcREoOG/U3kqD/OvJjwZd0fVmpDWLfbWnoIsT619T7C8Vh+uvcOjPYnmuE
	 2wqtRDZz9oVGHY1740sZY5MYJm9MC+nwVBiZVgXYE+MZjhmUZrZuGRPIE4b01JEyrT
	 EGfWPUdVOEapWnZml/hfiIBUpwPV9x35K6GzhmHk7gIYDY2EwLWrUhrRcQF5+Hmms2
	 8UT+T1L6gclwvl3kRiokXu0DJs1U5DiPQXBtohVetvK1pmv4WZjbwNICP5ooKIOQnJ
	 9+hqLZZyRqTs+u2SN+bareBfHvkBAm2aXJ+stLCLL4UL0kM5h95sUtGUZyd0/Ono+0
	 uXkcqw1yqSArg==
Date: Fri, 28 Aug 2026 17:13:43 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: kees@kernel.org, nathan@kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches
 for extmod builds
Message-ID: <apGlpwSPSI9YHjlR@levanger>
Mail-Followup-To: Jaihind Yadav <jaihindy@qti.qualcomm.com>,
	kees@kernel.org, nathan@kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
References: <20260817185146.GC1249844@ax162>
 <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>

On Thu, Aug 20, 2026 at 11:31:16AM +0530, Jaihind Yadav wrote:
> With GCC plugins enabled, external module builds can record
> -fplugin=... paths in DWARF producer metadata via
> -grecord-gcc-switches, leaking host/build specific paths and
> triggering QA checks.
> 
> Handle this in scripts/Makefile.gcc-plugins for KBUILD_EXTMOD
> builds by adding -gno-record-gcc-switches to plugin cflags.
> 
> This keeps plugin behavior unchanged while avoiding absolute
> plugin path leakage in external module debug metadata.

Maybe it makes sense to add a note on how to restore the original
behaviour for those who may want to have the gcc switches recorded in
debug data for external kmods ('make KCFLAGS=-grecord-gcc-switches').


-- 
Nicolas
